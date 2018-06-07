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
import MaterialComponents.MaterialButtonBar
import MaterialComponents.MaterialButtons

class ButtonBarObservationTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  func testTitleChangesAreObserved() {
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    do {
      let titles = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.title(for: .normal) }
      XCTAssertEqual(titles, [item.title])
    }

    // Change the value post-assignment
    item.title = "NEW TITLE"

    do {
      let titles = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.title(for: .normal) }
      XCTAssertEqual(titles, [item.title])
    }
  }

  func testImageChangesAreObserved() {
    let image1 = createImage(colored: .red)

    let item = UIBarButtonItem(image: image1, style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    do {
      let images = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.image(for: .normal) }
      XCTAssertEqual(images, [item.image])
    }

    // Change the value post-assignment
    item.image = createImage(colored: .blue)

    do {
      let images = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.image(for: .normal) }
      XCTAssertEqual(images, [item.image])
    }
  }

  func testEnabledChangesAreObserved() {
    let item = UIBarButtonItem(title: "Title", style: .plain, target: nil, action: nil)
    item.isEnabled = true
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    do {
      let enabled = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.isEnabled }
      XCTAssertEqual(enabled, [item.isEnabled])
    }

    // Change the value post-assignment
    item.isEnabled = false

    do {
      let enabled = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.isEnabled }
      XCTAssertEqual(enabled, [item.isEnabled])
    }
  }

  private func createImage(colored color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 64, height: 64), true, 1)
    color.setFill()
    UIRectFill(CGRect(x: 0, y: 0, width: 64, height: 64))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
