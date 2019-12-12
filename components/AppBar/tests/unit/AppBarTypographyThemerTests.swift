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
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_TypographyThemer
import MaterialComponents.MaterialTypography

class AppBarTypographyThemerTests: XCTestCase {

  func traitsForFont(_ font: UIFont) -> [String: NSNumber] {
    guard let fontTraits = font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.traits)
      as? [String: NSNumber]
      else {
        return [:]
    }

    return fontTraits
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
    XCTAssertEqual(traitsForFont(appBar.navigationBar.titleFont),
                   traitsForFont(typographyScheme.headline6))
  }
}
