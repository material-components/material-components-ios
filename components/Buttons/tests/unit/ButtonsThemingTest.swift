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
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialButtons_Theming

class ButtonsThemingTest: XCTestCase {

  static let disabledOpacity: CGFloat = 0.38
  static let disabledBackgroundOpacity: CGFloat = 0.12
  static let inkOpacity: CGFloat = 0.32
  let testScheme: MDCContainerScheme = {
    let defaultScheme = MDCContainerScheme()

    let typographyScheme = MDCTypographyScheme()
    typographyScheme.button = UIFont(name: "Zapfino", size: 54)!
    defaultScheme.typographyScheme = typographyScheme

    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    defaultScheme.colorScheme = colorScheme

    return defaultScheme
  }()

  func testContainedThemeWithFontForStateAPI() {
    // Given
    let button = MDCButton()
    let baselineCornerRadius: CGFloat = 4

    // When
    button.enableTitleFontForState = true
    button.applyContainedTheme(withScheme: testScheme)

    // Then
    // Test Colors
    XCTAssertEqual(button.backgroundColor(for: .normal), testScheme.colorScheme.primaryColor)
    XCTAssertEqual(
        button.backgroundColor(for: .disabled),
        testScheme.colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledBackgroundOpacity))
    XCTAssertEqual(button.titleColor(for: .normal), testScheme.colorScheme.onPrimaryColor)
    XCTAssertEqual(
        button.titleColor(for: .disabled),
        testScheme.colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
    XCTAssertEqual(button.imageTintColor(for: .normal), testScheme.colorScheme.onPrimaryColor)
    XCTAssertEqual(
        button.imageTintColor(for: .disabled),
        testScheme.colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
    XCTAssertEqual(button.inkColor,
                   testScheme.colorScheme.onPrimaryColor.withAlphaComponent(ButtonsThemingTest.inkOpacity))
    // Test shape
    XCTAssertEqual(button.layer.cornerRadius, baselineCornerRadius, accuracy: 0.001)
    // Test typography
    XCTAssertEqual(button.titleFont(for: .normal), testScheme.typographyScheme.button)
    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.raisedButtonResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.raisedButtonPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)
    XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
    XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
  }

