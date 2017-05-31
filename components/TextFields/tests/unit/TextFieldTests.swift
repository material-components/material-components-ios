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

class TextFieldTests: XCTestCase {
  func testAttributedSetters() {
    let textField = MDCTextField()

    let string = "attributed"
    textField.attributedPlaceholder = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedPlaceholder?.string, string)

    textField.attributedText = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedText?.string, string)
  }

  func testCopyingTextField() {
    let textField = MDCTextField()

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

    if let textFieldCopy = textField.copy() as? MDCTextField {
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
    let textField = MDCTextField()

    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    XCTAssertEqual(UIFont.systemFont(ofSize: UIFont.labelFontSize), textField.font)
    XCTAssertNotEqual(UIFont.systemFont(ofSize: UIFont.smallSystemFontSize), textField.font)
  }

  func testTextFieldMDCDynamicTypeAPI() {
    let textField = MDCTextField()

    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    if #available(iOS 10, *) {
      XCTAssertEqual(textField.mdc_adjustsFontForContentSizeCategory,
                     textField.adjustsFontForContentSizeCategory)
    }
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

  func testSerializationTextField() {
    let textField = MDCTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    let controller = MDCTextInputController(input: textField)
    XCTAssertNotNil(controller.textInput)

    let leadingText = "Serialized Helper Test"
    controller.helperText = leadingText
    controller.characterCountMax = 40

    let serializedInput = NSKeyedArchiver.archivedData(withRootObject: textField)
    XCTAssertNotNil(serializedInput)

    let unserializedInput =
      NSKeyedUnarchiver.unarchiveObject(with: serializedInput) as? MDCTextField
    XCTAssertNotNil(unserializedInput)

    XCTAssertEqual(textField.translatesAutoresizingMaskIntoConstraints,
                   unserializedInput?.translatesAutoresizingMaskIntoConstraints)
    XCTAssertEqual(textField.text,
                   unserializedInput?.text)

    XCTAssertEqual(textField.leadingUnderlineLabel.text,
                   unserializedInput?.leadingUnderlineLabel.text)

    XCTAssertEqual(textField.trailingUnderlineLabel.text, "51 / 40")
    XCTAssertEqual(textField.trailingUnderlineLabel.text, unserializedInput?.trailingUnderlineLabel.text)

    let serializedController = NSKeyedArchiver.archivedData(withRootObject: controller)
    XCTAssertNotNil(serializedController)

    let unserializedController =
      NSKeyedUnarchiver.unarchiveObject(with: serializedController) as?
    MDCTextInputController
    XCTAssertNotNil(unserializedController)

    unserializedController?.textInput = unserializedInput
    XCTAssertEqual(controller.helperText, unserializedController?.helperText)
    XCTAssertEqual(controller.characterCountMax, unserializedController?.characterCountMax)
  }

  func testUnderlineSetters() {
    let textField = MDCTextField()

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
