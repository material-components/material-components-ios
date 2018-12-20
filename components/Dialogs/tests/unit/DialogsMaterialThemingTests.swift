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
import MaterialComponentsBeta.MaterialContainerScheme
import MaterialComponentsBeta.MaterialDialogs_Theming

class DialogsMaterialThemingTests: XCTestCase {

  let kCornerRadius: CGFloat = 4;

  func testAlertThemingWithContainerScheme() {
    let alert: MDCAlertController = MDCAlertController(title: "Title", message: "Message")
    let scheme: MDCContainerScheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme()
    let typographyScheme = MDCTypographyScheme()

    let action1: MDCAlertAction = MDCAlertAction(title: "", emphasis: .low)
    alert.addAction(action1)
    let action2: MDCAlertAction = MDCAlertAction(title: "", emphasis: .medium)
    alert.addAction(action2)
    let action3: MDCAlertAction = MDCAlertAction(title: "", emphasis: .high)
    alert.addAction(action3)

    alert.applyTheme(withScheme: scheme)

    // Color
    XCTAssertEqual(alert.titleColor, colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(alert.messageColor, colorScheme.onSurfaceColor.withAlphaComponent(0.60))
    XCTAssertEqual(alert.titleIconTintColor, colorScheme.primaryColor)
    XCTAssertEqual(alert.scrimColor, colorScheme.onSurfaceColor.withAlphaComponent(0.32))
    XCTAssertEqual(alert.backgroundColor, colorScheme.surfaceColor);

    // Typography
    XCTAssertEqual(alert.titleFont, typographyScheme.headline6)
    XCTAssertEqual(alert.messageFont, typographyScheme.body1)

    // Other properties
    XCTAssertEqual(alert.cornerRadius, kCornerRadius, accuracy: 0.001)
    XCTAssertEqual(alert.elevation, ShadowElevation.dialog)

    for action in alert.actions {
      guard let button = alert.button(for: action),
        let colorScheme = scheme.colorScheme
        else { continue }
      switch action.emphasis {
      case .low:
        XCTAssertEqual(button.backgroundColor(for: .normal), .clear)
        XCTAssertEqual(button.borderColor(for: .normal), nil)
        XCTAssertEqual(button.inkColor, colorScheme.primaryColor.withAlphaComponent(0.16))
        XCTAssertEqual(button.titleColor(for: [.normal, .highlighted]), colorScheme.primaryColor)
        XCTAssertEqual(button.titleColor(for: .disabled),
                       colorScheme.onSurfaceColor.withAlphaComponent(0.38))
        [.normal, .highlighted].forEach {
          XCTAssertEqual(button.imageTintColor(for: $0), colorScheme.primaryColor)
        }
        XCTAssertEqual(button.imageTintColor(for: .disabled),
                       colorScheme.onSurfaceColor.withAlphaComponent(0.38))

        // Test typography
        XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)

        // Test shape
        XCTAssertEqual(button.layer.cornerRadius, 4.0, accuracy: 0.001)

        // Test remaining properties
        [.normal, .highlighted, .selected, .disabled].forEach {
          XCTAssertEqual(button.elevation(for: $0), ShadowElevation.none)
        }
        XCTAssertEqual(button.minimumSize.height, 36.0, accuracy: 0.001)
      case .medium:
        XCTAssertEqual(button.backgroundColor(for: .normal), .clear)
        XCTAssertEqual(button.titleColor(for: .normal), colorScheme.primaryColor)
        XCTAssertEqual(button.titleColor(for: .disabled), colorScheme.onSurfaceColor.withAlphaComponent(0.38))
        XCTAssertEqual(button.disabledAlpha,1)
        XCTAssertEqual(button.inkColor,colorScheme.primaryColor.withAlphaComponent(0.16))
        XCTAssertEqual(button.borderColor(for: .normal), colorScheme.onSurfaceColor.withAlphaComponent(0.12))
        // Test shape
        XCTAssertEqual(button.layer.cornerRadius, kCornerRadius, accuracy: 0.001)
        // Test typography
        XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
        // Test remaining properties
        XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
        XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
        XCTAssertEqual(button.borderWidth(for: .normal), 1, accuracy: 0.001)
        XCTAssertEqual(button.borderWidth(for: .selected), 1, accuracy: 0.001)
        XCTAssertEqual(button.borderWidth(for: .highlighted), 1, accuracy: 0.001)
        XCTAssertEqual(button.borderWidth(for: .disabled), 1, accuracy: 0.001)
      case .high:
        XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.primaryColor)
        XCTAssertEqual(
          button.backgroundColor(for: .disabled),
          colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledBackgroundOpacity))
        XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onPrimaryColor)
        XCTAssertEqual(
          button.titleColor(for: .disabled),
          colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
        XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onPrimaryColor)
        XCTAssertEqual(
          button.imageTintColor(for: .disabled),
          colorScheme.onSurfaceColor.withAlphaComponent(ButtonsThemingTest.disabledOpacity))
        XCTAssertEqual(button.inkColor,
                       colorScheme.onPrimaryColor.withAlphaComponent(ButtonsThemingTest.inkOpacity))
        // Test shape
        XCTAssertEqual(button.layer.cornerRadius, kCornerRadius, accuracy: 0.001)
        // Test typography
        XCTAssertEqual(button.titleFont(for: .normal), typographyScheme.button)
        // Test remaining properties
        XCTAssertEqual(button.elevation(for: .normal), ShadowElevation.raisedButtonResting)
        XCTAssertEqual(button.elevation(for: .highlighted), ShadowElevation.raisedButtonPressed)
        XCTAssertEqual(button.elevation(for: .disabled), ShadowElevation.none)
        XCTAssertEqual(button.minimumSize.width, 0, accuracy: 0.001)
        XCTAssertEqual(button.minimumSize.height, 36, accuracy: 0.001)
      }
    }
  }

  func testAlertThemingWithCustomColorScheme() {
    // Given
    let alert: MDCAlertController = MDCAlertController(title: "Title", message: "Message")
    let action = MDCAlertAction(title: "", emphasis: .high)
    alert.addAction(action)

    let alertView = alert.view as! MDCAlertControllerView
    let button = alert.button(for: action)!
    let presentationController = alert.mdc_dialogPresentationController!

    let scheme: MDCContainerScheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.surfaceColor = .black
    colorScheme.onSurfaceColor = .orange
    colorScheme.primaryColor = .green
    colorScheme.onPrimaryColor = .yellow
    scheme.colorScheme = colorScheme

    // When
    alert.applyTheme(withScheme: scheme)

    // Then
    XCTAssertEqual(alertView.backgroundColor, colorScheme.surfaceColor);

    XCTAssertEqual(alertView.titleColor, colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(alertView.messageColor, colorScheme.onSurfaceColor.withAlphaComponent(0.60))
    XCTAssertEqual(presentationController.scrimColor,
                   colorScheme.onSurfaceColor.withAlphaComponent(0.32))

    XCTAssertEqual(alertView.titleIconTintColor, colorScheme.primaryColor)
    XCTAssertEqual(button.backgroundColor(for: .normal), colorScheme.primaryColor)

    XCTAssertEqual(button.titleColor(for: .normal), colorScheme.onPrimaryColor)
    XCTAssertEqual(button.inkColor,
                   colorScheme.onPrimaryColor.withAlphaComponent(ButtonsThemingTest.inkOpacity))
    XCTAssertEqual(button.imageTintColor(for: .normal), colorScheme.onPrimaryColor)
  }
}
