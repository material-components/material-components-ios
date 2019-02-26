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
import MaterialComponents.MaterialButtonBar
import MaterialComponents.MaterialButtonBar_TypographyThemer
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTypographyScheme

class ButtonBarButtonTypographyThemerTests: XCTestCase {

  func testThemerAppliesButtonFontToButtons() {
    // Given
    let buttonBar = MDCButtonBar()
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    let typographyScheme = MDCTypographyScheme()
    MDCButtonBarTypographyThemer.applyTypographyScheme(typographyScheme, to: buttonBar)

    // Then
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
      }
    }
  }
}
