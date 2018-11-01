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
#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialTextFields.h>
#import "MaterialTextFields+ColorThemer.h"

@interface FilledTextFieldColorThemerTests : XCTestCase

@end

@implementation FilledTextFieldColorThemerTests

- (void)testThemerWithBaselineColorSchemeAppliesToSingleLineTextField {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerFilled *controller =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  // When
  [MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputControllerFilled:controller];

  // Then
  XCTAssertNil(textField.backgroundColor);
  XCTAssertEqualObjects(controller.borderFillColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.04f]);
  XCTAssertEqualObjects(textField.borderView.borderFillColor, controller.borderFillColor);
  XCTAssertEqualObjects(controller.normalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.42f]);
  XCTAssertEqualObjects(textField.underline.color, controller.normalColor);
  XCTAssertEqualObjects(controller.inlinePlaceholderColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, controller.inlinePlaceholderColor);
  XCTAssertEqualObjects(controller.leadingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor,
                        controller.leadingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.activeColor, colorScheme.primaryColor);
  // Set directly in the themer, not via the controller
  XCTAssertEqualObjects(textField.textColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(controller.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.38f]);
  XCTAssertEqualObjects(controller.floatingPlaceholderNormalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor,
                        controller.floatingPlaceholderNormalColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderActiveColor,
                        [colorScheme.primaryColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(controller.textInputClearButtonTintColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.54f]);
  XCTAssertEqualObjects(textField.clearButton.tintColor, controller.textInputClearButtonTintColor);
}

// TODO(https://github.com/material-components/material-components-ios/issues/4443 ): Restore this
// test
- (void)_disabled_testThemerWithBaselineColorSchemeAppliesToSingleLineTextFieldDisabledState {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  MDCTextInputControllerFilled *controller =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  // When
  [MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputControllerFilled:controller];
  textField.enabled = NO;

  // Then
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.38f]);
  XCTAssertEqualObjects(textField.underline.color, controller.disabledColor);
}

- (void)testThemerWithBaselineColorSchemeAppliesToMultilineTextField {
  // Given
  MDCMultilineTextField *textField = [[MDCMultilineTextField alloc] init];
  MDCTextInputControllerFilled *controller =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  // When
  [MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputControllerFilled:controller];

  // Then
  XCTAssertEqualObjects(textField.backgroundColor, UIColor.clearColor);
  XCTAssertEqualObjects(controller.borderFillColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.04f]);
  XCTAssertEqualObjects(textField.borderView.borderFillColor, controller.borderFillColor);
  XCTAssertEqualObjects(controller.normalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.42f]);
  XCTAssertEqualObjects(textField.underline.color, controller.normalColor);
  XCTAssertEqualObjects(controller.inlinePlaceholderColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor, controller.inlinePlaceholderColor);
  XCTAssertEqualObjects(controller.leadingUnderlineLabelTextColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.leadingUnderlineLabel.textColor,
                        controller.leadingUnderlineLabelTextColor);
  XCTAssertEqualObjects(controller.activeColor, colorScheme.primaryColor);
  // Set directly in the themer, not via the controller
  XCTAssertEqualObjects(textField.textColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(controller.errorColor, colorScheme.errorColor);
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.38f]);
  XCTAssertEqualObjects(controller.floatingPlaceholderNormalColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.6f]);
  XCTAssertEqualObjects(textField.placeholderLabel.textColor,
                        controller.floatingPlaceholderNormalColor);
  XCTAssertEqualObjects(controller.floatingPlaceholderActiveColor,
                        [colorScheme.primaryColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(controller.textInputClearButtonTintColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.54f]);
  XCTAssertEqualObjects(textField.clearButton.tintColor, controller.textInputClearButtonTintColor);
}

// TODO(https://github.com/material-components/material-components-ios/issues/4443 ): Restore this
// test
- (void)_disabled_testThemerWithBaselineColorSchemeAppliesToMultilineTextFieldDisabledState {
  // Given
  MDCMultilineTextField *textField = [[MDCMultilineTextField alloc] init];
  MDCTextInputControllerFilled *controller =
      [[MDCTextInputControllerFilled alloc] initWithTextInput:textField];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];

  // When
  [MDCFilledTextFieldColorThemer applySemanticColorScheme:colorScheme
                              toTextInputControllerFilled:controller];
  textField.enabled = NO;

  // Then
  XCTAssertEqualObjects(controller.disabledColor,
                        [colorScheme.onSurfaceColor colorWithAlphaComponent:0.38f]);
  XCTAssertEqualObjects(textField.underline.color, controller.disabledColor);
}

@end
