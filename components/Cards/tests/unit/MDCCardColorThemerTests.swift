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
import MaterialComponents.MaterialCards_ColorThemer

class CardColorThemerTests: XCTestCase {

  func testCardColorThemer() {
    // Given
    let colorScheme = MDCSemanticColorScheme()
    let card = MDCCard()
    colorScheme.surfaceColor = .red
    card.backgroundColor = .white

    // When
    MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: card)

    // Then
    XCTAssertEqual(card.backgroundColor, colorScheme.surfaceColor)
  }

  func testCardCollectionCellColorThemer() {
    // Given
    let colorScheme = MDCSemanticColorScheme()
    let cardCell = MDCCardCollectionCell()
    colorScheme.surfaceColor = .red
    cardCell.backgroundColor = .white

    // When
    MDCCardsColorThemer.applySemanticColorScheme(colorScheme, toCardCell: cardCell)

    // Then
    XCTAssertEqual(cardCell.backgroundColor, colorScheme.surfaceColor)
  }
}
