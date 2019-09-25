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

import MDFTesting
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTypography

class TextFieldControllerClassPropertiesTests: XCTestCase {
  override func tearDown() {
    super.tearDown()

    MDCTextInputControllerFilled.roundedCornersDefault = []
    MDCTextInputControllerFilled.errorColorDefault = nil
    MDCTextInputControllerFilled.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault = false
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
    MDCTextInputControllerFilled.textInputClearButtonTintColorDefault = nil;

    MDCTextInputControllerOutlined.roundedCornersDefault = []
    MDCTextInputControllerOutlined.errorColorDefault = nil
    MDCTextInputControllerOutlined.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault = false
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
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = nil;

    MDCTextInputControllerUnderline.roundedCornersDefault = []
    MDCTextInputControllerUnderline.errorColorDefault = nil
    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault = false
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
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = nil;

    MDCTextInputControllerFullWidth.errorColorDefault = nil
    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = false
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
    assertEqualFirstColor(MDCTextInputControllerFilled.errorColorDefault,
                          secondColor: MDCPalette.red.accent400)
    assertEqualFirstColor(MDCTextInputControllerFilled.inlinePlaceholderColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault, false)
    XCTAssertEqual(MDCTextInputControllerFilled.activeColorDefault,
                   MDCPalette.blue.accent700)
    assertEqualFirstColor(MDCTextInputControllerFilled.normalColorDefault, secondColor: .lightGray)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerFilled.underlineViewModeDefault, .whileEditing)
    assertEqualFirstColor(MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    assertEqualFirstColor(MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerFilled.inlinePlaceholderColorDefault)

    XCTAssertEqual(MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    assertEqualFirstColor(MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault,
                          secondColor: MDCTextInputControllerFilled.activeColorDefault)

    assertEqualFirstColor(MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerFilled.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerFilled.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerFilled.roundedCornersDefault,
                   [UIRectCorner.topLeft, .topRight])

    XCTAssertNil(MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerFilled(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerFilled.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerFilled.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerFilled.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFilled.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFilled.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFilled.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFilled.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerFilled.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerFilled.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerFilled.errorColorDefault = .green
    assertEqualFirstColor(MDCTextInputControllerFilled.errorColorDefault, secondColor: .green)

    MDCTextInputControllerFilled.inlinePlaceholderColorDefault = .orange
    assertEqualFirstColor(MDCTextInputControllerFilled.inlinePlaceholderColorDefault,
                          secondColor: .orange)

    MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerFilled.activeColorDefault = .purple
    assertEqualFirstColor(MDCTextInputControllerFilled.activeColorDefault, secondColor: .purple)

    MDCTextInputControllerFilled.normalColorDefault = .white
    assertEqualFirstColor(MDCTextInputControllerFilled.normalColorDefault, secondColor: .white)

    MDCTextInputControllerFilled.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightActiveDefault, 11)

    MDCTextInputControllerFilled.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerFilled.underlineHeightNormalDefault, 5)

    MDCTextInputControllerFilled.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerFilled.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault = .brown
    assertEqualFirstColor(MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault,
                          secondColor: .brown)

    MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault = .cyan
    assertEqualFirstColor(MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault,
                          secondColor: .cyan)

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerFilled.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerFilled.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault = .yellow
    assertEqualFirstColor(MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault,
                          secondColor: .yellow)

    MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault = .orange
    assertEqualFirstColor(MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault,
                          secondColor: .orange)

    MDCTextInputControllerFilled.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerFilled.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerFilled.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerFilled.isFloatingEnabledDefault, false)

    MDCTextInputControllerFilled.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerFilled.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerFilled(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerFilled.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerFilled.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFilled.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerFilled.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerFilled.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFilled.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFilled.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFilled.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFilled.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFilled.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFilled.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerFilled.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerFilled.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerFilled.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerFilled.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerFilled.roundedCornersDefault)

  }

