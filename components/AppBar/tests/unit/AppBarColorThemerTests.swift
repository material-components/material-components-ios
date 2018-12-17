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
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialThemes

class AppBarColorThemerTests: XCTestCase {

  func testSemanticColorThemerAffectsSubComponents() {
    // Given
    let appBar = MDCAppBar()
    appBar.headerViewController.headerView.backgroundColor = .red
    appBar.navigationBar.backgroundColor = .blue
    appBar.navigationBar.titleTextColor = .green;
    appBar.navigationBar.tintColor = .orange;
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = .purple
    colorScheme.onPrimaryColor = .lightGray

    // When
    MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)

    // Then
    XCTAssertEqual(appBar.headerViewController.headerView.backgroundColor,
                   colorScheme.primaryColor)
    XCTAssertEqual(appBar.navigationBar.backgroundColor, colorScheme.primaryColor)
    XCTAssertEqual(appBar.navigationBar.titleTextColor, colorScheme.onPrimaryColor)
    XCTAssertEqual(appBar.navigationBar.tintColor, colorScheme.onPrimaryColor)
  }

  func testSurfaceVariantColorThemerAffectsSubComponents() {
    // Given
    let appBar = MDCAppBar()
    appBar.headerViewController.headerView.backgroundColor = .red
    appBar.navigationBar.backgroundColor = .blue
    appBar.navigationBar.titleTextColor = .green;
    appBar.navigationBar.tintColor = .orange;
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.surfaceColor = .purple
    colorScheme.onSurfaceColor = .lightGray

    // When
    MDCAppBarColorThemer.applySurfaceVariant(withColorScheme: colorScheme, to: appBar)

    // Then
    XCTAssertEqual(appBar.headerViewController.headerView.backgroundColor,
                   colorScheme.surfaceColor)
    XCTAssertEqual(appBar.navigationBar.backgroundColor, colorScheme.surfaceColor)
    XCTAssertEqual(appBar.navigationBar.titleTextColor,
                   colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(appBar.navigationBar.buttonsTitleColor(for: .normal),
                   colorScheme.onSurfaceColor.withAlphaComponent(0.87))
    XCTAssertEqual(appBar.navigationBar.tintColor,
                   colorScheme.onSurfaceColor.withAlphaComponent(0.54))
  }

  func testColorThemerAffectsSubComponents() {
    // Given
    let appBar = MDCAppBar()
    let colorScheme = MDCBasicColorScheme(primaryColor: .red)

    // When
    MDCAppBarColorThemer.apply(colorScheme, to: appBar)

    // Then
    XCTAssertEqual(appBar.headerViewController.headerView.backgroundColor,
                   colorScheme.primaryColor)
    XCTAssertEqual(appBar.navigationBar.backgroundColor,
                   colorScheme.primaryColor)
  }
}
