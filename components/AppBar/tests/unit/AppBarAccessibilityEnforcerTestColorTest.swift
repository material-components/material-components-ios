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
    appBar.navigationBar.backgroundColor = UIColor.whiteColor()
    enforcer.enforceAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.whiteColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testDarkHeaderViewBackground() {
    appBar.headerViewController.headerView.backgroundColor = UIColor.blackColor()
    enforcer.enforceAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

  func testLightHeaderViewBackground() {
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    enforcer.enforceAccessibility(appBar)
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
    enforcer.enforceAccessibility(appBar)
    let fontColor =
      appBar.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
    XCTAssertEqual(fontColor,
                   MDFTextAccessibility.textColorOnBackgroundColor(UIColor.blackColor(), targetTextAlpha: 1.0, font: nil))
  }

}
