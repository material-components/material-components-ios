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

#import "MaterialTextFields+ContainedInputView.h"

@interface MDCBaseTextField (Testing)
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame;
@end

@interface MDCBaseTextFieldTests : XCTestCase
@end

@implementation MDCBaseTextFieldTests

- (UIView *)createSideView {
  UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  sideView.backgroundColor = [UIColor blueColor];
  return sideView;
}

- (void)testLeadingViewLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;
  XCTAssertTrue(textField.leftView == textField.leadingView,
                @"The leading view should be the left view.");
}

- (void)testLeadingViewRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;
  XCTAssertTrue(textField.rightView == textField.leadingView,
                @"The leading view should be the right view.");
}

- (void)testTrailingViewLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view should be the right view.");
}

- (void)testTrailingViewRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;
  XCTAssertTrue(textField.leftView == textField.trailingView,
                @"The trailing view should be the left view.");
}

- (void)testLeadingViewModeLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.leadingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.leftViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the left view mode.");
}

- (void)testLeadingViewModeRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.leadingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.rightViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeLTR {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.trailingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeRTL {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.trailingViewMode = UITextFieldViewModeAlways;
  XCTAssertTrue(textField.leftViewMode == textField.trailingViewMode,
                @"The trailing view mode should be equal to left view mode.");
}

- (void)testAdjustTextAreaFrameWithParentClassTextAreaFrame {
  CGRect textAreaFrame = CGRectMake(30, 50, 120, 20);
  CGRect parentClassTextAreaFrame = CGRectMake(20, 30, 120, 50);
  CGRect correctFinalTextAreaFrame = CGRectMake(30, 35, 120, 50);
  CGRect finalTextAreaFrame =
      [[[MDCBaseTextField alloc] init] adjustTextAreaFrame:textAreaFrame
                              withParentClassTextAreaFrame:parentClassTextAreaFrame];
  XCTAssertEqualObjects(NSStringFromCGRect(correctFinalTextAreaFrame),
                        NSStringFromCGRect(finalTextAreaFrame));
}

- (MDCBaseTextField *)createTextFieldWithLeadingView:(BOOL)leadingView
                          trailingView:(BOOL)trailingView
                              viewMode:(UITextFieldViewMode)viewMode {
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  if (leadingView) {
    textField.leadingView = [self createSideView];
  }
  if (trailingView) {
    textField.trailingView = [self createSideView];
  }
  textField.trailingViewMode = viewMode;
  textField.leadingViewMode = viewMode;
  UIWindow *window = [[UIWindow alloc] init];
  [window addSubview:textField];
  return textField;
}

- (void)forceLayoutOfView:(UIView *)view {
  [view setNeedsLayout];
  [view layoutIfNeeded];
}

- (BOOL)CGRect:(CGRect)CGRect1 isEqualToCGRect:(CGRect)CGRect2 {
  NSString *CGRect1Description = NSStringFromCGRect(CGRect1);
  NSString *CGRect2Description = NSStringFromCGRect(CGRect2);
  return [CGRect1Description isEqualToString:CGRect2Description];
}

- (void)testOnlyLeadingViewWithViewModeAlways {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeAlways];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  [textField becomeFirstResponder];
  CGRect leadingFrameEditing = textField.leftView.frame;
  XCTAssert([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse(textField.leadingView.hidden);
}

- (void)testOnlyTrailingViewWithViewModeAlways {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeAlways];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  [textField becomeFirstResponder];
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssert([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
  XCTAssertFalse(textField.trailingView.hidden);
}

- (void)testLeadingAndTrailingViewsWithViewModeAlways {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeAlways];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  [textField becomeFirstResponder];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssert([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssert([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse(textField.trailingView.hidden);
}

- (void)testNoLeadingOrTrailingViewWithViewModeAlways {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeAlways];
  [self forceLayoutOfView:textField];
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyLeadingViewWithViewModeNever {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeNever];
  [self forceLayoutOfView:textField];
  XCTAssertTrue(textField.leadingView.hidden);
  [textField becomeFirstResponder];
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyTrailingViewWithViewModeNever {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeNever];
  [self forceLayoutOfView:textField];
  XCTAssertTrue(textField.trailingView.hidden);
  [textField becomeFirstResponder];
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertNil(textField.leadingView);
}

- (void)testLeadingAndTrailingViewsWithViewModeNever {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeNever];
  [self forceLayoutOfView:textField];
  XCTAssertTrue(textField.leadingView.hidden);
  [textField becomeFirstResponder];
  XCTAssertTrue(textField.leadingView.hidden);
}

- (void)testNoLeadingOrTrailingViewWithViewModeNever {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeNever];
  [self forceLayoutOfView:textField];
  XCTAssertNil(textField.leadingView);
  [textField becomeFirstResponder];
  XCTAssertNil(textField.leadingView);
}

- (void)testOnlyLeadingViewWithViewModeWhileEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeWhileEditing];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  XCTAssertTrue(textField.leadingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
}

- (void)testOnlyTrailingViewWithViewModeWhileEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeWhileEditing];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  XCTAssertTrue(textField.trailingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssertFalse(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testLeadingAndTrailingViewsWithViewModeWhileEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeWhileEditing];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertTrue(textField.trailingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testNoLeadingOrTrailingViewWithViewModeWhileEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeWhileEditing];
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyleadingViewWithViewModeUnlessEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeUnlessEditing];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  XCTAssertFalse(textField.leadingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
}

- (void)testOnlytrailingViewWithViewModeUnlessEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeUnlessEditing];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  XCTAssertFalse(textField.trailingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testLeadingAndTrailingViewsWithViewModeUnlessEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:YES
                                                        trailingView:YES
                                                            viewMode:UITextFieldViewModeUnlessEditing];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse(textField.trailingView.hidden);
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testNoLeadingOrTrailingViewWithViewModeUnlessEditing {
  MDCBaseTextField *textField = [self createTextFieldWithLeadingView:NO
                                                        trailingView:NO
                                                            viewMode:UITextFieldViewModeUnlessEditing];
  [self forceLayoutOfView:textField];
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

@end
