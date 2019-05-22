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
import MaterialComponents.MaterialNavigationBar

class NavigationBarTitleViewTests: XCTestCase {

  // MARK: Direct assignment

  func testTitleViewAssignmentAddsItAsASubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()

    // When
    navigationBar.titleView = titleView

    // Then
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  func testTitleViewAssignmentTwiceStillAddsItAsASubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()

    // When
    navigationBar.titleView = titleView
    navigationBar.titleView = titleView

    // Then
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  func testTitleViewAssignmentAndThenRemovalFromViewHierarchyLeavesItWithoutASuperview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()

    // When
    navigationBar.titleView = titleView
    titleView.removeFromSuperview()

    // Then
    XCTAssertNil(titleView.superview)
  }

  // Designed to keep https://github.com/material-components/material-components-ios/issues/7207
  // from regressing.
  func testTitleViewAssignmentThenRemovalFromViewHierarchyThenReassignmentAddsItAsASubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()

    // When
    navigationBar.titleView = titleView
    titleView.removeFromSuperview()
    navigationBar.titleView = titleView

    // Then
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  // MARK: Assignment view UINavigationItem

  func testNavigationItemTitleViewAssignmentBeforeObservationAddsTitleViewAsASubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()
    let navigationItem = UINavigationItem()

    // When
    navigationItem.titleView = titleView
    navigationBar.observe(navigationItem)

    // Then
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  func testNavigationItemTitleViewAssignmentAfterObservationAddsTitleViewAsASubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()
    let navigationItem = UINavigationItem()

    // When
    navigationBar.observe(navigationItem)
    navigationItem.titleView = titleView

    // Then
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  func testNavigationItemTitleViewAssignmentWithSimulatedTheftKeepsTitleViewAsSubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()
    let navigationItem = UINavigationItem()
    let simulatedThiefView = UIView()

    // When
    navigationItem.titleView = titleView
    navigationBar.observe(navigationItem)
    simulatedThiefView.addSubview(navigationItem.titleView!)

    // Then
    XCTAssertEqual(navigationItem.titleView?.superview, simulatedThiefView)
    XCTAssertEqual(titleView.superview, navigationBar)
  }

  // Designed to keep https://github.com/material-components/material-components-ios/issues/7207
  // from regressing.
  func testNavigationItemTitleViewAssignmentWithReassignmentThenTheftKeepsTitleViewAsSubview() {
    // Given
    let navigationBar = MDCNavigationBar()
    let titleView = UIView()
    let navigationItem = UINavigationItem()
    let simulatedThiefView = UIView()

    // When
    navigationItem.titleView = titleView
    navigationBar.observe(navigationItem)
    navigationItem.titleView = titleView
    simulatedThiefView.addSubview(navigationItem.titleView!)

    // Then
    XCTAssertEqual(navigationItem.titleView?.superview, simulatedThiefView)
    XCTAssertEqual(titleView.superview, navigationBar)
  }
}
