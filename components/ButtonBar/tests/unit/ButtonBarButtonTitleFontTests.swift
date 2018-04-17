/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

import XCTest
import MaterialComponents.MaterialButtonBar
import MaterialComponents.MaterialButtons

class ButtonBarButtonTitleFontTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testDefaultFontBehavior() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertNil(button.titleFont(for: .normal))
      }
    }
  }

  func testCustomFontIsSetForNewButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.setButtonTitleFont(font, for: .normal)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
      }
    }
  }

  func testCustomFontIsSetForExistingButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.items = items
    buttonBar.setButtonTitleFont(font, for: .normal)

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
      }
    }
  }

  func testCustomFontFallbackBehavior() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.setButtonTitleFont(font, for: .selected)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        let defaultFont = button.titleLabel?.font

        button.isSelected = true

        XCTAssertEqual(button.titleLabel?.font, font)

        button.isSelected = false

        XCTAssertEqual(button.titleLabel?.font, defaultFont)
      }
    }
  }

}
