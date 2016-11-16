//
//  AppBarAccessibilityEnforcerTestColorTest.swift
//  Pods
//
//  Created by Justin Shephard on 11/15/16.
//
//

import XCTest
import MaterialComponents

class AppBarAccessibilityEnforcerTestColorTest: XCTestCase {

  var appBar: MDCAppBar!
  var enforcer = MDCAppBarAccessibilityEnforcer!

  override func setUp() {
    super.setUp()
    appBar = MDCAppBar()
    enforcer = MDCAppBarAccessibilityEnforcer()
  }

  func testDarkNavigationBarBackground() {
    appBar.navigationBar.backgroundColor = UIColor.blackColor()
    enforcer.enforceAccessibility(appBar)
    let color = appBar.navigationBar.titleTextAttributes?.
    XCTAssertEqual(, <#T##expression2: T?##T?#>)
  }

  func testLightNavigationBarBackground() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testLightHeaderViewBackground() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testDarkHeaderViewBackground() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testNoBackgroundColorSet() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testConflightingHeaderViewNavigationBarBackgroundColors() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

}
