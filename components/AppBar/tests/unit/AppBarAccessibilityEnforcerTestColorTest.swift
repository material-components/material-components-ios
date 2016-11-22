/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
import MaterialComponents
import MDFTextAccessibility

// Tests confirming that the App Bar Accessibility Enforcer correctly changes title font color and
// tint color on App Bar's |navigationBar| to meet accepted accessibility values defined by
// MDFTextAccessibility

class AppBarAccessibilityEnforcerTestColorTest: XCTestCase {

  var appBar: MDCAppBar!
  var enforcer: MDCAppBarAccessibilityEnforcer!

  override func setUp() {
    super.setUp()
    appBar = MDCAppBar()
    enforcer = MDCAppBarAccessibilityEnforcer()
  }

  func testDarkNavigationBarBackground() {
    // Given
    appBar.navigationBar.backgroundColor = UIColor.blackColor()

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(),
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)

    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testLightNavigationBarBackground() {
    // Given
    appBar.navigationBar.backgroundColor = UIColor.whiteColor()

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(UIColor.whiteColor(),
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testDarkHeaderViewBackground() {
    // Given
    appBar.headerViewController.headerView.backgroundColor = UIColor.blackColor()

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(),
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testLightHeaderViewBackground() {
    // Given
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(UIColor.whiteColor(),
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testNoBackgroundColorSet() {
    // Given
    let defaultBackgroundColor = appBar.headerViewController.headerView.backgroundColor!

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(defaultBackgroundColor,
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

  func testConflictingHeaderViewNavigationBarBackgroundColors() {
    // Given
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    appBar.navigationBar.backgroundColor = UIColor.blackColor()

    // When
    enforcer.enforceFontColorAccessibility(appBar)

    // Then
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    let tintColor = appBar.navigationBar.tintColor
    let accessibleColor = MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(),
                                                                          targetTextAlpha: 1.0,
                                                                          font: nil)
    XCTAssertEqual(fontColor, accessibleColor)
    XCTAssertEqual(tintColor, accessibleColor)
  }

}
