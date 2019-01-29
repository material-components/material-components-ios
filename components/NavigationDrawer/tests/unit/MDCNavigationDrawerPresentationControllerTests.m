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

#import "../../src/private/MDCBottomDrawerContainerViewController.h"
#import "MDCBottomDrawerPresentationController.h"
#import "MDCBottomDrawerViewController.h"

@interface MDCBottomDrawerPresentationController (Testing)
@property(nonatomic) UIView *scrimView;
@property(nonatomic) UIView *topHandle;
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;
@end

@interface MDCBottomDrawerContainerViewController (Testing)
- (void)updateViewWithContentOffset:(CGPoint)contentOffset;
@end

@interface MDCNavigationDrawerPresentationControllerTests : XCTestCase

@end

@implementation MDCNavigationDrawerPresentationControllerTests

- (void)testDismissViewController {
  // Given
  CGRect fakeInitialContentFrame = CGRectMake(0, 0, 200, 300);
  UIViewController *fakeContentViewController = [[UIViewController alloc] init];
  fakeContentViewController.view.frame = fakeInitialContentFrame;
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  fakeBottomDrawer.contentViewController = fakeContentViewController;
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];
  [presentationController presentationTransitionWillBegin];

  // When
  [presentationController.bottomDrawerContainerViewController
      updateViewWithContentOffset:CGPointMake(0, 100)];
  [presentationController dismissalTransitionDidEnd:YES];

  // Then
  XCTAssertNil(presentationController.topHandle.superview);
  XCTAssertNil(presentationController.scrimView.superview);
  CGRect finalContentFrame = CGRectStandardize(
      presentationController.bottomDrawerContainerViewController.contentViewController.view.frame);
  XCTAssertEqualWithAccuracy(finalContentFrame.origin.x, fakeInitialContentFrame.origin.x, 0.001);
  XCTAssertEqualWithAccuracy(finalContentFrame.origin.y, fakeInitialContentFrame.origin.y, 0.001);
  XCTAssertEqualWithAccuracy(finalContentFrame.size.width, fakeInitialContentFrame.size.width,
                             0.001);
  XCTAssertEqualWithAccuracy(finalContentFrame.size.height, fakeInitialContentFrame.size.height,
                             0.001);
}

@end
