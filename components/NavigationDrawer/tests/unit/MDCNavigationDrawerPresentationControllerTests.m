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

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *fakePresentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCBottomDrawerPresentationController *passedPresentationController = nil;
  fakePresentationController.traitCollectionDidChangeBlock =
      ^(MDCBottomDrawerPresentationController *_Nullable presentationController,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedPresentationController = presentationController;
        passedTraitCollection = previousTraitCollection;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [fakePresentationController traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedPresentationController, fakePresentationController);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testSettingShouldAlwaysExpandHeader {
  // Given
  UIViewController *fakeContentViewController = [[UIViewController alloc] init];
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  fakeBottomDrawer.contentViewController = fakeContentViewController;
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];

  // When
  presentationController.shouldAlwaysExpandHeader = YES;
  [presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(
      presentationController.bottomDrawerContainerViewController.shouldAlwaysExpandHeader);
}

- (void)testShouldIncludeSafeAreaInContentHeight {
  // Given
  UIViewController *fakeContentViewController = [[UIViewController alloc] init];
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  fakeBottomDrawer.contentViewController = fakeContentViewController;
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];

  // When
  presentationController.shouldIncludeSafeAreaInContentHeight = YES;
  [presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(presentationController.bottomDrawerContainerViewController
                    .shouldIncludeSafeAreaInContentHeight);
}

- (void)testShouldIncludeSafeAreaInInitialDrawerHeight {
  // Given
  UIViewController *fakeContentViewController = [[UIViewController alloc] init];
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  fakeBottomDrawer.contentViewController = fakeContentViewController;
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];

  // When
  presentationController.shouldIncludeSafeAreaInInitialDrawerHeight = YES;
  [presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(presentationController.bottomDrawerContainerViewController
                    .shouldIncludeSafeAreaInInitialDrawerHeight);
}

- (void)testShouldUseStickyStatusBar {
  // Given
  UIViewController *fakeContentViewController = [[UIViewController alloc] init];
  MDCBottomDrawerViewController *fakeBottomDrawer = [[MDCBottomDrawerViewController alloc] init];
  fakeBottomDrawer.contentViewController = fakeContentViewController;
  UIViewController *fakePresentingViewController = [[UIViewController alloc] init];
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc]
          initWithPresentedViewController:fakeBottomDrawer
                 presentingViewController:fakePresentingViewController];

  // When
  presentationController.shouldUseStickyStatusBar = YES;
  [presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertTrue(
      presentationController.bottomDrawerContainerViewController.shouldUseStickyStatusBar);
}

@end
