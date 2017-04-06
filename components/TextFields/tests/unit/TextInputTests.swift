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
import MaterialComponents.MaterialPalettes

class TextInputTests: XCTestCase {

  func testTextFieldInputProtocolConformance() {
    let textField = MDCTextField()

    XCTAssertNotNil(textField.leadingLabel)
    XCTAssertNotNil(textField.trailingLabel)
    XCTAssertNotNil(textField.placeholderLabel)

    let red = UIColor.red

    textField.clearButtonColor = red.copy() as? UIColor
    XCTAssert(textField.clearButtonColor == red)

    textField.textColor = red.copy() as? UIColor
    XCTAssertEqual(textField.textColor, red)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(textField.text, testText)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(textField.placeholder, testPlaceholder)

    textField.underlineColor = red.copy() as? UIColor
    XCTAssertEqual(textField.underlineColor, red)

    let width: CGFloat = 5.0
    textField.underlineHeight = width
    XCTAssertEqual(textField.underlineHeight, width)

    let testLeading = "Helper Test"
    textField.leadingLabel.text = testLeading
    XCTAssertEqual(textField.leadingLabel.text, testLeading)

    let testTrailing = "NN / NN"
    textField.trailingLabel.text = testTrailing
    XCTAssertEqual(textField.trailingLabel.text, testTrailing)
  }

  func testTextFieldOverlayViews() {
    let textField = MDCTextField()

    let leftView = UILabel()
    let rightView = UILabel()
    leftView.text = "X"
    textField.leftView = leftView
    textField.rightView = rightView
    textField.leftViewMode = .always
    textField.rightViewMode = .always

    // This will trigger autolayout to scream in the console. It's ok. It's for the testing.
    textField.layoutIfNeeded()

    XCTAssertTrue(textField.subviews.contains(leftView))
    XCTAssertTrue(textField.subviews.contains(rightView))
  }

  func testControllerTextField() {
    let textField = MDCTextField()

    let controller = MDCTextInputController(input: textField)
    XCTAssertNotNil(controller.input)

    let altLeading = "Alternative Helper Test"
    controller.helper = altLeading
    if let input = controller.input as? MDCTextInput {
      XCTAssertEqual(altLeading, input.leadingLabel.text)

      let error = "Error Test"
      controller.set(errorText: error, errorAccessibilityValue: nil)
      XCTAssertNotEqual(altLeading, input.leadingLabel.text)
      XCTAssertEqual(error, input.leadingLabel.text)
    } else {
      XCTFail("No input found on controller.")
    }

    controller.characterMax = 50
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"
    print(textField.trailingLabel)
    XCTAssertTrue("51 / 50".isEqual(textField.trailingLabel.text))
    XCTAssertEqual(MDCPalette.red().tint500, textField.underlineColor)
    XCTAssertEqual(MDCPalette.red().tint500, textField.trailingLabel.textColor)
  }
}
