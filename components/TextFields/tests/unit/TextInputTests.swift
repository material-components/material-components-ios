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

    let grey = UIColor.gray

    textField.clearButtonColor = grey.copy() as? UIColor
    XCTAssert(textField.clearButtonColor == grey)

    textField.textColor = grey.copy() as? UIColor
    XCTAssert(textField.textColor == grey)

    let testText = "Test text"
    textField.text = testText
    XCTAssert(textField.text == testText)

    let testPlaceholder = "Test placeholder"
    textField.placeholder = testPlaceholder
    XCTAssert(textField.placeholder == testPlaceholder)

    //let behavior = MDCTextInputBehavior(input: textField)

  }

  func testTextViewInputProtocolConformance() {
    let textView = MDCTextView()

    XCTAssertNotNil(textView.leadingLabel)
    XCTAssertNotNil(textView.trailingLabel)
    //XCTAssertNotNil(textView.placeholderLabel)

    let grey = UIColor.gray

    textView.textColor = grey.copy() as? UIColor
    XCTAssert(textView.textColor == grey)

    let testText = "Test text"
    textView.text = testText
    XCTAssert(textView.text == testText)

    let testPlaceholder = "Test placeholder"
    textView.placeholder = testPlaceholder
    XCTAssert(textView.placeholder == testPlaceholder)

    //let behavior = MDCTextInputBehavior(input: textView)
    
  }
}
