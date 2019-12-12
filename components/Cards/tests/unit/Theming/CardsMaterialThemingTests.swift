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

import MaterialComponents.MaterialCards
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialCards_Theming

class CardsMaterialThemingTests: XCTestCase {

  func testThemedCard() {
    // Given
    let card = MDCCard()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme

    // When
    card.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(card.backgroundColor, colorScheme.surfaceColor)

    // Test shape
    if let cardShape = card.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(cardShape.topLeftCorner, shapeScheme.mediumComponentShape.topLeftCorner)
      XCTAssertEqual(cardShape.topRightCorner, shapeScheme.mediumComponentShape.topRightCorner)
      XCTAssertEqual(cardShape.bottomRightCorner,
                     shapeScheme.mediumComponentShape.bottomRightCorner)
      XCTAssertEqual(cardShape.bottomLeftCorner, shapeScheme.mediumComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Card.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(card.shadowElevation(for: .normal), ShadowElevation(rawValue: 1))
    XCTAssertEqual(card.shadowElevation(for: .highlighted), ShadowElevation(rawValue: 1))
    XCTAssertTrue(card.isInteractable)
  }

  func testThemedCardWithoutShapeScheme() {
    // Given
    let card = MDCCard()
    let scheme = MDCContainerScheme()

    // When
    card.applyTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(card.layer.cornerRadius, 4, accuracy: 0.001)
    XCTAssertNil(card.shapeGenerator)
  }

  func testOutlinedThemedCard() {
    // Given
    let card = MDCCard()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme

    // When
    card.applyOutlinedTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(card.backgroundColor, colorScheme.surfaceColor)
    XCTAssertEqual(card.borderColor(for: .normal),
                   colorScheme.onSurfaceColor.withAlphaComponent(0.37))

    // Test shape
    if let cardShape = card.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(cardShape.topLeftCorner, shapeScheme.mediumComponentShape.topLeftCorner)
      XCTAssertEqual(cardShape.topRightCorner, shapeScheme.mediumComponentShape.topRightCorner)
      XCTAssertEqual(cardShape.bottomRightCorner,
                     shapeScheme.mediumComponentShape.bottomRightCorner)
      XCTAssertEqual(cardShape.bottomLeftCorner, shapeScheme.mediumComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Card.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    [UIControl.State.normal, .highlighted, .selected, .disabled].forEach {
      XCTAssertEqual(card.shadowElevation(for: $0),
                     ShadowElevation.none,
                     "Shadow elevation incorrect for state \($0)")
      XCTAssertEqual(card.borderWidth(for: $0),
                     1,
                     accuracy: 0.001,
                     "Border width incorrect for state \($0)")
    }
  }

  func testOutlinedThemedCardWithoutShapeScheme() {
    // Given
    let card = MDCCard()
    let scheme = MDCContainerScheme()

    // When
    card.applyOutlinedTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(card.layer.cornerRadius, 4, accuracy: 0.001)
    XCTAssertNil(card.shapeGenerator)
  }

  func testThemedCardCell() {
    // Given
    let cardCell = MDCCardCollectionCell()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme

    // When
    cardCell.applyTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cardCell.backgroundColor, colorScheme.surfaceColor)

    // Test shape
    if let cardShape = cardCell.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(cardShape.topLeftCorner, shapeScheme.mediumComponentShape.topLeftCorner)
      XCTAssertEqual(cardShape.topRightCorner, shapeScheme.mediumComponentShape.topRightCorner)
      XCTAssertEqual(cardShape.bottomRightCorner,
                     shapeScheme.mediumComponentShape.bottomRightCorner)
      XCTAssertEqual(cardShape.bottomLeftCorner, shapeScheme.mediumComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Card.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(cardCell.shadowElevation(for: .normal), ShadowElevation(rawValue: 1))
    XCTAssertEqual(cardCell.shadowElevation(for: .highlighted), ShadowElevation(rawValue: 1))
    XCTAssertEqual(cardCell.shadowElevation(for: .selected), ShadowElevation(rawValue: 1))
    XCTAssertTrue(cardCell.isInteractable)
  }

  func testThemedCardCellWithoutShapeScheme() {
    // Given
    let cardCell = MDCCardCollectionCell()
    let scheme = MDCContainerScheme()

    // When
    cardCell.applyTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(cardCell.layer.cornerRadius, 4, accuracy: 0.001)
    XCTAssertNil(cardCell.shapeGenerator)
  }

  func testOutlinedThemedCardCell() {
    // Given
    let cardCell = MDCCardCollectionCell()
    let scheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    let shapeScheme = MDCShapeScheme(defaults: .material201809)
    scheme.colorScheme = colorScheme
    scheme.shapeScheme = shapeScheme

    // When
    cardCell.applyOutlinedTheme(withScheme: scheme)

    // Then
    // Test Colors
    XCTAssertEqual(cardCell.backgroundColor, colorScheme.surfaceColor)
    XCTAssertEqual(cardCell.borderColor(for: .normal),
                   colorScheme.onSurfaceColor.withAlphaComponent(0.37))

    // Test shape
    if let cardShape = cardCell.shapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(cardShape.topLeftCorner, shapeScheme.mediumComponentShape.topLeftCorner)
      XCTAssertEqual(cardShape.topRightCorner, shapeScheme.mediumComponentShape.topRightCorner)
      XCTAssertEqual(cardShape.bottomRightCorner,
                     shapeScheme.mediumComponentShape.bottomRightCorner)
      XCTAssertEqual(cardShape.bottomLeftCorner, shapeScheme.mediumComponentShape.bottomLeftCorner)
    } else {
      XCTFail("Card.shapeGenerator was not a MDCRectangularShapeGenerator")
    }

    // Test remaining properties
    XCTAssertEqual(cardCell.borderWidth(for: .normal), 1, accuracy: 0.001)
    XCTAssertEqual(cardCell.borderWidth(for: .highlighted), 1, accuracy: 0.001)
    XCTAssertEqual(cardCell.borderWidth(for: .selected), 1, accuracy: 0.001)
    XCTAssertEqual(cardCell.shadowElevation(for: .normal), ShadowElevation.none)
    XCTAssertEqual(cardCell.shadowElevation(for: .highlighted), ShadowElevation.none)
    XCTAssertEqual(cardCell.shadowElevation(for: .selected), ShadowElevation.none)
  }

  func testOutlinedThemedCardCellWithoutShapeScheme() {
    // Given
    let cardCell = MDCCardCollectionCell()
    let scheme = MDCContainerScheme()

    // When
    cardCell.applyOutlinedTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(cardCell.layer.cornerRadius, 4, accuracy: 0.001)
    XCTAssertNil(cardCell.shapeGenerator)
  }
}
