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

class TextFieldLegacyTests: XCTestCase {
  func testSerializationTextFieldLegacy() {
    let textField = MDCTextField()

    let leadingView = UILabel()
    leadingView.text = "$"

    textField.leadingView = leadingView
    textField.leadingViewMode = .unlessEditing

    let trailingView = UILabel()
    trailingView.text = ".com"

    textField.trailingView = trailingView
    textField.trailingViewMode = .unlessEditing

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
      NSKeyedUnarchiver.unarchiveObject(with: serializedInput) as? MDCTextField
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

    if let leadingViewUnserialized = unserializedInput?.leadingView as? UILabel {
      XCTAssertEqual(leadingViewUnserialized.text, leadingView.text)
    } else {
      XCTFail("No leading view or it isn't a UILabel")
    }
    XCTAssertEqual(unserializedInput?.leadingViewMode, .unlessEditing)

    if let trailingViewUnserialized = unserializedInput?.trailingView as? UILabel {
      XCTAssertEqual(trailingViewUnserialized.text, trailingView.text)
    } else {
      XCTFail("No trailing view or it isn't a UILabel")
    }
    XCTAssertEqual(unserializedInput?.trailingViewMode, .unlessEditing)
  }

}
