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

  // All the constraints created internally by the MDCTextField need to have a rather low priority
  // so they can be overridden by a controller from the outside.
  func testConstraintPriorities() {
    let textField = MDCTextField()

    for constraint in textField.constraints {
      XCTAssertLessThanOrEqual(
        constraint.priority.rawValue,
        UILayoutPriority.defaultLow.rawValue + 10,
        String(describing: constraint))
    }
  }

  func testBorder() {
    let textField = MDCTextField()
    XCTAssertTrue((textField.borderView?.isDescendant(of: textField))!)
  }

  func testCopying() {
    let textField = MDCTextField()

    textField.textInsetsMode = .never
    textField.borderView?.borderFillColor = .purple
    textField.borderView?.borderStrokeColor = .orange
    textField.borderView?.borderPath =
      UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
    textField.borderView?.borderStrokeColor = .yellow
    textField.clearButton.tintColor = .red
    textField.clearButtonMode = .always
    textField.cursorColor = .white
    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    textField.hidesPlaceholderOnInput = false
    textField.isEnabled = false
    textField.leadingViewMode = .unlessEditing
    textField.placeholder = "test"
    textField.text = "test"
    textField.textColor = .red
    textField.trailingViewMode = .unlessEditing
    textField.underline?.color = .red
    textField.underline?.lineHeight = 10

    if let textFieldCopy = textField.copy() as? MDCTextField {
      XCTAssertEqual(textField.textInsetsMode, textFieldCopy.textInsetsMode)
      XCTAssertEqual(textField.attributedPlaceholder, textFieldCopy.attributedPlaceholder)
      XCTAssertEqual(textField.attributedText, textFieldCopy.attributedText)
      XCTAssertEqual(
        textField.borderView?.borderFillColor,
        textFieldCopy.borderView?.borderFillColor)
      XCTAssertEqual(
        textField.borderView?.borderStrokeColor,
        textFieldCopy.borderView?.borderStrokeColor)
      XCTAssertEqual(
        textField.borderView?.borderPath?.bounds.integral,
        textFieldCopy.borderView?.borderPath?.bounds.integral)
      XCTAssertEqual(
        textField.borderView?.borderStrokeColor,
        textFieldCopy.borderView?.borderStrokeColor)
      XCTAssertEqual(textField.clearButton.tintColor, textFieldCopy.clearButton.tintColor)
      XCTAssertEqual(textField.clearButtonMode, textFieldCopy.clearButtonMode)
      XCTAssertEqual(textField.cursorColor, textFieldCopy.cursorColor)
      XCTAssertEqual(textField.font, textFieldCopy.font)
      XCTAssertEqual(textField.hidesPlaceholderOnInput, textFieldCopy.hidesPlaceholderOnInput)
      XCTAssertEqual(textField.isEnabled, textFieldCopy.isEnabled)
      XCTAssertEqual(textField.leadingViewMode, textFieldCopy.leadingViewMode)
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
    let textField = MDCTextField()

    textField.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    XCTAssertEqual(UIFont.systemFont(ofSize: UIFont.labelFontSize), textField.font)
    XCTAssertNotEqual(UIFont.systemFont(ofSize: UIFont.smallSystemFontSize), textField.font)
  }

  func testLeadingingView() {
    let leadingView = UIView()
    let textField = MDCTextField()

    textField.leadingView = leadingView
    XCTAssertEqual(textField.leadingView, leadingView)
  }

  func testMDCDynamicTypeAPI() {
    let textField = MDCTextField()

    textField.mdc_adjustsFontForContentSizeCategory = true
    XCTAssertTrue(textField.mdc_adjustsFontForContentSizeCategory)

    XCTAssertEqual(
      textField.mdc_adjustsFontForContentSizeCategory,
      textField.adjustsFontForContentSizeCategory)
  }

  func testOverlayViews() {
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

    if UIView.userInterfaceLayoutDirection(for: .unspecified) == .leftToRight {
      XCTAssertEqual(textField.leadingView, leftView)
      XCTAssertEqual(textField.leadingView, textField.leftView)

      XCTAssertEqual(textField.trailingView, rightView)
      XCTAssertEqual(textField.trailingView, textField.rightView)
    } else {
      XCTAssertEqual(textField.leadingView, rightView)
      XCTAssertEqual(textField.leadingView, textField.rightView)

      XCTAssertEqual(textField.trailingView, leftView)
      XCTAssertEqual(textField.trailingView, textField.leftView)
    }
  }

  func testSizing() {
    let textField = MDCTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 0))
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

  func testUnderlineSetters() {
    let textField = MDCTextField()

    textField.underline?.color = .red
    textField.underline?.disabledColor = .yellow
    textField.underline?.lineHeight = 10

    XCTAssertEqual(textField.underline?.color, .red)
    if let underline = textField.underline {
      XCTAssertEqual(underline.color, .red)
      XCTAssertEqual(underline.color, textField.underline?.color)

      XCTAssertEqual(underline.lineHeight, 10)
      XCTAssertEqual(underline.lineHeight, textField.underline?.lineHeight)

      XCTAssertEqual(underline.disabledColor, .yellow)
    } else {
      XCTFail("No underline or underline is wrong class")
    }
  }

  func testTraitCollectionDidChangeBlockCalledWithExpectedParameters() {
    // Given
    let testTextField = MDCTextField()
    let expectation = XCTestExpectation(description: "traitCollection")
    var passedTraitCollection: UITraitCollection? = nil
    var passedTextField: MDCTextField? = nil
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
    XCTAssertLessThan(MDCTextField().mdc_overrideBaseElevation, 0)
  }

  func testSettingOverrideBaseElevationReturnsSetValue() {
    // Given
    let expectedBaseElevation: CGFloat = 99
    let textField = MDCTextField()

    // When
    textField.mdc_overrideBaseElevation = expectedBaseElevation

    // Then
    XCTAssertEqual(textField.mdc_overrideBaseElevation, expectedBaseElevation, accuracy: 0.001)
  }
}
