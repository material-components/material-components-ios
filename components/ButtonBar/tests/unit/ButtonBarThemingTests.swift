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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponentsAlpha.MaterialButtonBar_Theming
import MaterialComponentsAlpha.MaterialContainerScheme

class ButtonBarThemingTests: XCTestCase {

  func testPrimaryThemeWithDefaults() {
    // Given
    let buttonBar = MDCButtonBar()
    let items = [UIBarButtonItem(title: "Text", style: .plain, target: nil, action: nil)]
    buttonBar.items = items

    let scheme = MDCContainerScheme()
    buttonBar.applyPrimaryTheme(withScheme: scheme)

    // Then
    let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
    XCTAssertEqual(buttonBar.backgroundColor, colorScheme.primaryColor)
    XCTAssertEqual(buttonBar.tintColor, colorScheme.onPrimaryColor)
    let typographyScheme = MDCTypographyScheme(defaults: .material201804)
    for view in buttonBar.subviews {
      if let button = view as? MDCButton {
        XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
      }
    }
  }
}
