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

import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialShadowElevations
import MaterialComponentsAlpha.MaterialDialogs_Theming

class DialogsThemerTests: XCTestCase {

  let kCornerRadius: CGFloat = 4;

  func testAlertThemingWithContainerScheme() {
    let alert: MDCAlertController = MDCAlertController(title: "Title", message: "Message")
    let scheme: MDCContainerScheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme()
    let typographyScheme = MDCTypographyScheme()

    alert.applyTheme(withScheme: scheme)

    // Color
    XCTAssertEqual(alert.titleColor, colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(alert.messageColor, colorScheme.onSurfaceColor.withAlphaComponent(0.60))
    XCTAssertEqual(alert.titleIconTintColor, colorScheme.primaryColor)
    XCTAssertEqual(alert.scrimColor, colorScheme.onSurfaceColor.withAlphaComponent(0.32))

    // Typography
    XCTAssertEqual(alert.titleFont, typographyScheme.headline6)
    XCTAssertEqual(alert.messageFont, typographyScheme.body1)

    // Other properties
    XCTAssertEqual(alert.cornerRadius, kCornerRadius, accuracy: 0.001)
    XCTAssertEqual(alert.elevation, ShadowElevation.dialog)
  }
}
