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
#import "../../src/private/MDCBottomDrawerHeaderMask.h"
#import "MDCNavigationDrawerFakes.h"

@interface MDCBottomDrawerDelegateTest
    : UIViewController <MDCBottomDrawerPresentationControllerDelegate>
@property(nonatomic, assign) BOOL delegateWasCalled;
@end

@implementation MDCBottomDrawerDelegateTest

- (instancetype)init {
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

- (void)bottomDrawerTopTransitionRatio:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                       transitionRatio:(CGFloat)transitionRatio {
}

@end

@interface MDCBottomDrawerViewController (ScrollViewTests)
@property(nullable, nonatomic, readonly) MDCBottomDrawerHeaderMask *maskLayer;
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
@property(nonatomic) CGFloat initialDrawerFactor;
@property(nullable, nonatomic, readonly) UIPresentationController *presentationController;
- (void)cacheLayoutCalculations;
- (void)updateDrawerState:(CGFloat)transitionPercentage;
- (CGFloat)calculateInitialDrawerFactor;
@end

@interface MDCBottomDrawerPresentationController (ScrollViewTests) <
    MDCBottomDrawerContainerViewControllerDelegate>
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;
@property(nonatomic, weak, nullable) id<MDCBottomDrawerPresentationControllerDelegate> delegate;
@property(nonatomic, strong, nullable) UIView *topHandle;
@end

@interface MDCNavigationDrawerScrollViewTests : XCTestCase
@property(nonatomic, strong, nullable) UIScrollView *fakeScrollView;
@property(nonatomic, strong, nullable) MDCBottomDrawerContainerViewController *fakeBottomDrawer;
@property(nonatomic, strong, nullable) MDCBottomDrawerViewController *drawerViewController;
@property(nonatomic, strong, nullable)
    MDCBottomDrawerPresentationController *presentationController;
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
  MDCBottomDrawerPresentationController *presentationController =
      (MDCBottomDrawerPresentationController *)self.drawerViewController.presentationController;
  presentationController.bottomDrawerContainerViewController = self.fakeBottomDrawer;
  self.fakeBottomDrawer.contentViewController = self.drawerViewController.contentViewController;
}

- (void)tearDown {
  self.fakeScrollView = nil;
  self.fakeBottomDrawer = nil;

  [super tearDown];
}

- (void)setupHeaderWithPreferredContentSize:(CGSize)preferredContentSize {
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.fakeBottomDrawer.headerViewController.preferredContentSize = preferredContentSize;
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
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderHeight, 0, 0.001);
}

- (void)testContentHeaderHeightWithHeader {
  // Given
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);

  // When
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderHeight,
                             fakePreferredContentSize.height, 0.001);
}

- (void)testTopHeaderHeightWithNoHeader {
  // When
  self.fakeBottomDrawer.headerViewController = nil;

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.topHeaderHeight, 0, 0.001);
}

- (void)testTopHeaderHeightWithHeader {
  // Given
  // MDCDeviceTopSafeAreaInset adds 20 if there is no safe area and you are not in an application
  CGFloat mdcDeviceTopSafeArea = 20;
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);

  // When
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.topHeaderHeight,
                             mdcDeviceTopSafeArea + fakePreferredContentSize.height, 0.001);
}

- (void)testContentHeaderTopInsetWithHeaderAndContentViewController {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 100);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 300
  // contentViewController.preferredContentSize.height = 100
  // 500 - 300 - 100 = 100
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 100, 0.001);
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
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 500, 0.001);
}

- (void)testContentHeaderTopInsetWithHeaderAndNoContentViewController {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 300);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // presentingViewBounds.size.height = 500, contentHeaderHeight = 300
  // contentViewController.preferredContentSize.height = 0
  // 500 - 300 - 0 = 200
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 200, 0.001);
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
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 400, 0.001);
}

- (void)testContentHeaderTopInsetForScrollableContentForLargeHeader {
  // Given
  // Setup gives us presentingViewBoudns of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 700);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // In cacheLayoutCalculation we test if contentScrollsToReveal is true then contentHeaderTopInset
  // should be initialDrawerFactor * presentingViewBounds = 500 * 0.5
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250, 0.001);
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
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250, 0.001);
}

