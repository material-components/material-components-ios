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

class M3CTextViewTests: XCTestCase {
  let testColorValues: [UIControl.State: UIColor] = [
    .normal: .black, .error: .red, .selected: .blue,
  ]

  var sutTextView: M3CTextView!
  var sutTextContainer: UITextView!

  override func setUp() {
    super.setUp()
    sutTextView = M3CTextView()
    sutTextContainer = sutTextView.textContainer
  }

  override func tearDown() {
    sutTextView = nil
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

    sutTextView.isInErrorState = true

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

    sutTextView.isInErrorState = false
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
    sutTextView.isInErrorState = true
    let errorColor = expectedColor(for: .error)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: errorColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextView.isInErrorState = false

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
    sutTextView.isInErrorState = true
    let errorColor = expectedColor(for: .error)
    sutTextContainer.resignFirstResponder()
    assertSUTExpectations(for: errorColor)
    XCTAssertFalse(sutTextContainer.isFirstResponder)

    sutTextView.isInErrorState = false
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
    let sutTextContainer = sutTextView.textContainer
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

    sutTextView.isInErrorState = true

    let errorColor = expectedColor(for: .error)
    assertSUTExpectations(for: errorColor)
    XCTAssertTrue(sutTextContainer.isFirstResponder)
  }

  /// Tests that a new background color for a specific state is applied to the underlying
  /// UITextView when calling `setBackgroundColor`.
  func testSetBackgroundColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextContainer.backgroundColor, defaultColor)

    sutTextView.setBackgroundColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextContainer.backgroundColor, customColor)
  }

  /// Tests that a new border color for a specific state is applied to the underlying
  /// UITextView when calling `setBorderColor`.
  func testSetBorderColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextContainer.layer.borderColor, defaultColor.cgColor)

    sutTextView.setBorderColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextContainer.layer.borderColor, customColor.cgColor)
  }

  /// Tests that a new input color for a specific state is applied to the underlying
  /// UITextView when calling `setInputColor`.
  func testSetInputColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextContainer.textColor, defaultColor)

    sutTextView.setInputColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextContainer.textColor, customColor)
  }

  /// Tests that a new supporting label color for a specific state is applied to the underlying
  /// UILabel when calling `setSupportingLabelColor`.
  func testSetSupportingLabelColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextView.supportingLabel.textColor, defaultColor)

    sutTextView.setSupportingLabelColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextView.supportingLabel.textColor, customColor)
  }

  /// Tests that a new tint color for a specific state is applied to the underlying
  /// UITextView when calling `setTintColor`.
  func testSetTintColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextContainer.tintColor, defaultColor)

    sutTextView.setTintColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextContainer.tintColor, customColor)
  }

  /// Tests that a new title label color for a specific state is applied to the underlying
  /// UILabel when calling `setTitleLabelColor`.
  func testSetTitleLabelColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextView.titleLabel.textColor, defaultColor)

    sutTextView.setTitleLabelColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextView.titleLabel.textColor, customColor)
  }

  /// Tests that a new trailing label color for a specific state is applied to the underlying
  /// UILabel when calling `setTrailingLabelColor`.
  func testSetTrailingLabelColorAppliesNewColor() {
    applyInitialColorTestingConfiguration(for: .normal)
    let defaultColor = expectedColor(for: .normal)
    let customColor = UIColor.green
    XCTAssertEqual(sutTextView.trailingLabel.textColor, defaultColor)

    sutTextView.setTrailingLabelColor(customColor, for: UIControl.State.normal)

    XCTAssertEqual(sutTextView.trailingLabel.textColor, customColor)
  }
}

// MARK: - Test Assertion Helpers

extension M3CTextViewTests {
  private func assertSUTExpectations(
    for color: UIColor, file: StaticString = #file, line: UInt = #line
  ) {
    XCTAssertEqual(sutTextContainer.backgroundColor, color, file: file, line: line)
    XCTAssertEqual(sutTextContainer.layer.borderColor, color.cgColor, file: file, line: line)
    XCTAssertEqual(sutTextContainer.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextContainer.tintColor, color, file: file, line: line)
    XCTAssertEqual(sutTextView.supportingLabel.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextView.titleLabel.textColor, color, file: file, line: line)
    XCTAssertEqual(sutTextView.trailingLabel.textColor, color, file: file, line: line)
  }
}

// MARK: - Test Configuration Helpers

extension M3CTextViewTests {
  private func applyInitialColorTestingConfiguration(for controlState: UIControl.State) {
    // `becomeFirstResponder` and `resignFirstResponder` require a window.
    let window = UIWindow()
    window.addSubview(sutTextView)

    sutTextView.text = "test"
    configureColorDictionaries()
    configureTextContentColors(for: controlState)
  }

  private func configureColorDictionaries() {
    sutTextView.backgroundColors = testColorValues
    sutTextView.borderColors = testColorValues
    sutTextView.inputColors = testColorValues
    sutTextView.supportingLabelColors = testColorValues
    sutTextView.titleLabelColors = testColorValues
    sutTextView.trailingLabelColors = testColorValues
    sutTextView.tintColors = testColorValues
  }

  private func configureTextContentColors(for controlState: UIControl.State) {
    let color = expectedColor(for: controlState)
    sutTextContainer.backgroundColor = color
    sutTextContainer.layer.borderColor = color.cgColor
    sutTextContainer.textColor = color
    sutTextContainer.tintColor = color
    sutTextView.supportingLabel.textColor = color
    sutTextView.titleLabel.textColor = color
    sutTextView.trailingLabel.textColor = color
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
