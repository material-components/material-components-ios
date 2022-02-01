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
import MaterialComponents.MaterialTypography

class NavigationBarButtonTitleFontTests: XCTestCase {

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

  func testDefaultFontBehavior() {
    // Given
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        let font = button.titleFont(for: .normal)
        XCTAssertTrue(font.mdc_isSimplyEqual(MDCTypography.buttonFont()))
      }
    }
  }

  func testCustomFontIsSetForNewButtons() {
    // Given
    let font = UIFont.systemFont(ofSize: 100)

    // When
    navigationBar.setButtonsTitleFont(font, for: .normal)
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
        XCTAssertEqual(button.titleLabel?.font, font)
      }
    }
  }

  func testCustomFontIsSetForExistingButtons() {
    // Given
    let font = UIFont.systemFont(ofSize: 100)

    // When
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]
    navigationBar.setButtonsTitleFont(font, for: .normal)

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
        XCTAssertEqual(button.titleLabel?.font, font)
      }
    }
  }

  func testCustomFontFallbackBehavior() {
    // Given
    let normalFont = UIFont.systemFont(ofSize: 100)
    let selectedFont = UIFont.systemFont(ofSize: 50)

    // When
    navigationBar.setButtonsTitleFont(normalFont, for: .normal)
    navigationBar.setButtonsTitleFont(selectedFont, for: .selected)
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        button.isSelected = true

        XCTAssertEqual(button.titleLabel?.font, selectedFont)

        button.isSelected = false

        XCTAssertEqual(button.titleLabel?.font, normalFont)
      }
    }
  }
}
