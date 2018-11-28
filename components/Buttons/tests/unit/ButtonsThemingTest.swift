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
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialTypographyScheme
import MaterialComponentsAlpha.MaterialButtons_Theming

class ButtonsThemingTest: XCTestCase {

  static let disabledOpacity: CGFloat = 0.38
  static let disabledBackgroundOpacity: CGFloat = 0.12
  static let inkOpacity: CGFloat = 0.32

  func testContainedTheme() {
    // Given
    let button = MDCButton()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)
    let baselineCornerRadius: CGFloat = 4

    // When
    button.applyContainedTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(
        button.backgroundColor(for: .disabled),
        colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledBackgroundOpacity))
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onPrimaryColor)
    XCTAssertEqual(
        button.titleColor(for: .disabled),
        colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onPrimaryColor)
    XCTAssertEqual(
        button.imageTintColor(for: .disabled),
        colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
    XCTAssertEqual(button.inkColor,
                   colorScheme.onPrimaryColor.withAlphaComponent(ButtonsThemingTest.inkOpacity))
    // Test shape
    XCTAssertEqual(button.layer.cornerRadius, baselineCornerRadius, accuracy: 0.001)
    // Test typography
    XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.raisedButtonResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.raisedButtonPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)
    XCTAssertEqual(button.minimumSize.width, 0)
    XCTAssertEqual(button.minimumSize.height, 36)
  }

  func testContainedThemeWithShapeScheme() {
    // Given
    let button = MDCButton()
    let scheme = MDCContainerScheme()
    let shapeScheme = MDCShapeScheme()
    scheme.shapeScheme = shapeScheme

    // When
    button.applyContainedTheme(withScheme: scheme)

    // Then
    let buttonShape = button.shapeGenerator as! MDCRectangleShapeGenerator
    XCTAssertEqual(buttonShape.topLeftCorner, shapeScheme.smallComponentShape.topLeftCorner)
    XCTAssertEqual(buttonShape.topRightCorner, shapeScheme.smallComponentShape.topRightCorner)
    XCTAssertEqual(buttonShape.bottomRightCorner, shapeScheme.smallComponentShape.bottomRightCorner)
    XCTAssertEqual(buttonShape.bottomLeftCorner, shapeScheme.smallComponentShape.bottomLeftCorner)
  }
}
