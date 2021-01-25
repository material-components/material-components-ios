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

#import "MDCSheetState.h"
#import "MaterialBottomSheet.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCDraggableView.h"
#import "../../src/private/MDCSheetContainerView.h"

@interface MDCBottomSheetDelegateTest
    : UIViewController <MDCBottomSheetPresentationControllerDelegate>
@property(nonatomic, assign) BOOL delegateWasCalled;
@end

@implementation MDCBottomSheetDelegateTest

- (instancetype)init {
  self = [super init];
  if (self) {
    _delegateWasCalled = NO;
  }
  return self;
}

- (void)bottomSheetDidChangeYOffset:(MDCBottomSheetPresentationController *)bottomSheet
                            yOffset:(CGFloat)yOffset {
  _delegateWasCalled = YES;
}

- (void)bottomSheetWillChangeState:(MDCBottomSheetPresentationController *)bottomSheet
                        sheetState:(MDCSheetState)sheetState {
  _delegateWasCalled = YES;
}

@end

// Exposing internal methods for unit testing
@interface MDCBottomSheetPresentationController (Testing)
@property(nonatomic, strong) MDCSheetContainerView *sheetView;
- (void)updatePreferredSheetHeight;
@end

@interface MDCSheetContainerView (Testing)
@property(nonatomic) MDCDraggableView *sheet;
@property(nonatomic) MDCSheetState sheetState;
- (CGPoint)targetPoint;
- (void)draggableView:(MDCDraggableView *)view didPanToOffset:(CGFloat)offset;
- (BOOL)draggableView:(MDCDraggableView *)view shouldBeginDraggingWithVelocity:(CGPoint)velocity;
- (void)draggableView:(MDCDraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity;
@end

/**
 A testing double for @c MDCSheetContainerView that allows setting an explicitly-nonstandardized
 @c frame value.

 @note Although it is possible to retrieve a non-standardized frame or bounds from a UIView object,
       UIView will standardize the CGRect passed to @c setFrame:. To aid in testing, we turn
       @c frame into a simple get/set property. We still call up to the super implementation of
       @c setFrame: in case there are side-effects in UIView.
 */
@interface FakeSheetView : MDCSheetContainerView
@property(nonatomic, assign) UIEdgeInsets customSafeAreaInsets;
@end

@implementation FakeSheetView {
  CGRect _frame;
}

- (CGRect)frame {
  return _frame;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];

  _frame = frame;
}

- (UIEdgeInsets)safeAreaInsets {
  return _customSafeAreaInsets;
}
@end

@interface MDCBottomSheetPresentationControllerTests : XCTestCase
@property(nonatomic, strong) FakeSheetView *sheetView;
@property(nonatomic, strong) MDCBottomSheetPresentationController *presentationController;
@property(nonatomic, strong, nullable) MDCBottomSheetDelegateTest *delegateTest;
@end

@implementation MDCBottomSheetPresentationControllerTests

- (void)setUp {
  [super setUp];

  // The `sheetView` property is both an input and an output to `setPreferredSheetHeight:`. Its
  // frame may be used to guess the preferredContentHeight of the sheet. Once calculated, it
  // receives an updated value for `preferredSheetHeight`.
  self.sheetView = [[FakeSheetView alloc] initWithFrame:CGRectZero
                                            contentView:[[UIView alloc] init]
                                             scrollView:[[UIScrollView alloc] init]
                               simulateScrollViewBounce:YES];

  // Only used as a required `-init` parameters for MDCBottomSheetPresentationController
  UIViewController *stubPresentingViewController = [[UIViewController alloc] init];
  UIViewController *stubPresentedViewController = [[UIViewController alloc] init];

  self.presentationController = [[MDCBottomSheetPresentationController alloc]
      initWithPresentedViewController:stubPresentedViewController
             presentingViewController:stubPresentingViewController];
  self.presentationController.sheetView = self.sheetView;
  self.delegateTest = [[MDCBottomSheetDelegateTest alloc] init];
}

- (void)tearDown {
  self.presentationController.sheetView = nil;
  self.presentationController = nil;
  self.sheetView = nil;
  self.delegateTest = nil;

  [super tearDown];
}

- (void)testUpdatePreferredSheetHeightZeroWhenSheetViewHasStandardizedFrame {
  // Given
  CGFloat sheetFrameHeight = 80;
  self.sheetView.frame = CGRectMake(0, 0, 75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, sheetFrameHeight / 2, 0.001);
}

- (void)testUpdatePreferredSheetHeightZeroWhenSheetViewHasUnstandardizedFrame {
  // Given
  CGFloat sheetFrameHeight = -80;
  self.sheetView.frame = CGRectMake(75, 80, -75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight,
                             (CGFloat)fabs(sheetFrameHeight / 2), 0.001);
}

