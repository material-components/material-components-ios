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
import MaterialComponents.MaterialSnackbar_ColorThemer

class SnackbarColorThemerTests: XCTestCase {

  func testColorThemerChangesTheCorrectParameters() {
    // Given
    let colorScheme = MDCSemanticColorScheme()
    let message = MDCSnackbarMessage()
    message.text = "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
    colorScheme.surfaceColor = .red
    colorScheme.onSurfaceColor = .blue
    MDCSnackbarManager.snackbarMessageViewBackgroundColor = .white
    MDCSnackbarManager.messageTextColor = .white
    MDCSnackbarManager.setButtonTitleColor(.white, for: .normal)
    MDCSnackbarManager.setButtonTitleColor(.white, for: .highlighted)

    // When
    MDCSnackbarColorThemer.applySemanticColorScheme(colorScheme)

    MDCSnackbarManager.show(message)

    // Then
    XCTAssertEqual(MDCSnackbarManager.snackbarMessageViewBackgroundColor?.withAlphaComponent(1),
                   colorScheme.onSurfaceColor)
    XCTAssertEqual(MDCSnackbarManager.messageTextColor?.withAlphaComponent(1),
                   colorScheme.surfaceColor)
    XCTAssertEqual(MDCSnackbarManager.buttonTitleColor(for: .normal)?.withAlphaComponent(1),
                   colorScheme.surfaceColor)
    XCTAssertEqual(MDCSnackbarManager.buttonTitleColor(for: .highlighted)?.withAlphaComponent(1),
                   colorScheme.surfaceColor)

    MDCSnackbarManager.dismissAndCallCompletionBlocks(withCategory: nil)
  }
}
