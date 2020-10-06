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
import MaterialComponents.MaterialActionSheet

class MDCActionSheetControllerSwiftTests: XCTestCase {

  var actionSheet: MDCActionSheetController!

  override func setUp() {
    super.setUp()

    actionSheet = MDCActionSheetController()
  }

  override func tearDown() {
    actionSheet = nil

    super.tearDown()
  }

  func testNumberOfActions() {
    // Then
    XCTAssertEqual(actionSheet.actions.count, 0)

    // When
    for _ in 0..<4 {
      let action = MDCActionSheetAction(title: "Action", image: nil, handler: nil)
      actionSheet.addAction(action)
    }
    // Then
    XCTAssertEqual(actionSheet.actions.count, 4)
  }

  func testTitleChange() {
    // Then
    XCTAssertEqual(actionSheet.title, nil)

    // When
    actionSheet.title = "New title"

    // Then
    XCTAssertEqual(actionSheet.title, "New title")
  }

  func testAccessibilityIdentifiers() {
    // Given
    let rowCount = 1
    let section = 0
    let testIdentifier = "Test"

    // When
    let action = MDCActionSheetAction(title: "Title", image: nil, handler: nil)
    action.accessibilityIdentifier = testIdentifier
    actionSheet.addAction(action)

    // Then
    let tableView = actionSheet.view.subviews.compactMap { $0 as? UITableView }.first
    if let table = tableView {
      XCTAssertEqual(table.numberOfRows(inSection: section), rowCount)
      if let dataSource = table.dataSource {
        let cell = dataSource.tableView(
          table,
          cellForRowAt: IndexPath(
            row: rowCount - 1,
            section: section))
        XCTAssertEqual(cell.accessibilityIdentifier, testIdentifier)
      } else {
        XCTFail("No data source")
      }
    } else {
      XCTFail("No table was loaded")
    }

  }

  func testDefaultBackgroundColor() {
    // When
    let _ = actionSheet.view

    // Then
    XCTAssertEqual(actionSheet.backgroundColor, .white)
    XCTAssertEqual(actionSheet.view.backgroundColor, .white)

    //  TODO(https://github.com/material-components/material-components-ios/issues/8238): Re-enable this test.
    //  let subviewsArray = actionSheet.view.subviews
    //  for view in subviewsArray {
    //    XCTAssertEqual(view.backgroundColor, .white)
    //  }
  }

  func testBackgroundColorMatchesViewBackgroundColor() {
    // Given
    let newBackgroundColor: UIColor = .green
    actionSheet.backgroundColor = newBackgroundColor

    // When
    let _ = actionSheet.view

    // Then
    XCTAssertEqual(actionSheet.view.backgroundColor, actionSheet.backgroundColor)
    XCTAssertEqual(actionSheet.view.backgroundColor, newBackgroundColor)
  }

  func testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges() {
    // Given
    let expectation = XCTestExpectation(description: "traitCollectionDidChange")
    actionSheet.traitCollectionDidChangeBlock = { (_, _) in
      expectation.fulfill()
    }

    // When
    actionSheet.traitCollectionDidChange(nil)

    // Then
    self.wait(for: [expectation], timeout: 1)
  }

  func testTraitCollectionDidChangeBlockCalledWithExpectedParameters() {
    // Given
    let expectation = XCTestExpectation(description: "traitCollectionDidChange")
    var passedTraitCollection: UITraitCollection? = nil
    var passedActionSheet: MDCActionSheetController? = nil
    actionSheet.traitCollectionDidChangeBlock = { (action, traitCollection) in
      passedTraitCollection = traitCollection
      passedActionSheet = action
      expectation.fulfill()
    }
    let fakeTraitCollection = UITraitCollection(displayScale: 77)

    // When
    actionSheet.traitCollectionDidChange(fakeTraitCollection)

    // Then
    self.wait(for: [expectation], timeout: 1)
    XCTAssertEqual(passedTraitCollection, fakeTraitCollection)
    XCTAssertEqual(passedActionSheet, actionSheet)
  }
}
