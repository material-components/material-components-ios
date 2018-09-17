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

#import "MaterialBottomSheet.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCSheetContainerView.h"

// Exposing internal methods for unit testing
@interface MDCBottomSheetPresentationController (Testing)
@property(nonatomic, strong) MDCSheetContainerView *sheetView;
- (void)updatePreferredSheetHeight;
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
@end

@interface MDCBottomSheetPresentationControllerPreferredSheetHeightTests : XCTestCase
@property(nonatomic, strong) FakeSheetView *sheetView;
@property(nonatomic, strong) MDCBottomSheetPresentationController *presentationController;
@end

@implementation MDCBottomSheetPresentationControllerPreferredSheetHeightTests

- (void)setUp {
  [super setUp];

  // The `sheetView` property is both an input and an output to `setPreferredSheetHeight:`. Its
  // frame may be used to guess the preferredContentHeight of the sheet. Once calculated, it
  // receives an updated value for `preferredSheetHeight`.
  self.sheetView = [[FakeSheetView alloc] initWithFrame:CGRectZero
                                            contentView:[[UIView alloc] init]
                                             scrollView:[[UIScrollView alloc] init]];

  // Only used as a required `-init` parameters for MDCBottomSheetPresentationController
  UIViewController *stubPresentingViewController = [[UIViewController alloc] init];
  UIViewController *stubPresentedViewController = [[UIViewController alloc] init];

  self.presentationController = [[MDCBottomSheetPresentationController alloc]
      initWithPresentedViewController:stubPresentedViewController
             presentingViewController:stubPresentingViewController];
  self.presentationController.sheetView = self.sheetView;
}

- (void)testSetPreferredSheetHeightZeroWhenSheetViewHasStandardizedFrame {
  // Given
  CGFloat sheetFrameHeight = 80;
  self.sheetView.frame = CGRectMake(0, 0, 75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, sheetFrameHeight / 2, 0.001);
}

- (void)testSetPreferredSheetHeightZeroWhenSheetViewHasUnstandardizedFrame {
  // Given
  CGFloat sheetFrameHeight = -80;
  self.sheetView.frame = CGRectMake(75, 80, -75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight,
                             (CGFloat)fabs(sheetFrameHeight / 2), 0.001);
}

- (void)testSetPreferredSheetHeightPositiveValue {
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

- (void)testSetPreferredSheetHeightNegativeValue {
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

- (void)testSetPreferredSheetHeight {
  // Given
  CGFloat preferredSheetHeight = 100;
  self.presentationController.preferredSheetHeight = preferredSheetHeight;

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, preferredSheetHeight, 0.001);
}

- (void)testSetNegativePreferredSheetHeight {
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

- (void)testSetPreferredSheetHeightAndPreferredContentSize {
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

@end
