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

class TextFieldControllerClassPropertiesLegacyTests: XCTestCase {
  override func tearDown() {
    super.tearDown()

    MDCTextInputControllerLegacyDefault.errorColorDefault = nil
    MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault = true
    MDCTextInputControllerLegacyDefault.activeColorDefault = nil
    MDCTextInputControllerLegacyDefault.normalColorDefault = nil
    MDCTextInputControllerLegacyDefault.underlineViewModeDefault = .whileEditing
    MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault = nil

    MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault = nil
    MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault = true

    MDCTextInputControllerLegacyFullWidth.errorColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = true
    MDCTextInputControllerLegacyFullWidth.activeColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.normalColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault = .never

    MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault = nil
    MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault = nil
  }

  func testLegacyDefault() {

    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault, true)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.activeColorDefault,
                   MDCPalette.blue.accent700)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.normalColorDefault, .lightGray)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineViewModeDefault, .whileEditing)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault,
                   MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault,
                   MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)


    // Default specific properties
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault,
                   MDCPalette.blue.accent700)
    XCTAssertEqual(Float(MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault), 0.75)
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault, true)

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyDefault.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerLegacyDefault.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerLegacyDefault.normalColorDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerLegacyDefault.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault)

    // Default specific properties
    XCTAssertEqual(controller.floatingPlaceholderColor,
                   MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerLegacyDefault.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.errorColorDefault, .green)

    MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerLegacyDefault.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.activeColorDefault, .purple)

    MDCTextInputControllerLegacyDefault.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.normalColorDefault, .white)

    MDCTextInputControllerLegacyDefault.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.underlineViewModeDefault, .unlessEditing)

    MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault = .blue
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault, .blue)

    MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault, .white)

    // Default specific properties
    MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault = .red
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault, .red)

    MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault = 0.6
    XCTAssertEqual(Float(MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault), 0.6)

    MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault = false
    XCTAssertEqual(MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault, false)

    // Test the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyDefault.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerLegacyDefault.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerLegacyDefault.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerLegacyDefault.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerLegacyDefault.normalColorDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerLegacyDefault.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyDefault.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyDefault.trailingUnderlineLabelTextColorDefault)

    // Default specific properties
    XCTAssertEqual(controller.floatingPlaceholderColor,
                   MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault)
  }

  func testLegacyFullWidth() {
    // Test the values of the class properties.
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.disabledColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.errorColorDefault, MDCPalette.red.accent400)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   true)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.activeColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.normalColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault, .never)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault, .clear)
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault,
                   UIColor(white: 0, alpha: CGFloat(Float(0.54))))

    // Test the use of the class properties.
    let textField = MDCTextField()
    var controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyFullWidth.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerLegacyFullWidth.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerLegacyFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault)

    // Test the changes to the class properties.
    MDCTextInputControllerLegacyFullWidth.disabledColorDefault = .red
    XCTAssertNotEqual(MDCTextInputControllerLegacyFullWidth.disabledColorDefault, .red)

    MDCTextInputControllerLegacyFullWidth.errorColorDefault = .green
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.errorColorDefault, .green)

    MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault = .orange
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault, .orange)

    MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = false
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault,
                   false)

    MDCTextInputControllerLegacyFullWidth.activeColorDefault = .purple
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.activeColorDefault, .clear)

    MDCTextInputControllerLegacyFullWidth.normalColorDefault = .white
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.normalColorDefault, .clear)

    MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault = .unlessEditing
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault, .never)

    MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault = .brown
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault, .clear)

    MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault = .cyan
    XCTAssertEqual(MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault, .cyan)

    // Test the changes to the class properties can propogate to an instance.
    controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    XCTAssertEqual(controller.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, MDCTextInputControllerLegacyFullWidth.errorColorDefault)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   MDCTextInputControllerLegacyFullWidth.inlinePlaceholderColorDefault)
    XCTAssertEqual(controller.mdc_adjustsFontForContentSizeCategory,
                   MDCTextInputControllerLegacyFullWidth.mdc_adjustsFontForContentSizeCategoryDefault)
    XCTAssertEqual(controller.activeColor,
                   MDCTextInputControllerLegacyFullWidth.activeColorDefault)
    XCTAssertEqual(controller.normalColor,
                   MDCTextInputControllerLegacyFullWidth.normalColorDefault)
    XCTAssertEqual(controller.underlineViewMode,
                   MDCTextInputControllerLegacyFullWidth.underlineViewModeDefault)
    XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyFullWidth.leadingUnderlineLabelTextColorDefault)
    XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                   MDCTextInputControllerLegacyFullWidth.trailingUnderlineLabelTextColorDefault)
  }
}
