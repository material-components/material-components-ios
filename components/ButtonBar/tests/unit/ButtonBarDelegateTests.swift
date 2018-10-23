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

private class ButtonBarDelegate: NSObject, MDCButtonBarDelegate {
  var didInvalidateIntrinsicContentSize = false
  func buttonBarDidInvalidateIntrinsicContentSize(_ buttonBar: MDCButtonBar) {
    didInvalidateIntrinsicContentSize = true
  }
}

class ButtonBarDelegateTests: XCTestCase {
  private var buttonBar: MDCButtonBar!
  private var delegate: ButtonBarDelegate!

  override func setUp() {
    super.setUp()

    buttonBar = MDCButtonBar()
    delegate = ButtonBarDelegate()
    buttonBar.delegate = delegate
  }

  func testDelegateNotInvokedDuringInitialization() {
    // Given setUp conditions

    // Then
    XCTAssertFalse(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateNotInvokedAfterItemsSetToEqualArrayOfItems() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    buttonBar.items = [item]

    // Then
    XCTAssertFalse(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateInvokedAfterItemsSet() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)

    // When
    buttonBar.items = [item]

    // Then
    XCTAssertTrue(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateInvokedAfterItemsChange() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    buttonBar.items = [UIBarButtonItem(title: "RIGHT", style: .plain, target: nil, action: nil)]

    // Then
    XCTAssertTrue(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateInvokedAfterTitleChanges() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    item.title = "New title"

    // Then
    XCTAssertTrue(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateInvokedAfterImageChanges() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    item.image = createImage(colored: .blue)

    // Then
    XCTAssertTrue(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateInvokedAfterTitleFontChanges() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    buttonBar.setButtonsTitleFont(UIFont.systemFont(ofSize: 12), for: .normal)

    // Then
    XCTAssertTrue(delegate.didInvalidateIntrinsicContentSize)
  }

  func testDelegateNotInvokedAfterTitleBaselineChanges() {
    // Given
    let item = UIBarButtonItem(title: "LEFT", style: .plain, target: nil, action: nil)
    buttonBar.items = [item]
    buttonBar.buttonTitleBaseline = 0
    // Forcefully clear the flag
    delegate.didInvalidateIntrinsicContentSize = false

    // When
    buttonBar.buttonTitleBaseline = 5

    // Then
    XCTAssertFalse(delegate.didInvalidateIntrinsicContentSize)
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
}
