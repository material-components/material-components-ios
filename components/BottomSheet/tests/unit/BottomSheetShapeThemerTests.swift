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
import MaterialComponents.MaterialShapeLibrary

class BottomSheetShapeThemerTests: XCTestCase {

  func testBottomSheetShapeThemerPreferred() {
    // Given
    let shapeScheme = MDCShapeScheme()
    let bottomSheet = MDCBottomSheetController(contentViewController: UIViewController())
    shapeScheme.largeComponentShape = MDCShapeCategory(cornersWith: .cut, andSize: 10)
    shapeScheme.largeComponentShape.topRightCorner = MDCCornerTreatment.corner(withRadius: 3)
    bottomSheet.setShapeGenerator(MDCRectangleShapeGenerator(), for: .preferred)

    // When
    MDCBottomSheetControllerShapeThemer.applyShapeScheme(shapeScheme, to: bottomSheet)

    // Then
    let preferredShapeGenerator = bottomSheet.shapeGenerator(for: .preferred)
    XCTAssert(preferredShapeGenerator is MDCRectangleShapeGenerator)
    if let rectangleGenerator = preferredShapeGenerator as? MDCRectangleShapeGenerator {
      XCTAssertEqual(
        rectangleGenerator.topLeftCorner,
        shapeScheme.largeComponentShape.topLeftCorner)
      XCTAssertEqual(
        rectangleGenerator.topRightCorner,
        shapeScheme.largeComponentShape.topRightCorner)
      XCTAssertEqual(rectangleGenerator.bottomLeftCorner, MDCCornerTreatment())
      XCTAssertEqual(rectangleGenerator.bottomRightCorner, MDCCornerTreatment())
    }
  }
}