- (void)testContentHeaderTopInsetForScrollableContent {
  // Given
  // Setup gives us presentingViewBounds of (0, 0, 200, 500)
  CGSize fakePreferredContentSize = CGSizeMake(200, 700);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1000);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  // In cacheLayoutCalculation we test if contentScrollsToReveal is true then contentHeaderTopInset
  // should be initialDrawerFactor * presentingViewBounds = 500 * 0.5
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 250, 0.001);
}

- (void)testContentHeightSurplus {
  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeightSurplus, 0, 0.001);
}

- (void)testContentHeightSurplusWithScrollabelContent {
  // Given
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 1500);

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeightSurplus, 2250, 0.001);
}

- (void)testContentScrollsToRevealFalse {
  // Then
  XCTAssertFalse(self.fakeBottomDrawer.contentScrollsToReveal);
}

- (void)testContentScrollsToRevealTrue {
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
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
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
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
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];

  // When
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 200);
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  XCTAssertEqual(self.fakeBottomDrawer.drawerState, MDCBottomDrawerStateExpanded);
}

- (void)testBottomDrawerStateFullScreen {
  CGSize fakePreferredContentSize = CGSizeMake(200, 2000);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];

  // When
  [self.fakeBottomDrawer cacheLayoutCalculations];
  [self.fakeBottomDrawer updateDrawerState:1];

  // Then
  XCTAssertEqual(self.fakeBottomDrawer.drawerState, MDCBottomDrawerStateFullScreen);
}

- (void)testBottomDrawerStateCallback {
  CGSize fakePreferredContentSize = CGSizeMake(200, 1000);
  [self setupHeaderWithPreferredContentSize:fakePreferredContentSize];
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

- (void)testBottomDrawerCornersAPICollapsed {
  // When
  [self.drawerViewController setTopCornersRadius:10 forDrawerState:MDCBottomDrawerStateCollapsed];

  // Then
  XCTAssertEqual(self.drawerViewController.maskLayer.maximumCornerRadius, 10);
}

- (void)testBottomDrawerCornersAPIExpanded {
  // When
  self.drawerViewController.contentViewController.preferredContentSize = CGSizeMake(100, 100);
  [self.fakeBottomDrawer cacheLayoutCalculations];
  [self.drawerViewController setTopCornersRadius:5 forDrawerState:MDCBottomDrawerStateExpanded];

  // Then
  XCTAssertEqual(self.drawerViewController.maskLayer.minimumCornerRadius, 5);
}

- (void)testBottomDrawerCornersAPIFullScreen {
  // When
  self.drawerViewController.contentViewController.preferredContentSize = CGSizeMake(100, 5000);
  [self.fakeBottomDrawer cacheLayoutCalculations];
  [self.drawerViewController setTopCornersRadius:3 forDrawerState:MDCBottomDrawerStateFullScreen];

  // Then
  XCTAssertEqual(self.drawerViewController.maskLayer.minimumCornerRadius, 3);
}

- (void)testBottomDrawerDynamicSizing {
  // Given
  self.fakeBottomDrawer.contentViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  [self.fakeBottomDrawer viewDidLoad];
  [self.fakeBottomDrawer cacheLayoutCalculations];
  CGFloat previousContentHeaderTopInset = self.fakeBottomDrawer.contentHeaderTopInset;

  // When
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(200, 200);

  // Then
  XCTAssertLessThan(self.fakeBottomDrawer.contentHeaderTopInset, previousContentHeaderTopInset);
}

- (void)testBottomDrawerHandle {
  // When
  [self.presentationController presentationTransitionWillBegin];

  // Then
  XCTAssertNotNil(self.presentationController.topHandle);
  XCTAssertEqualWithAccuracy(CGRectGetWidth(self.presentationController.topHandle.frame),
                             (CGFloat)24.0, (CGFloat)0.001);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(self.presentationController.topHandle.frame),
                             (CGFloat)2.0, (CGFloat)0.001);
  XCTAssertEqualWithAccuracy(self.presentationController.topHandle.layer.cornerRadius, (CGFloat)1.0,
                             (CGFloat)0.001);
  XCTAssertEqual(self.presentationController.topHandle.hidden, YES);
}

- (void)testBottomDrawerHandleHidden {
  // When
  MDCBottomDrawerPresentationController *presentationController =
      (MDCBottomDrawerPresentationController *)self.drawerViewController.presentationController;
  presentationController.topHandle = [[UIView alloc] init];
  presentationController.topHandle.hidden = YES;
  self.drawerViewController.topHandleHidden = NO;

  // Then
  XCTAssertEqual(presentationController.topHandle.hidden, NO);
}

