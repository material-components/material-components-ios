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
#import <objc/runtime.h>

@interface MDCBaseTextField (Private)
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame;
@end

@interface MDCBaseTextField (Testing)
@property(nonatomic, assign) BOOL isEditingOverride;
@end

@implementation MDCBaseTextField (Testing)
@dynamic isEditingOverride;
- (BOOL)isEditingOverride {
  return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsEditingOverride:(BOOL)isEditingOverride {
  objc_setAssociatedObject(self, @selector(isEditingOverride), @(isEditingOverride),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)isEditing {
  return self.isEditingOverride ? self.isEditingOverride : [super isEditing];
}
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
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;

  // When
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;

  // Then
  XCTAssertTrue(textField.leftView == textField.leadingView,
                @"The leading view should be the left view.");
}

- (void)testLeadingViewRTL {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;

  // When
  UIView *sideView = [self createSideView];
  textField.leadingView = sideView;

  // Then
  XCTAssertTrue(textField.rightView == textField.leadingView,
                @"The leading view should be the right view.");
}

- (void)testTrailingViewLTR {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;

  // When
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;

  // Then
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view should be the right view.");
}

- (void)testTrailingViewRTL {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;

  // When
  UIView *sideView = [self createSideView];
  textField.trailingView = sideView;

  // Then
  XCTAssertTrue(textField.leftView == textField.trailingView,
                @"The trailing view should be the left view.");
}

- (void)testLeadingViewModeLTR {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.leftViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the left view mode.");
}

- (void)testLeadingViewModeRTL {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.rightViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeLTR {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.trailingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.rightView == textField.trailingView,
                @"The trailing view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeRTL {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.trailingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.leftViewMode == textField.trailingViewMode,
                @"The trailing view mode should be equal to left view mode.");
}

- (void)testAdjustTextAreaFrameWithParentClassTextAreaFrame {
  // Given
  CGRect textAreaFrame = CGRectMake(30, 50, 120, 20);
  CGRect parentClassTextAreaFrame = CGRectMake(20, 30, 120, 50);

  // When
  CGRect finalTextAreaFrame =
      [[[MDCBaseTextField alloc] init] adjustTextAreaFrame:textAreaFrame
                              withParentClassTextAreaFrame:parentClassTextAreaFrame];

  // Then
  CGRect correctFinalTextAreaFrame = CGRectMake(30, 35, 120, 50);
  XCTAssertEqualObjects(NSStringFromCGRect(correctFinalTextAreaFrame),
                        NSStringFromCGRect(finalTextAreaFrame));
}

- (MDCBaseTextField *)createLTRTextFieldWithLeadingView:(BOOL)leadingView
                                           trailingView:(BOOL)trailingView
                                               viewMode:(UITextFieldViewMode)viewMode {
  CGRect frame = CGRectMake(0, 0, 100, 60);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:frame];
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  if (leadingView) {
    textField.leadingView = [self createSideView];
  }
  if (trailingView) {
    textField.trailingView = [self createSideView];
  }
  textField.trailingViewMode = viewMode;
  textField.leadingViewMode = viewMode;
  UIWindow *window = [[UIWindow alloc] init];
  UIView *superview = [[UIView alloc] initWithFrame:frame];
  [window addSubview:superview];
  [superview addSubview:textField];
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
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeAlways];
  CGRect leadingFrameNotEditing = textField.leftView.frame;

  // When
  [textField becomeFirstResponder];
  CGRect leadingFrameEditing = textField.leftView.frame;

  // Then
  XCTAssert([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse(textField.leadingView.hidden);
}

- (void)testOnlyTrailingViewWithViewModeAlways {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeAlways];
  CGRect trailingFrameNotEditing = textField.rightView.frame;

  // When
  [textField becomeFirstResponder];
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssert([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
  XCTAssertFalse(textField.trailingView.hidden);
}

- (void)testLeadingAndTrailingViewsWithViewModeAlways {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeAlways];

  // When
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  [textField becomeFirstResponder];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssert([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssert([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse(textField.trailingView.hidden);
}

- (void)testNoLeadingOrTrailingViewWithViewModeAlways {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeAlways];

  // When
  [self forceLayoutOfView:textField];

  // Then
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyLeadingViewWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeNever];

  // When
  [self forceLayoutOfView:textField];
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  [textField becomeFirstResponder];

  // Then
  XCTAssertTrue(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyTrailingViewWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeNever];

  // When
  [self forceLayoutOfView:textField];
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  [textField becomeFirstResponder];

  // Then
  XCTAssertTrue(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertNil(textField.leadingView);
}

- (void)testLeadingAndTrailingViewsWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeNever];
  // When
  [self forceLayoutOfView:textField];
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  [textField becomeFirstResponder];

  // Then
  XCTAssertTrue(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertTrue(textField.leadingView.hidden);
}

- (void)testNoLeadingOrTrailingViewWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeNever];
  // When
  UIView *leadingView = textField.leadingView;
  UIView *trailingView = textField.trailingView;
  [textField becomeFirstResponder];

  // Then
  XCTAssertNil(leadingView);
  XCTAssertNil(trailingView);
}

- (void)testOnlyLeadingViewWithViewModeWhileEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:YES
                                 trailingView:NO
                                     viewMode:UITextFieldViewModeWhileEditing];
  // When
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;

  // Then
  XCTAssertTrue(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
}

