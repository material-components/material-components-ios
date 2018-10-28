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

#import "../../src/private/MDCBottomDrawerContainerViewController.h"
#import "MDCNavigationDrawerFakes.h"

@interface MDCBottomDrawerDelegateTest: UIViewController
<MDCBottomDrawerPresentationControllerDelegate>
@property(nonatomic, assign) BOOL delegateWasCalled;
@end

@implementation MDCBottomDrawerDelegateTest

- (instancetype)init
{
  self = [super init];
  if (self) {
    _delegateWasCalled = NO;
  }
  return self;
}
- (void)bottomDrawerWillChangeState:(MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState {
  _delegateWasCalled = YES;
}

@end


@interface MDCBottomDrawerContainerViewController (ScrollViewTests)

@property(nonatomic) BOOL scrollViewObserved;
@property(nonatomic, readonly) UIScrollView *scrollView;
@property(nonatomic, readonly) CGFloat topHeaderHeight;
@property(nonatomic, readonly) CGFloat contentHeaderHeight;
@property(nonatomic, readonly) CGFloat contentHeaderTopInset;
@property(nonatomic, readonly) CGRect presentingViewBounds;
@property(nonatomic, readonly) CGFloat contentHeightSurplus;
@property(nonatomic, readonly) BOOL contentScrollsToReveal;
@property(nonatomic) MDCBottomDrawerState drawerState;
@property (nullable, nonatomic, readonly) UIPresentationController *presentationController;
- (void)cacheLayoutCalculations;

@end

@interface MDCBottomDrawerPresentationController (ScrollViewTests) <MDCBottomDrawerContainerViewControllerDelegate>
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;
@property(nonatomic, weak, nullable) id<MDCBottomDrawerPresentationControllerDelegate> delegate;
@end

@interface MDCNavigationDrawerScrollViewTests : XCTestCase
@property(nonatomic, strong, nullable) UIScrollView *fakeScrollView;
@property(nonatomic, strong, nullable) MDCBottomDrawerContainerViewController *fakeBottomDrawer;
@property(nonatomic, strong, nullable) MDCBottomDrawerViewController *drawerViewController;
@property(nonatomic, strong, nullable) MDCBottomDrawerPresentationController
    *presentationController;
@property(nonatomic, strong, nullable) MDCBottomDrawerDelegateTest *delegateTest;
@end


@implementation MDCNavigationDrawerScrollViewTests

- (void)setUp {
  [super setUp];

  UIViewController *fakeViewController = [[UIViewController alloc] init];
  fakeViewController.view.frame = CGRectMake(0, 0, 200, 500);

  _fakeScrollView = [[UIScrollView alloc] init];
  _fakeBottomDrawer = [[MDCBottomDrawerContainerViewController alloc]
      initWithOriginalPresentingViewController:fakeViewController
                            trackingScrollView:_fakeScrollView];
  _drawerViewController = [[MDCBottomDrawerViewController alloc] init];
  _drawerViewController.contentViewController = fakeViewController;
  _presentationController = [[MDCBottomDrawerPresentationController alloc]
                             initWithPresentedViewController:_drawerViewController
                             presentingViewController:nil];
  _delegateTest = [[MDCBottomDrawerDelegateTest alloc] init];
}

- (void)tearDown {
  self.fakeScrollView = nil;
  self.fakeBottomDrawer = nil;

  [super tearDown];
}

- (void)testScrollViewNotNil {
  // Then
  XCTAssertNotNil(self.fakeBottomDrawer.scrollView);
}

- (void)testScrollViewBeingObserved {
  // When
  [self.fakeBottomDrawer viewWillAppear:YES];

  // Then
  XCTAssertTrue(self.fakeBottomDrawer.scrollViewObserved);
}

- (void)testScrollViewNotBeingObserved {
  // When
  [self.fakeBottomDrawer viewWillAppear:YES];
  [self.fakeBottomDrawer viewDidDisappear:YES];

  // Then
  XCTAssertFalse(self.fakeBottomDrawer.scrollViewObserved);
}

- (void)testPresentingViewBounds {
  // Given
  CGRect fakeRect = CGRectMake(0, 0, 250, 375);

  // When
  self.fakeBottomDrawer.originalPresentingViewController.view.bounds = fakeRect;

  // Then
  CGRect standardizePresentingViewBounds =
      CGRectStandardize(self.fakeBottomDrawer.presentingViewBounds);
  XCTAssertEqualWithAccuracy(standardizePresentingViewBounds.origin.x, fakeRect.origin.x, 0.001);
  XCTAssertEqualWithAccuracy(standardizePresentingViewBounds.origin.y, fakeRect.origin.y, 0.001);
  XCTAssertEqualWithAccuracy(standardizePresentingViewBounds.size.width, fakeRect.size.width,
                             0.001);
  XCTAssertEqualWithAccuracy(standardizePresentingViewBounds.size.height, fakeRect.size.height,
                             0.001);
}

- (void)testContentHeaderHeightWithNoHeader {
  // When
  self.fakeBottomDrawer.headerViewController = nil;

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderHeight, 0.f, 0.001);
}

