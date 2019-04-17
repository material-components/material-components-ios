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

// Tests confirming that the Button Bar respects UI appearance for bar button item
// titleTextAttributes on iOS 9 and above.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/370
class ButtonBarIssue370Tests: XCTestCase {

  var buttonBar: MDCButtonBar!
  let globalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
  let directAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
  let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  override func tearDown() {
    UIBarButtonItem.appearance().setTitleTextAttributes(nil, for: UIControl.State())
  }

  func testDirectOnly() {
    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, for: UIControl.State())
    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqual(to: attributes!))
    }
  }

  func testGlobalAppearanceOnly() {
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, for: UIControl.State())

    if UIBarButtonItem.appearance().titleTextAttributes(for: UIControl.State()) == nil {
      // This feature is not supported on this OS
      return
    }

    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.globalAttributes).isEqual(to: attributes!))
    }
  }

  func testGlobalAppearanceAndDirectOverwriting() {
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, for: UIControl.State())

    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)

    // Should take priority.
    item.setTitleTextAttributes(directAttributes, for: UIControl.State())

    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqual(to: attributes!))
    }
  }

  func testGlobalAppearanceAndDirectMerging() {
    UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, for: UIControl.State())

    if UIBarButtonItem.appearance().titleTextAttributes(for: UIControl.State()) == nil {
      // This feature is not supported on this OS
      return
    }

    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, for: UIControl.State())
    buttonBar.items = [item]

    var composite: [NSAttributedString.Key: Any] = fontAttributes
    for (key, value) in directAttributes {
      composite[key] = value
    }

    self.forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: composite).isEqual(to: attributes!))
    }
  }

  func forEachButton(_ work: (MDCButton) -> Void) {
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        work(button)
      }
    }
  }
}
