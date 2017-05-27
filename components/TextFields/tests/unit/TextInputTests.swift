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
  func testTextFieldTextInputProtocolConformance() {
    let textField = MDCTextField()

    XCTAssertNotNil(textField.leadingLabel)
    XCTAssertNotNil(textField.trailingLabel)
    XCTAssertNotNil(textField.placeholderLabel)

    textField.clearButtonColor = .red
    XCTAssertEqual(textField.clearButtonColor, .red)

    let font = UIFont.boldSystemFont(ofSize: 6)
    textField.font = font
    XCTAssertEqual(font, textField.font)

    let testLeading = "Helper Test"
    textField.leadingLabel.text = testLeading
    XCTAssertEqual(testLeading, textField.leadingLabel.text)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(testPlaceholder, textField.placeholder)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(testText, textField.text)

    textField.textColor = .red
    XCTAssertEqual(.red, textField.textColor)

    let testTrailing = "NN / NN"
    textField.trailingLabel.text = testTrailing
    XCTAssertEqual(testTrailing, textField.trailingLabel.text)

    textField.underlineColor = .red
    XCTAssertEqual(.red, textField.underlineColor)

    let width: CGFloat = 5.0
    textField.underlineHeight = width
    XCTAssertEqual(width, textField.underlineHeight)
  }
}
