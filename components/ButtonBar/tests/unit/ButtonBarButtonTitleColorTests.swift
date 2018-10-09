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
import MaterialComponents.MaterialButtonBar
import MaterialComponents.MaterialButtons

class ButtonBarButtonTitleColorTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testDefaultColorBehavior() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleColor(for: .normal), .white)
      }
    }
  }

  func testCustomColorIsSetForNewButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let color = UIColor.red

    // When
    buttonBar.setButtonsTitleColor(color, for: .normal)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleColor(for: .normal), color)
        XCTAssertEqual(button.titleLabel?.textColor, color)
      }
    }
  }

  func testCustomColorIsSetForExistingButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let color = UIColor.red

    // When
    buttonBar.items = items
    buttonBar.setButtonsTitleColor(color, for: .normal)

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleColor(for: .normal), color)
        XCTAssertEqual(button.titleLabel?.textColor, color)
      }
    }
  }

  func testCustomColorFallbackBehavior() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let normalColor = UIColor.red
    let selectedColor = UIColor.blue

    // When
    buttonBar.setButtonsTitleColor(normalColor, for: .normal)
    buttonBar.setButtonsTitleColor(selectedColor, for: .selected)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        button.isSelected = true

        XCTAssertEqual(button.titleColor(for: .normal), normalColor)
        XCTAssertEqual(button.titleColor(for: .selected), selectedColor)

        XCTAssertEqual(button.titleLabel?.textColor, selectedColor)

        button.isSelected = false

        XCTAssertEqual(button.titleColor(for: .normal), normalColor)
        XCTAssertEqual(button.titleColor(for: .selected), selectedColor)

        XCTAssertEqual(button.titleLabel?.textColor, normalColor)
      }
    }
  }

}
