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

#import "MaterialBottomSheet.h"

@interface MDCBottomSheetPresentationController (Testing)
- (void)updatePreferredSheetHeight;
@end

@interface MDCFakePresentedViewController : UIViewController
@property(nonatomic, assign) CGSize test_preferredContentSize;
@end

@implementation MDCFakePresentedViewController

- (CGSize)preferredContentSize {
  return self.test_preferredContentSize;
}

@end

@interface FakeSheetView : UIView
@property(nonatomic, assign) CGFloat preferredSheetHeight;
@end

@implementation FakeSheetView
@end

@interface MDCFakeBottomSheetPresentationController : MDCBottomSheetPresentationController
@property(nonatomic, strong) UIViewController *test_PresentedViewController;
@property(nonatomic, strong) UIView *test_sheetView;
@end

@implementation MDCFakeBottomSheetPresentationController

- (UIViewController *)presentedViewController {
  return self.test_PresentedViewController;
}

- (void)setTest_sheetView:(UIView *)test_sheetView {
  [self setValue:test_sheetView forKey:@"_sheetView"];
}

- (UIView *)test_sheetView {
  return [self valueForKey:@"_sheetView"];
}

@end

@interface MDCBottomSheetPresentationControllerTests : XCTestCase

@end

@implementation MDCBottomSheetPresentationControllerTests
/*
- (void)updatePreferredSheetHeight {
  CGFloat preferredContentHeight;
  if (self.preferredSheetHeight > 0.f) {
    preferredContentHeight = self.preferredSheetHeight;
  } else {
    preferredContentHeight = self.presentedViewController.preferredContentSize.height;
  }

  // If |preferredSheetHeight| has not been specified, use half of the current height.
  if (MDCCGFloatEqual(preferredContentHeight, 0)) {
    preferredContentHeight = MDCRound(_sheetView.frame.size.height / 2);
  }
  _sheetView.preferredSheetHeight = preferredContentHeight;
}
*/

- (void)testPreferredSheetHeightWhenPreferredContentSizeNonZero {
  // Given
  FakeSheetView *sheetView = [[FakeSheetView alloc] init];
  UIViewController *presentingViewController = [[UIViewController alloc] init];
  MDCFakePresentedViewController *presentedViewController = [[MDCFakePresentedViewController alloc] init];
  MDCFakeBottomSheetPresentationController *presentationController =
      [[MDCFakeBottomSheetPresentationController alloc]
          initWithPresentedViewController:presentedViewController
          presentingViewController:presentingViewController];
  presentationController.test_PresentedViewController = presentedViewController;
  presentationController.test_sheetView = sheetView;
  presentedViewController.test_preferredContentSize = CGSizeMake(50, 60);

  // When
  [presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(sheetView.preferredSheetHeight, 60, 0.001);
}

- (void)testPreferredSheetHeightWhenPreferredContentSizeIsZero {
  // Given
  FakeSheetView *sheetView = [[FakeSheetView alloc] init];
  UIViewController *presentingViewController = [[UIViewController alloc] init];
  MDCFakePresentedViewController *presentedViewController = [[MDCFakePresentedViewController alloc] init];
  MDCFakeBottomSheetPresentationController *presentationController =
  [[MDCFakeBottomSheetPresentationController alloc]
   initWithPresentedViewController:presentedViewController
   presentingViewController:presentingViewController];
  presentationController.test_sheetView = sheetView;
  sheetView.bounds = CGRectMake(0, 0, 100, 80);

  // When
  [presentationController updatePreferredSheetHeight];

  // Then
  XCTAssertEqualWithAccuracy(sheetView.preferredSheetHeight, 40, 0.001);
}

@end
