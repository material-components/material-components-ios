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

    MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault = nil
    MDCTextInputControllerLegacyDefault.floatingPlaceholderScaleDefault = 0.75
    MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault = true

    MDCTextInputControllerFullWidth.errorColorDefault = nil
    MDCTextInputControllerFullWidth.inlinePlaceholderColorDefault = nil
    MDCTextInputControllerFullWidth.mdc_adjustsFontForContentSizeCategoryDefault = true
    MDCTextInputControllerFullWidth.activeColorDefault = nil
    MDCTextInputControllerFullWidth.normalColorDefault = nil
    MDCTextInputControllerFullWidth.underlineViewModeDefault = .never
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

    // Default specific properties
    XCTAssertEqual(controller.floatingPlaceholderColor,
                   MDCTextInputControllerLegacyDefault.floatingPlaceholderColorDefault)
    XCTAssertEqual(controller.isFloatingEnabled,
                   MDCTextInputControllerLegacyDefault.isFloatingEnabledDefault)
  }
}
