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

// Exposing internal methods for unit testing
@interface MDCBottomSheetPresentationController (Testing)
- (void)updatePreferredSheetHeight;
@end

/**
 A testing double for @c MDCSheetContainerView that allows inspecting the `preferredSheetHeight`
 property directly within the test.
 */
@interface FakeSheetView : UIView
@property(nonatomic, assign) CGFloat preferredSheetHeight;
@end

@implementation FakeSheetView {
  // Although it is possible to retrieve a non-standardized frame or bounds from a UIView object,
  // UIView will standardize the CGRect passed to `setFrame`. To aid in testing, we turn `frame`
  // into a simple get/set property. We still call up to the super implementation of `setFrame`
  // in case there are side-effects in UIView.
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

/**
 A testing double for @c MDCBottomSheetPresentationController that allows setting the `_sheetView`
 instance variable via KVC.
 */
@interface MDCFakeBottomSheetPresentationController : MDCBottomSheetPresentationController
@property(nonatomic, strong) UIView *test_sheetView;
@end

@implementation MDCFakeBottomSheetPresentationController

- (void)setTest_sheetView:(UIView *)test_sheetView {
  [self setValue:test_sheetView forKey:@"_sheetView"];
}

- (UIView *)test_sheetView {
  return [self valueForKey:@"_sheetView"];
}

@end

@interface MDCBottomSheetPresentationControllerPreferredSheetHeightTests : XCTestCase
@property(nonatomic, strong) FakeSheetView *sheetView;
@property(nonatomic, strong) MDCFakeBottomSheetPresentationController *presentationController;
@end

@implementation MDCBottomSheetPresentationControllerPreferredSheetHeightTests

- (void)setUp {
  [super setUp];

  // The `_sheetView` is both an input and an output to `updatePreferredSheetHeight`. Its frame is
  // used to guess the preferredContentHeight of the sheet. Once calculated, it receives an updated
  // value for `preferredSheetHeight`.
  self.sheetView = [[FakeSheetView alloc] init];

  // Only used as a required `-init` parameter for MDCBottomSheetPresentationController
  UIViewController *stubPresentingViewController = [[UIViewController alloc] init];

  // Used as an input to `-updatePreferredSheetHeight`. In this test, the value of
  // `preferredContentSize` will remain CGSizeZero (the default) and trigger inspection of the sheet
  // view's frame instead.
  UIViewController *presentedViewController = [[UIViewController alloc] init];

  // Although we are testing MDCBottomSheetPresentationController, we only care about the behavior
  // of `-updatePreferredSheetHeight` in this test. Because `_sheetView` is an iVar and not a
  // property that can be exposed in a testing category, we have to write a subclass that employs
  // KVC to allow setting the value of `_sheetView` to our test double.
  self.presentationController = [[MDCFakeBottomSheetPresentationController alloc]
      initWithPresentedViewController:presentedViewController
             presentingViewController:stubPresentingViewController];
  self.presentationController.test_sheetView = self.sheetView;
}

- (void)testUpdatePreferredSheetHeightWhenPresentedVCHasZeroPreferredContentSize {
  // Given
  CGFloat sheetFrameHeight = 80;
  self.presentationController.presentedViewController.preferredContentSize = CGSizeZero;
  self.sheetView.frame = CGRectMake(0, 0, 75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight, sheetFrameHeight / 2, 0.001);
}

- (void)testUpdatePreferredSheetHeightWhenPresentedVCHasZeroPreferredContentSizeUnstandardFrame {
  // Given
  CGFloat sheetFrameHeight = -80;
  self.presentationController.presentedViewController.preferredContentSize = CGSizeZero;
  self.sheetView.frame = CGRectMake(75, 80, -75, sheetFrameHeight);

  // When
  [self.presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(self.sheetView.preferredSheetHeight,
                             (CGFloat)fabs(sheetFrameHeight / 2), 0.001);
}

- (void)testUpdatePreferredSheetHeightWhenPresentedVCHasPositivePreferredContentSize {
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

@end
