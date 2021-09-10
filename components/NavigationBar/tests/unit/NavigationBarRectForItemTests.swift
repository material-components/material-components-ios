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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialNavigationBar

// Tests for Navigation Bar's rectFor*ItemAtIndex:inCoordinateSpace: APIs.
class NavigationBarRectForItemTests: XCTestCase {

  var navigationBar: MDCNavigationBar!

  override func setUp() {
    super.setUp()

    navigationBar = MDCNavigationBar()
    navigationBar.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
  }

  override func tearDown() {
    navigationBar = nil

    super.tearDown()
  }

  func testLeadingShortTextButtonMatchesExpectedFrame() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.leadingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let rect = navigationBar.rect(forLeading: items[0], in: navigationBar)

    // Then
    XCTAssertEqual(rect, CGRect(x: 0, y: 0, width: 68, height: 56))
  }

  func testTrailingShortTextButtonMatchesExpectedFrame() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.trailingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let rect = navigationBar.rect(forTrailing: items[0], in: navigationBar)

    // Then
    XCTAssertEqual(rect, CGRect(x: 132, y: 0, width: 68, height: 56))
  }

  func testLeadingLongTextButtonMatchesExpectedFrame() {
    // Given
    let items = [
      UIBarButtonItem(
        title: "Text that is relatively long",
        style: .plain,
        target: nil,
        action: nil)
    ]
    navigationBar.leadingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let rect = navigationBar.rect(forLeading: items[0], in: navigationBar)

    // Then
    XCTAssertEqual(rect, CGRect(x: 0, y: 0, width: 252, height: 56))
  }

  func testTrailingLongTextButtonMatchesExpectedFrame() {
    // Given
    let items = [
      UIBarButtonItem(
        title: "Text that is relatively long",
        style: .plain,
        target: nil,
        action: nil)
    ]
    navigationBar.trailingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let rect = navigationBar.rect(forTrailing: items[0], in: navigationBar)

    // Then
    XCTAssertEqual(rect, CGRect(x: -52, y: 0, width: 252, height: 56))
  }

  func testOriginOfEachLeadingButtonIncreases() {
    // Given
    let items = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil),
    ]
    navigationBar.leadingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let origins = items.map { item in
      navigationBar.rect(forLeading: item, in: navigationBar).origin
    }

    // Then
    XCTAssertEqual(origins, [CGPoint(x: 0, y: 0), CGPoint(x: 64, y: 0)])
  }

  func testOriginOfEachTrailingButtonDecreases() {
    // Given
    let items = [
      UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil),
      UIBarButtonItem(title: "Text 2", style: .plain, target: nil, action: nil),
    ]
    navigationBar.trailingBarButtonItems = items
    navigationBar.layoutIfNeeded()

    // When
    let origins = items.map { item in
      navigationBar.rect(forTrailing: item, in: navigationBar).origin
    }

    // Then
    XCTAssertEqual(origins, [CGPoint(x: 136, y: 0), CGPoint(x: 60, y: 0)])
  }

  func testLeadingRectInParentCoordinateSpaceFactorsInNavigationBarOrigin() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.leadingBarButtonItems = items
    navigationBar.layoutIfNeeded()
    let containerView = UIView()
    navigationBar.frame.origin.x += 10
    navigationBar.frame.origin.y += 20
    containerView.addSubview(navigationBar)

    // When
    let rect = navigationBar.rect(forLeading: items[0], in: containerView)

    // Then
    XCTAssertEqual(rect, CGRect(x: 10, y: 20, width: 68, height: 56))
  }

  func testTrailingRectInParentCoordinateSpaceFactorsInNavigationBarOrigin() {
    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.trailingBarButtonItems = items
    navigationBar.layoutIfNeeded()
    let containerView = UIView()
    navigationBar.frame.origin.x += 10
    navigationBar.frame.origin.y += 20
    containerView.addSubview(navigationBar)

    // When
    let rect = navigationBar.rect(forTrailing: items[0], in: containerView)

    // Then
    XCTAssertEqual(rect, CGRect(x: 142, y: 20, width: 68, height: 56))
  }
}
