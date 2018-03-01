/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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


@interface MDCTabBarControllerEncodingTests : XCTestCase

@end

@implementation MDCTabBarControllerEncodingTests

- (void)testTabBarControllerEncoding {
  MDCTabBarViewController *tabBarVC = [[MDCTabBarViewController alloc] init];
  [tabBarVC.view setBackgroundColor:[UIColor clearColor]];

  UIViewController *vc1 = [[UIViewController alloc] init];
  UIViewController *vc2 = [[UIViewController alloc] init];
  vc1.view.tag = 1;
  vc2.view.tag = 2;
  tabBarVC.viewControllers = @[vc1, vc2];
  tabBarVC.selectedViewController = vc1;
  tabBarVC.tabBar.tintColor = [UIColor colorWithRed:0.6f green:0.2f blue:0.3f alpha:1.0f];
  // force view did load

  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:tabBarVC];
  MDCTabBarViewController *unarchivedtabBarVC =
      [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
  XCTAssertEqual(unarchivedtabBarVC.view.subviews.count, tabBarVC.view.subviews.count);
  XCTAssertEqual([[unarchivedtabBarVC.viewControllers[0] view] tag],
                 [[tabBarVC.viewControllers[0] view] tag]);
  XCTAssertEqual([[unarchivedtabBarVC.viewControllers[1] view] tag],
                 [[tabBarVC.viewControllers[1] view] tag]);
  XCTAssertEqual([unarchivedtabBarVC.selectedViewController.view tag],
                 [tabBarVC.selectedViewController.view tag]);
  XCTAssertEqual(unarchivedtabBarVC.tabBar.tintColor, tabBarVC.tabBar.tintColor);
}

@end
