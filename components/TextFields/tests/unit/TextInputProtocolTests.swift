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

class TextInputTests: XCTestCase {
  func testMDCTextInputProtocolConformanceSingleline() {
    let textField = MDCTextField()

    XCTAssertNotNil(textField.leadingUnderlineLabel)
    XCTAssertNotNil(textField.trailingUnderlineLabel)
    XCTAssertNotNil(textField.placeholderLabel)

    textField.clearButtonColor = .red
    XCTAssertEqual(textField.clearButtonColor, .red)

    let font = UIFont.boldSystemFont(ofSize: 6)
    textField.font = font
    XCTAssertEqual(font, textField.font)

    let testLeading = "Helper Test"
    textField.leadingUnderlineLabel.text = testLeading
    XCTAssertEqual(testLeading, textField.leadingUnderlineLabel.text)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(testPlaceholder, textField.placeholder)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(testText, textField.text)

    textField.textColor = .red
    XCTAssertEqual(.red, textField.textColor)

    let testTrailing = "NN / NN"
    textField.trailingUnderlineLabel.text = testTrailing
    XCTAssertEqual(testTrailing, textField.trailingUnderlineLabel.text)

    textField.underline?.color = .red
    XCTAssertEqual(.red, textField.underline?.color)

    let width: CGFloat = 5.0
    textField.underline?.lineHeight = width
    XCTAssertEqual(width, textField.underline?.lineHeight)
  }

  func testMDCTextInputProtocolConformanceMultiline() {
    let textField = MDCMultilineTextField()

    XCTAssertNotNil(textField.leadingUnderlineLabel)
    XCTAssertNotNil(textField.trailingUnderlineLabel)
    XCTAssertNotNil(textField.placeholderLabel)

    let gray = UIColor.gray

    textField.textColor = gray.copy() as? UIColor
    XCTAssertEqual(textField.textColor, gray)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(textField.text, testText)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(textField.placeholder, testPlaceholder)

    textField.underline?.color = gray.copy() as? UIColor
    XCTAssertEqual(textField.underline?.color, gray)

    let width: CGFloat = 5.0
    textField.underline?.lineHeight = width
    XCTAssertEqual(textField.underline?.lineHeight, width)

    let testLeading = "Helper Test"
    textField.leadingUnderlineLabel.text = testLeading
    XCTAssertEqual(textField.leadingUnderlineLabel.text, testLeading)

    let testTrailing = "NN / NN"
    textField.trailingUnderlineLabel.text = testTrailing
    XCTAssertEqual(textField.trailingUnderlineLabel.text, testTrailing)

    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)
    XCTAssertNotNil(controller.textInput)
  }

  func testMDCMultilineTextInputProtocolConformance() {
    let textField = MDCMultilineTextField()
    XCTAssertEqual(textField.minimumLines, 1)

    textField.minimumLines = 3
    XCTAssertEqual(textField.minimumLines, 3)

    textField.minimumLines = 0
    XCTAssertEqual(textField.minimumLines, 1)
  }
}
