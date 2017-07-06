/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "MaterialTabs.h"

@interface MaterialTabsTests : XCTestCase
@end

@implementation MaterialTabsTests {
  MDCTabBar *_tabBar;
  UITabBarItem *_itemA;
  UITabBarItem *_itemB;
  UITabBarItem *_itemC;
}

- (void)setUp {
  _tabBar = [[MDCTabBar alloc] init];
  _itemA = [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0];
  _itemB = [[UITabBarItem alloc] initWithTitle:@"B" image:nil tag:0];
  _itemC = [[UITabBarItem alloc] initWithTitle:@"C" image:nil tag:0];
}

/// Tab bars should by default select the first item in their items array.
- (void)testSelectsFirstItemByDefault {
  _tabBar.items = @[ _itemA, _itemB, _itemC ];
  XCTAssertEqual(_tabBar.selectedItem, _itemA);
}

/// Tab bars should preserve their selection if possible when changing items.
- (void)testPreservesDefaultSelectedItem {
  // Set items {A, B} which should select item A
  _tabBar.items = @[ _itemA, _itemB ];

  // Set items {C, A} which should preserve the selection of A.
  _tabBar.items = @[ _itemC, _itemA ];
  XCTAssertEqual(_tabBar.selectedItem, _itemA);
}

/// Tab bars should preserve their explicitly-set selection if possible when changing items.
- (void)testPreservesNondefaultSelectedItem {
  // Set items {A, B} and explicitly select B.
  _tabBar.items = @[ _itemA, _itemB ];
  _tabBar.selectedItem = _itemB;

  // Set items {B, C} which should preserve the selection of B.
  _tabBar.items = @[ _itemB, _itemC ];
  XCTAssertEqual(_tabBar.selectedItem, _itemB);
}

/// Tab bars should clear the default selection if that item is no longer present.
- (void)testDeselectsWhenDefaultSelectedItemMissing {
  // Set items {A, B} which should select item A
  _tabBar.items = @[ _itemA, _itemB ];

  // Set items not including A, which should clear the selection.
  _tabBar.items = @[ _itemB, _itemC ];
  XCTAssertNil(_tabBar.selectedItem);
}

/// Tab bars should clear the explicit selection if that item is no longer present.
- (void)testDeselectsWhenNondefaultSelectedItemMissing {
  // Set items {A, B} and select B
  _tabBar.items = @[ _itemA, _itemB ];
  _tabBar.selectedItem = _itemB;

  // Set items not including B, which should clear the selection.
  _tabBar.items = @[ _itemA, _itemC ];
  XCTAssertNil(_tabBar.selectedItem);
}

/// Tab bars should safely accept having their items set to the empty array.
- (void)testSafelyHandlesEmptyItems {
  _tabBar.items = @[];
  XCTAssertNil(_tabBar.selectedItem);

  // Setting the empty array should also be safe coming from a non-empty array.
  _tabBar.items = @[ _itemA ];
  _tabBar.items = @[];
  XCTAssertNil(_tabBar.selectedItem);
}

/// If the selection is cleared, future updates should preserve the empty selection.
- (void)testPerservesEmptySelection {
  // Initial state: Items but explicitly cleared selection.
  _tabBar.items = @[ _itemA, _itemB ];
  _tabBar.selectedItem = nil;
  XCTAssertNil(_tabBar.selectedItem);

  // Update with new items, verify that empty selection is preserved.
  _tabBar.items = @[ _itemB, _itemC ];
  XCTAssertNil(_tabBar.selectedItem);
}

@end
