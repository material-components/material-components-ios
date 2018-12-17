// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialSnackbar

class SnackbarManagerSwiftTests: XCTestCase {

  override func tearDown() {
    MDCSnackbarManager.dismissAndCallCompletionBlocks(withCategory: nil)
    super.tearDown()
  }

  func testMessagesResumedWhenTokenIsDeallocated() {
    // Given
    let expectation = self.expectation(description: "completion")

    let suspendedMessage = MDCSnackbarMessage(text: "")
    suspendedMessage.duration = 0.05
    suspendedMessage.completionHandler = { (userInitiated) -> Void  in
      expectation.fulfill()
    }

    // Encourage the runtime to deallocate the token immediately
    autoreleasepool {
      var token = MDCSnackbarManager.suspendAllMessages()
      MDCSnackbarManager.show(suspendedMessage)
      token = nil

      // When
      XCTAssertNil(token, "Ensuring that the compiler knows we're reading this variable")
    }

    // Then
    // Swift unit tests are sometimes slower, need to wait a little longer
    self.waitForExpectations(timeout: 3.0, handler: nil)
  }

  func testHasMessagesShowingOrQueued() {
    let message = MDCSnackbarMessage(text: "foo1")
    message.duration = 10;
    MDCSnackbarManager.show(message)

    let expectation = self.expectation(description: "has_shown_message")

    // We need to dispatch_async in order to assure that the assertion happens after showMessage:
    // actually displays the message.
    DispatchQueue.main.async {
      XCTAssertTrue(MDCSnackbarManager.hasMessagesShowingOrQueued())
      expectation.fulfill()
    }

    self.waitForExpectations(timeout: 3.0, handler: nil)
  }
}