- (void)testContentHeaderHeightWithHeader {
  // Given
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.fakeBottomDrawer.headerViewController = fakeHeader;

  // When
  self.fakeBottomDrawer.headerViewController.preferredContentSize = fakePreferredContentSize;

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderHeight,
                             fakePreferredContentSize.height, 0.001);
}

- (void)testTopHeaderHeightWithNoHeader {
  // When
  self.fakeBottomDrawer.headerViewController = nil;

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.topHeaderHeight, 0.f, 0.001);
}

- (void)testTopHeaderHeightWithHeader {
  // Given
  // MDCDeviceTopSafeAreaInset adds 20.f if there is no safe area and you are not in an application
  CGFloat mdcDeviceTopSafeArea = 20.f;
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.fakeBottomDrawer.headerViewController = fakeHeader;

  // When
  self.fakeBottomDrawer.headerViewController.preferredContentSize = fakePreferredContentSize;

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.topHeaderHeight,
                             mdcDeviceTopSafeArea + fakePreferredContentSize.height, 0.001);
}

- (void)testContentHeaderTopInsetWithHeaderAndContentViewController {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 100);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 300
  // contentViewController.preferredContentSize.height = 100
  // 500 - 300 - 100 = 100
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 100.f, 0.001);
}

- (void)testContentHeaderTopInsetWithNoHeaderOrContentViewController {
  // Given
  // Setup gives us presentingViewbounds of (0, 0, 200, 500)

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 0
  // contentViewController.preferredContentSize.height = 0
  // 500 - 0 - 0 = 500
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 500.f, 0.001);
}

- (void)testContentHeaderTopInsetWithHeaderAndNoContentViewController {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 300
  // contentViewController.preferredContentSize.height = 0
  // 500 - 300 - 0 = 200
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 200.f, 0.001);
}

- (void)testContentHeaderTopInsetWithOnlyContentViewController {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 100);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 0
  // contentViewController.preferredContentSize.height = 100
  // 500 - 0 - 100 = 400
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 400.f, 0.001);
}

- (void)testContentHeaderTopInsetForScrollableContentForLargeHeader {
  // Given
  // Setup gives us presentingViewBoudns of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 700);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // In cacheLayoutCalculation we test if contentScrollsToReveal is true then contentHeaderTopInset
  // should be initialDrawerFactor * presentingViewBounds = 500 * 0.5
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250.f, 0.001);
}

- (void)testContentHeaderTopInsetForScrollableContentForLargeContent {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1000);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // In cacheLayoutCalculation we test if contentScrollsToReveal is true then contentHeaderTopInset
  // should be initialDrawerFactor * presentingViewBounds = 500 * 0.5
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250.f, 0.001);
}

- (void)testContentHeaderTopInsetForScrollableContent {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 700);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1000);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // In cacheLayoutCalculation we test if contentScrollsToReveal is true then contentHeaderTopInset
  // should be initialDrawerFactor * presentingViewBounds = 500 * 0.5
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250.f, 0.001);
}

- (void)testContentHeightSurplus {
  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeightSurplus, 0.f, 0.001);
}

- (void)testContentHeightSurplusWithScrollabelContent {
  // Given
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1500);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeightSurplus, 2250.f, 0.001);
}

- (void)testContentScrollsToRevealFalse {
  // Then
  XCTAssertFalse(self.fakeBottomDrawer.contentScrollsToReveal);
}

- (void)testContentScrollsToRevealTrue {
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1500);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertTrue(self.fakeBottomDrawer.contentScrollsToReveal);
}

- (void)testBottomDrawerStateCollapsed {
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];

  // When
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1500);
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertEqual(self.fakeBottomDrawer.drawerState, MDCBottomDrawerStateCollapsed);
}

- (void)testBottomDrawerStateExpanded {
  CGSize fakePreferredContentSize = CGSizeMake(200, 100);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];

  // When
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 200);
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertEqual(self.fakeBottomDrawer.drawerState, MDCBottomDrawerStateExpanded);
}

- (void)testBottomDrawerStateCallback {
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  fakeHeader.preferredContentSize = fakePreferredContentSize;
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];

  // When
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1500);
  [self.fakeBottomDrawer cacheLayoutCalculations];
  self.presentationController.delegate = self.delegateTest;
  self.presentationController.bottomDrawerContainerViewController = self.fakeBottomDrawer;
  self.fakeBottomDrawer.delegate = self.presentationController;
  self.fakeBottomDrawer.drawerState = MDCBottomDrawerStateExpanded;

  // Then
  XCTAssertEqual(self.delegateTest.delegateWasCalled, YES);
}

@end
