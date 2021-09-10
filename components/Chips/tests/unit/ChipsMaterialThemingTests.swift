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
import MaterialComponents.MaterialChips
import MaterialComponents.MaterialChips_Theming 
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialTypographyScheme

class ChipsMaterialThemingTests: XCTestCase {

  func testThemedChip() {
    // Given
    let chip = MDCChipView()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme
    scheme.typographyScheme = typographyScheme

    let onSurface12OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.12)
    let onSurface87OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.87)
    let onSurface16OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.16)
    let backgroundColor =
      MDCSemanticColorScheme.blendColor(
        onSurface12OpacityColor,
        withBackgroundColor: colorScheme.surfaceColor)
    let selectedBackgroundColor =
      MDCSemanticColorScheme.blendColor(
        onSurface12OpacityColor,
        withBackgroundColor: backgroundColor)
    let textColor =
      MDCSemanticColorScheme.blendColor(
        onSurface87OpacityColor,
        withBackgroundColor: backgroundColor)
    let selectedTextColor =
      MDCSemanticColorScheme.blendColor(
        onSurface87OpacityColor,
        withBackgroundColor: selectedBackgroundColor)

    // When
    chip.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(chip.inkColor(for: .normal), onSurface16OpacityColor)
    XCTAssertEqual(chip.backgroundColor(for: .normal), backgroundColor)
    XCTAssertEqual(chip.backgroundColor(for: .selected), selectedBackgroundColor)
    XCTAssertEqual(chip.backgroundColor(for: .disabled), backgroundColor.withAlphaComponent(0.38))
    XCTAssertEqual(chip.titleColor(for: .normal), textColor)
    XCTAssertEqual(chip.titleColor(for: .selected), selectedTextColor)
    XCTAssertEqual(chip.titleColor(for: .disabled), textColor.withAlphaComponent(0.38))

    // Test shape
    if let cardShape = chip.shapeGenerator as? MDCRectangleShapeGenerator {
      let corner = MDCCornerTreatment.corner(withRadius: 0.5)
      corner?.valueType = .percentage
      XCTAssertEqual(cardShape.topLeftCorner, corner)
      XCTAssertEqual(cardShape.topRightCorner, corner)
      XCTAssertEqual(cardShape.bottomRightCorner, corner)
      XCTAssertEqual(cardShape.bottomLeftCorner, corner)
    } else {
      XCTFail("Chip.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test typography
    XCTAssertEqual(chip.titleFont, typographyScheme.body2)

    // Test remaining properties
    [.normal, .highlighted, .selected, .disabled].forEach {
      XCTAssertEqual(
        chip.borderWidth(for: $0),
        0,
        accuracy: 0.001,
        "Border width incorrect for state \($0)")
    }
  }

  func testOutlinedThemedChip() {
    // Given
    let chip = MDCChipView()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme
    scheme.typographyScheme = typographyScheme

    let onSurface12OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.12)
    let onSurface87OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.87)
    let onSurface16OpacityColor = colorScheme.onSurfaceColor.withAlphaComponent(0.16)
    let borderColor =
      MDCSemanticColorScheme.blendColor(
        onSurface12OpacityColor,
        withBackgroundColor: colorScheme.surfaceColor)
    let selectedBackgroundColor =
      MDCSemanticColorScheme.blendColor(
        onSurface12OpacityColor,
        withBackgroundColor: colorScheme.surfaceColor)
    let textColor =
      MDCSemanticColorScheme.blendColor(
        onSurface87OpacityColor,
        withBackgroundColor: colorScheme.surfaceColor)
    let selectedTextColor =
      MDCSemanticColorScheme.blendColor(
        onSurface87OpacityColor,
        withBackgroundColor: selectedBackgroundColor)

    // When
    chip.applyOutlinedTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(chip.inkColor(for: .normal), onSurface16OpacityColor)
    XCTAssertEqual(chip.borderColor(for: .normal), borderColor)
    XCTAssertEqual(chip.borderColor(for: .selected), .clear)
    XCTAssertEqual(chip.backgroundColor(for: .normal), colorScheme.surfaceColor)
    XCTAssertEqual(chip.backgroundColor(for: .selected), selectedBackgroundColor)
    XCTAssertEqual(
      chip.backgroundColor(for: .disabled), colorScheme.surfaceColor.withAlphaComponent(0.38))
    XCTAssertEqual(chip.titleColor(for: .normal), textColor)
    XCTAssertEqual(chip.titleColor(for: .selected), selectedTextColor)
    XCTAssertEqual(chip.titleColor(for: .disabled), textColor.withAlphaComponent(0.38))

    // Test shape
    if let cardShape = chip.shapeGenerator as? MDCRectangleShapeGenerator {
      let corner = MDCCornerTreatment.corner(withRadius: 0.5)
      corner?.valueType = .percentage
      XCTAssertEqual(cardShape.topLeftCorner, corner)
      XCTAssertEqual(cardShape.topRightCorner, corner)
      XCTAssertEqual(cardShape.bottomRightCorner, corner)
      XCTAssertEqual(cardShape.bottomLeftCorner, corner)
    } else {
      XCTFail("Chip.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test typography
    XCTAssertEqual(chip.titleFont, typographyScheme.body2)

    // Test remaining properties
    [.normal, .highlighted, .selected, .disabled].forEach {
      XCTAssertEqual(
        chip.borderWidth(for: $0),
        1,
        accuracy: 0.001,
        "Border width incorrect for state \($0)")
    }
  }
}