- (void)testOnlyTrailingViewWithViewModeWhileEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:NO
                                 trailingView:YES
                                     viewMode:UITextFieldViewModeWhileEditing];

  // When
  [self forceLayoutOfView:textField];
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertFalse(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testLeadingAndTrailingViewsWithViewModeWhileEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:YES
                                 trailingView:YES
                                     viewMode:UITextFieldViewModeWhileEditing];

  // When
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertFalse(textField.leadingView.hidden);
  XCTAssertFalse(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testNoLeadingOrTrailingViewWithViewModeWhileEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:NO
                                 trailingView:NO
                                     viewMode:UITextFieldViewModeWhileEditing];

  // When
  [self forceLayoutOfView:textField];

  // Then
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyleadingViewWithViewModeUnlessEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:YES
                                 trailingView:NO
                                     viewMode:UITextFieldViewModeUnlessEditing];

  // When
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertFalse(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
}

- (void)testOnlytrailingViewWithViewModeUnlessEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:NO
                                 trailingView:YES
                                     viewMode:UITextFieldViewModeUnlessEditing];

  // When
  [self forceLayoutOfView:textField];
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertFalse(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testLeadingAndTrailingViewsWithViewModeUnlessEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:YES
                                 trailingView:YES
                                     viewMode:UITextFieldViewModeUnlessEditing];

  // When
  [self forceLayoutOfView:textField];
  CGRect leadingFrameNotEditing = textField.leftView.frame;
  CGRect trailingFrameNotEditing = textField.rightView.frame;
  BOOL leadingViewHiddenBeforeBecomingFirstResponder = textField.leadingView.hidden;
  BOOL trailingViewHiddenBeforeBecomingFirstResponder = textField.trailingView.hidden;
  [textField becomeFirstResponder];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertFalse(leadingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertFalse(trailingViewHiddenBeforeBecomingFirstResponder);
  XCTAssertTrue(textField.leadingView.hidden);
  XCTAssertTrue(textField.trailingView.hidden);
  XCTAssertFalse([self CGRect:leadingFrameNotEditing isEqualToCGRect:leadingFrameEditing]);
  XCTAssertFalse([self CGRect:trailingFrameNotEditing isEqualToCGRect:trailingFrameEditing]);
}

- (void)testNoLeadingOrTrailingViewWithViewModeUnlessEditing {
  // Given
  MDCBaseTextField *textField =
      [self createLTRTextFieldWithLeadingView:NO
                                 trailingView:NO
                                     viewMode:UITextFieldViewModeUnlessEditing];

  // When
  [self forceLayoutOfView:textField];

  // Then
  XCTAssertNil(textField.leadingView);
  XCTAssertNil(textField.trailingView);
}

@end
