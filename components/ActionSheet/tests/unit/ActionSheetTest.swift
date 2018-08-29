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
import MaterialComponentsAlpha.MaterialActionSheet

class ActionSheetTest: XCTestCase {
  func testNumberOfActions() {
    // Given
    let actionSheet = MDCActionSheetController(title: nil)

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
    // Given
    let actionSheet = MDCActionSheetController(title: nil)

    // Then
    XCTAssertEqual(actionSheet.title, nil)

    // When
    actionSheet.title = "New title"

    // Then
    XCTAssertEqual(actionSheet.title, "New title")
  }

  func testAccessibilityIdentifiers() {
    // Given
    var testIdentifiers: [String] = []
    let section = 0
    let actionCount = 10
    for i in 0..<actionCount {
      testIdentifiers += ["Test \(i)"]
    }
    let actionSheet = MDCActionSheetController(title: nil)

    // When
    for i in 0..<actionCount {
      let action = MDCActionSheetAction(title: "Title", image: nil, handler: nil)
      action.accessibilityIdentifier = testIdentifiers[i]
      actionSheet.addAction(action)
    }

    // Then
    XCTAssertEqual(actionSheet.view.subviews.count, 2)
    let tableView = actionSheet.view.subviews.flatMap{ $0 as? UITableView }.first
    if let table = tableView {
      XCTAssertEqual(table.numberOfRows(inSection: section), actionCount)
      for row in 0..<table.numberOfRows(inSection: section) {
        let cell = table.cellForRow(at: IndexPath(row: row, section: section))
        XCTAssertEqual(cell?.accessibilityIdentifier, testIdentifiers[row])
      }
    }
  }
}
