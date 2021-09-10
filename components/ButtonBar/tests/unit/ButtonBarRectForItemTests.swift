// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

// Tests for Button Bar's rectForItemAtIndex:inCoordinateSpace: API.
class ButtonBarRectForItemTests: XCTestCase {

  var buttonBar: MDCButtonBar!

  override func setUp() {
    super.setUp()

    buttonBar = MDCButtonBar()
    buttonBar.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
  }

  override func tearDown() {
    buttonBar = nil

    super.tearDown()
  }

  func testShortTextButtonMatchesExpectedSize() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items
    buttonBar.layoutIfNeeded()

    // When
    let rect = buttonBar.rect(for: items[0], in: buttonBar)

    // Then
    XCTAssertEqual(rect.size, CGSize(width: 60, height: 100))
  }

  func testLongTextButtonMatchesExpectedSize() {
    // Given
    let items = [
      UIBarButtonItem(
        title: "Text that is relatively long",
        style: .plain,
        target: nil,
        action: nil)
    ]
    buttonBar.items = items
    buttonBar.layoutIfNeeded()

    // When
    let rect = buttonBar.rect(for: items[0], in: buttonBar)

    // Then
    XCTAssertEqual(rect.size, CGSize(width: 244, height: 100))
  }

  func testOriginOfEachButtonIncreasesWhenLeading() {
    // Given
    let items = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil),
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .leading
    buttonBar.layoutIfNeeded()

    // When
    let origins = items.map { item in
      buttonBar.rect(for: item, in: buttonBar).origin
    }

    // Then
    XCTAssertEqual(origins, [CGPoint(x: 0, y: 0), CGPoint(x: 60, y: 0)])
  }

  func testOriginOfEachButtonDecreasesWhenTrailing() {
    // Given
    let items = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil),
    ]
    buttonBar.items = items
    buttonBar.layoutPosition = .trailing
    buttonBar.layoutIfNeeded()

    // When
    let origins = items.map { item in
      buttonBar.rect(for: item, in: buttonBar).origin
    }

    // Then
    XCTAssertEqual(origins, [CGPoint(x: 72, y: 0), CGPoint(x: 0, y: 0)])
  }

  func testRectInParentCoordinateSpaceFactorsInButtonBarOrigin() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items
    buttonBar.layoutIfNeeded()
    let containerView = UIView()
    buttonBar.frame.origin.x += 10
    buttonBar.frame.origin.y += 20
    containerView.addSubview(buttonBar)

    // When
    let rect = buttonBar.rect(for: items[0], in: containerView)

    // Then
    XCTAssertEqual(rect, CGRect(x: 10, y: 20, width: 60, height: 100))
  }
}
