// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <XCTest/XCTest.h>

#import "MDCTabBarView.h"

@interface MDCTabBarViewTests : XCTestCase

@property(nonatomic, strong) MDCTabBarView *tabBarView;

@property(nonatomic, strong) UITabBarItem *itemA;

@property(nonatomic, strong) UITabBarItem *itemB;

@property(nonatomic, strong) UITabBarItem *itemC;

@end

@implementation MDCTabBarViewTests

- (void)setUp {
  [super setUp];

  self.tabBarView = [[MDCTabBarView alloc] init];
  self.itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];
  self.itemB = [[UITabBarItem alloc] initWithTitle:@"B" image:nil tag:0];
  self.itemC = [[UITabBarItem alloc] initWithTitle:@"C" image:nil tag:0];
}

- (void)tearDown {
  self.itemA = nil;
  self.itemB = nil;
  self.itemC = nil;
  self.tabBarView = nil;

  [super tearDown];
}

- (void)testInitCreatesObject {
  // When
  MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];

  // Then
  XCTAssertNotNil(tabBarView);
  XCTAssertNotNil(tabBarView.items);
}

/// Tab bars should by default select nil in their items array. The behavior should also be
/// consistent with the UIKit
- (void)testSelectsNilByDefault {
  // Given
  self.tabBarView.items = @[ self.itemA, self.itemB, self.itemC ];

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

/// Tab bars should preserve their selection if possible when changing items.
- (void)testPreservesSelectedItem {
  // Given items {A, B} which selected item A
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When
  self.tabBarView.items = @[ self.itemC, self.itemA ];

  // Then should preserve the selection of A.
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

/// Tab bars should select nil if the old selection is no longer present.
- (void)testSelectsNilWhenSelectedItemMissing {
  // Given items {A, B} which selected item A.
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When
  self.tabBarView.items = @[ self.itemB, self.itemC ];

  // Then set items not including A, which should select nil.
  XCTAssertNil(self.tabBarView.selectedItem);
}

/// Tab bars should safely accept having their items set to the empty array.
- (void)testSafelyHandlesEmptyItems {
  // Given
  self.tabBarView.items = @[];
  XCTAssertNil(self.tabBarView.selectedItem);

  // When
  self.tabBarView.items = @[ self.itemA ];
  self.tabBarView.items = @[];

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

// Tab bar should ignore setting a `selectedItem` to something not in the `items` array.
- (void)testSafelyHandlesNonExistItem {
  // Given
  self.tabBarView.items = @[];
  self.tabBarView.selectedItem = nil;

  // When
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemC;

  // Then
  XCTAssertNil(self.tabBarView.selectedItem);
}

// Setting items to the same set of items should change nothing.
- (void)testItemsUpdateIsIdempotent {
  // Given items {A, B} which selected item A.
  self.tabBarView.items = @[ self.itemA, self.itemB ];
  self.tabBarView.selectedItem = self.itemA;
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);

  // When set same set of items.
  self.tabBarView.items = @[ self.itemA, self.itemB ];

  // Then should make no difference to the selection.
  XCTAssertEqual(self.tabBarView.selectedItem, self.itemA);
}

#pragma mark - Properties

- (void)testSettingBarTintColorUpdatesBackgroundColor {
  // Given
  self.tabBarView.backgroundColor = nil;

  // When
  self.tabBarView.barTintColor = UIColor.orangeColor;

  // Then
  XCTAssertEqual(self.tabBarView.barTintColor, UIColor.orangeColor);
  XCTAssertEqual(self.tabBarView.backgroundColor, self.tabBarView.barTintColor);
}

- (void)testSettingBackgroundColorUpdatesBarTintColor {
  // Given
  self.tabBarView.barTintColor = nil;

  // When
  self.tabBarView.backgroundColor = UIColor.purpleColor;

  // Then
  XCTAssertEqual(self.tabBarView.backgroundColor, UIColor.purpleColor);
  XCTAssertEqual(self.tabBarView.barTintColor, self.tabBarView.backgroundColor);
}

@end
