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
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_Theming
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

class MDCSnackbarThemingTests: XCTestCase {
  var manager: MDCSnackbarManager!

  private let messageTextOpacity: CGFloat = 0.87
  static private let snackbarBackgroundOpacity: CGFloat = 0.8
  private let expectedSnackbarBackgroundColor: (MDCSemanticColorScheme) -> UIColor = { scheme in
    let topColor = scheme
      .onSurfaceColor
      .withAlphaComponent(MDCSnackbarThemingTests.snackbarBackgroundOpacity)
    let backgroundColor = scheme.surfaceColor
    return MDCSemanticColorScheme.blendColor(topColor, withBackgroundColor: backgroundColor)
  }

  override func setUp() {
    super.setUp()

    manager = MDCSnackbarManager()
  }

  override func tearDown() {
    manager = nil

    super.tearDown()
  }

  func testDefaultContainerScheme() {
    // Given
    let containerScheme = MDCContainerScheme()
    let colorScheme = containerScheme.colorScheme

    // When
    manager.applyTheme(withScheme: containerScheme)

    // Then
    XCTAssertEqual(manager.buttonTitleColor(for: .normal), colorScheme.primaryColorVariant)
    XCTAssertEqual(
      manager.snackbarMessageViewBackgroundColor, expectedSnackbarBackgroundColor(colorScheme))
    XCTAssertEqual(
      manager.messageTextColor, colorScheme.surfaceColor.withAlphaComponent(messageTextOpacity))
    XCTAssertEqual(manager.buttonFont, containerScheme.typographyScheme.button)
    XCTAssertEqual(manager.messageFont, containerScheme.typographyScheme.body2)
  }

  func testNonDefaultContainerScheme() {
    // Given
    let containerScheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201907)
    let typographyScheme = MDCTypographyScheme(defaults: .material201902)

    // When
    containerScheme.colorScheme = colorScheme
    containerScheme.typographyScheme = typographyScheme
    manager.applyTheme(withScheme: containerScheme)

    // Then
    XCTAssertEqual(manager.buttonTitleColor(for: .normal), colorScheme.primaryColorVariant)
    XCTAssertEqual(
      manager.snackbarMessageViewBackgroundColor, expectedSnackbarBackgroundColor(colorScheme))
    XCTAssertEqual(
      manager.messageTextColor, colorScheme.surfaceColor.withAlphaComponent(messageTextOpacity))
    XCTAssertEqual(manager.buttonFont, typographyScheme.button)
    XCTAssertEqual(manager.messageFont, typographyScheme.body2)
  }
}
