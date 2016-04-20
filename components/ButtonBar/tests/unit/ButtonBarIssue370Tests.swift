/*
Copyright 2016-present Google Inc. All Rights Reserved.

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
// Based on issue https://github.com/google/material-components-ios/issues/370
class ButtonBarIssue370Tests: XCTestCase {

  var buttonBar: MDCButtonBar!
  let globalAttributes = [NSForegroundColorAttributeName:UIColor.blueColor()]
  let directAttributes = [NSForegroundColorAttributeName:UIColor.blueColor()]
  let fontAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(12)]

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  override func tearDown() {
    UIBarButtonItem.appearance().setTitleTextAttributes(nil, forState: .Normal)
  }

  func testDirectOnly() {
    let item = UIBarButtonItem(title: "Text", style: .Plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, forState: .Normal)
    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributesAtIndex(0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqualToDictionary(attributes!))
    }
  }

  func testGlobalAppearanceOnly() {
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, forState: .Normal)

    if UIBarButtonItem.appearance().titleTextAttributesForState(.Normal) == nil {
      // This feature is not supported on this OS
      return
    }

    let item = UIBarButtonItem(title: "Text", style: .Plain, target: nil, action: nil)
    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributesAtIndex(0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.globalAttributes).isEqualToDictionary(attributes!))
    }
  }

  func testGlobalAppearanceAndDirectOverwriting() {
    UIBarButtonItem.appearance().setTitleTextAttributes(globalAttributes, forState: .Normal)

    let item = UIBarButtonItem(title: "Text", style: .Plain, target: nil, action: nil)

    // Should take priority.
    item.setTitleTextAttributes(directAttributes, forState: .Normal)

    buttonBar.items = [item]

    forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributesAtIndex(0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: self.directAttributes).isEqualToDictionary(attributes!))
    }
  }

  func testGlobalAppearanceAndDirectMerging() {
    UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, forState: .Normal)

    if UIBarButtonItem.appearance().titleTextAttributesForState(.Normal) == nil {
      // This feature is not supported on this OS
      return
    }

    let item = UIBarButtonItem(title: "Text", style: .Plain, target: nil, action: nil)
    item.setTitleTextAttributes(directAttributes, forState: .Normal)
    buttonBar.items = [item]

    var composite: [String: AnyObject] = fontAttributes
    for (key, value) in directAttributes {
      composite[key] = value
    }

    self.forEachButton { button in
      let attributes = button.titleLabel?.attributedText?.attributesAtIndex(0, effectiveRange: nil)
      XCTAssertTrue(NSDictionary(dictionary: composite).isEqualToDictionary(attributes!))
    }
  }

  func forEachButton(work: MDCButton -> Void) {
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        work(button)
      }
    }
  }
}
