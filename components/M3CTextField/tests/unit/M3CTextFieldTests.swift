// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

@testable import MaterialComponents.MaterialM3CTextField

class M3CTextFieldTests: XCTestCase {
  let testColorValues: [UIControl.State: UIColor] = [
    .normal: .black, .error: .red, .selected: .blue,
  ]

  var sutTextField: M3CTextField!
  var sutTextContainer: UITextField!

  override func setUp() {
    super.setUp()
    sutTextField = M3CTextField()
    sutTextContainer = sutTextField.textContainer
  }

  override func tearDown() {
    sutTextField = nil
    super.tearDown()
  }

  /// Tests that the expected colors are applied for the .normal to .error case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - !isFirstResponder unchanged.
  func testApplyColorsFromNormalToErrorState() {
    applyInitialColorTestingConfiguration(for: .normal)
    let normalColor = expectedColor(for: .normal)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: normalColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextField.isInErrorState = true

    let errorColor = expectedColor(for: .error)
    assertSUTExpectations(for: errorColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)
  }

  /// Tests that the expected colors are applied for the .normal to .selected case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - !isFirstResponder toggled to isFirstResponder.
  func testApplyColorsFromNormalToSelectedState() {
    applyInitialColorTestingConfiguration(for: .normal)
    let normalColor = expectedColor(for: .normal)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: normalColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextField.isInErrorState = false
    sutTextContainer.becomeFirstResponder()

    let selectedColor = expectedColor(for: .selected)
    assertSUTExpectations(for: selectedColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)
  }

  /// Tests that the expected colors are applied for the .error to .normal case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - !isFirstResponder unchanged.
  func testApplyColorsFromErrorToNormalState() {
    applyInitialColorTestingConfiguration(for: .error)
    sutTextField.isInErrorState = true
    let errorColor = expectedColor(for: .error)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: errorColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextField.isInErrorState = false

    let normalColor = expectedColor(for: .normal)
    assertSUTExpectations(for: normalColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)
  }

  /// Tests that the expected colors are applied for the .error to .selected case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - !isFirstResponder toggled to isFirstResponder.
  func testApplyColorsFromErrorToSelectedState() {
    applyInitialColorTestingConfiguration(for: .error)
    sutTextField.isInErrorState = true
    let errorColor = expectedColor(for: .error)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: errorColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextField.isInErrorState = false
    sutTextContainer.becomeFirstResponder()

    let selectedColor = expectedColor(for: .selected)
    assertSUTExpectations(for: selectedColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)
  }

  /// Tests that the expected colors are applied for the .selected to .normal case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - isFirstResponder toggled to !isFirstResponder.
  func testApplyColorsFromSelectedToNormalState() {
    applyInitialColorTestingConfiguration(for: .selected)
    let selectedColor = expectedColor(for: .selected)
    let sutTextContainer = sutTextField.textContainer
    sutTextContainer.becomeFirstResponder()
    assertSUTExpectations(for: selectedColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)

    sutTextContainer.resignFirstResponder()

    let normalColor = expectedColor(for: .normal)
    assertSUTExpectations(for: normalColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)
  }

  /// Tests that the expected colors are applied for the .selected to .error case.
  /// This includes verifying:
  ///     - Expected colors for background, border, labels, input text, and tint.
  ///     - isFirstResponder unchanged.
  func testApplyColorsFromSelectedToErrorState() {
    applyInitialColorTestingConfiguration(for: .selected)
    let selectedColor = expectedColor(for: .selected)
    sutTextContainer.becomeFirstResponder()
    assertSUTExpectations(for: selectedColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)

    sutTextField.isInErrorState = true

    let errorColor = expectedColor(for: .error)
    assertSUTExpectations(for: errorColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)
  }
}

// MARK: - Test Assertion Helpers

extension M3CTextFieldTests {
  private func assertSUTExpectations(
    for color: UIColor, file: StaticString = #file, line: UInt = #line
  ) {
    XCTAssertEqual(sutTextContainer.backgroundColor, color, file: file, line: line)
    XCTAssertEqual(sutTextContainer.layer.borderColor, color.cgColor, file: file, line: line)
    XCTAssertEqual(sutTextContainer.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextContainer.tintColor, color, file: file, line: line)
    XCTAssertEqual(sutTextField.supportingLabel.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextField.titleLabel.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextField.trailingLabel.textColor, color, file: file, line: line)
  }
}

// MARK: - Test Configuration Helpers

extension M3CTextFieldTests {
  private func applyInitialColorTestingConfiguration(for controlState: UIControl.State) {
    // `becomeFirstResponder` and `resignFirstResponder` require a window.
    let window = UIWindow()
    window.addSubview(sutTextField)

    sutTextField.text = "test"
    configureColorDictionaries()
    configureTextContentColors(for: controlState)
  }

  private func configureColorDictionaries() {
    sutTextField.backgroundColors = testColorValues
    sutTextField.borderColors = testColorValues
    sutTextField.inputColors = testColorValues
    sutTextField.supportingLabelColors = testColorValues
    sutTextField.titleLabelColors = testColorValues
    sutTextField.trailingLabelColors = testColorValues
    sutTextField.tintColors = testColorValues
  }

  private func configureTextContentColors(for controlState: UIControl.State) {
    let color = expectedColor(for: controlState)
    sutTextContainer.backgroundColor = color
    sutTextContainer.layer.borderColor = color.cgColor
    sutTextContainer.textColor = color
    sutTextContainer.tintColor = color
    sutTextField.supportingLabel.textColor = color
    sutTextField.titleLabel.textColor = color
    sutTextField.trailingLabel.textColor = color
  }

  private func expectedColor(for controlState: UIControl.State) -> UIColor {
    switch controlState {
    case .normal:
      .black
    case .error:
      .red
    case .selected:
      .blue
    default:
      .black
    }
  }
}
