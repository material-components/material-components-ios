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

@interface MDCBaseTextFieldTests : XCTestCase
@end

@implementation MDCBaseTextFieldTests

#pragma mark Helper Methods

- (UIView *)createSideView {
  UIView *sideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  sideView.backgroundColor = [UIColor blueColor];
  return sideView;
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

- (void)testClearButtonRectForBounds {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];

  // When
  textField.clearButtonMode = UITextFieldViewModeAlways;
  [textField setNeedsLayout];
  [textField layoutIfNeeded];

  // Then
  CGRect expectedClearButtonFrame = CGRectMake(99, 21, 19, 19);
  CGRect actualClearButtonFrame = [textField clearButtonRectForBounds:textFieldFrame];
  XCTAssertTrue(CGRectEqualToRect(actualClearButtonFrame, expectedClearButtonFrame));
}

- (void)testFloatingLabelColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *floatingLabelColor = [UIColor redColor];

  // When
  [textField setFloatingLabelColor:floatingLabelColor forState:UIControlStateNormal];
  [textField setFloatingLabelColor:floatingLabelColor forState:MDCTextControlStateEditing];
  [textField setFloatingLabelColor:floatingLabelColor forState:UIControlStateDisabled];
  [textField setNeedsLayout];
  [textField layoutIfNeeded];

  // Then
  XCTAssertEqualObjects(floatingLabelColor,
                        [textField floatingLabelColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(floatingLabelColor,
                        [textField floatingLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(floatingLabelColor,
                        [textField floatingLabelColorForState:UIControlStateDisabled]);
}

- (void)testNormalLabelColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *normalLabelColor = [UIColor blueColor];

  // When
  [textField setNormalLabelColor:normalLabelColor forState:UIControlStateNormal];
  [textField setNormalLabelColor:normalLabelColor forState:MDCTextControlStateEditing];
  [textField setNormalLabelColor:normalLabelColor forState:UIControlStateDisabled];
  [textField setNeedsLayout];
  [textField layoutIfNeeded];

  // Then
  XCTAssertEqualObjects(normalLabelColor,
                        [textField normalLabelColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(normalLabelColor,
                        [textField normalLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(normalLabelColor,
                        [textField normalLabelColorForState:UIControlStateDisabled]);
}

- (void)testTextColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *textColor = [UIColor purpleColor];

  // When
  [textField setTextColor:textColor forState:UIControlStateNormal];
  [textField setTextColor:textColor forState:MDCTextControlStateEditing];
  [textField setTextColor:textColor forState:UIControlStateDisabled];
  [textField setNeedsLayout];
  [textField layoutIfNeeded];

  // Then
  XCTAssertEqualObjects(textColor, [textField textColorForState:UIControlStateNormal]);
  XCTAssertEqualObjects(textColor, [textField textColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(textColor, [textField textColorForState:UIControlStateDisabled]);
}

@end