  func testContainedThemeWithoutFontForStateAPI() {
    // Given
    let button = MDCButton()
    let colorScheme = testScheme.colorScheme
    let typographyScheme = testScheme.typographyScheme
    let baselineCornerRadius: CGFloat = 4

    // When
    button.enableTitleFontForState = false
    button.applyContainedTheme(withScheme: testScheme)

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
    XCTAssertEqual(button.titleLabel?.font, typographyScheme.button)
    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.raisedButtonResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.raisedButtonPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)
    XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
    XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
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
    if let buttonShape = button.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(buttonShape.topLeftCorner, shapeScheme.smallComponentShape.topLeftCorner)
      XCTAssertEqual(buttonShape.topRightCorner, shapeScheme.smallComponentShape.topRightCorner)
      XCTAssertEqual(buttonShape.bottomRightCorner,
                     shapeScheme.smallComponentShape.bottomRightCorner)
      XCTAssertEqual(buttonShape.bottomLeftCorner, shapeScheme.smallComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Button.shapeGenerator was not a MDCRectangularShapeGenerator")
    }
  }

  func testOutlinedThemeWithFontForStateAPI() {
    // Given
    let button = MDCButton()
    let colorScheme = testScheme.colorScheme
    let typographyScheme = testScheme.typographyScheme
    let baselineCornerRadius: CGFloat = 4

    // When
    button.enableTitleFontForState = true
    button.applyOutlinedTheme(withScheme: testScheme)

    // Then
    // Test Colors
    XCTAssertEqual(button.backgroundColor(for: .normal), .clear)
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(
      button.imageTintColor(for: .disabled),
      colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(
      button.titleColor(for: .disabled),
      colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(button.disabledAlpha,1)
    XCTAssertEqual(button.inkColor,colorScheme.primaryColor.withAlphaComponent(0.12))
    XCTAssertEqual(
      button.borderColor(for: .normal),
      colorScheme.onSurfaceColor.withAlphaComponent(0.12))
    // Test shape
    XCTAssertEqual(button.layer.cornerRadius, baselineCornerRadius, accuracy: 0.001)
    // Test typography
    XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
    // Test remaining properties
    XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
    XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .normal), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .selected), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .highlighted), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .disabled), 1, accuracy: 0.001)
  }

  func testOutlinedThemeWithoutFontForStateAPI() {
    // Given
    let button = MDCButton()
    let colorScheme = testScheme.colorScheme
    let typographyScheme = testScheme.typographyScheme
    let baselineCornerRadius: CGFloat = 4

    // When
    button.enableTitleFontForState = false
    button.applyOutlinedTheme(withScheme: testScheme)

    // Then
    // Test Colors
    XCTAssertEqual(button.backgroundColor(for: .normal), .clear)
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(
      button.imageTintColor(for: .disabled),
      colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.primaryColor)
    XCTAssertEqual(
      button.titleColor(for: .disabled),
      colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(button.disabledAlpha,1)
    XCTAssertEqual(button.inkColor,colorScheme.primaryColor.withAlphaComponent(0.12))
    XCTAssertEqual(
      button.borderColor(for: .normal),
      colorScheme.onSurfaceColor.withAlphaComponent(0.12))
    // Test shape
    XCTAssertEqual(button.layer.cornerRadius, baselineCornerRadius, accuracy: 0.001)
    // Test typography
    XCTAssertEqual(button.titleLabel?.font, typographyScheme.button)
    // Test remaining properties
    XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
    XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .normal), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .selected), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .highlighted), 1, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .disabled), 1, accuracy: 0.001)
  }

  func testOutlinedThemeWithShapeScheme() {
    // Given
    let button = MDCButton()
    let scheme = MDCContainerScheme()
    let shapeScheme = MDCShapeScheme()
    scheme.shapeScheme = shapeScheme

    // When
    button.applyOutlinedTheme(withScheme: scheme)

    // Then
    if let buttonShape = button.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(buttonShape.topLeftCorner, shapeScheme.smallComponentShape.topLeftCorner)
      XCTAssertEqual(buttonShape.topRightCorner, shapeScheme.smallComponentShape.topRightCorner)
      XCTAssertEqual(buttonShape.bottomRightCorner, shapeScheme.smallComponentShape.bottomRightCorner)
      XCTAssertEqual(buttonShape.bottomLeftCorner, shapeScheme.smallComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Button.shapeGenerator was not a MDCRectangularShapeGenerator")
    }
  }

  func testTextThemeWithFontForStateAPI() {
    // Given
    let button = MDCButton()

    // When
    button.enableTitleFontForState = true
    button.applyTextTheme(withScheme: testScheme)

    // Then
    helperAssertTextTheme(button: button)
  }

  func testTextThemeWithoutFontForStateAPI() {
    // Given
    let button = MDCButton()

    // When
    button.enableTitleFontForState = false
    button.applyTextTheme(withScheme: testScheme)

    // Then
    helperAssertTextTheme(button: button)
  }

  func testTextThemeWithColorScheme() {
    // Given
    let button = MDCButton()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let customColor = UIColor.orange
    colorScheme.primaryColor = customColor
    scheme.colorScheme = colorScheme

    // When
    button.applyTextTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(button.titleColor(for: .normal), customColor)
    XCTAssertEqual(button.imageTintColor(for: .normal), customColor)
  }

  func testConvertContainedToTextTheme() {
    // Given
    let button = MDCButton()

    // When
    button.applyContainedTheme(withScheme: testScheme)
    button.applyTextTheme(withScheme: testScheme)

    // Then
    helperAssertTextTheme(button: button)
  }

  // MARK: Helpers

  func helperAssertTextTheme(button: MDCButton) {
    let colorScheme = testScheme.colorScheme
    let typographyScheme = testScheme.typographyScheme

    // Test colors
    XCTAssertEqual(button.backgroundColor(for: .normal), .clear)
    XCTAssertEqual(button.borderColor(for: .normal), nil)
    XCTAssertEqual(button.inkColor, colorScheme.primaryColor.withAlphaComponent(0.16))
    XCTAssertEqual(button.titleColor(for: [.normal, .highlighted]), colorScheme.primaryColor)
    XCTAssertEqual(button.titleColor(for: .disabled),
                   colorScheme.onSurfaceColor.withAlphaComponent(0.38))
    [.normal, .highlighted].forEach {
      XCTAssertEqual(button.imageTintColor(for: $0), colorScheme.primaryColor)
    }
    XCTAssertEqual(button.imageTintColor(for: .disabled),
                   colorScheme.onSurfaceColor.withAlphaComponent(0.38))

    // Test typography
    if button.enableTitleFontForState {
      XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
    } else {
      XCTAssertEqual(button.titleLabel?.font, typographyScheme.button)
    }

    // Test shape
    XCTAssertEqual(button.layer.cornerRadius, 4.0, accuracy: 0.001)

    // Test remaining properties
    [.normal, .highlighted, .selected, .disabled].forEach {
      XCTAssertEqual(button.elevation(for: $0), ShadowElevation.none)
    }
    XCTAssertEqual(button.minimumSize.height, 36.0, accuracy: 0.001)
  }

  func testFloatingButtonSecondaryThemeWithNoCustomThemes() {
    // Given
    let button = MDCFloatingButton()
    let defaultButton = MDCFloatingButton()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)

    // When
    button.applySecondaryTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.secondaryColor)
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onSecondaryColor)
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onSecondaryColor)
    XCTAssertEqual(button.shadowColor(for: .normal), defaultButton.shadowColor(for: .normal))
    XCTAssertEqual(button.inkColor, defaultButton.inkColor)

    XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)

    if let buttonShape = button.shapeGenerator as? MDCRectangleShapeGenerator {
      let corner = MDCCornerTreatment.corner(withRadius: 0.5)
      corner?.valueType = .percentage
      XCTAssertEqual(buttonShape.topLeftCorner, corner)
      XCTAssertEqual(buttonShape.topRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomLeftCorner, corner)
    } else {
      XCTFail("Button.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.fabResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.fabPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)

    XCTAssertEqual(button.borderWidth(for: .normal), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .selected), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .highlighted), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .disabled), 0, accuracy: 0.001)
  }

  func testFloatingButtonSecondaryThemeWithCustomColorTheme() {
    // Given
    let button = MDCFloatingButton()
    let defaultButton = MDCFloatingButton()
    let scheme = MDCContainerScheme()
    let customColorScheme = MDCSemanticColorScheme(defaults: .material201804)
    customColorScheme.secondaryColor = .purple
    customColorScheme.onSecondaryColor = .purple
    scheme.colorScheme = customColorScheme
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)

    // When
    button.applySecondaryTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(button.backgroundColor(for: .normal), customColorScheme.secondaryColor)
    XCTAssertEqual(button.imageTintColor(for: .normal), customColorScheme.onSecondaryColor)
    XCTAssertEqual(button.titleColor(for: .normal), customColorScheme.onSecondaryColor)
    XCTAssertEqual(button.shadowColor(for: .normal), defaultButton.shadowColor(for: .normal))
    XCTAssertEqual(button.inkColor, defaultButton.inkColor)

    XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)

    if let buttonShape = button.shapeGenerator as? MDCRectangleShapeGenerator {
      let corner = MDCCornerTreatment.corner(withRadius: 0.5)
      corner?.valueType = .percentage
      XCTAssertEqual(buttonShape.topLeftCorner, corner)
      XCTAssertEqual(buttonShape.topRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomLeftCorner, corner)
    } else {
      XCTFail("Button.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.fabResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.fabPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)

    XCTAssertEqual(button.borderWidth(for: .normal), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .selected), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .highlighted), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .disabled), 0, accuracy: 0.001)
  }

  func testFloatingButtonSecondaryThemeWithCustomTypographyTheme() {
    // Given
    let button = MDCFloatingButton()
    let defaultButton = MDCFloatingButton()
    let scheme = MDCContainerScheme()
    let customTypographyScheme = MDCTypographyScheme()
    customTypographyScheme.button = UIFont.systemFont(ofSize: 19)
    scheme.typographyScheme = customTypographyScheme
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)

    // When
    button.applySecondaryTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.secondaryColor)
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onSecondaryColor)
    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onSecondaryColor)
    XCTAssertEqual(button.shadowColor(for: .normal), defaultButton.shadowColor(for: .normal))
    XCTAssertEqual(button.inkColor, defaultButton.inkColor)

    XCTAssertEqual(button.titleFont(for: .normal), customTypographyScheme.button)

    if let buttonShape = button.shapeGenerator as? MDCRectangleShapeGenerator {
      let corner = MDCCornerTreatment.corner(withRadius: 0.5)
      corner?.valueType = .percentage
      XCTAssertEqual(buttonShape.topLeftCorner, corner)
      XCTAssertEqual(buttonShape.topRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomRightCorner, corner)
      XCTAssertEqual(buttonShape.bottomLeftCorner, corner)
    } else {
      XCTFail("Button.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.fabResting)
    XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.fabPressed)
    XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)

    XCTAssertEqual(button.borderWidth(for: .normal), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .selected), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .highlighted), 0, accuracy: 0.001)
    XCTAssertEqual(button.borderWidth(for: .disabled), 0, accuracy: 0.001)
  }
}
