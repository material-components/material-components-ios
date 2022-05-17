// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialDialogs

class MDCAlertControllerAlignmentTests: XCTestCase {

  let maximumAlertWidth: CGFloat = 560
  let minimumAlertWidth: CGFloat = 280

  func testJustifiedAlignmentAlertWidth() {
    // Given
    let alert: MDCAlertController = MDCAlertController(title: "Title", message: "Message")
    alert.actionsHorizontalAlignment = .justified

    let action1: MDCAlertAction = MDCAlertAction(title: "Action1", emphasis: .low)
    alert.addAction(action1)
    let action2: MDCAlertAction = MDCAlertAction(title: "Action2", emphasis: .medium)
    alert.addAction(action2)

    // When
    alert.view.setNeedsLayout()
    alert.view.layoutIfNeeded()

    // Then
    let expectedWidth = min(max(alert.view.bounds.width, minimumAlertWidth), maximumAlertWidth)
    XCTAssertEqual(alert.preferredContentSize.width, expectedWidth)
  }
}
