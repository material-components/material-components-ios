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

#import <objc/runtime.h>
#import "MaterialTextFields+ContainedInputView.h"

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
- (BOOL)isEditing {
  return self.isEditingOverride ? self.isEditingOverride : [super isEditing];
}
@end

@interface MDCBaseTextFieldTests : XCTestCase
@end

@implementation MDCBaseTextFieldTests

#pragma mark Helper Methods

- (UIView *)createSideView {
  UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  sideView.backgroundColor = [UIColor blueColor];
  return sideView;
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

- (void)setIsEditing:(BOOL)isEditing onTextField:(MDCBaseTextField *)textField {
  [textField becomeFirstResponder];
  textField.isEditingOverride = isEditing;
  NSLog(@"yo yo: %@", @(textField.isEditingOverride));
  NSLog(@"bo bo: %@", @(textField.isEditing));
}

#pragma mark Tests

- (void)testLeadingViewEqualsLeftViewInLTR {
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

- (void)testLeadingViewEqualsRightViewInRTL {
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

- (void)testTrailingViewEqualsRightViewInLTR {
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

- (void)testTrailingViewEqualsLeftViewInRTL {
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

- (void)testLeadingViewModeEqualsLeftViewModeInLTR {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.leftViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the left view mode.");
}

- (void)testLeadingViewModeEqualsRightViewModeInRTL {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionRightToLeft;
  textField.leadingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.rightViewMode == textField.leadingViewMode,
                @"The leading view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeEqualsRightViewModeInLTR {
  // Given
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];

  // When
  textField.layoutDirection = UIUserInterfaceLayoutDirectionLeftToRight;
  textField.trailingViewMode = UITextFieldViewModeAlways;

  // Then
  XCTAssertTrue(textField.rightViewMode == textField.trailingViewMode,
                @"The trailing view mode should be equal to the right view mode.");
}

- (void)testTrailingViewModeEqualsLeftViewModeInRTL {
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
  CGRect desiredTextAreaFrame = CGRectMake(30, 50, 120, 20);
  CGRect pretendParentClassTextAreaFrame = CGRectMake(20, 30, 120, 50);
  CGFloat pretendSystemDefinedHeight = CGRectGetHeight(pretendParentClassTextAreaFrame);
  CGFloat desiredTextAreaMidY = CGRectGetMidY(desiredTextAreaFrame);
  CGFloat halfOfPretendSystemDefinedHeight = (pretendSystemDefinedHeight * (CGFloat)0.5);
  CGFloat desiredTextAreaMinY = desiredTextAreaMidY - halfOfPretendSystemDefinedHeight;
  CGRect desiredFinalTextAreaFrame =
      CGRectMake(CGRectGetMinX(desiredTextAreaFrame), desiredTextAreaMinY,
                 CGRectGetWidth(desiredTextAreaFrame), pretendSystemDefinedHeight);

  // When
  CGRect finalTextAreaFrame =
      [[[MDCBaseTextField alloc] init] adjustTextAreaFrame:desiredTextAreaFrame
                              withParentClassTextAreaFrame:pretendParentClassTextAreaFrame];

  // Then
  XCTAssertEqualObjects(NSStringFromCGRect(desiredFinalTextAreaFrame),
                        NSStringFromCGRect(finalTextAreaFrame));
}

- (void)testOnlyLeadingViewWithViewModeAlways {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeAlways];
  CGRect leadingFrameNotEditing = textField.leftView.frame;

  // When
  [self setIsEditing:YES onTextField:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  BOOL leadingViewIsVisible = !textField.leadingView.hidden;

  // Then
  XCTAssertTrue(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
  XCTAssertTrue(leadingViewIsVisible);
}

- (void)testOnlyTrailingViewWithViewModeAlways {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeAlways];
  CGRect trailingFrameNotEditing = textField.rightView.frame;

  // When
  [self setIsEditing:YES onTextField:textField];
  CGRect trailingFrameEditing = textField.rightView.frame;
  BOOL trailingViewIsVisible = !textField.trailingView.hidden;

  // Then
  XCTAssertTrue(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
  XCTAssertTrue(trailingViewIsVisible);
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
  [self setIsEditing:YES onTextField:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;
  BOOL trailingViewIsVisible = !textField.trailingView.hidden;
  BOOL leadingViewIsVisible = !textField.leadingView.hidden;

  // Then
  XCTAssertTrue(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
  XCTAssertTrue(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
  XCTAssertTrue(trailingViewIsVisible);
  XCTAssertTrue(leadingViewIsVisible);
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
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  [textField becomeFirstResponder];
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;

  // Then
  XCTAssertFalse(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(leadingViewVisibleAfterBecomingFirstResponder);
  XCTAssertNil(textField.trailingView);
}

- (void)testOnlyTrailingViewWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeNever];

  // When
  [self forceLayoutOfView:textField];
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;

  // Then
  XCTAssertFalse(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertNil(textField.leadingView);
}

- (void)testLeadingAndTrailingViewsWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:YES
                                                           trailingView:YES
                                                               viewMode:UITextFieldViewModeNever];
  // When
  [self forceLayoutOfView:textField];
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;

  // Then
  XCTAssertFalse(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(leadingViewVisibleAfterBecomingFirstResponder);
}

- (void)testNoLeadingOrTrailingViewWithViewModeNever {
  // Given
  MDCBaseTextField *textField = [self createLTRTextFieldWithLeadingView:NO
                                                           trailingView:NO
                                                               viewMode:UITextFieldViewModeNever];
  // When
  UIView *leadingView = textField.leadingView;
  UIView *trailingView = textField.trailingView;
  [self setIsEditing:YES onTextField:textField];

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
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  CGRect leadingFrameEditing = textField.leftView.frame;
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;

  // Then
  XCTAssertFalse(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertTrue(leadingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
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
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertFalse(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertTrue(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
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
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertFalse(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertTrue(leadingViewVisibleAfterBecomingFirstResponder);
  XCTAssertTrue(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
  XCTAssertFalse(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
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
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;
  CGRect leadingFrameEditing = textField.leftView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertTrue(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(leadingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
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
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertTrue(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
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
  BOOL leadingViewVisibleBeforeBecomingFirstResponder = !textField.leadingView.hidden;
  BOOL trailingViewVisibleBeforeBecomingFirstResponder = !textField.trailingView.hidden;
  [self setIsEditing:YES onTextField:textField];
  [self forceLayoutOfView:textField];
  BOOL leadingViewVisibleAfterBecomingFirstResponder = !textField.leadingView.hidden;
  BOOL trailingViewVisibleAfterBecomingFirstResponder = !textField.trailingView.hidden;
  CGRect leadingFrameEditing = textField.leftView.frame;
  CGRect trailingFrameEditing = textField.rightView.frame;

  // Then
  XCTAssertTrue(textField.isEditing);
  XCTAssertTrue(leadingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertTrue(trailingViewVisibleBeforeBecomingFirstResponder);
  XCTAssertFalse(leadingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(trailingViewVisibleAfterBecomingFirstResponder);
  XCTAssertFalse(CGRectEqualToRect(leadingFrameNotEditing, leadingFrameEditing));
  XCTAssertFalse(CGRectEqualToRect(trailingFrameNotEditing, trailingFrameEditing));
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
