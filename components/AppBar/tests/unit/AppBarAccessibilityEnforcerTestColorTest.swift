//
//  AppBarAccessibilityEnforcerTestColorTest.swift
//  Pods
//
//  Created by Justin Shephard on 11/15/16.
//
//

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
    enforcer.enforceAccessibility(appBar)
    let fontColor =
        appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testLightNavigationBarBackground() {

  }

  func testLightHeaderViewBackground() {

  }

  func testDarkHeaderViewBackground() {

  }

  func testNoBackgroundColorSet() {

  }

  func testConflightingHeaderViewNavigationBarBackgroundColors() {

  }

}
