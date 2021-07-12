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

class TextFieldControllerClassPropertiesTests: XCTestCase {
  override func tearDown() {
    super.tearDown()

    MDCTextInputControllerFilled.roundedCornersDefault = []
    MDCTextInputControllerFilled.errorColorDefault = nil
    MDCTextInputControllerFilled.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFilled.activeColorDefault = nil
    MDCTextInputControllerFilled.normalColorDefault = nil
    MDCTextInputControllerFilled.disabledColorDefault = nil
    MDCTextInputControllerFilled.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault = nil

    MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault = nil
    MDCTextInputControllerFilled.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerFilled.textInputClearButtonTintColorDefault = nil

    MDCTextInputControllerOutlined.roundedCornersDefault = []
    MDCTextInputControllerOutlined.errorColorDefault = nil
    MDCTextInputControllerOutlined.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerOutlined.activeColorDefault = nil
    MDCTextInputControllerOutlined.normalColorDefault = nil
    MDCTextInputControllerOutlined.disabledColorDefault = nil
    MDCTextInputControllerOutlined.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault = nil

    MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault = nil
    MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerOutlined.isFloatingEnabledDefault = true
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = nil

    MDCTextInputControllerUnderline.roundedCornersDefault = []
    MDCTextInputControllerUnderline.errorColorDefault = nil
    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerUnderline.activeColorDefault = nil
    MDCTextInputControllerUnderline.normalColorDefault = nil
    MDCTextInputControllerUnderline.disabledColorDefault = nil
    MDCTextInputControllerUnderline.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault = nil

    MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault = nil
    MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerUnderline.isFloatingEnabledDefault = true
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = nil

    MDCTextInputControllerFullWidth.errorColorDefault = nil
    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFullWidth.activeColorDefault = nil
    MDCTextInputControllerFullWidth.normalColorDefault = nil
    MDCTextInputControllerFullWidth.disabledColorDefault = nil
    MDCTextInputControllerFullWidth.underlineViewModeDefault = .never

    MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault = nil
  }

  func testFilled() {

    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerFilled.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerFilled.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerFilled.activeColorDefault,
      MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerFilled.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(
      MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault,
      MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault,
      MDCTextInputControllerFilled.inlinePlaceholderColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    XCTAssertEqual(
      MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault,
      MDCTextInputControllerFilled.activeColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerFilled.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerFilled.isFloatingEnabledDefault, true)
    // TODO(b/184185897): Evaluate why this is flaky.
    XCTAssertEqual(MDCTextInputControllerFilled.roundedCornersDefault, [])

    XCTAssertNil(MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerFilled(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFilled.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerFilled.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerFilled.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerFilled.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerFilled.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerFilled.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerFilled.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerFilled.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerFilled.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerFilled.errorColorDefault, .green)

    MDCTextInputControllerFilled.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerFilled.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerFilled.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerFilled.activeColorDefault, .purple)

    MDCTextInputControllerFilled.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerFilled.normalColorDefault, .white)

    MDCTextInputControllerFilled.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightActiveDefault, 11)

