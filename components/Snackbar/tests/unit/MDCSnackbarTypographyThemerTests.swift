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
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_TypographyThemer

class MDCSnackbarTypographyThemerTests: XCTestCase {

  override func tearDown() {
    MDCSnackbarManager.dismissAndCallCompletionBlocks(withCategory: nil)

    super.tearDown()
  }
    
  func testSnackbarTypographyThemer() {
    // Given
    let typographyScheme = MDCTypographyScheme()
    let message = MDCSnackbarMessage()
    message.text = "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
    typographyScheme.button = UIFont.boldSystemFont(ofSize: 12)
    typographyScheme.body2 = UIFont.systemFont(ofSize: 19)
    MDCSnackbarManager.buttonFont = UIFont.systemFont(ofSize: 21)
    MDCSnackbarManager.messageFont = UIFont.systemFont(ofSize: 30)

    // When
    MDCSnackbarTypographyThemer.applyTypographyScheme(typographyScheme)

    MDCSnackbarManager.show(message)

    // Then
    XCTAssertEqual(MDCSnackbarManager.buttonFont, typographyScheme.button)
    XCTAssertEqual(MDCSnackbarManager.messageFont, typographyScheme.body2)
  }
    
}
