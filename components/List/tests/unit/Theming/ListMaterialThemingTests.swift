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

import MaterialComponents.MaterialList
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialList_Theming

class ListMaterialThemingTests: XCTestCase {

  private let highAlpha: CGFloat = 0.87
  private let inkAlpha: CGFloat = 0.16

  var defaultTypographyScheme: MDCTypographyScheme {
    return MDCTypographyScheme(defaults: .material201804)
  }

  var customTypographyScheme: MDCTypographyScheme {
    let scheme = defaultTypographyScheme
    scheme.subtitle1 = scheme.subtitle1.withSize(scheme.subtitle1.pointSize + 3)
    scheme.subtitle2 = scheme.subtitle1.withSize(scheme.subtitle1.pointSize + 5)
    return scheme
  }

  var defaultColorScheme: MDCSemanticColorScheme {
    return MDCSemanticColorScheme(defaults: .material201804)
  }

  var customColorScheme: MDCSemanticColorScheme {
    let scheme = defaultColorScheme
    scheme.onSurfaceColor = UIColor.magenta
    return scheme
  }

  func testMDCBaseCellWithEmptyContainerScheme() {
    // Given
    let cell = MDCBaseCell()
    let scheme = MDCContainerScheme()
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)

    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
  }

  func testMDCBaseCellWithContainerSchemeWithCustomColorScheme() {
    // Given
    let cell = MDCBaseCell()
    let scheme = MDCContainerScheme()
    scheme.colorScheme = customColorScheme
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)

    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
  }

  func testMDCSelfSizingStereoCellWithEmptyContainerScheme() {
    // Given
    let cell = MDCSelfSizingStereoCell()
    let scheme = MDCContainerScheme()
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)
    let textAndTintColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(highAlpha)
    let titleFont = defaultTypographyScheme.subtitle1
    let detailFont = defaultTypographyScheme.body2
    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
    XCTAssertEqual(cell.titleLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.detailLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.leadingImageView.tintColor, textAndTintColor)
    XCTAssertEqual(cell.trailingImageView.tintColor, textAndTintColor)
    // Test Typography
    XCTAssertEqual(cell.titleLabel.font, titleFont)
    XCTAssertEqual(cell.detailLabel.font, detailFont)
  }

  func testMDCSelfSizingStereoCellWithContainerSchemeWithCustomColorScheme() {
    // Given
    let cell = MDCSelfSizingStereoCell()
    let scheme = MDCContainerScheme()
    scheme.colorScheme = customColorScheme
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)
    let textAndTintColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(highAlpha)
    let titleFont = defaultTypographyScheme.subtitle1
    let detailFont = defaultTypographyScheme.body2
    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
    XCTAssertEqual(cell.titleLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.detailLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.leadingImageView.tintColor, textAndTintColor)
    XCTAssertEqual(cell.trailingImageView.tintColor, textAndTintColor)
    // Test Typography
    XCTAssertEqual(cell.titleLabel.font, titleFont)
    XCTAssertEqual(cell.detailLabel.font, detailFont)
  }

  func testMDCSelfSizingStereoCellWithContainerSchemeWithCustomTypographyScheme() {
    // Given
    let cell = MDCSelfSizingStereoCell()
    let scheme = MDCContainerScheme()
    scheme.typographyScheme = customTypographyScheme
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)
    let textAndTintColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(highAlpha)
    let titleFont = scheme.typographyScheme.subtitle1
    let detailFont = scheme.typographyScheme.body2
    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
    XCTAssertEqual(cell.titleLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.detailLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.leadingImageView.tintColor, textAndTintColor)
    XCTAssertEqual(cell.trailingImageView.tintColor, textAndTintColor)
    // Test Typography
    XCTAssertEqual(cell.titleLabel.font, titleFont)
    XCTAssertEqual(cell.detailLabel.font, detailFont)
  }

  func testMDCSelfSizingStereoCellWithContainerSchemeWithCustomColorSchemeAndCustomTypographyScheme() {
    // Given
    let cell = MDCSelfSizingStereoCell()
    let scheme = MDCContainerScheme()
    scheme.colorScheme = customColorScheme
    scheme.typographyScheme = customTypographyScheme
    let inkColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(inkAlpha)
    let textAndTintColor = scheme.colorScheme.onSurfaceColor.withAlphaComponent(highAlpha)
    let titleFont = scheme.typographyScheme.subtitle1
    let detailFont = scheme.typographyScheme.body2
    // When
    cell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cell.inkColor, inkColor)
    XCTAssertEqual(cell.titleLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.detailLabel.textColor, textAndTintColor)
    XCTAssertEqual(cell.leadingImageView.tintColor, textAndTintColor)
    XCTAssertEqual(cell.trailingImageView.tintColor, textAndTintColor)
    // Test Typography
    XCTAssertEqual(cell.titleLabel.font, titleFont)
    XCTAssertEqual(cell.detailLabel.font, detailFont)
  }
}
