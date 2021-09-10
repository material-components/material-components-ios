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

class NavigationBarButtonLayoutTests: XCTestCase {

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

  func testInitialLayoutMatchesSizeThatFitsWidth() {
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
        let width = button.sizeThatFits(
          CGSize(
            width: CGFloat.infinity,
            height: CGFloat.infinity)
        ).width
        XCTAssertEqual(width, button.bounds.width)
      }
    }
  }

  func testChangingTitleUpdatesLayoutToMatchSizeThatFitsWidth() {
    // Given
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]

    // When
    navigationBar.leadingBarButtonItems?.forEach {
      $0.title = "Longer title"
    }
    navigationBar.trailingBarButtonItems?.forEach {
      $0.title = "Longer title"
    }
    navigationBar.layoutIfNeeded()

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        let width = button.sizeThatFits(
          CGSize(
            width: CGFloat.infinity,
            height: CGFloat.infinity)
        ).width
        XCTAssertEqual(width, button.bounds.width)
      }
    }
  }

  func testChangingTitleFontUpdatesLayoutToMatchSizeThatFitsWidth() {
    // Given
    navigationBar.leadingBarButtonItems = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    ]
    navigationBar.trailingBarButtonItems = [
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil)
    ]

    // When
    navigationBar.setButtonsTitleFont(UIFont.systemFont(ofSize: 20), for: .normal)
    navigationBar.layoutIfNeeded()

    // Then
    for view in recursiveSubviews(of: navigationBar) {
      if let button = view as? MDCButton {
        let width = button.sizeThatFits(
          CGSize(
            width: CGFloat.infinity,
            height: CGFloat.infinity)
        ).width
        XCTAssertEqual(width, button.bounds.width)
      }
    }
  }
}
