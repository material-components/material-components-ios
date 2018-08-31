// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

// Tests confirming that the Button Bar button ink configuration is:
//
// - Bounded for buttons with text.
// - Unbounded for icon-only buttons.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/328
class ButtonBarIssue328Tests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testTextButtons() {
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertTrue(button.inkStyle == .bounded)
      }
    }
  }

  func testIconButtons() {
    let items = [UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertTrue(button.inkStyle == .unbounded)
      }
    }
  }

  func testTextIconButtons() {
    let item = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
    item.title = "Text"
    let items = [item]
    buttonBar.items = items

    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertTrue(button.inkStyle == .bounded)
      }
    }
  }
}
