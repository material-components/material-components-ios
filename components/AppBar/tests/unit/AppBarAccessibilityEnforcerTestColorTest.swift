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

class AppBarAccessibilityEnforcerTestColorTest: XCTestCase {

  var appBar: MDCAppBar!
  var enforcer: MDCAppBarAccessibilityEnforcer!

  override func setUp() {
    super.setUp()
    appBar = MDCAppBar()
    enforcer = MDCAppBarAccessibilityEnforcer()
  }

  func testDarkNavigationBarBackground() {
    appBar.navigationBar.backgroundColor = UIColor.blackColor()
    enforcer.enforceFontColorAccessibility(appBar)
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testLightNavigationBarBackground() {
    appBar.navigationBar.backgroundColor = UIColor.whiteColor()
    enforcer.enforceFontColorAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.whiteColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testDarkHeaderViewBackground() {
    appBar.headerViewController.headerView.backgroundColor = UIColor.blackColor()
    enforcer.enforceFontColorAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testLightHeaderViewBackground() {
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    enforcer.enforceFontColorAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.whiteColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testNoBackgroundColorSet() {

  }

  func testConflightingHeaderViewNavigationBarBackgroundColors() {
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    appBar.navigationBar.backgroundColor = UIColor.blackColor()
    enforcer.enforceFontColorAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

}
