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

#import "MaterialTextControls.h"

#import "../../src/private/MDCTextControlLabelState.h"

@interface MDCBaseTextField (Private)
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
- (CGRect)adjustTextAreaFrame:(CGRect)textRect
    withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame;
- (BOOL)shouldPlaceholderBeVisibleWithPlaceholder:(NSString *)placeholder
                                             text:(NSString *)text
                                       labelState:(MDCTextControlLabelState)labelState;
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
  CGRect expectedClearButtonFrame = CGRectMake(99, 20, 19, 19);
  CGRect actualClearButtonFrame = [textField clearButtonRectForBounds:textFieldFrame];
  XCTAssertTrue(CGRectEqualToRect(actualClearButtonFrame, expectedClearButtonFrame));
}

- (void)testFloatingLabelColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *floatingLabelColorNormal = [UIColor blueColor];
  UIColor *floatingLabelColorEditing = [UIColor greenColor];
  UIColor *floatingLabelColorDisabled = [UIColor purpleColor];

  // When
  [textField setFloatingLabelColor:floatingLabelColorNormal forState:MDCTextControlStateNormal];
  [textField setFloatingLabelColor:floatingLabelColorEditing forState:MDCTextControlStateEditing];
  [textField setFloatingLabelColor:floatingLabelColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(floatingLabelColorNormal,
                        [textField floatingLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(floatingLabelColorEditing,
                        [textField floatingLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(floatingLabelColorDisabled,
                        [textField floatingLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testNormalLabelColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *normalLabelColorNormal = [UIColor blueColor];
  UIColor *normalLabelColorEditing = [UIColor greenColor];
  UIColor *normalLabelColorDisabled = [UIColor purpleColor];

  // When
  [textField setNormalLabelColor:normalLabelColorNormal forState:MDCTextControlStateNormal];
  [textField setNormalLabelColor:normalLabelColorEditing forState:MDCTextControlStateEditing];
  [textField setNormalLabelColor:normalLabelColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(normalLabelColorNormal,
                        [textField normalLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(normalLabelColorEditing,
                        [textField normalLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(normalLabelColorDisabled,
                        [textField normalLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testTextColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *textColorNormal = [UIColor blueColor];
  UIColor *textColorEditing = [UIColor greenColor];
  UIColor *textColorDisabled = [UIColor purpleColor];

  // When
  [textField setTextColor:textColorNormal forState:MDCTextControlStateNormal];
  [textField setTextColor:textColorEditing forState:MDCTextControlStateEditing];
  [textField setTextColor:textColorDisabled forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(textColorNormal, [textField textColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(textColorEditing, [textField textColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(textColorDisabled,
                        [textField textColorForState:MDCTextControlStateDisabled]);
}

- (void)testAssistiveLabelColorAccessors {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 40);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  UIColor *leadingAssistiveLabelColorNormal = [UIColor blueColor];
  UIColor *leadingAssistiveLabelColorEditing = [UIColor greenColor];
  UIColor *leadingAssistiveLabelColorDisabled = [UIColor purpleColor];
  UIColor *trailingAssistiveLabelColorNormal = [UIColor brownColor];
  UIColor *trailingAssistiveLabelColorEditing = [UIColor magentaColor];
  UIColor *trailingAssistiveLabelColorDisabled = [UIColor yellowColor];

  // When
  [textField setLeadingAssistiveLabelColor:leadingAssistiveLabelColorNormal
                                  forState:MDCTextControlStateNormal];
  [textField setLeadingAssistiveLabelColor:leadingAssistiveLabelColorEditing
                                  forState:MDCTextControlStateEditing];
  [textField setLeadingAssistiveLabelColor:leadingAssistiveLabelColorDisabled
                                  forState:MDCTextControlStateDisabled];
  [textField setTrailingAssistiveLabelColor:trailingAssistiveLabelColorNormal
                                   forState:MDCTextControlStateNormal];
  [textField setTrailingAssistiveLabelColor:trailingAssistiveLabelColorEditing
                                   forState:MDCTextControlStateEditing];
  [textField setTrailingAssistiveLabelColor:trailingAssistiveLabelColorDisabled
                                   forState:MDCTextControlStateDisabled];

  // Then
  XCTAssertEqualObjects(leadingAssistiveLabelColorNormal,
                        [textField leadingAssistiveLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(leadingAssistiveLabelColorEditing,
                        [textField leadingAssistiveLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(leadingAssistiveLabelColorDisabled,
                        [textField leadingAssistiveLabelColorForState:MDCTextControlStateDisabled]);
  XCTAssertEqualObjects(trailingAssistiveLabelColorNormal,
                        [textField trailingAssistiveLabelColorForState:MDCTextControlStateNormal]);
  XCTAssertEqualObjects(trailingAssistiveLabelColorEditing,
                        [textField trailingAssistiveLabelColorForState:MDCTextControlStateEditing]);
  XCTAssertEqualObjects(
      trailingAssistiveLabelColorDisabled,
      [textField trailingAssistiveLabelColorForState:MDCTextControlStateDisabled]);
}

- (void)testSizeThatFits {
  // Given
  CGRect largeTextFieldFrame = CGRectMake(0, 0, 130, 300);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:largeTextFieldFrame];

  // When
  textField.text = @"text";
  [textField sizeToFit];

  // Then
  CGSize newSize = textField.frame.size;
  CGSize correctSize = CGSizeMake(130, 59);
  XCTAssertTrue(CGSizeEqualToSize(newSize, correctSize));
}

- (void)testPlaceholderVisibility {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];

  // When
  NSString *placeholder = @"placeholder";
  NSString *text = @"text";
  NSString *nilPlaceholder = nil;
  NSString *nilText = nil;

  // Then
  XCTAssertFalse([textField
      shouldPlaceholderBeVisibleWithPlaceholder:nilPlaceholder
                                           text:text
                                     labelState:MDCTextControlLabelStateNormal]);
  XCTAssertFalse([textField
      shouldPlaceholderBeVisibleWithPlaceholder:placeholder
                                           text:text
                                     labelState:MDCTextControlLabelStateNormal]);
  XCTAssertFalse([textField
      shouldPlaceholderBeVisibleWithPlaceholder:placeholder
                                           text:nilText
                                     labelState:MDCTextControlLabelStateNormal]);
  XCTAssertTrue([textField
      shouldPlaceholderBeVisibleWithPlaceholder:placeholder
                                           text:nilText
                                     labelState:MDCTextControlLabelStateFloating]);
}

- (void)testDefaultAccessibilityLabelWithOnlyLabelText {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *labelText = @"label text";

  // When
  textField.label.text = labelText;

  // Then
  XCTAssertTrue([labelText isEqualToString:textField.accessibilityLabel]);
}

- (void)testDefaultAccessibilityLabelWithLeadingAssistiveLabelText {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *leadingAssistiveLabelText = @"leading assistive label text";

  // When
  textField.leadingAssistiveLabel.text = leadingAssistiveLabelText;

  // Then
  XCTAssertTrue(
      [textField.leadingAssistiveLabel.text isEqualToString:textField.accessibilityLabel]);
}

- (void)testDefaultAccessibilityLabelWithTrailingAssistiveLabelText {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *trailingAssistiveLabelText = @"trailing assistive label text";

  // When
  textField.trailingAssistiveLabel.text = trailingAssistiveLabelText;

  // Then
  XCTAssertTrue(
      [textField.trailingAssistiveLabel.text isEqualToString:textField.accessibilityLabel]);
}

- (void)testDefaultAccessibilityLabelWithTextSetOnEveryLabel {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *labelText = @"label text";
  NSString *leadingAssistiveLabelText = @"leading assistive label text";
  NSString *trailingAssistiveLabelText = @"trailing assistive label text";

  // When
  textField.label.text = labelText;
  textField.leadingAssistiveLabel.text = leadingAssistiveLabelText;
  textField.trailingAssistiveLabel.text = trailingAssistiveLabelText;

  // Then
  NSString *concatenatedText =
      [NSString stringWithFormat:@"%@, %@, %@", labelText, leadingAssistiveLabelText,
                                 trailingAssistiveLabelText];
  XCTAssertTrue([concatenatedText isEqualToString:textField.accessibilityLabel]);
}

- (void)testDefaultAccessibilityLabelWithNoLabelText {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];

  // Then
  XCTAssertNil(textField.accessibilityLabel);
}

- (void)testDefaultAccessibilityLabelWithLabelTextAndLeadingAssistiveLabelText {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *labelText = @"label text";
  NSString *leadingAssistiveLabelText = @"leading assistive label text";

  // When
  textField.label.text = labelText;
  textField.leadingAssistiveLabel.text = leadingAssistiveLabelText;

  // Then
  NSString *concatenatedText =
      [NSString stringWithFormat:@"%@, %@", labelText, leadingAssistiveLabelText];
  XCTAssertTrue([concatenatedText isEqualToString:textField.accessibilityLabel]);
}

- (void)testClientSpecifiedAccessibilityLabel {
  // Given
  CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
  MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];
  NSString *labelText = @"label text";
  NSString *leadingAssistiveLabelText = @"leading assistive label text";
  NSString *userSpecifiedAccessibilityLabel = @"user-specified accessibility label";

  // When
  textField.label.text = labelText;
  textField.leadingAssistiveLabel.text = leadingAssistiveLabelText;
  textField.accessibilityLabel = userSpecifiedAccessibilityLabel;

  // Then
  XCTAssertTrue([userSpecifiedAccessibilityLabel isEqualToString:textField.accessibilityLabel]);
}

- (void)testAdjustsFontForContentSizeCategory {
  if (@available(iOS 10.0, *)) {
    // Given
    CGRect textFieldFrame = CGRectMake(0, 0, 130, 100);
    MDCBaseTextField *textField = [[MDCBaseTextField alloc] initWithFrame:textFieldFrame];

    // When
    textField.adjustsFontForContentSizeCategory = YES;

    // Then
    XCTAssertTrue(textField.adjustsFontForContentSizeCategory);
    XCTAssertTrue(textField.leadingAssistiveLabel.adjustsFontForContentSizeCategory);
    XCTAssertTrue(textField.trailingAssistiveLabel.adjustsFontForContentSizeCategory);
  }
}

@end
