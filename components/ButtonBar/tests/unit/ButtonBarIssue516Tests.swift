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

// Tests confirming that the Button Bar lays its buttons according to the layout position:
//
// - From leading to trailing with MDCButtonBarLayoutPositionLeading.
// - From trailing to leading with MDCButtonBarLayoutPositionTrailing.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/516
class ButtonBarIssue516Tests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testLayoutPositionDefault() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons = buttons.sorted { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).title(for: UIControl.State()), "LEFT")
    XCTAssertEqual((buttons[1] as! MDCButton).title(for: UIControl.State()), "RIGHT")
  }

  func testLayoutPositionLeading() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .leading
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons = buttons.sorted { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).title(for: UIControl.State()), "LEFT")
    XCTAssertEqual((buttons[1] as! MDCButton).title(for: UIControl.State()), "RIGHT")
  }

  func testLayoutPositionTrailing() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .trailing
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons = buttons.sorted { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).title(for: UIControl.State()), "RIGHT")
    XCTAssertEqual((buttons[1] as! MDCButton).title(for: UIControl.State()), "LEFT")
  }
}
