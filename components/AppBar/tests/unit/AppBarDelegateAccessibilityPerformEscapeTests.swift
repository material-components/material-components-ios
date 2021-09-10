// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialAppBar

private class FakeDelegate: NSObject, MDCAppBarViewControllerAccessibilityPerformEscapeDelegate {
  var accessibilityPerformEscapeResult = false
  var didInvokeAppBarViewControllerAccessibilityPerformEscape = false

  func appBarViewControllerAccessibilityPerformEscape(
    _ appBarViewController: MDCAppBarViewController
  ) -> Bool {
    didInvokeAppBarViewControllerAccessibilityPerformEscape = true
    return accessibilityPerformEscapeResult
  }
}

class AppBarDelegateAccessibilityPerformEscapeTests: XCTestCase {

  var appBarViewController: MDCAppBarViewController!

  override func setUp() {
    super.setUp()

    appBarViewController = MDCAppBarViewController()
  }

  override func tearDown() {
    appBarViewController = nil

    super.tearDown()
  }

  func testDefaults() {
    XCTAssertNil(appBarViewController.accessibilityPerformEscapeDelegate)
  }

  func testInvokesDelegateAndReturnsTrueValue() {
    // Given
    let delegate = FakeDelegate()
    delegate.accessibilityPerformEscapeResult = true
    appBarViewController.accessibilityPerformEscapeDelegate = delegate

    // When
    let result = appBarViewController.accessibilityPerformEscape()

    // Then
    XCTAssertTrue(delegate.didInvokeAppBarViewControllerAccessibilityPerformEscape)
    XCTAssertTrue(result)
  }

  func testInvokesDelegateAndReturnsFalseValue() {
    // Given
    let delegate = FakeDelegate()
    delegate.accessibilityPerformEscapeResult = false
    appBarViewController.accessibilityPerformEscapeDelegate = delegate

    // When
    let result = appBarViewController.accessibilityPerformEscape()

    // Then
    XCTAssertTrue(delegate.didInvokeAppBarViewControllerAccessibilityPerformEscape)
    XCTAssertFalse(result)
  }
}
