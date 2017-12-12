/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTypography

class TextFieldControllerClassPropertiesTests: XCTestCase {
  override func tearDown() {
    super.tearDown()

    MDCTextInputControllerUnderline.roundedCornersDefault = []
    MDCTextInputControllerUnderline.errorColorDefault = nil
    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault = true
    MDCTextInputControllerUnderline.activeColorDefault = nil
    MDCTextInputControllerUnderline.normalColorDefault = nil
    MDCTextInputControllerUnderline.disabledColorDefault = nil
    MDCTextInputControllerUnderline.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault = nil

    MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault = nil
    MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerUnderline.isFloatingEnabledDefault = true

    MDCTextInputControllerFullWidth.errorColorDefault = nil
    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = true
    MDCTextInputControllerFullWidth.activeColorDefault = nil
    MDCTextInputControllerFullWidth.normalColorDefault = nil
    MDCTextInputControllerFullWidth.disabledColorDefault = nil
    MDCTextInputControllerFullWidth.underlineViewModeDefault = .never

    MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = nil
    MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault = nil
    MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault = nil
  }

  func testUnderline() {

    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerUnderline.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault, true)
    XCTAssertEqual(MDCTextInputControllerUnderline.activeColorDefault,
                   MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerUnderline.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightActiveDefault, 2)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineHeightNormalDefault, 1)
    XCTAssertEqual(MDCTextInputControllerUnderline.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault,
                   MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault,
                   MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)

    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.mdc_preferredFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_preferredFont(forMaterialTextStyle: .caption))

    // Default specific properties
    XCTAssertEqual(MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, true)
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [])

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerUnderline(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerUnderline.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerUnderline.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerUnderline.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(controller.floatingPlaceholderNormalColor,
                   MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerUnderline.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerUnderline.errorColorDefault, .green)

    MDCTextInputControllerUnderline.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

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
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerUnderline.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerUnderline.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Default specific properties
    MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault = .red
    XCTAssertEqual(MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault, .red)

    MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerUnderline.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerUnderline.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerUnderline.isFloatingEnabledDefault, false)

    MDCTextInputControllerUnderline.roundedCornersDefault = [.bottomRight]
    XCTAssertEqual(MDCTextInputControllerUnderline.roundedCornersDefault, [.bottomRight])

    // Test that the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerUnderline(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerUnderline.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerUnderline.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerUnderline.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerUnderline.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerUnderline.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerUnderline.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerUnderline.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerUnderline.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerUnderline.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.leadingUnderlineLabelFontDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerUnderline.trailingUnderlineLabelFontDefault)

    // Default specific properties
    XCTAssertEqual(controller.floatingPlaceholderNormalColor,
                   MDCTextInputControllerUnderline.floatingPlaceholderNormalColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerUnderline.isFloatingEnabledDefault)
    XCTAssertEqual(controller.roundedCorners, MDCTextInputControllerUnderline.roundedCornersDefault)
  }

  func testFullWidth() {
    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerFullWidth.disabledColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   true)
    XCTAssertEqual(MDCTextInputControllerFullWidth.activeColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.normalColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightActiveDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineHeightNormalDefault, 0)
    XCTAssertEqual(MDCTextInputControllerFullWidth.underlineViewModeDefault, .never)
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))

    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.mdc_preferredFont(forMaterialTextStyle: .body1))
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)
    XCTAssertEqual(MDCTextInputControllerFullWidth.leadingUnderlineLabelFontDefault,
                   UIFont.mdc_preferredFont(forMaterialTextStyle: .caption))

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFullWidth.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerFullWidth.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFullWidth.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   nil)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerFullWidth.disabledColorDefault = .red
    XCTAssertNotEqual(MDCTextInputControllerFullWidth.disabledColorDefault, .red)

    MDCTextInputControllerFullWidth.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerFullWidth.errorColorDefault, .green)

    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

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
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 4))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 5)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 5))

    MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault = UIFont.systemFont(ofSize: 6)
    XCTAssertEqual(MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault,
                   UIFont.systemFont(ofSize: 6))

    // Test the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerFullWidth.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerFullWidth.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineHeightActive,
                   MDCTextInputControllerFullWidth.underlineHeightActiveDefault)
    XCTAssertEqual(controller.underlineHeightNormal,
                   MDCTextInputControllerFullWidth.underlineHeightNormalDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerFullWidth.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelTextColorDefault)

    XCTAssertEqual(controller.inlinePlaceholderFont,
                   MDCTextInputControllerFullWidth.inlinePlaceholderFontDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelFont,
                   nil)
    XCTAssertEqual(controller.trailingUnderlineLabelFont,
                   MDCTextInputControllerFullWidth.trailingUnderlineLabelFontDefault)
  }
}
