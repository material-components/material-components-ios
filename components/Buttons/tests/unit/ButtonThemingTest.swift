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

import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponentsAlpha.MaterialButtons_Theming

class ButtonThemingTest: XCTestCase {
  func testContainedTheme() {
    // Given
    let button = MDCButton()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)

    // When
    button.applyContainerThemeWithScheme(scheme)

    // Then
    // Test Colors
    XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(button.backgroundColor(for: .disabled), colorScheme.surfaceColor.withAlphaComponent(0.12))
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onPrimaryColor)
    XCTAssertEqual(button.titleColor(for: .disabled), colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onPrimaryColor)
    XCTAssertEqual(button.imageTintColor(for: .disabled), colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    // Test shape
    // Test typography
  }
}
