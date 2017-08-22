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

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import MaterialComponents.MaterialTextFields

class MultilineTextFieldLegacyTests: XCTestCase {
  func testAttributedSetters() {
    let textField = MDCMultilineTextField()

    let string = "attributed"
    textField.attributedPlaceholder = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedPlaceholder?.string, string)

    textField.attributedText = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedText?.string, string)
  }

  func testCopying() {
    let textField = MDCMultilineTextField()

    textField.clearButtonColor = .red
    textField.clearButtonMode = .always
    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    textField.hidesPlaceholderOnInput = false
    textField.isEnabled = false
    textField.mdc_adjustsFontForContentSizeCategory = true
    textField.placeholder = "test"
    textField.text = "test"
    textField.textColor = .red
    textField.underline?.color = .red
    textField.underline?.lineHeight = 10

    if let textFieldCopy = textField.copy() as? MDCMultilineTextField {
      XCTAssertNotNil(textField.textView)
      XCTAssertTrue(textField.subviews.contains(textField.textView!))

      XCTAssertEqual(textField.attributedPlaceholder, textFieldCopy.attributedPlaceholder)
      XCTAssertEqual(textField.attributedText, textFieldCopy.attributedText)
      XCTAssertEqual(textField.clearButtonColor, textFieldCopy.clearButtonColor)
      XCTAssertEqual(textField.clearButtonMode, textFieldCopy.clearButtonMode)
      XCTAssertEqual(textField.font, textFieldCopy.font)
      XCTAssertEqual(textField.hidesPlaceholderOnInput, textFieldCopy.hidesPlaceholderOnInput)
      XCTAssertEqual(textField.isEnabled, textFieldCopy.isEnabled)
      XCTAssertEqual(textField.mdc_adjustsFontForContentSizeCategory,
                     textFieldCopy.mdc_adjustsFontForContentSizeCategory)
      XCTAssertEqual(textField.placeholder, textFieldCopy.placeholder)
      XCTAssertEqual(textField.text, textFieldCopy.text)
      XCTAssertEqual(textField.textColor, textFieldCopy.textColor)
      XCTAssertEqual(textField.underline?.color, textFieldCopy.underline?.color)
      XCTAssertEqual(textField.underline?.lineHeight, textFieldCopy.underline?.lineHeight)
    } else {
      XCTFail("No copy or copy is wrong class")
    }
  }

  func testFontChange() {
    let textField = MDCMultilineTextField()

    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    XCTAssertEqual(UIFont.systemFont(ofSize: UIFont.labelFontSize), textField.font)
    XCTAssertNotEqual(UIFont.systemFont(ofSize: UIFont.smallSystemFontSize), textField.font)
  }

  func testMDCDynamicTypeAPI() {
    let textField = MDCMultilineTextField()

    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    if #available(iOS 10, *) {
      XCTAssertEqual(textField.mdc_adjustsFontForContentSizeCategory,
                     textField.adjustsFontForContentSizeCategory)
    }
  }

  func testSerializationLegacy() {
    let textField = MDCMultilineTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)
    XCTAssertNotNil(controller.textInput)

    let leadingText = "Serialized Helper Test"
    controller.helperText = leadingText
    controller.characterCountMax = 40

    let serializedInput = NSKeyedArchiver.archivedData(withRootObject: textField)
    XCTAssertNotNil(serializedInput)

    let unserializedInput =
      NSKeyedUnarchiver.unarchiveObject(with: serializedInput) as? MDCMultilineTextField
    XCTAssertNotNil(unserializedInput)

    XCTAssertEqual(textField.translatesAutoresizingMaskIntoConstraints,
                   unserializedInput?.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(textField.text,
                   unserializedInput?.text)

    XCTAssertEqual(textField.leadingUnderlineLabel.text,
                   unserializedInput?.leadingUnderlineLabel.text)

    XCTAssertEqual(textField.trailingUnderlineLabel.text, "51 / 40")
    XCTAssertEqual(textField.trailingUnderlineLabel.text,
                   unserializedInput?.trailingUnderlineLabel.text)
  }

  func testSizing() {
    let textField = MDCMultilineTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 0))
    XCTAssertEqual(textField.frame.height, 0)

    textField.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    XCTAssertEqual(textField.frame.height, 40)

    textField.sizeToFit()
    XCTAssertEqual(textField.frame.height, 49)

    textField.leadingUnderlineLabel.text = "Helper"
    textField.sizeToFit()
    XCTAssertEqual(textField.frame.height, 66)
  }

  func testUnderlineSetters() {
    let textField = MDCMultilineTextField()

    textField.underline?.color = .red
    textField.underline?.lineHeight = 10

    XCTAssertEqual(textField.underline?.color, .red)
    if let underline = textField.underline {
      XCTAssertEqual(underline.color, .red)
      XCTAssertEqual(underline.color, textField.underline?.color)

      XCTAssertEqual(underline.lineHeight, 10)
      XCTAssertEqual(underline.lineHeight, textField.underline?.lineHeight)
    } else {
      XCTFail("No underline or underline is wrong class")
    }
  }
}
