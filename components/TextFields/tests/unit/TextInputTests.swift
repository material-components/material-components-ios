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
import MaterialComponents.MaterialTextField

class TextInputTests: XCTestCase {

  func testTextFieldInputProtocolConformance() {
    let textField = MDCTextField()

    XCTAssertNotNil(textField.leadingLabel)
    XCTAssertNotNil(textField.trailingLabel)
    //XCTAssertNotNil(textField.placeholderLabel)

    let gray = UIColor.gray

    textField.clearButtonColor = gray.copy() as? UIColor
    XCTAssert(textField.clearButtonColor == gray)

    textField.textColor = gray.copy() as? UIColor
    XCTAssertEqual(textField.textColor, gray)

    let testText = "Test text"
    textField.text = testText
    XCTAssertEqual(textField.text, testText)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssertEqual(textField.placeholder, testPlaceholder)

    textField.underlineColor = gray.copy() as? UIColor
    XCTAssertEqual(textField.underlineColor, gray)
    //let behavior = MDCTextInputBehavior(input: textField)

    let width: CGFloat = 5.0
    textField.underlineWidth = width
    XCTAssertEqual(textField.underlineWidth, width)

    let testLeading = "Helper Test"
    textField.leadingLabel.text = testLeading
    XCTAssertEqual(textField.leadingLabel.text, testLeading)

    let testTrailing = "NN/NN"
    textField.trailingLabel.text = testTrailing
    XCTAssertEqual(textField.trailingLabel.text, testTrailing)
  }

  func testTextViewInputProtocolConformance() {
    let textView = MDCTextView()

    XCTAssertNotNil(textView.leadingLabel)
    XCTAssertNotNil(textView.trailingLabel)
    //XCTAssertNotNil(textView.placeholderLabel)

    let gray = UIColor.gray

    textView.textColor = gray.copy() as? UIColor
    XCTAssertEqual(textView.textColor, gray)

    let testText = "Test text"
    textView.text = testText
    XCTAssertEqual(textView.text, testText)

    let testPlaceholder = "Test placeholder"
    textView.placeholder = testPlaceholder
    XCTAssertEqual(textView.placeholder, testPlaceholder)

    textView.underlineColor = gray.copy() as? UIColor
    XCTAssertEqual(textView.underlineColor, gray)

    //let behavior = MDCTextInputBehavior(input: textView)

    let width: CGFloat = 5.0
    textView.underlineWidth = width
    XCTAssertEqual(textView.underlineWidth, width)

    let testLeading = "Helper Test"
    textView.leadingLabel.text = testLeading
    XCTAssertEqual(textView.leadingLabel.text, testLeading)

    let testTrailing = "NN/NN"
    textView.trailingLabel.text = testTrailing
    XCTAssertEqual(textView.trailingLabel.text, testTrailing)
  }
}
