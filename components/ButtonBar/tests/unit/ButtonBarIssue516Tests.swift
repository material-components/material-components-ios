/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
import MaterialComponents

// Tests confirming that the Button Bar lays its buttons according to the layout position:
//
// - From leading to trailing with MDCButtonBarLayoutPositionLeading.
// - From trailing to leading with MDCButtonBarLayoutPositionTrailing.
//
// Based on issue https://github.com/google/material-components-ios/issues/516
class ButtonBarIssue516Tests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testLayoutPositionDefault() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .Plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .Plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons.sortInPlace { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).titleForState(.Normal), "LEFT")
    XCTAssertEqual((buttons[1] as! MDCButton).titleForState(.Normal), "RIGHT")
  }

  func testLayoutPositionLeading() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .Plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .Plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .Leading
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons.sortInPlace { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).titleForState(.Normal), "LEFT")
    XCTAssertEqual((buttons[1] as! MDCButton).titleForState(.Normal), "RIGHT")
  }

  func testLayoutPositionTrailing() {
    let items = [
      UIBarButtonItem(title: "LEFT", style: .Plain, target: nil, action: nil),
      UIBarButtonItem(title: "RIGHT", style: .Plain, target: nil, action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .Trailing
    buttonBar.layoutSubviews()

    var buttons = buttonBar.subviews.filter { $0 is MDCButton }
    buttons.sortInPlace { (button1, button2) -> Bool in
      return button1.frame.origin.x < button2.frame.origin.x
    }
    XCTAssertEqual((buttons[0] as! MDCButton).titleForState(.Normal), "RIGHT")
    XCTAssertEqual((buttons[1] as! MDCButton).titleForState(.Normal), "LEFT")
  }
}
