// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialNavigationBar

class NavigationBarButtonTitleCasingTests: XCTestCase {

  var navigationBar: MDCNavigationBar!

  override func setUp() {
    super.setUp()

    navigationBar = MDCNavigationBar()
  }

  override func tearDown() {
    navigationBar = nil

    super.tearDown()
  }

  private func recursiveSubviews(of superview: UIView) -> [UIView] {
    var subviews = superview.subviews
    for subview in superview.subviews {
      subviews.append(contentsOf: recursiveSubviews(of: subview))
    }
    return subviews
  }

  func testDefaultCasingIsUppercase() {
    // Then
    XCTAssertTrue(navigationBar.uppercasesButtonTitles)
  }

  func testLeadingButtonTitlesAreUppercasedByDefault() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]

    // When
    navigationBar.leadingBarButtonItems = items

    // Then
    XCTAssertTrue(navigationBar.uppercasesButtonTitles)
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "TEXT")
      }
    }
  }

  func testLeadingButtonTitlesAreNotUppercasedWhenFlagIsDisabledBeforeAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]

    // When
    navigationBar.uppercasesButtonTitles = false
    navigationBar.leadingBarButtonItems = items

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }

  func testLeadingButtonTitlesAreNotUppercasedWhenFlagIsDisabledAfterAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.leadingBarButtonItems = items

    // When
    navigationBar.uppercasesButtonTitles = false

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }

  func testTrailingButtonTitlesAreUppercasedByDefault() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.trailingBarButtonItems = items

    // Then
    XCTAssertTrue(navigationBar.uppercasesButtonTitles)
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "TEXT")
      }
    }
  }

  func testTrailingButtonTitlesAreNotUppercasedWhenFlagIsDisabledBeforeAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]

    // When
    navigationBar.uppercasesButtonTitles = false
    navigationBar.trailingBarButtonItems = items

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }

  func testTrailingButtonTitlesAreNotUppercasedWhenFlagIsDisabledAfterAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.trailingBarButtonItems = items

    // When
    navigationBar.uppercasesButtonTitles = false

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }
}
