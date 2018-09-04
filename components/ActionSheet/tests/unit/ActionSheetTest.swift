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
import MaterialComponentsAlpha.MaterialActionSheet_ColorThemer
import MaterialComponentsAlpha.MaterialActionSheet_TypographyThemer
import MaterialComponents.MaterialColorScheme

class ActionSheetTest: XCTestCase {

  var actionSheet: MDCActionSheetController!

  override func setUp() {
    super.setUp()

    actionSheet = MDCActionSheetController()
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
    let tableView = actionSheet.view.subviews.flatMap { $0 as? UITableView }.first
    if let table = tableView {
      XCTAssertEqual(table.numberOfRows(inSection: section), rowCount)
      if let dataSource = table.dataSource {
        let cell = dataSource.tableView(table, cellForRowAt: IndexPath(row: rowCount - 1,
                                                                       section: section))
        XCTAssertEqual(cell.accessibilityIdentifier, testIdentifier)
      } else {
        XCTFail("No data source")
      }
    } else {
      XCTFail("No table was loaded")
    }
    
  }

  func testColorThemer() {
    // Given
    let titleTest = "Title"

    // When
    actionSheet.title = titleTest

    // Then
    if let title = getLabel(with: titleTest) {
      XCTAssertEqual(title.textColor, .black)
    } else {
      XCTFail("No title label")
    }

    // Given
    let messageTest = "Message"

    // When
    actionSheet.message = messageTest

    // Then
    if let message = getLabel(with: messageTest) {
      XCTAssertEqual(message.textColor, .black)
    } else {
      XCTFail("No message label was created")
    }

    // Given
    actionSheet.message = nil
    var colorScheme = MDCSemanticColorScheme()
    colorScheme.onSurfaceColor = .blue

    // When
    MDCActionSheetColorThemer.applySemanticColorScheme(colorScheme, to: actionSheet)

    // Then
    if let title = getLabel(with: titleTest) {
      XCTAssertEqual(title.textColor, colorScheme.onSurfaceColor.withAlphaComponent(0.6))
    } else {
      XCTFail("No title label")
    }

    // Given
    actionSheet.message = messageTest
    if let title = getLabel(with: titleTest), let message = getLabel(with: messageTest) {
      XCTAssertEqual(title.textColor, colorScheme.onSurfaceColor.withAlphaComponent(0.87))
      XCTAssertEqual(message.textColor, colorScheme.onSurfaceColor.withAlphaComponent(0.6))
    } else {
      XCTFail("One of the labels wasn't set correctly")
    }

  }

  func getLabel(with text: String) -> UILabel? {
    let headerArray = actionSheet.view.subviews.filter { !($0 is UITableView) }
    if let header = headerArray.first {
      var labels: [UILabel] = header.subviews.flatMap { $0 as UILabel }
                                             .filter { $0.text = text }
      if let label = labels.first {
        return label
      } else {
        return nil
      }
    } else {
      return nil
    }
  }
}
