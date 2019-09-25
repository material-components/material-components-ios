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
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialChips_Theming
import MDFTesting

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
        MDCSemanticColorScheme.blendColor(onSurface12OpacityColor,
                                           withBackgroundColor: colorScheme.surfaceColor)
    let selectedBackgroundColor =
        MDCSemanticColorScheme.blendColor(onSurface12OpacityColor,
                                           withBackgroundColor: backgroundColor)
    let textColor =
        MDCSemanticColorScheme.blendColor(onSurface87OpacityColor,
                                           withBackgroundColor: backgroundColor)
    let selectedTextColor =
        MDCSemanticColorScheme.blendColor(onSurface87OpacityColor,
                                           withBackgroundColor: selectedBackgroundColor)

    // When
    chip.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    assertEqualFirstColor(chip.inkColor(for: .normal), secondColor: onSurface16OpacityColor)
    assertEqualFirstColor(chip.backgroundColor(for: .normal), secondColor: backgroundColor)
    assertEqualFirstColor(chip.backgroundColor(for: .selected), secondColor: selectedBackgroundColor)
    assertEqualFirstColor(chip.backgroundColor(for: .disabled), secondColor: backgroundColor.withAlphaComponent(0.38))
    assertEqualFirstColor(chip.titleColor(for: .normal), secondColor: textColor)
    assertEqualFirstColor(chip.titleColor(for: .selected), secondColor: selectedTextColor)
    assertEqualFirstColor(chip.titleColor(for: .disabled), secondColor: textColor.withAlphaComponent(0.38))

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
      XCTAssertEqual(chip.borderWidth(for: $0),
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
      MDCSemanticColorScheme.blendColor(onSurface12OpacityColor,
                                        withBackgroundColor: colorScheme.surfaceColor)
    let selectedBackgroundColor =
      MDCSemanticColorScheme.blendColor(onSurface12OpacityColor,
                                        withBackgroundColor: colorScheme.surfaceColor)
    let textColor =
      MDCSemanticColorScheme.blendColor(onSurface87OpacityColor,
                                        withBackgroundColor: colorScheme.surfaceColor)
    let selectedTextColor =
      MDCSemanticColorScheme.blendColor(onSurface87OpacityColor,
                                        withBackgroundColor: selectedBackgroundColor)

    // When
    chip.applyOutlinedTheme(withScheme: scheme)

    // Then
    // Test Colors
    assertEqualFirstColor(chip.inkColor(for: .normal), secondColor: onSurface16OpacityColor)
    assertEqualFirstColor(chip.borderColor(for: .normal), secondColor: borderColor)
    assertEqualFirstColor(chip.borderColor(for: .selected), secondColor: .clear)
    assertEqualFirstColor(chip.backgroundColor(for: .normal), secondColor: colorScheme.surfaceColor)
    assertEqualFirstColor(chip.backgroundColor(for: .selected), secondColor: selectedBackgroundColor)
    assertEqualFirstColor(chip.backgroundColor(for: .disabled), secondColor: colorScheme.surfaceColor.withAlphaComponent(0.38))
    assertEqualFirstColor(chip.titleColor(for: .normal), secondColor: textColor)
    assertEqualFirstColor(chip.titleColor(for: .selected), secondColor: selectedTextColor)
    assertEqualFirstColor(chip.titleColor(for: .disabled), secondColor: textColor.withAlphaComponent(0.38))

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
      XCTAssertEqual(chip.borderWidth(for: $0),
                     1,
                     accuracy: 0.001,
                     "Border width incorrect for state \($0)")
    }
  }
}