  func testOutlined() {
    // Test the values of the class properties.
    assertEqualFirstColor(MDCTextInputControllerOutlined.errorColorDefault,
                          secondColor: MDCPalette.red.accent400)
    assertEqualFirstColor(MDCTextInputControllerOutlined.inlinePlaceholderColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault, false)
    assertEqualFirstColor(MDCTextInputControllerOutlined.activeColorDefault,
                          secondColor: MDCPalette.blue.accent700)
    assertEqualFirstColor(MDCTextInputControllerOutlined.normalColorDefault,
                          secondColor: .lightGray)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineViewModeDefault, .whileEditing)
    assertEqualFirstColor(MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    assertEqualFirstColor(MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)

    XCTAssertEqual(MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    assertEqualFirstColor(MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault,
                          secondColor: MDCTextInputControllerOutlined.activeColorDefault)

    assertEqualFirstColor(MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerOutlined.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerOutlined.roundedCornersDefault, [])
    
    XCTAssertNil(MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerOutlined(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerOutlined.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerOutlined.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerOutlined.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerOutlined.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerOutlined.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerOutlined.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerOutlined.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerOutlined.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerOutlined.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerOutlined.errorColorDefault = .green
    assertEqualFirstColor(MDCTextInputControllerOutlined.errorColorDefault, secondColor: .green)

    MDCTextInputControllerOutlined.inlinePlaceholderColorDefault = .orange
    assertEqualFirstColor(MDCTextInputControllerOutlined.inlinePlaceholderColorDefault,
                          secondColor: .orange)

    MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerOutlined.activeColorDefault = .purple
    assertEqualFirstColor(MDCTextInputControllerOutlined.activeColorDefault, secondColor: .purple)

    MDCTextInputControllerOutlined.normalColorDefault = .white
    assertEqualFirstColor(MDCTextInputControllerOutlined.normalColorDefault, secondColor: .white)

    MDCTextInputControllerOutlined.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightActiveDefault, 11)

    MDCTextInputControllerOutlined.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineHeightNormalDefault, 5)

    MDCTextInputControllerOutlined.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerOutlined.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault = .green
    assertEqualFirstColor(MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault,
                          secondColor: .green)

    MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault = .gray
    assertEqualFirstColor(MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault,
                          secondColor: .gray)

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerOutlined.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerOutlined.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault = .clear
    assertEqualFirstColor(MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault,
                          secondColor: .clear)

    MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault = .purple
    assertEqualFirstColor(MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault,
                          secondColor: .purple)

    MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerOutlined.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerOutlined.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerOutlined.isFloatingEnabledDefault, false)

    MDCTextInputControllerOutlined.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerOutlined.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerOutlined(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerOutlined.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerOutlined.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerOutlined.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerOutlined.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerOutlined.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerOutlined.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerOutlined.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerOutlined.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerOutlined.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerOutlined.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerOutlined.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerOutlined.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerOutlined.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerOutlined.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerOutlined.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerOutlined.roundedCornersDefault)
  }

  func testUnderline() {

    // Test the values of the class properties.
    assertEqualFirstColor(MDCTextInputControllerUnderline.errorColorDefault,
                          secondColor: MDCPalette.red.accent400)
    assertEqualFirstColor(MDCTextInputControllerUnderline.inlinePlaceholderColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault, false)
    assertEqualFirstColor(MDCTextInputControllerUnderline.activeColorDefault,
                          secondColor: MDCPalette.blue.accent700)
    assertEqualFirstColor(MDCTextInputControllerUnderline.normalColorDefault,
                          secondColor: .lightGray)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineViewModeDefault, .whileEditing)
    assertEqualFirstColor(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    assertEqualFirstColor(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    assertEqualFirstColor(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
                          secondColor: MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)

    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .caption))

    // Default specific properties
    assertEqualFirstColor(MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault,
                          secondColor: MDCTextInputControllerUnderline.activeColorDefault)

    assertEqualFirstColor(MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [])
    
    XCTAssertNil(MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerUnderline(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerUnderline.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerUnderline.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerUnderline.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerUnderline.errorColorDefault = .green
    assertEqualFirstColor(MDCTextInputControllerUnderline.errorColorDefault, secondColor: .green)

    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = .orange
    assertEqualFirstColor(MDCTextInputControllerUnderline.inlinePlaceholderColorDefault,
                          secondColor: .orange)

    MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerUnderline.activeColorDefault = .purple
    assertEqualFirstColor(MDCTextInputControllerUnderline.activeColorDefault, secondColor: .purple)

    MDCTextInputControllerUnderline.normalColorDefault = .white
    assertEqualFirstColor(MDCTextInputControllerUnderline.normalColorDefault, secondColor: .white)

    MDCTextInputControllerUnderline.underlineHeightActiveDefault = 11
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightActiveDefault, 11)

    MDCTextInputControllerUnderline.underlineHeightNormalDefault = 5
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightNormalDefault, 5)

