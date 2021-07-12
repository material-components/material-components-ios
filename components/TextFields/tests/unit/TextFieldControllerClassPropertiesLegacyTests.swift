// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTypography

class TextFieldControllerClassPropertiesLegacyTests: XCTestCase {
  override func tearDown() {
    super.tearDown()

    MDCTextInputControllerLegacyDefault.errorColorDefault = nil
    MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerLegacyDefault.activeColorDefault = nil
    MDCTextInputControllerLegacyDefault.normalColorDefault = nil
    MDCTextInputControllerLegacyDefault.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerLegacyDefault.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerLegacyDefault.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault = nil
    MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault = true
    MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault = nil

    MDCTextInputControllerLegacyFullWidth.errorColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.activeColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.normalColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault = .never

    MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault = nil
  }

  func testLegacyDefault() {

    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.activeColorDefault,
      MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault, true)

    XCTAssertNil(MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyDefault.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerLegacyDefault.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerLegacyDefault.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerLegacyDefault.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerLegacyDefault.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerLegacyDefault.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerLegacyDefault.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.errorColorDefault, .green)

    MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerLegacyDefault.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.activeColorDefault, .purple)

    MDCTextInputControllerLegacyDefault.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.normalColorDefault, .white)

    MDCTextInputControllerLegacyDefault.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineHeightActiveDefault, 11)

    MDCTextInputControllerLegacyDefault.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineHeightNormalDefault, 5)

    MDCTextInputControllerLegacyDefault.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault = .blue
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault, .blue)

    MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault = .white
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault, .white)

    MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault = .red
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault, .red)

    MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault, false)

    // Test the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyDefault.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerLegacyDefault.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerLegacyDefault.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerLegacyDefault.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerLegacyDefault.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerLegacyDefault.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerLegacyDefault.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerLegacyDefault.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerLegacyDefault.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerLegacyDefault.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault)
  }

  func testLegacyFullWidth() {
    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.disabledColorDefault, .clear)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.activeColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.normalColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault, .never)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault, .clear)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))

    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    XCTAssertNil(MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyFullWidth.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerLegacyFullWidth.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerLegacyFullWidth.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerLegacyFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerLegacyFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelFontDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerLegacyFullWidth.disabledColorDefault = .red
    XCTAssertNotEqual(MDCTextInputControllerLegacyFullWidth.disabledColorDefault, .red)

    MDCTextInputControllerLegacyFullWidth.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.errorColorDefault, .green)

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerLegacyFullWidth.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.activeColorDefault, .clear)

    MDCTextInputControllerLegacyFullWidth.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.normalColorDefault, .clear)

    // The underline is not shown in this controller
    MDCTextInputControllerLegacyFullWidth.underlineHeightActiveDefault = 8
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineHeightActiveDefault, 0)

    MDCTextInputControllerLegacyFullWidth.underlineHeightNormalDefault = 7
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineHeightNormalDefault, 0)

    MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault, .never)

    MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault = .brown
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault, .clear)

    MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault = .cyan
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault, .cyan)

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(
      ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(
      ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(
      ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Test the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyFullWidth.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerLegacyFullWidth.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerLegacyFullWidth.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerLegacyFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerLegacyFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerLegacyFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelFontDefault)
  }

  func testLegacyDefaultTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault = .orange

    // When
    let textInput = MDCTextField()
    let controllerLegacyDefault = MDCTextInputControllerLegacyDefault(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerLegacyDefault.textInputClearButtonTintColor,
      MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault)
  }

  func testLegacyDefaultTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputLegacyDefault = MDCTextField()
    let _ = MDCTextInputControllerLegacyDefault(textInput: textInputLegacyDefault)

    // Then
    XCTAssertEqual(
      textInputLegacyDefault.clearButton.tintColor,
      MDCTextInputControllerLegacyDefault.textInputClearButtonTintColorDefault)
  }

  func testLegacyDefaultTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputLegacyDefault = MDCTextField()
    let controllerLegacyDefault = MDCTextInputControllerLegacyDefault(
      textInput: textInputLegacyDefault)

    // When
    controllerLegacyDefault.textInputClearButtonTintColor = .black

    // Then
    XCTAssertEqual(
      textInputLegacyDefault.clearButton.tintColor,
      controllerLegacyDefault.textInputClearButtonTintColor)
  }

  func testLegacyFullWidthTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault = .orange

    // When
    let textInput = MDCTextField()
    let controllerLegacyFullWidth = MDCTextInputControllerLegacyFullWidth(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerLegacyFullWidth.textInputClearButtonTintColor,
      MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault)
  }

  func testLegacyFullWidthTextinputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputLegacyFullWidth = MDCTextField()
    let _ = MDCTextInputControllerLegacyFullWidth(textInput: textInputLegacyFullWidth)

    // Then
    XCTAssertEqual(
      textInputLegacyFullWidth.clearButton.tintColor,
      MDCTextInputControllerLegacyFullWidth.textInputClearButtonTintColorDefault)
  }

  func testLegacyFullWidthTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputLegacyFullWidth = MDCTextField()
    let controllerLegacyFullWidth = MDCTextInputControllerLegacyFullWidth(
      textInput: textInputLegacyFullWidth)

    // When
    controllerLegacyFullWidth.textInputClearButtonTintColor = .black

    // Then
    XCTAssertEqual(
      textInputLegacyFullWidth.clearButton.tintColor,
      controllerLegacyFullWidth.textInputClearButtonTintColor)
  }

}
