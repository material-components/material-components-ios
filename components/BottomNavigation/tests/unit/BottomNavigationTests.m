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

#import "MaterialBottomNavigation.h"
#import "../../src/private/MDCBottomNavigationItemView.h"

@interface MDCBottomNavigationBar (Testing)
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
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

@end