- (void)testBottomDrawerHandleColor {
  // When
  MDCBottomDrawerPresentationController *presentationController =
      (MDCBottomDrawerPresentationController *)self.drawerViewController.presentationController;
  presentationController.topHandle = [[UIView alloc] init];
  presentationController.topHandle.backgroundColor = UIColor.blueColor;
  self.drawerViewController.topHandleColor = UIColor.redColor;

  // Then
  XCTAssertEqualObjects(presentationController.topHandle.backgroundColor, UIColor.redColor);
}

- (void)testBottomDrawerScrollingEnabled {
  // When
  self.drawerViewController.trackingScrollView = self.fakeScrollView;

  // Then
  XCTAssertEqual(self.fakeScrollView.scrollEnabled, NO);
}

- (void)testBottomDrawerTopInset {
  // Given
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.drawerViewController.delegate = fakeHeader;
  self.fakeBottomDrawer.delegate = self.presentationController;
  [self.presentationController presentationTransitionWillBegin];

  // When
  [self.fakeBottomDrawer viewWillAppear:YES];
  [self.fakeBottomDrawer cacheLayoutCalculations];
  [self.fakeBottomDrawer.scrollView setContentOffset:CGPointMake(0, 1000)];

  // Then
  XCTAssertEqualWithAccuracy(fakeHeader.topInset, (CGFloat)7.0, (CGFloat)0.001);
}

- (void)testContentReachesFullscreenPresentationControllerValue {
  // When
  [self.presentationController presentationTransitionWillBegin];
  [self.presentationController.bottomDrawerContainerViewController cacheLayoutCalculations];

  // Then
  XCTAssertEqual(
      self.presentationController.bottomDrawerContainerViewController.contentReachesFullscreen,
      self.presentationController.contentReachesFullscreen);
}

- (void)testContentOffsetY {
  // When
  [self.drawerViewController setContentOffsetY:0 animated:YES];

  // Then
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.scrollView.contentOffset.y, 500, (CGFloat)0.001);
}

- (void)testCalculateInitialDrawerFactorWithSmallHeight {
  // Given
  CGRect fakeRect = CGRectMake(0, 0, 250, 500);
  self.fakeBottomDrawer.originalPresentingViewController.view.bounds = fakeRect;
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(250, 100);

  // When
  CGFloat drawerFactor = [self.fakeBottomDrawer calculateInitialDrawerFactor];

  // Then
  XCTAssertEqualWithAccuracy(drawerFactor, 0.2, 0.001);
}

- (void)testCalculateInitialDrawerFactorWithLargeHeight {
  // Given
  CGRect fakeRect = CGRectMake(0, 0, 250, 500);
  self.fakeBottomDrawer.originalPresentingViewController.view.bounds = fakeRect;
  self.fakeBottomDrawer.contentViewController.preferredContentSize = CGSizeMake(250, 1000);

  // When
  CGFloat drawerFactor = [self.fakeBottomDrawer calculateInitialDrawerFactor];

  // Then
  XCTAssertEqualWithAccuracy(drawerFactor, 0.5, 0.001);
}

- (void)testExpandToFullScreen {
  // Given
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.fakeBottomDrawer.headerViewController = fakeHeader;
  self.drawerViewController.delegate = fakeHeader;
  self.fakeBottomDrawer.delegate = self.presentationController;
  [self.presentationController presentationTransitionWillBegin];
  XCTestExpectation *expectation = [self expectationWithDescription:@"expand complete"];

  // When
  [self.fakeBottomDrawer viewWillAppear:YES];
  [self.fakeBottomDrawer cacheLayoutCalculations];

  // Then
  [self.drawerViewController expandToFullscreenWithDuration:(CGFloat)0.2
                                                 completion:^(BOOL completed) {
                                                   [expectation fulfill];
                                                 }];
  [self waitForExpectationsWithTimeout:1 handler:nil];

  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.trackingScrollView.frame.origin.y, 0,
                             (CGFloat)0.01);
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.scrollView.frame.origin.y, 0, (CGFloat)0.01);
  XCTAssertEqualWithAccuracy(self.fakeBottomDrawer.contentHeaderTopInset, 20, (CGFloat)0.01);
}

@end
