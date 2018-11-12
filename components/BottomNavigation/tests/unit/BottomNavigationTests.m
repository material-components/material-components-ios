// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialBottomNavigation.h"
#import "MaterialShadowElevations.h"
#import "../../src/private/MDCBottomNavigationItemView.h"

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@end

@interface MDCBottomNavigationItemView (Testing)
@property(nonatomic, strong) UILabel *label;
@end

@interface BottomNavigationTests : XCTestCase
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;
@end

@implementation BottomNavigationTests

- (void)setUp {
  self.bottomNavBar = [[MDCBottomNavigationBar alloc] init];
}

- (void)tearDown {
  self.bottomNavBar = nil;
}

- (void)testDefaultValues {
  // When
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];

  // Then
  XCTAssertEqualObjects(bar.backgroundColor, UIColor.whiteColor);
}

#pragma mark - Fonts

- (void)testItemTitleFontDefault {
  // Then
  XCTAssertNotNil(self.bottomNavBar.itemTitleFont);
}

- (void)testItemTitleFontAppliesToNewItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.itemTitleFont = [UIFont systemFontOfSize:31];
  self.bottomNavBar.items = @[item1, item2];

  // Then
  for (MDCBottomNavigationItemView *item in self.bottomNavBar.itemViews) {
    XCTAssertEqual(item.itemTitleFont, self.bottomNavBar.itemTitleFont);
  }
}

- (void)testItemTitleFontAppliesToExistingItems {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[item1, item2];
  self.bottomNavBar.itemTitleFont = [UIFont systemFontOfSize:31];

  // Then
  for (MDCBottomNavigationItemView *item in self.bottomNavBar.itemViews) {
    XCTAssertEqual(item.itemTitleFont, self.bottomNavBar.itemTitleFont);
  }
}

-(void)testItemReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[item1, item2];
  self.bottomNavBar.items = @[item1, item2, item3];

  // Then
  NSUInteger tabsCount = 3;
  XCTAssertEqual(self.bottomNavBar.itemViews.count, tabsCount);
}

-(void)testFramesAfterReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:2];
  [self.bottomNavBar sizeToFit];
  self.bottomNavBar.frame = CGRectMake(0, 0, 320, 56);

  // When
  self.bottomNavBar.items = @[item1, item2];
  self.bottomNavBar.items = @[item1, item2, item3];
  [self.bottomNavBar layoutIfNeeded];

  // Then
  XCTAssertFalse(CGRectEqualToRect(self.bottomNavBar.itemViews[0].frame, CGRectZero));
}

-(void)testSelectedItemAfterReset {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[item1, item2];
  self.bottomNavBar.items = @[item1, item2, item3];

  // Then
  XCTAssertNil(self.bottomNavBar.selectedItem);
}

- (void)testAccessibilityIdentifier {
  NSString *oldIdentifier = @"oldIdentifier";
  NSString *newIdentifier = @"newIdentifier";
  UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                           image:nil
                                                             tag:0];
  tabBarItem.accessibilityIdentifier = oldIdentifier;
  MDCBottomNavigationBar *bar = [[MDCBottomNavigationBar alloc] init];
  bar.items = @[ tabBarItem ];
  XCTAssert([bar.itemViews.firstObject.accessibilityIdentifier isEqualToString:oldIdentifier]);
  tabBarItem.accessibilityIdentifier = newIdentifier;
  XCTAssert([bar.itemViews.firstObject.accessibilityIdentifier isEqualToString:newIdentifier]);
}

-(void)testTitleVisibility {
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  self.bottomNavBar.items = @[item1, item2];
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityNever;
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssert(itemView.label.isHidden);
  }
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilityAlways;
  for (MDCBottomNavigationItemView *itemView in self.bottomNavBar.itemViews) {
    XCTAssert(!itemView.label.isHidden);
  }
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.bottomNavBar.itemViews.firstObject.selected = YES;
  self.bottomNavBar.itemViews.lastObject.selected = NO;
  XCTAssert(!self.bottomNavBar.itemViews.firstObject.label.isHidden);
  XCTAssert(self.bottomNavBar.itemViews.lastObject.label.isHidden);
}

- (void)testDefaultElevation {
  // Then
  XCTAssertEqual(self.bottomNavBar.elevation, MDCShadowElevationBottomNavigationBar);
}

- (void)testCustomElevation {
  // Given
  CGFloat customElevation = 20;

  // When
  self.bottomNavBar.elevation = customElevation;

  // Then
  XCTAssertEqual(self.bottomNavBar.elevation, customElevation);
}

- (void)testViewForItemFound {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  MDCBottomNavigationItemView *viewForItem1 =
      (MDCBottomNavigationItemView *)[self.bottomNavBar viewForItem:item1];
  MDCBottomNavigationItemView *viewForItem2 =
      (MDCBottomNavigationItemView *)[self.bottomNavBar viewForItem:item2];
  XCTAssertNotEqual(viewForItem1, viewForItem2);
  XCTAssertTrue(
      [self.bottomNavBar.itemViews containsObject:viewForItem1],
      @"BottomNavBar.itemViews did not contain the view (%@) returned for UITabBarItem (%@)",
      viewForItem1, item1);
  XCTAssertTrue(
      [self.bottomNavBar.itemViews containsObject:viewForItem2],
      @"BottomNavBar.itemViews did not contain the view (%@) returned for UITabBarItem (%@)",
      viewForItem2, item2);
}

- (void)testViewForItemNotFound {
  // Given
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil tag:0];
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil tag:0];

  // When
  self.bottomNavBar.items = @[ item1, item2 ];

  // Then
  XCTAssert([self.bottomNavBar viewForItem:item3] == nil);
}

@end
