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

import XCTest

import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialTextFields_Theming
import MDFTesting

class TextFieldsMaterialThemingTests: XCTestCase {

  let filledActiveAlpha: CGFloat = 0.87
  let filledOnSurfaceAlpha: CGFloat = 0.6
  let filledDisabledAlpha: CGFloat = 0.38
  let filledSurfaceOverlayAlpha: CGFloat = 0.04
  let filledIndicatorLineAlpha: CGFloat = 0.42
  let filledIconAlpha: CGFloat = 0.54

  let outlinedTextFieldActiveAlpha: CGFloat = 0.87
  let outlinedTextFieldOnSurfaceAlpha: CGFloat = 0.6
  let outlinedTextFieldDisabledAlpha: CGFloat = 0.38
  let outlinedTextFieldIconAlpha: CGFloat = 0.54

  func testMDCTextInputControllerFilledThemingWithContainerScheme() {
    // Given
    let textFieldFilled = MDCTextField()
    let textFieldControllerFilled = MDCTextInputControllerFilled(textInput: textFieldFilled)
    let scheme: MDCContainerScheme = MDCContainerScheme()

    // When
    textFieldControllerFilled.applyTheme(withScheme: scheme)

    // Then
    // Color
    assertEqualFirstColor(textFieldControllerFilled.borderFillColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledSurfaceOverlayAlpha))
    assertEqualFirstColor(textFieldControllerFilled.normalColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledIndicatorLineAlpha))
    assertEqualFirstColor(textFieldControllerFilled.inlinePlaceholderColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    assertEqualFirstColor(textFieldControllerFilled.leadingUnderlineLabelTextColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    assertEqualFirstColor(textFieldControllerFilled.activeColor, secondColor: scheme.colorScheme.primaryColor)
    //XCTAssertEqual(textFieldControllerFilled.textInput.textColor,
    //               scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledActiveAlpha))
    assertEqualFirstColor(textFieldControllerFilled.errorColor, secondColor: scheme.colorScheme.errorColor)
    assertEqualFirstColor(textFieldControllerFilled.disabledColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledDisabledAlpha))
    assertEqualFirstColor(textFieldControllerFilled.floatingPlaceholderNormalColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    assertEqualFirstColor(textFieldControllerFilled.floatingPlaceholderActiveColor,
                          secondColor: scheme.colorScheme.primaryColor.withAlphaComponent(filledActiveAlpha))
    assertEqualFirstColor(textFieldControllerFilled.textInputClearButtonTintColor,
                          secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledIconAlpha))

    // Typography
    XCTAssertEqual(textFieldControllerFilled.inlinePlaceholderFont,
                   scheme.typographyScheme.subtitle1)
    XCTAssertEqual(textFieldControllerFilled.leadingUnderlineLabelFont,
                   scheme.typographyScheme.caption)
    XCTAssertEqual(textFieldControllerFilled.trailingUnderlineLabelFont,
                   scheme.typographyScheme.caption)
    let placeholderScale: CGFloat =
      scheme.typographyScheme.caption.pointSize / scheme.typographyScheme.subtitle1.pointSize
    XCTAssertEqual(CGFloat(textFieldControllerFilled.floatingPlaceholderScale.doubleValue),
                   placeholderScale)
  }

  func testMDCTextInputControllerOutlinedThemingWithContainerScheme() {
    // Given
    let textFieldOutlined = MDCTextField()
    let textFieldControllerOutlined = MDCTextInputControllerOutlined(textInput: textFieldOutlined)
    let scheme: MDCContainerScheme = MDCContainerScheme()

    // When
    textFieldControllerOutlined.applyTheme(withScheme: scheme)

    // Then
    // Color
    let onSurfaceOpacity = scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldOnSurfaceAlpha)
    assertEqualFirstColor(textFieldControllerOutlined.activeColor, secondColor: scheme.colorScheme.primaryColor)
    assertEqualFirstColor(textFieldControllerOutlined.errorColor, secondColor: scheme.colorScheme.errorColor)
    assertEqualFirstColor(textFieldControllerOutlined.trailingUnderlineLabelTextColor, secondColor: onSurfaceOpacity)
    assertEqualFirstColor(textFieldControllerOutlined.normalColor, secondColor: onSurfaceOpacity)
    assertEqualFirstColor(textFieldControllerOutlined.inlinePlaceholderColor, secondColor: onSurfaceOpacity)
    let textInput = textFieldControllerOutlined.textInput!
    assertEqualFirstColor(textInput.textColor, secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldActiveAlpha))
    assertEqualFirstColor(textFieldControllerOutlined.leadingUnderlineLabelTextColor, secondColor: onSurfaceOpacity)
    assertEqualFirstColor(textFieldControllerOutlined.disabledColor, secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldDisabledAlpha))
    assertEqualFirstColor(textFieldControllerOutlined.textInputClearButtonTintColor, secondColor: scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldIconAlpha))
    assertEqualFirstColor(textFieldControllerOutlined.floatingPlaceholderNormalColor, secondColor: onSurfaceOpacity)
    assertEqualFirstColor(textFieldControllerOutlined.floatingPlaceholderActiveColor, secondColor: scheme.colorScheme.primaryColor.withAlphaComponent(outlinedTextFieldActiveAlpha))

    // Typography
    XCTAssertEqual(textFieldControllerOutlined.inlinePlaceholderFont,
                   scheme.typographyScheme.subtitle1)
    XCTAssertEqual(textFieldControllerOutlined.leadingUnderlineLabelFont,
                   scheme.typographyScheme.caption)
    XCTAssertEqual(textFieldControllerOutlined.trailingUnderlineLabelFont,
                   scheme.typographyScheme.caption)
    let placeholderScale: CGFloat =
      scheme.typographyScheme.caption.pointSize / scheme.typographyScheme.subtitle1.pointSize
    XCTAssertEqual(CGFloat(textFieldControllerOutlined.floatingPlaceholderScale.doubleValue),
                   placeholderScale)
  }
}
