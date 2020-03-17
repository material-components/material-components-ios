// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

// MDCAppBarViewController implements default behavior for accessibilityPerformEscape when it is
// a descendant of a UINavigationController. These tests verify when this behavior does and does not
// take effect.
class AppBarNavigationControllerAccessibilityPerformEscapeTests: XCTestCase {

  var appBarViewController: MDCAppBarViewController!

  override func setUp() {
    super.setUp()

    appBarViewController = MDCAppBarViewController()
  }

  override func tearDown() {
    appBarViewController = nil

    super.tearDown()
  }

  // MARK: UINavigationController [ MDCAppBarViewController ]

  func testInitializedWithAppBarViewController() {
    // Given
    let navigationController = UINavigationController(rootViewController: appBarViewController)

    // Then
    XCTAssertEqual(navigationController.children.count, 1)
  }

  func testDoesNotPopWhenTheAppBarIsTheRootViewController() {
    // Given
    let navigationController = UINavigationController(rootViewController: appBarViewController)

    // When
    appBarViewController.accessibilityPerformEscape()

    // THen
    XCTAssertEqual(navigationController.children.count, 1)
  }

  // MARK: UINavigationController [ UIViewController, MDCAppBarViewController ]

  func testPushedWithAppBarViewController() {
    // Given
    let navigationController = UINavigationController(rootViewController: UIViewController())

    // When
    navigationController.pushViewController(appBarViewController, animated: false)

    // Then
    XCTAssertEqual(navigationController.children.count, 2)
  }

  // Note that this behavior may appear at first glance to be surprising, but
  // MDCAppBarViewController is not designed to be pushed directly onto a UINavigationController;
  // it's supposed to be added to another view controller as a child, and that child is then to be
  // pushed onto a navigation controller.
  func testDoesNotPopWhenTheAppBarIsPushed() {
    // Given
    let navigationController = UINavigationController(rootViewController: UIViewController())
    navigationController.pushViewController(appBarViewController, animated: false)

    // When
    appBarViewController.accessibilityPerformEscape()

    // Then
    XCTAssertEqual(navigationController.children.count, 2)
  }

  // MARK: UINavigationController [ UIViewController [ MDCAppBarViewController ] ]

  func testInitializedWithAppBarViewControllerAsChildOfViewController() {
    // Given
    let viewController = UIViewController()
    viewController.addChild(appBarViewController)
    viewController.view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: viewController)

    // When
    let navigationController = UINavigationController(rootViewController: viewController)

    // Then
    XCTAssertEqual(navigationController.children.count, 1)
  }

  // This may also be surprising but the default behavior of the MDCAppBarViewController is to
  // not dismiss itself if it detects that it is a child of the root view controller.
  func testDoesNotPopWhenTheAppBarIsAChildOfTheRootViewController() {
    // Given
    let viewController = UIViewController()
    viewController.addChild(appBarViewController)
    viewController.view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: viewController)
    let navigationController = UINavigationController(rootViewController: viewController)

    // When
    appBarViewController.accessibilityPerformEscape()

    // THen
    XCTAssertEqual(navigationController.children.count, 1)
  }

  // MARK: UINavigationController [ UIViewController, UIViewController [ MDCAppBarViewController ] ]

  func testPushedWithAppBarViewControllerAsChildOfViewController() {
    // Given
    let navigationController = UINavigationController(rootViewController: UIViewController())

    // When
    let viewController = UIViewController()
    viewController.addChild(appBarViewController)
    viewController.view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: viewController)
    navigationController.pushViewController(viewController, animated: false)

    // Then
    XCTAssertEqual(navigationController.children.count, 2)
  }

  func testDoesPopWhenTheAppBarIsAChildOfAPushedViewController() {
    // Given
    let viewController = UIViewController()
    viewController.addChild(appBarViewController)
    viewController.view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: viewController)
    let navigationController = UINavigationController(rootViewController: viewController)

    // When
    appBarViewController.accessibilityPerformEscape()

    // THen
    XCTAssertEqual(navigationController.children.count, 1)
  }
}