    MDCTextInputControllerUnderline.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault = .blue
    assertEqualFirstColor(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
                          secondColor: .blue)

    MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault = .white
    assertEqualFirstColor(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
                          secondColor: .white)

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault = .red
    assertEqualFirstColor(MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault,
                          secondColor: .red)

    MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault = .red
    assertEqualFirstColor(MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault,
                          secondColor: .red)

    MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerUnderline.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, false)

    MDCTextInputControllerUnderline.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerUnderline(textInput: textField)

    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerUnderline.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerUnderline.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerUnderline.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    assertEqualFirstColor(controller.floatingPlaceholderActiveColor,
                          secondColor: MDCTextInputControllerUnderline.floatingPlaceholderActiveColorDefault)

    assertEqualFirstColor(controller.floatingPlaceholderNormalColor,
                          secondColor: MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)
  }

  func testFullWidth() {
    // Test the values of the class properties.
    assertEqualFirstColor(MDCTextInputControllerFullWidth.disabledColorDefault, secondColor: .clear)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.errorColorDefault,
                          secondColor: MDCPalette.red.accent400)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))
    XCTAssertEqual(MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.activeColorDefault, secondColor: .clear)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.normalColorDefault, secondColor: .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineViewModeDefault, .never)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault,
                          secondColor: .clear)
    assertEqualFirstColor(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
                          secondColor: UIColor(white: 0, alpha: CGFloat(0.54)))

    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_standardFont(forMaterialTextStyle: .caption))
    
    XCTAssertNil(MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerFullWidth(textInput: textField)

    assertEqualFirstColor(controller.disabledColor, secondColor: .clear)
    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerFullWidth.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerFullWidth.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFullWidth.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerFullWidth.disabledColorDefault = .red
    XCTAssertNotEqual(MDCTextInputControllerFullWidth.disabledColorDefault, .red)

    MDCTextInputControllerFullWidth.errorColorDefault = .green
    assertEqualFirstColor(MDCTextInputControllerFullWidth.errorColorDefault, secondColor: .green)

    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = .orange
    assertEqualFirstColor(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
                          secondColor: .orange)

    MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerFullWidth.activeColorDefault = .purple
    assertEqualFirstColor(MDCTextInputControllerFullWidth.activeColorDefault, secondColor: .clear)

    MDCTextInputControllerFullWidth.normalColorDefault = .white
    assertEqualFirstColor(MDCTextInputControllerFullWidth.normalColorDefault, secondColor: .clear)

    MDCTextInputControllerFullWidth.underlineHeightActiveDefault = 9
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightActiveDefault, 0)

    MDCTextInputControllerFullWidth.underlineHeightNormalDefault = 17
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightNormalDefault, 0)

    MDCTextInputControllerFullWidth.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineViewModeDefault, .never)

    MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault = .brown
    assertEqualFirstColor(MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault,
                          secondColor: .clear)

    MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault = .cyan
    assertEqualFirstColor(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
                          secondColor: .cyan)

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 4)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Test the changes to the class properties can propagate to an instance.
    controller = MDCTextInputControllerFullWidth(textInput: textField)

    assertEqualFirstColor(controller.disabledColor, secondColor: .clear)
    assertEqualFirstColor(controller.errorColor,
                          secondColor: MDCTextInputControllerFullWidth.errorColorDefault)
    assertEqualFirstColor(controller.inlinePlaceholderColor,
                          secondColor: MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    assertEqualFirstColor(controller.activeColor,
                          secondColor: MDCTextInputControllerFullWidth.activeColorDefault)
    assertEqualFirstColor(controller.normalColor,
                          secondColor: MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFullWidth.underlineViewModeDefault)
    assertEqualFirstColor(controller.leadingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    assertEqualFirstColor(controller.trailingUnderlineLabelTextColor,
                          secondColor: MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
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
    assertEqualFirstColor(controllerFilled.textInputClearButtonTintColor,
                          secondColor: MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testFilledTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerFilled.textInputClearButtonTintColorDefault = .orange

    // When
    let textInputFilled = MDCTextField()
    let _ = MDCTextInputControllerFilled(textInput: textInputFilled)

    // Then
    assertEqualFirstColor(textInputFilled.clearButton.tintColor,
                          secondColor: MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testFilledTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputFilled = MDCTextField()
    let controllerFilled = MDCTextInputControllerFilled(textInput: textInputFilled)

    // When
    controllerFilled.textInputClearButtonTintColor = .black

    // Then
    assertEqualFirstColor(textInputFilled.clearButton.tintColor,
                          secondColor: controllerFilled.textInputClearButtonTintColor)
  }

  func testOutlinedTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = .cyan

    // When
    let textInput = MDCTextField()
    let controllerOutlined = MDCTextInputControllerOutlined(textInput: textInput)

    // Then
    assertEqualFirstColor(controllerOutlined.textInputClearButtonTintColor,
                          secondColor: MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testOutlinedTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerOutlined.textInputClearButtonTintColorDefault = .cyan

    // When
    let textInputOutlined = MDCTextField()
    let _ = MDCTextInputControllerOutlined(textInput: textInputOutlined)

    // Then
    assertEqualFirstColor(textInputOutlined.clearButton.tintColor,
                          secondColor: MDCTextInputControllerFilled.textInputClearButtonTintColorDefault)
  }

  func testOutlinedTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputOutlined = MDCTextField()
    let controllerOutlined = MDCTextInputControllerOutlined(textInput: textInputOutlined)

    // When
    controllerOutlined.textInputClearButtonTintColor = .red

    // Then
    assertEqualFirstColor(textInputOutlined.clearButton.tintColor,
                          secondColor: controllerOutlined.textInputClearButtonTintColor)
  }
  
  func testUnderlineTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = .orange
    
    // When
    let textInput = MDCTextField()
    let controllerUnderline = MDCTextInputControllerUnderline(textInput: textInput)
    
    // Then
    assertEqualFirstColor(controllerUnderline.textInputClearButtonTintColor,
                          secondColor: MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)
  }
  
  func testUnderlineTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault = .orange
    
    // When
    let textInputUnderline = MDCTextField()
    let _ = MDCTextInputControllerUnderline(textInput: textInputUnderline)
    
    // Then
    assertEqualFirstColor(textInputUnderline.clearButton.tintColor,
                          secondColor: MDCTextInputControllerUnderline.textInputClearButtonTintColorDefault)
  }
  
  func testUnderlineTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputUnderline = MDCTextField()
    let controllerUnderline = MDCTextInputControllerUnderline(textInput: textInputUnderline)
    
    // When
    controllerUnderline.textInputClearButtonTintColor = .black
    
    // Then
    assertEqualFirstColor(textInputUnderline.clearButton.tintColor,
                          secondColor: controllerUnderline.textInputClearButtonTintColor)
  }
  
  func testFullWidthTextInputClearButtonTintColorUsesDefault() {
    // Given
    MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault = .orange
    
    // When
    let textInput = MDCTextField()
    let controllerFullWidth = MDCTextInputControllerFullWidth(textInput: textInput)
    
    // Then
    assertEqualFirstColor(controllerFullWidth.textInputClearButtonTintColor,
                          secondColor: MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault)
  }
  
  func testFullWidthTextInputClearButtonTintColorDefaultAppliesToTextField() {
    // Given
    MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault = .orange
    
    // When
    let textInputFullWidth = MDCTextField()
    let _ = MDCTextInputControllerFullWidth(textInput: textInputFullWidth)
    
    // Then
    assertEqualFirstColor(textInputFullWidth.clearButton.tintColor,
                          secondColor: MDCTextInputControllerFullWidth.textInputClearButtonTintColorDefault)
  }
  
  func testFullWidthTextInputClearButtonTintColorAppliesToTextField() {
    // Given
    let textInputFullWidth = MDCTextField()
    let controllerFullWidth = MDCTextInputControllerFullWidth(textInput: textInputFullWidth)
    
    // When
    controllerFullWidth.textInputClearButtonTintColor = .black
    
    // Then
    assertEqualFirstColor(textInputFullWidth.clearButton.tintColor,
                          secondColor: controllerFullWidth.textInputClearButtonTintColor)
  }
}
