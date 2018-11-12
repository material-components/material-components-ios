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
#import "MaterialTabs.h"

@interface MDCTabBarCodingTests : XCTestCase

@end

@implementation MDCTabBarCodingTests

- (void)testEncoding {
  MDCTabBar *tabBar = [[MDCTabBar alloc] initWithFrame:CGRectZero];
  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"item1" image:nil tag:1];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"item2" image:nil tag:2];
  tabBar.items = @[item1, item2];
  tabBar.selectedItem = item1;
  tabBar.tintColor = [UIColor colorWithRed:(float)0.6 green:(float)0.2 blue:(float)0.3 alpha:1];
  tabBar.selectedItemTintColor = [UIColor colorWithRed:1 green:(float)0.5 blue:0 alpha:1];
  tabBar.unselectedItemTintColor = [UIColor colorWithRed:(float)0.2
                                                   green:(float)0.3
                                                    blue:(float)0.3
                                                   alpha:1];
  tabBar.inkColor = [UIColor colorWithRed:(float)0.5 green:(float)0.8 blue:(float)0.6 alpha:1];
  tabBar.barTintColor = [UIColor colorWithRed:(float)0.4 green:(float)0.7 blue:(float)0.4 alpha:1];
  tabBar.selectedItemTitleFont = [UIFont systemFontOfSize:20];
  tabBar.unselectedItemTitleFont = [UIFont systemFontOfSize:18];
  tabBar.alignment = MDCTabBarAlignmentJustified;
  tabBar.itemAppearance = MDCTabBarItemAppearanceImages;
  tabBar.displaysUppercaseTitles = YES;
  tabBar.titleTextTransform = MDCTabBarTextTransformNone;

  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:tabBar];
  MDCTabBar *unarchivedTabBar = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];

  XCTAssertNotNil(unarchivedTabBar);
  XCTAssertEqual(tabBar.items.count, unarchivedTabBar.items.count);
  XCTAssertEqualObjects([tabBar.items[0] title], [unarchivedTabBar.items[0] title]);
  XCTAssertEqual([tabBar.items[0] tag], [unarchivedTabBar.items[0] tag]);
  XCTAssertEqualObjects([tabBar.items[1] title], [unarchivedTabBar.items[1] title]);
  XCTAssertEqual([tabBar.items[1] tag], [unarchivedTabBar.items[1] tag]);
  XCTAssertEqualObjects([tabBar.selectedItem title], [unarchivedTabBar.selectedItem title]);
  XCTAssertEqual([tabBar.selectedItem tag], [unarchivedTabBar.selectedItem tag]);
  XCTAssertTrue(CGColorEqualToColor(tabBar.tintColor.CGColor, unarchivedTabBar.tintColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(tabBar.selectedItemTintColor.CGColor,
                                    unarchivedTabBar.selectedItemTintColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(tabBar.unselectedItemTintColor.CGColor,
                                    unarchivedTabBar.unselectedItemTintColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(tabBar.inkColor.CGColor, unarchivedTabBar.inkColor.CGColor));
  XCTAssertTrue(CGColorEqualToColor(tabBar.barTintColor.CGColor,
                                    unarchivedTabBar.barTintColor.CGColor));
  XCTAssertEqualObjects(tabBar.selectedItemTitleFont, unarchivedTabBar.selectedItemTitleFont);
  XCTAssertEqualObjects(tabBar.unselectedItemTitleFont, unarchivedTabBar.unselectedItemTitleFont);
  XCTAssertEqual(tabBar.alignment, unarchivedTabBar.alignment);
  XCTAssertEqual(tabBar.itemAppearance, unarchivedTabBar.itemAppearance);
  XCTAssertEqual(tabBar.displaysUppercaseTitles, unarchivedTabBar.displaysUppercaseTitles);
  XCTAssertEqual(tabBar.titleTextTransform, unarchivedTabBar.titleTextTransform);
}

@end
