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
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialBottomSheet_ShapeThemer

class BottomSheetShapeThemerTests: XCTestCase {

  func testBottomSheetShapeThemerExtended() {
    // Given
    let shapeScheme = MDCShapeScheme()
    let bottomSheet = MDCBottomSheetController(contentViewController: UIViewController())
    shapeScheme.largeSurfaceShape = MDCShapeCategory(cornersWith: .angled, andSize: 10)
    bottomSheet.setShapeGenerator(MDCRectangleShapeGenerator(), for: .extended)

    // When
    MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: bottomSheet)

    // Then
    let extendedShapeGenerator = bottomSheet.shapeGenerator(for: .extended)
    XCTAssert(extendedShapeGenerator is MDCRectangleShapeGenerator);
    XCTAssertEqual((extendedShapeGenerator as! MDCRectangleShapeGenerator).topLeftCorner,
                   shapeScheme.largeSurfaceShape.topLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((extendedShapeGenerator as! MDCRectangleShapeGenerator).topRightCorner,
                   shapeScheme.largeSurfaceShape.topRightCorner.cornerTreatmentValue())
    XCTAssertEqual((extendedShapeGenerator as! MDCRectangleShapeGenerator).bottomLeftCorner,
                   shapeScheme.largeSurfaceShape.bottomLeftCorner.cornerTreatmentValue())
    XCTAssertEqual((extendedShapeGenerator as! MDCRectangleShapeGenerator).bottomRightCorner,
                   shapeScheme.largeSurfaceShape.bottomRightCorner.cornerTreatmentValue())
  }

  func testBottomSheetShapeThemerPreferred() {
    // Given
    let bottomSheetCollapsedBaselineShapeValue = NSNumber(value: 24)
    let shapeScheme = MDCShapeScheme()
    let bottomSheet = MDCBottomSheetController(contentViewController: UIViewController())
    let generatedCorner = MDCRoundedCornerTreatment(cornerType: .rounded,
                                                    andSize: bottomSheetCollapsedBaselineShapeValue)
    shapeScheme.largeSurfaceShape = MDCShapeCategory(cornersWith: .angled, andSize: 10)
    bottomSheet.setShapeGenerator(MDCRectangleShapeGenerator(), for: .preferred)

    // When
    MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: bottomSheet)

    // Then
    let preferredShapeGenerator = bottomSheet.shapeGenerator(for: .preferred)
    XCTAssert(preferredShapeGenerator is MDCRectangleShapeGenerator);
    XCTAssertEqual((preferredShapeGenerator as! MDCRectangleShapeGenerator).topLeftCorner,
                   generatedCorner)
    XCTAssertEqual((preferredShapeGenerator as! MDCRectangleShapeGenerator).topRightCorner,
                   generatedCorner)
    XCTAssertEqual((preferredShapeGenerator as! MDCRectangleShapeGenerator).bottomLeftCorner,
                   generatedCorner)
    XCTAssertEqual((preferredShapeGenerator as! MDCRectangleShapeGenerator).bottomRightCorner,
                   generatedCorner)
  }

}
