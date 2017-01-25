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

// Tests confirming that the Button Bar respects UI appearance for bar button item
// titleTextAttributes on iOS 9 and above.
//
// Based on issue https://github.com/material-components/material-components-ios/issues/370
class ButtonBarIssue370Tests: XCTestCase {

  var buttonBar: MDCButtonBar!
  let globalAttributes = [NSForegroundColorAttributeName: UIColor.blue]
  let directAttributes = [NSForegroundColorAttributeName: UIColor.blue]
  let fontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  override func tearDown() {
    UIBarButtonItem.appearance().setTitleTextAttributes(nil, for: UIControlState())
  }

  func testDirectOnly() {
    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, for: UIControlState())
    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqual(to: attributes!))
    }
  }

  func testGlobalAppearanceOnly() {
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, for: UIControlState())

    if UIBarButtonItem.appearance().titleTextAttributes(for: UIControlState()) == nil {
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
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, for: UIControlState())

    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)

    // Should take priority.
    item.setTitleTextAttributes(directAttributes, for: UIControlState())

    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributes(at: 0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqual(to: attributes!))
    }
  }

  func testGlobalAppearanceAndDirectMerging() {
    UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, for: UIControlState())

    if UIBarButtonItem.appearance().titleTextAttributes(for: UIControlState()) == nil {
      // This feature is not supported on this OS
      return
    }

    let item = UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, for: UIControlState())
    buttonBar.items = [item]

    var composite: [String: Any] = fontAttributes
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
