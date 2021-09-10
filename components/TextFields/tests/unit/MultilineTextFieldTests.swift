// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import MaterialComponents.MaterialTextFields

class MultilineTextFieldTests: XCTestCase {
  func testAttributedSetters() {
    let textField = MDCMultilineTextField()

    XCTAssertNotNil(textField.textView)

    let string = "attributed"
    textField.attributedPlaceholder = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedPlaceholder?.string, string)

    textField.attributedText = NSAttributedString(string: string)
    XCTAssertEqual(textField.attributedText?.string, string)
  }

  func testCopying() {
    let textField = MDCMultilineTextField()

    textField.textInsetsMode = .never
    textField.borderView?.borderFillColor = .blue
    textField.borderView?.borderPath = UIBezierPath(
      ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
    textField.borderView?.borderPath?.lineWidth = 2
    textField.borderView?.borderStrokeColor = .green
    textField.clearButton.tintColor = .red
    textField.clearButtonMode = .always
    textField.cursorColor = .white
    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    textField.hidesPlaceholderOnInput = false
    textField.isEnabled = false
    textField.placeholder = "test"
    textField.text = "test"
    textField.textColor = .red
    textField.trailingViewMode = .never
    textField.underline?.color = .red
    textField.underline?.lineHeight = 10

    if let textFieldCopy = textField.copy() as? MDCMultilineTextField {
      XCTAssertNotNil(textField.textView)
      XCTAssertTrue(textField.subviews.contains(textField.textView!))

      XCTAssertEqual(textField.textInsetsMode, textFieldCopy.textInsetsMode)
      XCTAssertEqual(textField.attributedPlaceholder, textFieldCopy.attributedPlaceholder)
      XCTAssertEqual(textField.attributedText, textFieldCopy.attributedText)
      XCTAssertEqual(
        textField.borderView?.borderFillColor, textFieldCopy.borderView?.borderFillColor)
      XCTAssertEqual(
        textField.borderView?.borderPath?.bounds, textFieldCopy.borderView?.borderPath?.bounds)
      XCTAssertEqual(
        textField.borderView?.borderPath?.lineWidth, textFieldCopy.borderView?.borderPath?.lineWidth
      )
      XCTAssertEqual(
        textField.borderView?.borderStrokeColor, textFieldCopy.borderView?.borderStrokeColor)
      XCTAssertEqual(textField.clearButton.tintColor, textFieldCopy.clearButton.tintColor)
      XCTAssertEqual(textField.clearButtonMode, textFieldCopy.clearButtonMode)
      XCTAssertEqual(textField.cursorColor, textFieldCopy.cursorColor)
      XCTAssertEqual(textField.font, textFieldCopy.font)
      XCTAssertEqual(textField.hidesPlaceholderOnInput, textFieldCopy.hidesPlaceholderOnInput)
      XCTAssertEqual(textField.isEnabled, textFieldCopy.isEnabled)
      XCTAssertEqual(
        textField.mdc_adjustsFontForContentSizeCategory,
        textFieldCopy.mdc_adjustsFontForContentSizeCategory)
      XCTAssertEqual(textField.placeholder, textFieldCopy.placeholder)
      XCTAssertEqual(textField.text, textFieldCopy.text)
      XCTAssertEqual(textField.textColor, textFieldCopy.textColor)
      XCTAssertEqual(textField.trailingViewMode, textFieldCopy.trailingViewMode)
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

    textField.textInsetsMode = .never
    XCTAssertEqual(textField.textInsetsMode, .never)
  }

  func testTrailingView() {
    let trailingView = UIView()
    let textField = MDCMultilineTextField()

    textField.trailingView = trailingView
    XCTAssertEqual(textField.trailingView, trailingView)
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

  func testTraitCollectionDidChangeBlockCalledWithExpectedParameters() {
    // Given
    let testTextField = MDCMultilineTextField()
    let expectation = XCTestExpectation(description: "traitCollection")
    var passedTraitCollection: UITraitCollection? = nil
    var passedTextField: MDCMultilineTextField? = nil
    testTextField.traitCollectionDidChangeBlock = { (textField, traitCollection) in
      passedTraitCollection = traitCollection
      passedTextField = textField
      expectation.fulfill()
    }
    let fakeTraitCollection = UITraitCollection(displayScale: 7)

    // When
    testTextField.traitCollectionDidChange(fakeTraitCollection)

    // Then
    self.wait(for: [expectation], timeout: 1)
    XCTAssertEqual(passedTraitCollection, fakeTraitCollection)
    XCTAssertEqual(passedTextField, testTextField)
  }

  // MARK - Material Elevation

  func testDefaultBaseElevationOverrideIsNegative() {
    // Then
    XCTAssertLessThan(MDCMultilineTextField().mdc_overrideBaseElevation, 0)
  }

  func testSettingOverrideBaseElevationReturnsSetValue() {
    // Given
    let expectedBaseElevation: CGFloat = 99
    let textField = MDCMultilineTextField()

    // When
    textField.mdc_overrideBaseElevation = expectedBaseElevation

    // Then
    XCTAssertEqual(textField.mdc_overrideBaseElevation, expectedBaseElevation, accuracy: 0.001)
  }
}