    MDCTextInputControllerFilled.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightNormalDefault, 5)

    MDCTextInputControllerFilled.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerFilled.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault = .brown
    XCTAssertEqual(MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault, .brown)

    MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault = .cyan
    XCTAssertEqual(MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault, .cyan)

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault = .yellow
    XCTAssertEqual(MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault, .yellow)

    MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault, .orange)

    MDCTextInputControllerFilled.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerFilled.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerFilled.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerFilled.isFloatingEnabledDefault, false)

    MDCTextInputControllerFilled.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerFilled.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerFilled(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFilled.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerFilled.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerFilled.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerFilled.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerFilled.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerFilled.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerFilled.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerFilled.roundedCornersDefault)

  }

  func testOutlined() {
    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerOutlined.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerOutlined.activeColorDefault,
      MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerOutlined.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault,
      MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault,
      MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    XCTAssertEqual(
      MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault,
      MDCTextInputControllerOutlined.activeColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerOutlined.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerOutlined.roundedCornersDefault, [])

    XCTAssertNil(MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerOutlined(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerOutlined.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerOutlined.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerOutlined.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerOutlined.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerOutlined.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerOutlined.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerOutlined.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerOutlined.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerOutlined.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerOutlined.errorColorDefault, .green)

    MDCTextInputControllerOutlined.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerOutlined.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerOutlined.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerOutlined.activeColorDefault, .purple)

    MDCTextInputControllerOutlined.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerOutlined.normalColorDefault, .white)

    MDCTextInputControllerOutlined.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightActiveDefault, 11)

    MDCTextInputControllerOutlined.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightNormalDefault, 5)

    MDCTextInputControllerOutlined.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault, .green)

    MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault = .gray
    XCTAssertEqual(MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault, .gray)

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault = .clear
    XCTAssertEqual(MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault, .clear)

    MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault, .purple)

    MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerOutlined.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerOutlined.isFloatingEnabledDefault, false)

    MDCTextInputControllerOutlined.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerOutlined.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerOutlined(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerOutlined.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerOutlined.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerOutlined.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerOutlined.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerOutlined.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerOutlined.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerOutlined.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerOutlined.roundedCornersDefault)
  }

  func testUnderline() {

    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerUnderline.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerUnderline.activeColorDefault,
      MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerUnderline.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(
      MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
      MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
      MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    XCTAssertEqual(
      MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault,
      MDCTextInputControllerUnderline.activeColorDefault)

    XCTAssertEqual(
      MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [])

    XCTAssertNil(MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerUnderline(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerUnderline.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerUnderline.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerUnderline.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerUnderline.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerUnderline.errorColorDefault, .green)

    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerUnderline.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerUnderline.activeColorDefault, .purple)

    MDCTextInputControllerUnderline.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerUnderline.normalColorDefault, .white)

    MDCTextInputControllerUnderline.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightActiveDefault, 11)

    MDCTextInputControllerUnderline.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightNormalDefault, 5)

    MDCTextInputControllerUnderline.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault = .blue
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault, .blue)

    MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault, .white)

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault = .red
    XCTAssertEqual(MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault, .red)

    MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault = .red
    XCTAssertEqual(MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault, .red)

    MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerUnderline.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, false)

    MDCTextInputControllerUnderline.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerUnderline(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerUnderline.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerUnderline.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerUnderline.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(
      controller.floatingPlaceholderActiveColor,
      MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault)

    XCTAssertEqual(
      controller.floatingPlaceholderNormalColor,
      MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(
      controller.isFloatingEnabled,
      MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)
  }

  func testFullWidth() {
    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerFullWidth.disabledColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerFullWidth.activeColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.normalColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineViewModeDefault, .never)
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault, .clear)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
      UIColor(white: 0, alpha: CGFloat(0.54)))

    XCTAssertEqual(
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
      MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
      UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    XCTAssertNil(MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFullWidth.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerFullWidth.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerFullWidth.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerFullWidth.disabledColorDefault = .red
    XCTAssertNotEqual(MDCTextInputControllerFullWidth.disabledColorDefault, .red)

    MDCTextInputControllerFullWidth.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerFullWidth.errorColorDefault, .green)

    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerFullWidth.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerFullWidth.activeColorDefault, .clear)

    MDCTextInputControllerFullWidth.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerFullWidth.normalColorDefault, .clear)

    MDCTextInputControllerFullWidth.underlineHeightActiveDefault = 9
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightActiveDefault, 0)

    MDCTextInputControllerFullWidth.underlineHeightNormalDefault = 17
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightNormalDefault, 0)

    MDCTextInputControllerFullWidth.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineViewModeDefault, .never)

    MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault = .brown
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault, .clear)

    MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault = .cyan
    XCTAssertEqual(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault, .cyan)

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
      UIFont.systemFont(ofSize: 6))

    // Test the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFullWidth.errorColorDefault)
    XCTAssertEqual(
      controller.inlinePlaceholderColor,
      MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(
      controller.activeColor,
      MDCTextInputControllerFullWidth.activeColorDefault)
    XCTAssertEqual(
      controller.normalColor,
      MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(
      controller.underlineHeightActive,
      MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(
      controller.underlineHeightNormal,
      MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(
      controller.underlineViewMode,
      MDCTextInputControllerFullWidth.underlineViewModeDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelTextColor,
      MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelTextColor,
      MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(
      controller.inlinePlaceholderFont,
      MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(
      controller.leadingUnderlineLabelFont,
      MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(
      controller.trailingUnderlineLabelFont,
      MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)
  }

  // MARK: - textInputClearButtonTintColor

  func testFilledTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerFilled.textInputClearButtonTintColorDefault = .orange

    // When
    let textInput = MDCTextField()
    let controllerFilled = MDCTextInputControllerFilled(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerFilled.textInputClearButtonTintColor,
      MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testFilledTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerFilled.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputFilled = MDCTextField()
    let _ = MDCTextInputControllerFilled(textInput: textInputFilled)

    // Then
    XCTAssertEqual(
      textInputFilled.clearButton.tintColor,
      MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testFilledTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputFilled = MDCTextField()
    let controllerFilled = MDCTextInputControllerFilled(textInput: textInputFilled)

    // When
    controllerFilled.textInputClearButtonTintColor = .black

    // Then
    XCTAssertEqual(
      textInputFilled.clearButton.tintColor,
      controllerFilled.textInputClearButtonTintColor)
  }

  func testOutlinedTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = .cyan

    // When
    let textInput = MDCTextField()
    let controllerOutlined = MDCTextInputControllerOutlined(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerOutlined.textInputClearButtonTintColor,
      MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testOutlinedTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = .cyan

    // When
    let textInputOutlined = MDCTextField()
    let _ = MDCTextInputControllerOutlined(textInput: textInputOutlined)

    // Then
    XCTAssertEqual(
      textInputOutlined.clearButton.tintColor,
      MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testOutlinedTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputOutlined = MDCTextField()
    let controllerOutlined = MDCTextInputControllerOutlined(textInput: textInputOutlined)

    // When
    controllerOutlined.textInputClearButtonTintColor = .red

    // Then
    XCTAssertEqual(
      textInputOutlined.clearButton.tintColor,
      controllerOutlined.textInputClearButtonTintColor)
  }

  func testUnderlineTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = .orange

    // When
    let textInput = MDCTextField()
    let controllerUnderline = MDCTextInputControllerUnderline(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerUnderline.textInputClearButtonTintColor,
      MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)
  }

  func testUnderlineTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputUnderline = MDCTextField()
    let _ = MDCTextInputControllerUnderline(textInput: textInputUnderline)

    // Then
    XCTAssertEqual(
      textInputUnderline.clearButton.tintColor,
      MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)
  }

  func testUnderlineTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputUnderline = MDCTextField()
    let controllerUnderline = MDCTextInputControllerUnderline(textInput: textInputUnderline)

    // When
    controllerUnderline.textInputClearButtonTintColor = .black

    // Then
    XCTAssertEqual(
      textInputUnderline.clearButton.tintColor,
      controllerUnderline.textInputClearButtonTintColor)
  }

  func testFullWidthTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault = .orange

    // When
    let textInput = MDCTextField()
    let controllerFullWidth = MDCTextInputControllerFullWidth(textInput: textInput)

    // Then
    XCTAssertEqual(
      controllerFullWidth.textInputClearButtonTintColor,
      MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault)
  }

  func testFullWidthTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputFullWidth = MDCTextField()
    let _ = MDCTextInputControllerFullWidth(textInput: textInputFullWidth)

    // Then
    XCTAssertEqual(
      textInputFullWidth.clearButton.tintColor,
      MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault)
  }

  func testFullWidthTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputFullWidth = MDCTextField()
    let controllerFullWidth = MDCTextInputControllerFullWidth(textInput: textInputFullWidth)

    // When
    controllerFullWidth.textInputClearButtonTintColor = .black

    // Then
    XCTAssertEqual(
      textInputFullWidth.clearButton.tintColor,
      controllerFullWidth.textInputClearButtonTintColor)
  }
}
