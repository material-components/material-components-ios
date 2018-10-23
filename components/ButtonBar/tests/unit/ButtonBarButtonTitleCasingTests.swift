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

class ButtonBarButtonTitleCasingTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testDefaultCasingIsUppercase() {
    // Then
    XCTAssertTrue(buttonBar.uppercasesButtonTitles)
  }

  func testButtonTitlesAreUppercasedByDefault() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]

    // When
    buttonBar.items = items

    // Then
    XCTAssertTrue(buttonBar.uppercasesButtonTitles)
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "TEXT")
      }
    }
  }

  func testButtonTitlesAreNotUppercasedWhenFlagIsDisabledBeforeAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]

    // When
    buttonBar.uppercasesButtonTitles = false
    buttonBar.items = items

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }

  func testButtonTitlesAreNotUppercasedWhenFlagIsDisabledAfterAssignment() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    // When
    buttonBar.uppercasesButtonTitles = false

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.title(for: .normal), "Text")
      }
    }
  }
}
