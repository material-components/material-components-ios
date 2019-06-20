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

  _tabBarView = [[MDCTabBarView alloc] init];
  _itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];
  _itemB = [[UITabBarItem alloc] initWithTitle:@"B" image:nil tag:0];
  _itemC = [[UITabBarItem alloc] initWithTitle:@"C" image:nil tag:0];
}

- (void)tearDown {
  _itemA = nil;
  _itemB = nil;
  _itemC = nil;
  _tabBarView = nil;

  [super tearDown];
}

- (void)testInitCreatesObject {
  // Given
  MDCTabBarView *tabBarView = [[MDCTabBarView alloc] init];

  // Then
  XCTAssertNotNil(tabBarView);
  XCTAssertNotNil(tabBarView.items);
}

/// Tab bars should by default select nil in their items array. The behavior should also consistent
/// with the UIKit
- (void)testSelectsNilByDefault {
  // Given
  _tabBarView.items = @[ _itemA, _itemB, _itemC ];

  // Then
  XCTAssertNil(_tabBarView.selectedItem);
}

/// Tab bars should preserve their selection if possible when changing items.
- (void)testPreservesSelectedItem {
  // Given items {A, B} which selected item A
  _tabBarView.items = @[ _itemA, _itemB ];
  _tabBarView.selectedItem = _itemA;
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);

  // When
  _tabBarView.items = @[ _itemC, _itemA ];

  // Then should preserve the selection of A.
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);
}

/// Tab bars should select nil if the old selection is no longer present.
- (void)testSelectsNilWhenSelectedItemMissing {
  // Given items {A, B} which selected item A.
  _tabBarView.items = @[ _itemA, _itemB ];
  _tabBarView.selectedItem = _itemA;
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);

  // When
  _tabBarView.items = @[ _itemB, _itemC ];

  // Then set items not including A, which should select nil.
  XCTAssertNil(_tabBarView.selectedItem);
}

/// Tab bars should safely accept having their items set to the empty array.
- (void)testSafelyHandlesEmptyItems {
  // Given
  _tabBarView.items = @[];
  XCTAssertNil(_tabBarView.selectedItem);

  // When
  _tabBarView.items = @[ _itemA ];
  _tabBarView.items = @[];

  // Then
  XCTAssertNil(_tabBarView.selectedItem);
}

// Tab bar should throw error when select the item that doesn't belongs to items.
- (void)testSafelyHandlesNonExistItem {
  // Given
  _tabBarView.items = @[];
  XCTAssertNil(_tabBarView.selectedItem);

  // When set selected item to nil.
  _tabBarView.selectedItem = nil;

  // Then should make no difference to the selection.
  XCTAssertNil(_tabBarView.selectedItem);

  // Given items {A, B} which selected item A.
  _tabBarView.items = @[ _itemA, _itemB ];
  _tabBarView.selectedItem = _itemA;
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);

  // When set selected item to C, then should rise exception.
  XCTAssertThrowsSpecific(_tabBarView.selectedItem = _itemC, NSException);
}

// Setting items to the same set of items should change nothing.
- (void)testItemsUpdateIsIdempotent {
  // Given items {A, B} which selected item A.
  _tabBarView.items = @[ _itemA, _itemB ];
  _tabBarView.selectedItem = _itemA;
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);

  // When set same set of items.
  _tabBarView.items = @[ _itemA, _itemB ];

  // Then should make no difference to the selection.
  XCTAssertEqual(_tabBarView.selectedItem, _itemA);
}

@end
