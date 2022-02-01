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
import MaterialComponents.MaterialTypography

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
        let font = button.titleFont(for: .normal)
        XCTAssertTrue(font.mdc_isSimplyEqual(MDCTypography.buttonFont()))
      }
    }
  }

  func testCustomFontIsSetForNewButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.setButtonsTitleFont(font, for: .normal)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
        XCTAssertEqual(button.titleLabel?.font, font)
      }
    }
  }

  func testCustomFontIsSetForExistingButtons() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.items = items
    buttonBar.setButtonsTitleFont(font, for: .normal)

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), font)
        XCTAssertEqual(button.titleLabel?.font, font)
      }
    }
  }

  func testCustomFontChangesButtonFrames() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.items = items
    let initialFrames = buttonBar.subviews.map { $0.frame }
    buttonBar.setButtonsTitleFont(font, for: .normal)
    let updatedFrames = buttonBar.subviews.map { $0.frame }

    XCTAssertNotEqual(initialFrames, updatedFrames)
  }

  func testCustomFontDoesNotChangeFixedWidthButtonFrames() {
    // Given
    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    item.width = 100
    let items = [item]
    let font = UIFont.systemFont(ofSize: 100)

    // When
    buttonBar.items = items
    let initialFrames = buttonBar.subviews.map { $0.frame }
    buttonBar.setButtonsTitleFont(font, for: .normal)
    let updatedFrames = buttonBar.subviews.map { $0.frame }

    XCTAssertEqual(initialFrames, updatedFrames)
  }

  func testCustomFontFallbackBehavior() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    let normalFont = UIFont.systemFont(ofSize: 100)
    let selectedFont = UIFont.systemFont(ofSize: 50)

    // When
    buttonBar.setButtonsTitleFont(normalFont, for: .normal)
    buttonBar.setButtonsTitleFont(selectedFont, for: .selected)
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        button.isSelected = true

        XCTAssertEqual(button.titleLabel?.font, selectedFont)

        button.isSelected = false

        XCTAssertEqual(button.titleLabel?.font, normalFont)
      }
    }
  }

}
