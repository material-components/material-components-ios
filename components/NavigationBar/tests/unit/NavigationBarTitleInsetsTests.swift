// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialNavigationBar

class NavigationBarTitleInsetsTests: XCTestCase {

  var navigationBar: MDCNavigationBar!
  override func setUp() {
    super.setUp()

    navigationBar = MDCNavigationBar()
  }

  override func tearDown() {
    navigationBar = nil

    super.tearDown()
  }

  func testDefault() {
    XCTAssertEqual(navigationBar.titleInsets, UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }

  func testDefaultWithCenter() {
    // Given
    navigationBar.titleAlignment = .center

    // Then
    XCTAssertEqual(navigationBar.titleInsets, UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }

  func testDefaultWithLeadingAndNoItems() {
    // Given
    navigationBar.titleAlignment = .leading

    // Then
    XCTAssertEqual(navigationBar.titleInsets, UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }

  func testDefaultWithLeadingAndOnlyLeadingItems() {
    // Given
    navigationBar.titleAlignment = .leading

    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.leadingBarButtonItems = items

    // Then
    XCTAssertEqual(navigationBar.titleInsets, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
  }

  func testDefaultWithLeadingAndOnlyTrailingItems() {
    // Given
    navigationBar.titleAlignment = .leading

    // Given
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    navigationBar.trailingBarButtonItems = items

    // Then
    XCTAssertEqual(navigationBar.titleInsets, UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
  }

  func testAssignmentPersistsWithCenterLayout() {
    // Given
    navigationBar.titleAlignment = .center
    let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    // When
    navigationBar.titleInsets = insets

    // Then
    XCTAssertEqual(navigationBar.titleInsets, insets)
  }

  func testAssignmentPersistsWithLeadingLayout() {
    // Given
    navigationBar.titleAlignment = .leading
    let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    // When
    navigationBar.titleInsets = insets

    // Then
    XCTAssertEqual(navigationBar.titleInsets, insets)
  }

  func testAssignmentPersistsWhenLayoutIsChangedFromLeadingToCenter() {
    // Given
    navigationBar.titleAlignment = .leading
    let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    // When
    navigationBar.titleInsets = insets
    navigationBar.titleAlignment = .center

    // Then
    XCTAssertEqual(navigationBar.titleInsets, insets)
  }

  func testAssignmentPersistsWhenLayoutIsChangedFromCenterToleading() {
    // Given
    navigationBar.titleAlignment = .center
    let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    // When
    navigationBar.titleInsets = insets
    navigationBar.titleAlignment = .leading

    // Then
    XCTAssertEqual(navigationBar.titleInsets, insets)
  }
}
