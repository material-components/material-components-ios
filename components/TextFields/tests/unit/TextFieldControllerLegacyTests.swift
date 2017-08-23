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

class TextFieldControllerDefaultLegacyTests: XCTestCase {
  func testCopyingLegacyDefault() {
    let textField = MDCTextField()

    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)
    controller.characterCountMax = 49
    controller.characterCountViewMode = .always
    controller.disabledColor = .orange
    controller.isFloatingEnabled = false
    controller.floatingPlaceholderColor = .purple
    controller.floatingPlaceholderScale = 0.1
    controller.helperText = "Helper"
    controller.inlinePlaceholderColor = .green
    controller.activeColor = .blue
    controller.normalColor = .white
    controller.underlineViewMode = .always
    controller.leadingUnderlineLabelTextColor = .yellow
    controller.trailingUnderlineLabelTextColor = .orange

    if let controllerCopy = controller.copy() as? MDCTextInputControllerLegacyDefault {
      XCTAssertEqual(controller.characterCountMax, controllerCopy.characterCountMax)
      XCTAssertEqual(controller.characterCountViewMode, controllerCopy.characterCountViewMode)
      XCTAssertEqual(controller.disabledColor, controllerCopy.disabledColor)
      XCTAssertEqual(controller.isFloatingEnabled, controllerCopy.isFloatingEnabled)
      XCTAssertEqual(controller.floatingPlaceholderColor, controllerCopy.floatingPlaceholderColor)
      XCTAssertEqual(controller.floatingPlaceholderScale, controllerCopy.floatingPlaceholderScale)
      XCTAssertEqual(controller.helperText, controllerCopy.helperText)
      XCTAssertEqual(controller.inlinePlaceholderColor, controllerCopy.inlinePlaceholderColor)
      XCTAssertEqual(controller.activeColor, controllerCopy.activeColor)
      XCTAssertEqual(controller.normalColor, controllerCopy.normalColor)
      XCTAssertEqual(controller.underlineViewMode, controllerCopy.underlineViewMode)
      XCTAssertEqual(controller.leadingUnderlineLabelTextColor,
                     controllerCopy.leadingUnderlineLabelTextColor)
      XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                     controllerCopy.trailingUnderlineLabelTextColor)
    } else {
      XCTFail("No copy or copy is wrong class")
    }
  }

  func testCopyingLegacyFullWidth() {
    let textField = MDCTextField()

    let controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)
    controller.characterCountMax = 49
    controller.characterCountViewMode = .always
    controller.disabledColor = .yellow
    controller.helperText = "Helper"
    controller.inlinePlaceholderColor = .green
    controller.activeColor = .blue
    controller.normalColor = .white
    controller.underlineViewMode = .always
    controller.trailingUnderlineLabelTextColor = .purple

    if let controllerCopy = controller.copy() as? MDCTextInputControllerLegacyFullWidth {
      XCTAssertEqual(controller.characterCountMax, controllerCopy.characterCountMax)
      XCTAssertEqual(controller.characterCountViewMode, controllerCopy.characterCountViewMode)
      XCTAssertEqual(controller.disabledColor, controllerCopy.disabledColor)
      XCTAssertEqual(controller.helperText, controllerCopy.helperText)
      XCTAssertEqual(controller.inlinePlaceholderColor, controllerCopy.inlinePlaceholderColor)
      XCTAssertEqual(controller.activeColor, controllerCopy.activeColor)
      XCTAssertEqual(controller.normalColor, controllerCopy.normalColor)
      XCTAssertEqual(controller.underlineViewMode, controllerCopy.underlineViewMode)
      XCTAssertEqual(controller.trailingUnderlineLabelTextColor,
                     controllerCopy.trailingUnderlineLabelTextColor)
    } else {
      XCTFail("No copy or copy is wrong class")
    }
  }

  func testDynamicTypeLegacyDefault() {
    let textField = MDCTextField()

    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)
    XCTAssertNotNil(controller.textInput)

    controller.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(controller.mdc_adjustsFontForContentSizeCategory)

    // The controller takes over listening for dynamic type size changes.
    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
  }

  func testDynamicTypeLegacyFullWidth() {
    let textField = MDCTextField()

    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    let controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)
    XCTAssertNotNil(controller.textInput)

    controller.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(controller.mdc_adjustsFontForContentSizeCategory)

    // The controller takes over listening for dynamic type size changes.
    XCTAssertFalse(textField.mdc_adjustsFontForContentSizeCategory)
  }

  func testCharacterMaxLegacyDefault() {
    let textField = MDCTextField()
    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    let altLeading = "Alternative Helper Test"
    controller.helperText = altLeading

    controller.characterCountMax = 50

    // By setting the folowing text with is 51 characters when the max is set to 50 characters, it 
    // should trigger an error state.
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    XCTAssertTrue("51 / 50".isEqual(textField.trailingUnderlineLabel.text))
    XCTAssertEqual(MDCPalette.red.accent400, textField.underline?.color)
    XCTAssertEqual(MDCPalette.red.accent400, textField.trailingUnderlineLabel.textColor)
  }

  func testCharacterMaxLegacyFullWidth() {
    let textField = MDCTextField()
    let controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    let altLeading = "Alternative Helper Test"
    controller.helperText = altLeading

    controller.characterCountMax = 50

    // By setting the folowing text with is 51 characters when the max is set to 50 characters, it
    // should trigger an error state.
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"

    XCTAssertTrue("51 / 50".isEqual(textField.trailingUnderlineLabel.text))
    XCTAssertEqual(MDCPalette.red.accent400, textField.trailingUnderlineLabel.textColor)
  }

  func testErrorsLegacyDefault() {
    let textField = MDCTextField()
    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    // Helper text is shown on the leading underline label. Make sure the color and content are as 
    // expected.
    let altLeading = "Alternative Helper Test"
    controller.helperText = altLeading
    controller.leadingUnderlineLabelTextColor = .green

    XCTAssertEqual(.green, textField.leadingUnderlineLabel.textColor)
    XCTAssertEqual(altLeading, textField.leadingUnderlineLabel.text)

    controller.trailingUnderlineLabelTextColor = .white
    XCTAssertEqual(textField.trailingUnderlineLabel.textColor, .white)

    XCTAssertNil(controller.errorText)

    // Setting error text should change the color and content of the leading underline label
    let error = "Error Test"
    controller.setErrorText(error, errorAccessibilityValue: nil)
    XCTAssertNotEqual(altLeading, textField.leadingUnderlineLabel.text)
    XCTAssertEqual(error, textField.leadingUnderlineLabel.text)
    XCTAssertEqual(error, controller.errorText)

    let newError = "Different Error Test"
    let altErrorAccessibilityValue = "Not the default"
    controller.setErrorText(newError, errorAccessibilityValue: altErrorAccessibilityValue)
    XCTAssertEqual(newError, controller.errorText)
    XCTAssertEqual(newError, textField.leadingUnderlineLabel.text)
    XCTAssertNotEqual(error, controller.errorText)
    XCTAssertNotEqual(error, textField.leadingUnderlineLabel.text)

    // Setting an error should change the leading label's text color.
    XCTAssertNotEqual(.green, textField.leadingUnderlineLabel.textColor)

    // Setting error color should change the color of the underline, leading, and trailing colors.
    controller.errorColor = .blue
    XCTAssertEqual(.blue, controller.errorColor)

    XCTAssertNotEqual(MDCPalette.red.accent400, textField.leadingUnderlineLabel.textColor)
    XCTAssertNotEqual(MDCPalette.red.accent400, textField.trailingUnderlineLabel.textColor)
    XCTAssertNotEqual(MDCPalette.red.accent400, textField.underline?.color)

    XCTAssertEqual(.blue, textField.leadingUnderlineLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingUnderlineLabel.textColor)
    XCTAssertEqual(.blue, textField.underline?.color)

    // If the controller is also in a character max error state, the leading label should still be 
    // showing the text from the error that was set.
    controller.setErrorText(error, errorAccessibilityValue: nil)
    controller.characterCountMax = 50
    textField.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing"
    XCTAssertEqual(error, textField.leadingUnderlineLabel.text)

    // Removing the error should set the leading text back to its previous text.
    controller.setErrorText(nil, errorAccessibilityValue: nil)
    XCTAssertNotEqual(error, textField.leadingUnderlineLabel.text)
    XCTAssertEqual(altLeading, textField.leadingUnderlineLabel.text)

    // Test error text being reset but character max still exceded.
    XCTAssertEqual(.blue, textField.leadingUnderlineLabel.textColor)
    XCTAssertEqual(.blue, textField.trailingUnderlineLabel.textColor)
    XCTAssertEqual(.blue, textField.underline?.color)

    // Removing the text should remove the error state from character max and therefore remove 
    // anything from showing the error color.
    textField.text = nil
    XCTAssertNotEqual(.blue, textField.leadingUnderlineLabel.textColor)
    XCTAssertNotEqual(.blue, textField.trailingUnderlineLabel.textColor)
    XCTAssertNotEqual(.blue, textField.underline?.color)
  }

  func testPresentationLegacyDefault() {
    let textField = MDCTextField()
    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)

    XCTAssertEqual(controller.isFloatingEnabled, true)
    controller.isFloatingEnabled = false
    XCTAssertEqual(controller.isFloatingEnabled, false)

    controller.isFloatingEnabled = true
    textField.sizeToFit()
    XCTAssertEqual(textField.frame.height, 70)

    controller.helperText = "Helper"
    textField.sizeToFit()
    XCTAssertEqual(textField.frame.height, 84.5)

    controller.characterCountViewMode = .never
    XCTAssertEqual(.clear, textField.trailingUnderlineLabel.textColor)
    controller.characterCountViewMode = .always
    XCTAssertNotEqual(.clear, textField.trailingUnderlineLabel.textColor)

    controller.underlineViewMode = .never
    XCTAssertEqual(.lightGray, textField.underline?.color)
    controller.underlineViewMode = .always
    XCTAssertEqual(MDCPalette.blue.accent700, textField.underline?.color)
  }

  func testPresentationLegacyFullWidth() {
    let textField = MDCTextField()
    let controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)

    textField.sizeToFit()
    XCTAssertEqual(textField.frame.height, 57)

    controller.characterCountViewMode = .never
    XCTAssertEqual(.clear, textField.trailingUnderlineLabel.textColor)
    controller.characterCountViewMode = .always
    XCTAssertNotEqual(.clear, textField.trailingUnderlineLabel.textColor)

    controller.underlineViewMode = .never
    XCTAssertEqual(.clear, textField.underline?.color)
    controller.underlineViewMode = .always
    XCTAssertEqual(.clear, textField.underline?.color)

    controller.disabledColor = .red
    XCTAssertEqual(controller.disabledColor, .clear)
  }

  func testSerializationLegacyDefault() {
    let textField = MDCTextField()

    let controller = MDCTextInputControllerLegacyDefault(textInput: textField)
    controller.characterCountMax = 25
    controller.characterCountViewMode = .always
    controller.disabledColor = .yellow
    controller.isFloatingEnabled = false
    controller.floatingPlaceholderColor = .purple
    controller.floatingPlaceholderScale = 0.1
    controller.helperText = "Helper"
    controller.inlinePlaceholderColor = .green
    controller.activeColor = .blue
    controller.normalColor = .white
    controller.underlineViewMode = .always

    let serializedController = NSKeyedArchiver.archivedData(withRootObject: controller)
    XCTAssertNotNil(serializedController)

    let unserializedController =
      NSKeyedUnarchiver.unarchiveObject(with: serializedController) as?
      MDCTextInputControllerLegacyDefault
    XCTAssertNotNil(unserializedController)

    unserializedController?.textInput = textField
    XCTAssertEqual(controller.characterCountMax, unserializedController?.characterCountMax)
    XCTAssertEqual(controller.characterCountViewMode,
                   unserializedController?.characterCountViewMode)
    XCTAssertEqual(controller.disabledColor, unserializedController?.disabledColor)
    XCTAssertEqual(controller.isFloatingEnabled, unserializedController?.isFloatingEnabled)
    XCTAssertEqual(controller.floatingPlaceholderColor,
                   unserializedController?.floatingPlaceholderColor)
    XCTAssertEqual(controller.floatingPlaceholderScale,
                   unserializedController?.floatingPlaceholderScale)
    XCTAssertEqual(controller.helperText, unserializedController?.helperText)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   unserializedController?.inlinePlaceholderColor)
    XCTAssertEqual(controller.activeColor, unserializedController?.activeColor)
    XCTAssertEqual(controller.normalColor, unserializedController?.normalColor)
    XCTAssertEqual(controller.underlineViewMode, unserializedController?.underlineViewMode)
  }

  func testSerializationLegacyFullWidth() {
    let textField = MDCTextField()

    let controller = MDCTextInputControllerLegacyFullWidth(textInput: textField)
    controller.characterCountMax = 25
    controller.characterCountViewMode = .always
    controller.disabledColor = .yellow
    controller.errorColor = .blue
    controller.inlinePlaceholderColor = .green

    let serializedController = NSKeyedArchiver.archivedData(withRootObject: controller)
    XCTAssertNotNil(serializedController)

    let unserializedController =
      NSKeyedUnarchiver.unarchiveObject(with: serializedController) as?
      MDCTextInputControllerLegacyFullWidth
    XCTAssertNotNil(unserializedController)

    unserializedController?.textInput = textField
    XCTAssertEqual(controller.characterCountMax, unserializedController?.characterCountMax)
    XCTAssertEqual(controller.characterCountViewMode,
                   unserializedController?.characterCountViewMode)
    XCTAssertEqual(unserializedController?.disabledColor, .clear)
    XCTAssertEqual(controller.errorColor, unserializedController?.errorColor)
    XCTAssertEqual(controller.helperText, unserializedController?.helperText)
    XCTAssertEqual(controller.inlinePlaceholderColor,
                   unserializedController?.inlinePlaceholderColor)
  }

}
