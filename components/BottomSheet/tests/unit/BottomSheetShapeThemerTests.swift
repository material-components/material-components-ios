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
    shapeScheme.largeSurfaceShape.topRightCorner = MDCCornerTreatment.corner(withRadius: 3)
    bottomSheet.setShapeGenerator(MDCRectangleShapeGenerator(), for: .extended)

    // When
    MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: bottomSheet)

    // Then
    let extendedShapeGenerator = bottomSheet.shapeGenerator(for: .extended)
    XCTAssert(extendedShapeGenerator is MDCRectangleShapeGenerator)
    if let rectangleGenerator = extendedShapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(rectangleGenerator.topLeftCorner,
                     shapeScheme.largeSurfaceShape.topLeftCorner)
      XCTAssertEqual(rectangleGenerator.topRightCorner,
                     shapeScheme.largeSurfaceShape.topRightCorner)
      XCTAssertEqual(rectangleGenerator.bottomLeftCorner,
                     shapeScheme.largeSurfaceShape.bottomLeftCorner)
      XCTAssertEqual(rectangleGenerator.bottomRightCorner,
                     shapeScheme.largeSurfaceShape.bottomRightCorner)
    }

  }

  func testBottomSheetShapeThemerPreferred() {
    // Given
    let collapsedBaselineShapeValue = CGFloat(24)
    let shapeScheme = MDCShapeScheme()
    let bottomSheet = MDCBottomSheetController(contentViewController: UIViewController())
    let generatedCorner = MDCCornerTreatment.corner(withRadius: collapsedBaselineShapeValue)
    shapeScheme.largeSurfaceShape = MDCShapeCategory(cornersWith: .angled, andSize: 10)
    bottomSheet.setShapeGenerator(MDCRectangleShapeGenerator(), for: .preferred)

    // When
    MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: bottomSheet)

    // Then
    let preferredShapeGenerator = bottomSheet.shapeGenerator(for: .preferred)
    XCTAssert(preferredShapeGenerator is MDCRectangleShapeGenerator)
    if let rectangleGenerator = preferredShapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(rectangleGenerator.topLeftCorner, generatedCorner)
      XCTAssertEqual(rectangleGenerator.topRightCorner, generatedCorner)
      XCTAssertEqual(rectangleGenerator.bottomLeftCorner, generatedCorner)
      XCTAssertEqual(rectangleGenerator.bottomRightCorner, generatedCorner)
    }
  }

}
