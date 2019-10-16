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

// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

import XCTest
import MaterialComponents.MaterialTextFields

class TextInputControllerOutlinedTextAreaTests: XCTestCase {

  func testOutlinedTextAreaWithCustomizedNumberOfLines() {
    // Given
    let message = MDCMultilineTextField()
    let messageController = MDCTextInputControllerOutlinedTextArea(textInput: message)

    // When
    messageController.minimumLines = 1
    // This calls the update layout method.
    messageController.borderFillColor = .red
    message.setNeedsLayout()

    // Then
    XCTAssertEqual(messageController.minimumLines, 1)
  }

  func testOutlinedTextAreWithExpandsOnOverflowSetToTrue() {
    // Given
    let message = MDCMultilineTextField()
    let messageController = MDCTextInputControllerOutlinedTextArea(textInput: message)

    // When
    messageController.expandsOnOverflow = true
    // This calls the update layout method.
    messageController.borderFillColor = .red
    message.setNeedsLayout()

    // Then
    XCTAssertTrue(messageController.expandsOnOverflow)
  }
}
