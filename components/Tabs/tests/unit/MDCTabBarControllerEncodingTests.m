// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

@interface MDCTabBarViewControllerDelegateExample : NSObject<MDCTabBarControllerDelegate, NSCoding>

@property (nonatomic, assign) NSInteger exampleInteger;

@end

@implementation MDCTabBarViewControllerDelegateExample

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _exampleInteger = [aDecoder decodeIntegerForKey:@"exampleInteger"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeInteger:_exampleInteger forKey:@"exampleInteger"];
}

- (BOOL)tabBarController:(nonnull MDCTabBarViewController *)tabBarController
    shouldSelectViewController:(nonnull UIViewController *)viewController {
  return YES;
}

- (void)tabBarController:(nonnull MDCTabBarViewController *)tabBarController
    didSelectViewController:(nonnull UIViewController *)viewController {

}

@end

@interface MDCTabBarControllerEncodingTests : XCTestCase

@end

@implementation MDCTabBarControllerEncodingTests

//TODO: (#3220) [TabBar] Re-enable test that is throwing an exception
- (void)_disabled_testTabBarControllerEncoding {
  MDCTabBarViewController *tabBarVC = [[MDCTabBarViewController alloc] init];
  [tabBarVC.view setBackgroundColor:[UIColor clearColor]];

  UIViewController *vc1 = [[UIViewController alloc] init];
  UIViewController *vc2 = [[UIViewController alloc] init];
  vc1.view.tag = 1;
  vc2.view.tag = 2;
  tabBarVC.viewControllers = @[vc1, vc2];
  tabBarVC.selectedViewController = vc1;
  tabBarVC.tabBar.tintColor =
      [UIColor colorWithRed:(CGFloat)0.6 green:(CGFloat)0.2 blue:(CGFloat)0.3 alpha:1.0f];
  MDCTabBarViewControllerDelegateExample *delegate =
      [[MDCTabBarViewControllerDelegateExample alloc] init];
  tabBarVC.delegate = delegate;
  // force view did load

  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:tabBarVC];
  MDCTabBarViewController *unarchivedTabBarVC =
      [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
  XCTAssertEqual(unarchivedTabBarVC.view.subviews.count, tabBarVC.view.subviews.count);
  XCTAssertEqual(unarchivedTabBarVC.viewControllers[0].view.tag,
                 tabBarVC.viewControllers[0].view.tag);
  XCTAssertEqual(unarchivedTabBarVC.viewControllers[1].view.tag,
                 tabBarVC.viewControllers[1].view.tag);
  XCTAssertEqual(unarchivedTabBarVC.selectedViewController.view.tag,
                 tabBarVC.selectedViewController.view.tag);
  XCTAssertEqualObjects(unarchivedTabBarVC.tabBar.tintColor, tabBarVC.tabBar.tintColor);
  XCTAssertNil(unarchivedTabBarVC.delegate);
}

- (void)testTabBarControllerDelegateEncoding {
  MDCTabBarViewController *tabBarVC = [[MDCTabBarViewController alloc] init];
  [tabBarVC.view setBackgroundColor:[UIColor clearColor]];
  MDCTabBarViewControllerDelegateExample *delegate =
      [[MDCTabBarViewControllerDelegateExample alloc] init];
  delegate.exampleInteger = 2;
  tabBarVC.delegate = delegate;
  NSMutableData *mutableArchivedData = [[NSMutableData alloc] init];
  NSKeyedArchiver *keyedArchiver =
      [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableArchivedData];
  [keyedArchiver encodeObject:tabBarVC forKey:@"TabBarVC"];
  [keyedArchiver encodeObject:delegate forKey:@"TabBarDelegate"];
  [keyedArchiver finishEncoding];
  NSKeyedUnarchiver *unarchiver =
      [[NSKeyedUnarchiver alloc] initForReadingWithData:mutableArchivedData];
  MDCTabBarViewController *unarchivedTabBarVC =
      [unarchiver decodeObjectForKey:@"TabBarVC"];
  MDCTabBarViewControllerDelegateExample *unarchivedDelegate =
      [unarchiver decodeObjectForKey:@"TabBarDelegate"];
  MDCTabBarViewControllerDelegateExample *tabBarVCDelegate =
      (MDCTabBarViewControllerDelegateExample *)unarchivedTabBarVC.delegate;
  XCTAssertNotNil(unarchivedTabBarVC.delegate);

  XCTAssertEqual(tabBarVCDelegate.exampleInteger, unarchivedDelegate.exampleInteger);
  XCTAssertEqual(delegate.exampleInteger, unarchivedDelegate.exampleInteger);
}

@end
