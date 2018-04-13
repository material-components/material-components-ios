/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
import MaterialComponents.MaterialAppBar
import MaterialComponents.MDCAppBarTypographyThemer
import MaterialComponents.MaterialTypography

class AppBarTypographyThemerTests: XCTestCase {

  func weightForFont(_ font: UIFont) -> Float {
    // The default font weight is UIFontWeightRegular, which is 0.0.
    var weight: Float = 0.0

    if let fontTraits =
          font.fontDescriptor.object(forKey: UIFontDescriptorTraitsAttribute) as? [String: Any] {
      if let weightNumber = fontTraits[UIFontWeightTrait] as? NSNumber {
        weight = weightNumber.floatValue
      }
    }

    return weight
  }

  func testTypographyThemerAffectsSubComponents() {
    // Given
    let appBar = MDCAppBar()
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)

    // When
    MDCAppBarTypographyThemer.applyTypographyScheme(typographyScheme, to: appBar)

    // Then
    XCTAssertEqual(appBar.navigationBar.titleFont.fontName, typographyScheme.headline6.fontName)
    XCTAssertEqual(appBar.navigationBar.titleFont.pointSize, typographyScheme.headline6.pointSize)
    XCTAssertEqual(weightForFont(appBar.navigationBar.titleFont),
                   weightForFont(typographyScheme.headline6))
  }
}