- (void)testUpdatePreferredSheetHeightPositiveValue {
  // Given
  CGFloat preferredSheetHeight = 120;
  self.presentationController.presentedViewController.preferredContentSize =
      CGSizeMake(100, preferredSheetHeight);
  self.sheetView.frame = CGRectMake(0, 0, 75, 80);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testUpdatePreferredSheetHeightNegativeValue {
  // Given
  CGFloat preferredSheetHeight = -120;
  self.presentationController.presentedViewController.preferredContentSize =
      CGSizeMake(0, preferredSheetHeight);
  self.sheetView.frame = CGRectMake(0, 0, 75, -80);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testUpdatePreferredSheetHeight {
  // Given
  CGFloat preferredSheetHeight = 100;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testUpdateNegativePreferredSheetHeight {
  // Given
  CGFloat preferrredSheetHeight = -100;
  self.presentationController.preferredSheetHeight = preferrredSheetHeight;
  CGFloat sheetHeight = 250;
  self.sheetView.frame = CGRectMake(0, 0, 75, sheetHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, (CGFloat)(sheetHeight / 2),
                             0.001);
}

- (void)testUpdatePreferredSheetHeightAndPreferredContentSize {
  // Given
  CGSize preferredContentSize = CGSizeMake(100, 100);
  CGFloat preferredSheetHeight = 200;
  self.presentationController.presentedViewController.preferredContentSize = preferredContentSize;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testPreferredSheetHeightNegativeAndPreferredContentSizePositive {
  // Given
  CGSize preferredContentSize = CGSizeMake(100, 100);
  CGFloat preferredSheetHeight = -200;
  self.presentationController.presentedViewController.preferredContentSize = preferredContentSize;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredContentSize.height,
                             0.001);
}

- (void)testPreferredSheetHeightNonZeroThenZero {
  // Given
  CGFloat preferredSheetHeight = 200;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;
  CGFloat sheetHeight = 300;
  self.sheetView.frame = CGRectMake(0, 0, 200, sheetHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];
  self.presentationController.preferredSheetHeight = 0;
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, (CGFloat)(sheetHeight / 2),
                             0.001);
}

- (void)testVeryLargePreferredSheetHeightAndSmallContent {
  // Given
  CGFloat scrollViewHeight = 100;
  CGRect smallFrame = CGRectMake(0, 0, 200, scrollViewHeight);
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:smallFrame];
  FakeSheetView *sheetView =
      [[FakeSheetView alloc] initWithFrame:smallFrame
                               contentView:[[UIView alloc] initWithFrame:smallFrame]
                                scrollView:scrollView
                  simulateScrollViewBounce:YES];

  self.presentationController.sheetView = sheetView;
  self.presentationController.preferredSheetHeight = 5000;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(CGRectGetHeight(sheetView.frame), CGRectGetHeight(smallFrame), 0.001);
}

- (void)testDefaultAdjustHeightForSafeAreaInsets {
  XCTAssertTrue(self.presentationController.adjustHeightForSafeAreaInsets);
}

- (void)testAdjustHeightForSafeAreaInsetsIsNo {
  // Given
  CGFloat preferredSheetHeight = 200;
  CGFloat inset = 20;
  self.sheetView.customSafeAreaInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
  self.presentationController.preferredSheetHeight = preferredSheetHeight;
  self.presentationController.adjustHeightForSafeAreaInsets = NO;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testAdjustHeightForSafeAreaInsetsSetBeforeHeightIsSet {
  // Given
  CGFloat preferredSheetHeight = 200;
  CGFloat inset = 20;
  self.sheetView.customSafeAreaInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
  self.presentationController.adjustHeightForSafeAreaInsets = NO;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testAdjustHeightForSafeAreaInsetsIsYes {
  // Given
  CGFloat preferredSheetHeight = 200;
  CGFloat inset = 20;
  self.sheetView.customSafeAreaInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
  self.presentationController.preferredSheetHeight = preferredSheetHeight;
  self.presentationController.adjustHeightForSafeAreaInsets = YES;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight + inset,
                             0.001);
}

- (void)testadjustHeightForSafeAreaInsetsChangesToNo {
  // Given
  CGFloat preferredSheetHeight = 200;
  CGFloat inset = 20;
  self.sheetView.customSafeAreaInsets = UIEdgeInsetsMake(inset, inset, inset, inset);
  self.presentationController.adjustHeightForSafeAreaInsets = YES;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;
  self.presentationController.adjustHeightForSafeAreaInsets = NO;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testSheetViewFrameMatchesScrollViewFrame {
  // Given
  CGFloat scrollViewHeight = 100;
  CGRect fakeFrame = CGRectMake(0, 0, 200, scrollViewHeight);
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  MDCSheetContainerView *fakeSheet =
      [[MDCSheetContainerView alloc] initWithFrame:fakeFrame
                                       contentView:[[UIView alloc] initWithFrame:fakeFrame]
                                        scrollView:scrollView
                          simulateScrollViewBounce:YES];

  // When
  [fakeSheet setNeedsLayout];
  [fakeSheet layoutIfNeeded];

  // Then
  CGRect scrollViewFrame = CGRectStandardize(fakeSheet.sheet.frame);
  XCTAssertEqualWithAccuracy(scrollViewFrame.size.height, scrollViewHeight, 0.001);
}

- (void)testSheetStateChangeCallback {
  // Given
  self.presentationController.delegate = self.delegateTest;
  self.presentationController.sheetView.delegate =
      (id<MDCSheetContainerViewDelegate>)self.presentationController;

  // When
  self.sheetView.sheetState = MDCSheetStateExtended;

  // Then
  XCTAssertEqual(self.delegateTest.delegateWasCalled, YES);
}

- (void)testSheetYOffsetChangeCallbackFromTargetPoint {
  // Given
  self.presentationController.delegate = self.delegateTest;
  self.presentationController.sheetView.delegate =
      (id<MDCSheetContainerViewDelegate>)self.presentationController;

  // When
  [self.sheetView targetPoint];

  // Then
  XCTAssertEqual(self.delegateTest.delegateWasCalled, YES);
}

- (void)testSheetYOffsetChangeCallbackFromDidPanToOffset {
  // Given
  self.presentationController.delegate = self.delegateTest;
  self.presentationController.sheetView.delegate =
      (id<MDCSheetContainerViewDelegate>)self.presentationController;

  // When
  [self.sheetView draggableView:self.sheetView.sheet didPanToOffset:10];

  // Then
  XCTAssertEqual(self.delegateTest.delegateWasCalled, YES);
}

#pragma mark - dismissOnDraggingDownSheet

- (void)testSettingDismissOnDraggingDownSheetOnPresentationController {
  // Given
  self.presentationController.dismissOnDraggingDownSheet = NO;

  // Then
  XCTAssertFalse(self.sheetView.dismissOnDraggingDownSheet);
}

- (void)testSettingDismissOnDraggingDownSheetViewDoesNotBlocksGesture {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = NO;

  // When
  BOOL shouldBeginDragging = [self.sheetView draggableView:self.sheetView.sheet
                           shouldBeginDraggingWithVelocity:CGPointMake(0, 0)];

  // Then
  XCTAssertTrue(shouldBeginDragging);
}

- (void)testSettingDismissOnDraggingDownSheetToNoViewShouldNotCloseWithDragDown {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = NO;
  self.sheetView.sheetState = MDCSheetStatePreferred;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, 1)];

  // Then
  XCTAssertNotEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetToNoViewShouldNotCloseWithDragDownWithPreferredHeight {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = NO;
  self.sheetView.sheetState = MDCSheetStatePreferred;
  self.sheetView.preferredSheetHeight = 222;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, 1)];

  // Then
  XCTAssertNotEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetViewToYesShouldCloseWithDragDown {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = YES;
  self.sheetView.sheetState = MDCSheetStatePreferred;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, 1)];

  // Then
  XCTAssertEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetViewToYesShouldCloseWithDragDownWithPreferredHeight {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = YES;
  self.sheetView.sheetState = MDCSheetStatePreferred;
  self.sheetView.preferredSheetHeight = 222;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, 1)];

  // Then
  XCTAssertEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetToNoViewShouldNotCloseWithDragUp {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = NO;
  self.sheetView.sheetState = MDCSheetStatePreferred;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, -1)];

  // Then
  XCTAssertNotEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetToNoViewShouldNotCloseWithDragUpWithPreferredHeight {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = NO;
  self.sheetView.sheetState = MDCSheetStatePreferred;
  self.sheetView.preferredSheetHeight = 222;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, -1)];

  // Then
  XCTAssertNotEqual(self.sheetView.sheetState, MDCSheetStateClosed);
}

- (void)testSettingDismissOnDraggingDownSheetViewToYesShouldCloseWithDragUp {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = YES;
  self.sheetView.sheetState = MDCSheetStatePreferred;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, -1)];

  // Then
  XCTAssertEqual(self.sheetView.sheetState, MDCSheetStatePreferred);
}

- (void)testSettingDismissOnDraggingDownSheetViewToYesShouldCloseWithDragUpWithPreferredHeight {
  // Given
  self.sheetView.dismissOnDraggingDownSheet = YES;
  self.sheetView.sheetState = MDCSheetStatePreferred;
  self.sheetView.preferredSheetHeight = 222;

  // When
  [self.sheetView draggableView:self.sheetView.sheet draggingEndedWithVelocity:CGPointMake(0, -1)];

  // Then
  XCTAssertEqual(self.sheetView.sheetState, MDCSheetStatePreferred);
}

@end
