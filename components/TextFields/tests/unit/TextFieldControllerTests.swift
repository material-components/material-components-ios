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
  func testCopying() {
    let textField = MDCTextField()

    let controller = MDCTextInputController(input: textField)
    controller.characterMax = 49

    if let controllerCopy = controller.copy() as? MDCTextInputController {
      XCTAssertEqual(controller.characterMax, controllerCopy.characterMax)
    } else {
      XCTFail("No copy or copy is wrong class")
    }
  }

  func testDynamicType() {
    let textField = MDCTextField()

    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    let controller = MDCTextInputController(input: textField)
    XCTAssertNotNil(controller.input)

    controller.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(controller.mdc_adjustsFontForContentSizeCategory)

    // The controller takes over listening for dynamic type size changes.
    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
  }

  func testCharacterMax() {
    let textField = MDCTextField()
    let controller = MDCTextInputController(input: textField)

    let altLeading = "Alternative Helper Test"
    controller.helper = altLeading

    controller.characterMax = 50

    // By setting the folowing text with is 51 characters when the max is set to 50 characters, it 
    // should trigger an error state.
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    XCTAssertTrue("51 / 50".isEqual(textField.trailingLabel.text))
    XCTAssertEqual(MDCPalette.red().tint500, textField.underline?.color)
    XCTAssertEqual(MDCPalette.red().tint500, textField.trailingLabel.textColor)
  }

  func testErrors() {
    let textField = MDCTextField()
    let controller = MDCTextInputController(input: textField)

    // Helper text is shown on the leading underline label. Make sure the color and content are as 
    // expected.
    let altLeading = "Alternative Helper Test"
    controller.helper = altLeading
    textField.leadingLabel.textColor = .green
    XCTAssertEqual(.green, textField.leadingLabel.textColor)
    XCTAssertEqual(altLeading, textField.leadingLabel.text)

    // Setting error text should change the color and content of the leading underline label
    let error = "Error Test"
    controller.set(errorText: error, errorAccessibilityValue: nil)
    XCTAssertNotEqual(altLeading, textField.leadingLabel.text)
    XCTAssertEqual(error, textField.leadingLabel.text)

    // Setting an error should change the leading label's text color.
    XCTAssertNotEqual(.green, textField.leadingLabel.textColor)

    // Setting error color should change the color of the underline, leading, and trailing colors.
    controller.errorColor = .blue
    XCTAssertEqual(.blue, controller.errorColor)

    XCTAssertNotEqual(MDCPalette.red().tint500, textField.leadingLabel.textColor)
    XCTAssertNotEqual(MDCPalette.red().tint500, textField.trailingLabel.textColor)
    XCTAssertNotEqual(MDCPalette.red().tint500, textField.underline?.color)

    XCTAssertEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertEqual(.blue, textField.underline?.color)

    // If the controller is also in a character max error state, the leading label should still be 
    // showing the text from the error that was set.
    controller.characterMax = 50
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"
    XCTAssertEqual(error, textField.leadingLabel.text)

    // Removing the error should set the leading text back to its previous text.
    controller.set(errorText: nil, errorAccessibilityValue: nil)
    XCTAssertNotEqual(error, textField.leadingLabel.text)
    XCTAssertEqual(altLeading, textField.leadingLabel.text)

    // Test error text being reset but character max still exceded.
    XCTAssertEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertEqual(.blue, textField.underline?.color)

    // Removing the text should remove the error state from character max and therefore remove 
    // anything from showing the error color.
    textField.text = nil
    XCTAssertNotEqual(.blue, textField.leadingLabel.textColor)
    XCTAssertNotEqual(.blue, textField.trailingLabel.textColor)
    XCTAssertNotEqual(.blue, textField.underline?.color)
  }

  func testPresentation() {
    let textField = MDCTextField()
    let controller = MDCTextInputController(input: textField)

    XCTAssertNotEqual(controller.presentation, .floatingPlaceholder)
    controller.presentation = .floatingPlaceholder
    XCTAssertEqual(controller.presentation, .floatingPlaceholder)

    controller.characterMode = .never
    XCTAssertEqual(.clear, textField.trailingLabel.textColor)
    controller.characterMode = .always
    XCTAssertNotEqual(.clear, textField.trailingLabel.textColor)

    controller.underlineMode = .never
    XCTAssertEqual(.lightGray, textField.underline?.color)
    controller.underlineMode = .always
    XCTAssertEqual(MDCPalette.indigo().tint500, textField.underline?.color)
  }
}
