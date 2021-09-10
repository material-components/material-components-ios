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
import MaterialComponents.MaterialTextFields_Theming 
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

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
    XCTAssertEqual(
      textFieldControllerFilled.borderFillColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledSurfaceOverlayAlpha))
    XCTAssertEqual(
      textFieldControllerFilled.normalColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledIndicatorLineAlpha))
    XCTAssertEqual(
      textFieldControllerFilled.inlinePlaceholderColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    XCTAssertEqual(
      textFieldControllerFilled.leadingUnderlineLabelTextColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    XCTAssertEqual(textFieldControllerFilled.activeColor, scheme.colorScheme.primaryColor)
    //XCTAssertEqual(textFieldControllerFilled.textInput.textColor,
    //               scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledActiveAlpha))
    XCTAssertEqual(textFieldControllerFilled.errorColor, scheme.colorScheme.errorColor)
    XCTAssertEqual(
      textFieldControllerFilled.disabledColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledDisabledAlpha))
    XCTAssertEqual(
      textFieldControllerFilled.floatingPlaceholderNormalColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledOnSurfaceAlpha))
    XCTAssertEqual(
      textFieldControllerFilled.floatingPlaceholderActiveColor,
      scheme.colorScheme.primaryColor.withAlphaComponent(filledActiveAlpha))
    XCTAssertNil(textFieldControllerFilled.floatingPlaceholderErrorActiveColor)
    XCTAssertEqual(
      textFieldControllerFilled.textInputClearButtonTintColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(filledIconAlpha))

    // Typography
    XCTAssertEqual(
      textFieldControllerFilled.inlinePlaceholderFont,
      scheme.typographyScheme.subtitle1)
    XCTAssertEqual(
      textFieldControllerFilled.leadingUnderlineLabelFont,
      scheme.typographyScheme.caption)
    XCTAssertEqual(
      textFieldControllerFilled.trailingUnderlineLabelFont,
      scheme.typographyScheme.caption)
    let placeholderScale: CGFloat =
      scheme.typographyScheme.caption.pointSize / scheme.typographyScheme.subtitle1.pointSize
    XCTAssertEqual(
      CGFloat(textFieldControllerFilled.floatingPlaceholderScale.doubleValue),
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
    let onSurfaceOpacity = scheme.colorScheme.onSurfaceColor.withAlphaComponent(
      outlinedTextFieldOnSurfaceAlpha)
    XCTAssertEqual(textFieldControllerOutlined.activeColor, scheme.colorScheme.primaryColor)
    XCTAssertEqual(textFieldControllerOutlined.errorColor, scheme.colorScheme.errorColor)
    XCTAssertEqual(textFieldControllerOutlined.trailingUnderlineLabelTextColor, onSurfaceOpacity)
    XCTAssertEqual(textFieldControllerOutlined.normalColor, onSurfaceOpacity)
    XCTAssertEqual(textFieldControllerOutlined.inlinePlaceholderColor, onSurfaceOpacity)
    let textInput = textFieldControllerOutlined.textInput as! MDCTextInput
    XCTAssertEqual(
      textInput.textColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldActiveAlpha))
    XCTAssertEqual(textFieldControllerOutlined.leadingUnderlineLabelTextColor, onSurfaceOpacity)
    XCTAssertEqual(
      textFieldControllerOutlined.disabledColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldDisabledAlpha))
    XCTAssertEqual(
      textFieldControllerOutlined.textInputClearButtonTintColor,
      scheme.colorScheme.onSurfaceColor.withAlphaComponent(outlinedTextFieldIconAlpha))
    XCTAssertEqual(textFieldControllerOutlined.floatingPlaceholderNormalColor, onSurfaceOpacity)
    XCTAssertEqual(
      textFieldControllerOutlined.floatingPlaceholderActiveColor,
      scheme.colorScheme.primaryColor.withAlphaComponent(outlinedTextFieldActiveAlpha))
    XCTAssertNil(textFieldControllerOutlined.floatingPlaceholderErrorActiveColor)

    // Typography
    XCTAssertEqual(
      textFieldControllerOutlined.inlinePlaceholderFont,
      scheme.typographyScheme.subtitle1)
    XCTAssertEqual(
      textFieldControllerOutlined.leadingUnderlineLabelFont,
      scheme.typographyScheme.caption)
    XCTAssertEqual(
      textFieldControllerOutlined.trailingUnderlineLabelFont,
      scheme.typographyScheme.caption)
    let placeholderScale: CGFloat =
      scheme.typographyScheme.caption.pointSize / scheme.typographyScheme.subtitle1.pointSize
    XCTAssertEqual(
      CGFloat(textFieldControllerOutlined.floatingPlaceholderScale.doubleValue),
      placeholderScale)
  }
}
