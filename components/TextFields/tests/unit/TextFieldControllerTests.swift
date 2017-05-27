/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

import XCTest
import MaterialComponents.MaterialTextFields

class TextFieldControllerTests: XCTestCase {
  func testControllerTextField() {
    let textField = MDCTextField()

    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    let controller = MDCTextInputController(input: textField)
    XCTAssertNotNil(controller.input)

    controller.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(controller.mdc_adjustsFontForContentSizeCategory)
    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)

    let altLeading = "Alternative Helper Test"
    controller.helper = altLeading

    controller.characterMax = 50
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    XCTAssertTrue("51 / 50".isEqual(textField.trailingLabel.text))
    XCTAssertEqual(MDCPalette.red().tint500, textField.underlineColor)
    XCTAssertEqual(MDCPalette.red().tint500, textField.trailingLabel.textColor)

    textField.leadingLabel.textColor = .green
    XCTAssertEqual(.green, textField.leadingLabel.textColor)
    XCTAssertEqual(altLeading, textField.leadingLabel.text)

    let error = "Error Test"
    controller.set(errorText: error, errorAccessibilityValue: nil)
    XCTAssertNotEqual(altLeading, textField.leadingLabel.text)
    XCTAssertNotEqual(.green, textField.leadingLabel.textColor)

    controller.errorColor = .blue
    XCTAssertEqual(.blue, controller.errorColor)

    XCTAssertNotEqual(MDCPalette.red().tint500, textField.trailingLabel.textColor)
    XCTAssertNotEqual(MDCPalette.red().tint500, textField.underlineColor)

    XCTAssertEqual(error, textField.leadingLabel.text)
    XCTAssertEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertEqual(.blue, textField.underlineColor)

    controller.set(errorText: nil, errorAccessibilityValue: nil)
    XCTAssertNotEqual(error, textField.leadingLabel.text)

    // Test errorText being reset but characterMax still exceded
    XCTAssertEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertEqual(.blue, textField.underlineColor)

    textField.text = nil
    XCTAssertNotEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertNotEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertNotEqual(.blue, textField.underlineColor)

    XCTAssertNotEqual(controller.presentation, .floatingPlaceholder)
    controller.presentation = .floatingPlaceholder
    XCTAssertEqual(controller.presentation, .floatingPlaceholder)

    controller.characterMode = .never
    XCTAssertEqual(.clear, textField.trailingLabel.textColor)
    controller.characterMode = .always
    XCTAssertNotEqual(.clear, textField.trailingLabel.textColor)

    controller.underlineMode = .never
    XCTAssertEqual(.lightGray, textField.underlineColor)
    controller.underlineMode = .always
    XCTAssertEqual(MDCPalette.indigo().tint500, textField.underlineColor)
  }
}
