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
import MaterialComponents.MaterialCards_ShapeThemer

class CardShapeThemerTests: XCTestCase {

  func testCardShapeThemer() {
    // Given
    let shapeScheme = MDCShapeScheme()
    let card = MDCCard()
    shapeScheme.mediumSurfaceShape = MDCShapeCategory(cornersWith: .angled, andSize: 10)
    card.shapeGenerator = MDCRectangleShapeGenerator()

    // When
    MDCCardsShapeThemer.applyShapeScheme(shapeScheme, to: card)

    // Then
    XCTAssert(card.shapeGenerator is MDCRectangleShapeGenerator);
    XCTAssertEqual((card.shapeGenerator as! MDCRectangleShapeGenerator).topLeftCorner,
                   shapeScheme.mediumSurfaceShape.topLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((card.shapeGenerator as! MDCRectangleShapeGenerator).topRightCorner,
                   shapeScheme.mediumSurfaceShape.topRightCorner.cornerTreatmentValue())
    XCTAssertEqual((card.shapeGenerator as! MDCRectangleShapeGenerator).bottomLeftCorner,
                   shapeScheme.mediumSurfaceShape.bottomLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((card.shapeGenerator as! MDCRectangleShapeGenerator).bottomRightCorner,
                   shapeScheme.mediumSurfaceShape.bottomRightCorner.cornerTreatmentValue())
  }

  func testCardCollectionCellShapeThemer() {
    // Given
    let shapeScheme = MDCShapeScheme()
    let cardCell = MDCCardCollectionCell()
    shapeScheme.mediumSurfaceShape = MDCShapeCategory(cornersWith: .angled, andSize: 10)
    cardCell.shapeGenerator = MDCRectangleShapeGenerator()

    // When
    MDCCardsShapeThemer.applyShapeScheme(shapeScheme, toCardCell: cardCell)

    // Then
    XCTAssert(cardCell.shapeGenerator is MDCRectangleShapeGenerator);
    XCTAssertEqual((cardCell.shapeGenerator as! MDCRectangleShapeGenerator).topLeftCorner,
                   shapeScheme.mediumSurfaceShape.topLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((cardCell.shapeGenerator as! MDCRectangleShapeGenerator).topRightCorner,
                   shapeScheme.mediumSurfaceShape.topRightCorner.cornerTreatmentValue())
    XCTAssertEqual((cardCell.shapeGenerator as! MDCRectangleShapeGenerator).bottomLeftCorner,
                   shapeScheme.mediumSurfaceShape.bottomLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((cardCell.shapeGenerator as! MDCRectangleShapeGenerator).bottomRightCorner,
                   shapeScheme.mediumSurfaceShape.bottomRightCorner.cornerTreatmentValue())
  }
}

extension MDCCornerTreatment {
  override open func isEqual(_ object: Any?) -> Bool {
    if let cutCorner = self as? MDCCutCornerTreatment,
      let cutCorner2 = object as? MDCCutCornerTreatment {
      return cutCorner.cut == cutCorner2.cut
    } else if let roundedCorner = self as? MDCRoundedCornerTreatment,
      let roundedCorner2 = object as? MDCRoundedCornerTreatment {
      return roundedCorner.radius == roundedCorner2.radius
    } else if let curvedCorner = self as? MDCCurvedCornerTreatment,
      let curvedCorner2 = object as? MDCCurvedCornerTreatment {
      return curvedCorner.size == curvedCorner2.size
    }
    return false
  }
}
