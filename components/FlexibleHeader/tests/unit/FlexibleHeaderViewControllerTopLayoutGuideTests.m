/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialApplication.h"
#import "MaterialFlexibleHeader.h"

@interface FlexibleHeaderViewControllerTopLayoutGuideTests : XCTestCase

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) UIViewController *contentViewController;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;

@end

@implementation FlexibleHeaderViewControllerTopLayoutGuideTests

- (void)setUp {
  [super setUp];

  // Given
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.contentViewController = [[UIViewController alloc] init];
  self.fhvc = [[MDCFlexibleHeaderViewController alloc] init];
  [self.contentViewController addChildViewController:self.fhvc];

  [self.contentViewController.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self.contentViewController];

  self.window.rootViewController = self.contentViewController;
}

- (void)tearDown {
  self.window = nil;
  self.contentViewController = nil;

  [super tearDown];
}
//
//- (void)testTopLayoutGuideNotUpdatedImmediately {
//  // Then
//  XCTAssertEqual(self.contentViewController.topLayoutGuide.length, 0);
//}
//
//- (void)testTopLayoutGuideMatchesMinimumHeightOnceUpdated {
//  // When
//  [self.fhvc updateTopLayoutGuide];
//
//  // Then
//  XCTAssertEqual(self.contentViewController.topLayoutGuide.length,
//                 self.fhvc.headerView.minimumHeight);
//}
//
//- (void)testTopLayoutGuideMatchesMinimumHeightOnceUpdated {
//  // When
//  [self.fhvc updateTopLayoutGuide];
//
//  // Then
//  XCTAssertEqual(self.contentViewController.topLayoutGuide.length,
//                 self.fhvc.headerView.minimumHeight);
//}
//
//- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffsetScrollingUpOffscreenKeepStatus {
//  // Given
//  CGFloat statusBarHeight =
//      [UIApplication mdc_safeSharedApplication].statusBarFrame.size.height;
//
//  // When
//  self.vc.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
//  CGRect offScreenScroll =
//      CGRectMake(0, [UIScreen mainScreen].bounds.size.height,
//                 [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//  [self.vc.scrollView scrollRectToVisible:offScreenScroll animated:NO];
//
//  // Then
//  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, statusBarHeight);
//}
//
//- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffsetScrollingUpOffscreenHideStatus {
//  // When
//  self.vc.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
//  CGRect offScreenScroll =
//      CGRectMake(0, [UIScreen mainScreen].bounds.size.height,
//                 [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//  [self.vc.scrollView scrollRectToVisible:offScreenScroll animated:NO];
//
//  // Then
//  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, 0);
//}
//
//- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffPullDownRelease {
//  // When
//  CGFloat randomHeight = (CGFloat)(arc4random_uniform(50.0) + 20.0);
//  self.vc.fhvc.headerView.maximumHeight = randomHeight;
//  CGRect initialFrame =
//      CGRectMake(0, self.vc.scrollView.contentInset.top, [UIScreen mainScreen].bounds.size.width,
//                 [UIScreen mainScreen].bounds.size.height);
//  CGRect pulledFrame = CGRectMake(0, -600, [UIScreen mainScreen].bounds.size.width,
//                                  [UIScreen mainScreen].bounds.size.height);
//
//  // Pull Down
//  [self.vc.scrollView scrollRectToVisible:pulledFrame animated:NO];
//  // Release
//  [self.vc.scrollView scrollRectToVisible:initialFrame animated:NO];
//
//  // Then
//  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, randomHeight);
//}

@end
