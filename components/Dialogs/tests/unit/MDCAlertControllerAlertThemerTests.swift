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

import MaterialComponents.MDCAlertScheme
import MaterialComponents.MDCAlertControllerThemer

class MDCAlertControllerAlertThemerTests: XCTestCase {

  let defaultCornerRadius: CGFloat = 4.0
  var alertScheme: MDCAlertScheme = MDCAlertScheme()
  var alert = MDCAlertController(title: "Title", message: "Message")
  var alertView: MDCAlertControllerView { return alert.view as! MDCAlertControllerView }

  override func setUp() {
    super.setUp()

    alertScheme = MDCAlertScheme()
    alertScheme.colorScheme = MDCSemanticColorScheme()
    alertScheme.typographyScheme = MDCTypographyScheme()

    alert = MDCAlertController(title: "Title", message: "Message")
  }

  func testDefaultAlertScheme() {
    XCTAssertEqual(alertScheme.colorScheme.primaryColor, MDCSemanticColorScheme().primaryColor)
    XCTAssertEqual(alertScheme.typographyScheme.body1, MDCTypographyScheme().body1)
    XCTAssertEqual(alertScheme.cornerRadius, defaultCornerRadius)
  }

  func testApplyingAlertSchemeWithCustomColor() {
    // Given
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.onSurfaceColor = .orange
    colorScheme.primaryColor = .green
    alertScheme.colorScheme = colorScheme

    // When
    MDCAlertControllerThemer.applyScheme(alertScheme, to: alert)

    // Then
    XCTAssertEqual(alertScheme.colorScheme.onSurfaceColor, colorScheme.onSurfaceColor)
    XCTAssertEqual(alertView.titleColor,
                   alertScheme.colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertNotEqual(alertView.titleColor,
                   MDCSemanticColorScheme().onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(alertView.titleIconTintColor, colorScheme.primaryColor)
  }
    
  func testApplyingCustomTitleIconTintColor() {
    // Given
    let iconColor = UIColor.red
    let primaryColor = UIColor.green
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = primaryColor
    alertScheme.colorScheme = colorScheme

    // When
    MDCAlertControllerThemer.applyScheme(alertScheme, to: alert)
    alert.titleIconTintColor = iconColor

    // Then
    XCTAssertEqual(alert.buttonTitleColor, primaryColor)
    XCTAssertEqual(alertView.buttonColor, primaryColor)
    XCTAssertEqual(alertView.titleIconTintColor, iconColor)
  }

  func testApplyingAlertSchemeWithCustomTypography() {
    // Given
    let typographyScheme = MDCTypographyScheme()
    let testFont = UIFont.boldSystemFont(ofSize: 55.0)
    typographyScheme.headline6 = testFont
    alertScheme.typographyScheme = typographyScheme

    // When
    MDCAlertControllerThemer.applyScheme(alertScheme, to: alert)

    // Then
    XCTAssertEqual(alertScheme.typographyScheme.headline6, typographyScheme.headline6)
    XCTAssertEqual(alertView.titleFont, alertScheme.typographyScheme.headline6)
    XCTAssertNotEqual(alertView.titleFont, MDCTypographyScheme().headline6)
    XCTAssertEqual(alertView.titleFont, testFont)
  }

  func testApplyingAlertSchemeWithCustomShape() {
    // Given
    let cornerRadius: CGFloat = 33.3
    alertScheme.cornerRadius = cornerRadius

    // When
    MDCAlertControllerThemer.applyScheme(alertScheme, to: alert)

    // Then
    XCTAssertEqual(alertScheme.cornerRadius, cornerRadius, accuracy: 0.0)
    XCTAssertEqual(alertView.cornerRadius, cornerRadius, accuracy: 0.0)
    XCTAssertNotEqual(alertScheme.cornerRadius, defaultCornerRadius, accuracy: 0.0)
  }
}
