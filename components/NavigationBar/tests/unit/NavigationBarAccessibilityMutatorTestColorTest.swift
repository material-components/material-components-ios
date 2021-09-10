// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialNavigationBar
import MDFTextAccessibility

// Tests confirming that the Navigation Bar Accessibility Mutator correctly changes title font
// color and tint color to meet accepted accessibility values defined by MDFTextAccessibility

class NavigationBarAccessibilityMutatorTestColorTest: XCTestCase {

  var navBar: MDCNavigationBar!
  var mutator: MDCNavigationBarTextColorAccessibilityMutator!

  override func setUp() {
    super.setUp()
    navBar = MDCNavigationBar()
    mutator = MDCNavigationBarTextColorAccessibilityMutator()
  }

  override func tearDown() {
    navBar = nil
    mutator = nil

    super.tearDown()
  }

  func testDarkNavigationBarBackground() {
    // Given
    navBar.backgroundColor = UIColor.black

    // When
    mutator.mutate(navBar)

    // Then
    let fontColor = navBar.titleTextAttributes![NSAttributedString.Key.foregroundColor] as! UIColor
    let tintColor = navBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColor(
      onBackgroundColor: UIColor.black,
      targetTextAlpha: 1.0,
      font: nil)

    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testLightNavigationBarBackground() {
    // Given
    navBar.backgroundColor = UIColor.white

    // When
    mutator.mutate(navBar)

    // Then
    let fontColor = navBar.titleTextAttributes![NSAttributedString.Key.foregroundColor] as! UIColor
    let tintColor = navBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColor(
      onBackgroundColor: UIColor.white,
      targetTextAlpha: 1.0,
      font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testNoBackgroundColor() {
    // Given no background color set
    let fontColorBefore =
      navBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor]
      as? UIColor
    let tintColorBefore = navBar.tintColor

    // When
    mutator.mutate(navBar)

    // Then
    let fontColorAfter =
      navBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor]
      as? UIColor
    let tintColorAfter = navBar.tintColor
    XCTAssertEqual(fontColorBefore, fontColorAfter)
    XCTAssertEqual(tintColorBefore, tintColorAfter)

  }

}
