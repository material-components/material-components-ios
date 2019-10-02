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

#import "MDCTextInputBorderView.h"
#import "MaterialColorScheme.h"
#import "MaterialTextFields+ColorThemer.h"
#import "MaterialTextFields.h"

@interface OutlinedTextFieldColorThemerTests : XCTestCase

@end

@implementation OutlinedTextFieldColorThemerTests

- (void)testThemerWithBaselineColorSchemeAppliesToSingleLineTextField {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerOutlined *controller =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCOutlinedTextFieldColorThemer applySemanticColorScheme:colorScheme
                                      toTextInputController:controller];

  // Then
  XCTAssertEqualObjects(controller.activeColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(controller.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(controller.trailingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.textColor,
                        controller.trailingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.normalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, controller.normalColor);

  XCTAssertEqualObjects(controller.inlinePlaceholderColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, controller.inlinePlaceholderColor);
  // Set directly in the themer, not by the controller
  XCTAssertEqualObjects(textField.textColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects(controller.leadingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor,
                        controller.leadingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.textInputClearButtonTintColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54]);
  XCTAssertEqualObjects(textField.clearButton.tintColor, controller.textInputClearButtonTintColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderNormalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor,
                        controller.floatingPlaceholderNormalColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderActiveColor,
                        [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87]);
}

// TODO(https://github.com/material-components/material-components-ios/issues/4443 ): Restore this
// test
- (void)_disabled_testThemerWithBaselineColorSchemeAppliesToSingleLineTextFieldDisabledState {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerOutlined *controller =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCOutlinedTextFieldColorThemer applySemanticColorScheme:colorScheme
                                      toTextInputController:controller];
  textField.enabled = NO;

  // Then
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects(textField.underline.disabledColor, controller.disabledColor);
}

- (void)testThemerWithBaselineColorSchemeAppliesToMultilineTextField {
  // Given
  MDCMultilineTextField *textField = [[MDCMultilineTextField alloc] init];
  MDCTextInputControllerOutlinedTextArea *controller =
      [[MDCTextInputControllerOutlinedTextArea alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCOutlinedTextFieldColorThemer applySemanticColorScheme:colorScheme
                                      toTextInputController:controller];

  // Then
  XCTAssertEqualObjects(controller.activeColor, colorScheme.primaryColor);
  XCTAssertEqualObjects(controller.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(controller.trailingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.trailingUnderlineLabel.textColor,
                        controller.trailingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.normalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.underline.color, controller.normalColor);
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, controller.normalColor);
  XCTAssertEqualObjects(controller.inlinePlaceholderColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, controller.inlinePlaceholderColor);
  // Set directly in the themer, not by the controller
  XCTAssertEqualObjects(textField.textColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects(controller.leadingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor,
                        controller.leadingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.textInputClearButtonTintColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54]);
  XCTAssertEqualObjects(textField.clearButton.tintColor, controller.textInputClearButtonTintColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderNormalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.6]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor,
                        controller.floatingPlaceholderNormalColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderActiveColor,
                        [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.87]);
}

// TODO(https://github.com/material-components/material-components-ios/issues/4443 ): Restore this
// test
- (void)_disabled_testThemerWithBaselineColorSchemeAppliesToMultilineTextFieldDisabledState {
  // Given
  MDCMultilineTextField *textField = [[MDCMultilineTextField alloc] init];
  MDCTextInputControllerOutlinedTextArea *controller =
      [[MDCTextInputControllerOutlinedTextArea alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // When
  [MDCOutlinedTextFieldColorThemer applySemanticColorScheme:colorScheme
                                      toTextInputController:controller];
  textField.enabled = NO;

  // Then
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]);
  XCTAssertEqualObjects(textField.underline.disabledColor, controller.disabledColor);
}

- (void)testOutlinedTextFieldBorderStrokeColorTheming {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerOutlined *controller =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textField];

  // When
  controller.borderStrokeColor = UIColor.redColor;
  controller.normalColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, controller.borderStrokeColor);
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, UIColor.redColor);
}

- (void)testOutlinedTextFieldBorderStrokeColorDefaultsToNormal {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerOutlined *controller =
      [[MDCTextInputControllerOutlined alloc] initWithTextInput:textField];

  // When
  controller.borderStrokeColor = nil;
  controller.normalColor = UIColor.purpleColor;

  // Then
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, controller.normalColor);
  XCTAssertEqualObjects(textField.borderView.borderStrokeColor, UIColor.purpleColor);
}

@end
