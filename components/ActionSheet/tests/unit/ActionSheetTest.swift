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
import MaterialComponentsAlpha.MaterialActionSheet

class ActionSheetTest: XCTestCase {

  var actionSheet: MDCActionSheetController!

  override func setUp() {
    super.setUp()

    actionSheet = MDCActionSheetController()
  }

  private func getLabel(with text: String) -> UILabel? {
    let subviewsArray = actionSheet.view.subviews.filter { !($0 is UITableView) }
    if let header = subviewsArray.first {
      var labels: [UILabel] = header.subviews.flatMap { $0 as? UILabel }
      labels = labels.filter { $0.text == text }
      if let label = labels.first {
        return label
      } else {
        return nil
      }
    } else {
      return nil
    }
  }

  private func setupTitle() -> String {
    let testTitleString: String = "Title test"
    actionSheet.title = testTitleString
    return testTitleString
  }

  private func setupMessage() -> String {
    let testMessageString: String = "Message test"
    actionSheet.message = testMessageString
    return testMessageString
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
    let tableView = actionSheet.view.subviews.flatMap{ $0 as? UITableView }.first
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

  func testDefaultHeaderTitleColor() {
    // When
    let titleString = setupTitle()
    let titleLabel = getLabel(with: titleString)

    // Then
    XCTAssertNotNil(titleLabel)
    XCTAssertEqual(titleLabel?.textColor, .black)
  }

  func testDefaultHeaderMessageColor() {
    // When
    let messageString = setupMessage()
    let messageLabel = getLabel(with: messageString)

    // Then
    XCTAssertNotNil(messageLabel)
    XCTAssertEqual(messageLabel?.textColor, .black)
  }

  func testSetHeaderTitleColor() {
    // Given
    let titleString = setupTitle()
    var titleColor: UIColor = .blue

    // When
    actionSheet.titleTextColor = titleColor
    var titleLabel = getLabel(with: titleString)

    // Then
    XCTAssertNotNil(titleLabel)
    XCTAssertEqual(titleLabel?.textColor, actionSheet.titleTextColor)

    // Given
    actionSheet.title = nil
    titleColor = .green
    let newTitle = "Test"

    // When
    actionSheet.titleTextColor = titleColor
    actionSheet.title = newTitle
    titleLabel = getLabel(with: newTitle)

    // Then
    XCTAssertNotNil(titleLabel)
    XCTAssertEqual(titleLabel?.textColor, titleColor)
  }

  func testSetHeaderMessageColor() {
    // Given
    let messageString = setupMessage()
    var messageColor: UIColor = .blue

    // When
    actionSheet.messageTextColor = messageColor
    var messageLabel = getLabel(with: messageString)

    // Then
    XCTAssertNotNil(messageLabel)
    XCTAssertEqual(messageLabel?.textColor, actionSheet.messageTextColor)

    // Given
    actionSheet.message = nil
    messageColor = .green
    let newMessage = "Test"

    // When
    actionSheet.messageTextColor = messageColor
    actionSheet.message = newMessage
    messageLabel = getLabel(with: newMessage)

    // Then
    XCTAssertNotNil(messageLabel)
    XCTAssertEqual(messageLabel?.textColor, messageColor)
  }
}
