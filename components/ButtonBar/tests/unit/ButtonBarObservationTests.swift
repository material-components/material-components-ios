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

class ButtonBarObservationTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    buttonBar = MDCButtonBar()
  }

  // Create a solid color image for testing purposes.
  private func createImage(colored color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 64, height: 64), true, 1)
    color.setFill()
    UIRectFill(CGRect(x: 0, y: 0, width: 64, height: 64))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }

  // MARK: Initial state

  func testInitialTextButtonStateMatchesItemState() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)

    // When
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // Then
    let titles = buttonBar.subviews.flatMap { $0 as? MDCButton }.flatMap { $0.title(for: .normal) }
    XCTAssertEqual(titles, [item.title!])
  }

  func testInitialImageButtonStateMatchesItemState() {
    // Given
    let image1 = createImage(colored: .red)
    let item = UIBarButtonItem(image: image1, style: .plain, target: nil, action: nil)

    // When
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // Then
    let images =
        buttonBar.subviews.flatMap { $0 as? MDCButton }.flatMap { $0.image(for: .normal) }
    XCTAssertEqual(images, [item.image!])
  }

  func testInitialGeneralStateMatchesItemState() {
    // Given
    let item = UIBarButtonItem(title: "Title", style: .plain, target: nil, action: nil)

    // When
    item.isEnabled = true
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // Then
    let enabled = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.isEnabled }
    XCTAssertEqual(enabled, [item.isEnabled])
  }

  // MARK: KVO observation

  func testEnabledChangesAreObserved() {
    // Given
    let item = UIBarButtonItem(title: "Title", style: .plain, target: nil, action: nil)
    item.isEnabled = true
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // When
    item.isEnabled = false

    // Then
    let enabled = buttonBar.subviews.flatMap { $0 as? MDCButton }.map { $0.isEnabled }
    XCTAssertEqual(enabled, [item.isEnabled])
  }

  func testImageChangesAreObserved() {
    // Given
    let image1 = createImage(colored: .red)
    let item = UIBarButtonItem(image: image1, style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // When
    item.image = createImage(colored: .blue)

    // Then
    let images =
      buttonBar.subviews.flatMap { $0 as? MDCButton }.flatMap { $0.image(for: .normal) }
    XCTAssertEqual(images, [item.image!])
  }

  func testTitleChangesAreObserved() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    buttonBar.layoutSubviews()

    // When
    item.title = "NEW TITLE"

    // Then
    let titles = buttonBar.subviews.flatMap { $0 as? MDCButton }.flatMap { $0.title(for: .normal) }
    XCTAssertEqual(titles, [item.title!])
  }

}
