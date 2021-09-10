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

private class MockAppBarNavigationControllerDelegate:
  NSObject, MDCAppBarNavigationControllerDelegate
{
  var trackingScrollView: UIScrollView?
  func appBarNavigationController(
    _ navigationController: MDCAppBarNavigationController,
    trackingScrollViewFor trackingScrollViewForViewController: UIViewController,
    suggestedTrackingScrollView: UIScrollView?
  ) -> UIScrollView? {
    return trackingScrollView
  }
}

class AppBarNavigationControllerTests: XCTestCase {

  var navigationController: MDCAppBarNavigationController!
  override func setUp() {
    super.setUp()

    navigationController = MDCAppBarNavigationController()
  }

  override func tearDown() {
    navigationController = nil

    super.tearDown()
  }
  // MARK: -  AppBar injection

  func testInitializingWithRootViewControllerInjectsAnAppBar() {
    // Given
    let viewController = UIViewController()

    // When
    let navigationController = MDCAppBarNavigationController(rootViewController: viewController)

    // Then
    XCTAssertEqual(
      viewController.children.count, 1,
      "Expected there to be exactly one child view controller added to the view"
        + " controller.")

    XCTAssertEqual(
      navigationController.topViewController, viewController,
      "The navigation controller's top view controller is supposed to be the pushed"
        + " view controller, but it is \(viewController).")

    XCTAssertTrue(
      viewController.children.first is MDCFlexibleHeaderViewController,
      "The injected view controller is not a flexible header view controller, it is"
        + "\(String(describing: viewController.children.first)) instead.")

    if let headerViewController = viewController.children.first as? MDCFlexibleHeaderViewController
    {
      XCTAssertEqual(
        headerViewController.headerView.frame.height,
        headerViewController.headerView.maximumHeight)
    }
  }

  func testPushingAViewControllerInjectsAnAppBar() {
    // Given
    let viewController = UIViewController()

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    XCTAssertEqual(
      viewController.children.count, 1,
      "Expected there to be exactly one child view controller added to the view"
        + " controller.")

    XCTAssertEqual(
      navigationController.topViewController, viewController,
      "The navigation controller's top view controller is supposed to be the pushed"
        + " view controller, but it is \(viewController).")

    XCTAssertTrue(
      viewController.children.first is MDCFlexibleHeaderViewController,
      "The injected view controller is not a flexible header view controller, it is"
        + "\(String(describing: viewController.children.first)) instead.")

    if let headerViewController = viewController.children.first as? MDCFlexibleHeaderViewController
    {
      XCTAssertEqual(
        headerViewController.headerView.frame.height,
        headerViewController.headerView.maximumHeight)
    }
  }

  func testPushingAnAppBarContainerViewControllerDoesNotInjectAnAppBar() {
    // Given
    let viewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: viewController)

    // When
    navigationController.pushViewController(container, animated: false)

    // Then
    XCTAssertEqual(
      container.children.count, 2,
      "An App Bar container view controller should have exactly two child view"
        + " controllers. A failure of this assertion implies that the navigation"
        + " controller may have injected another App Bar.")
  }

  func testPushingAContainedAppBarContainerViewControllerDoesNotInjectAnAppBar() {
    // Given
    let viewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: viewController)
    let nestedContainer = UIViewController()
    nestedContainer.addChild(container)
    nestedContainer.view.addSubview(container.view)
    container.didMove(toParent: nestedContainer)

    // When
    navigationController.pushViewController(nestedContainer, animated: false)

    // Then
    XCTAssertEqual(
      nestedContainer.children.count, 1,
      "The view controller hierarchy already has one app bar view controller, but it"
        + " appears to have possibly added another.")
  }

  func testPushingAViewControllerWithAFlexibleHeaderDoesNotInjectAnAppBar() {
    // Given
    let viewController = UIViewController()
    let fhvc = MDCFlexibleHeaderViewController()
    viewController.addChild(fhvc)
    viewController.view.addSubview(fhvc.view)
    fhvc.didMove(toParent: viewController)

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    XCTAssertEqual(
      viewController.children.count, 1,
      "The navigation controller may have injected another App Bar when it shouldn't"
        + " have.")
  }

  // MARK: - traitCollectionDidChangeBlock support

  func testInitializingWithRootViewControllerDoesNotSetTraitCollectionDidChangeBlock() {
    // Given
    let viewController = UIViewController()

    // When
    let _ = MDCAppBarNavigationController(rootViewController: viewController)

    // Then
    let injectedAppBarViewController = viewController.children.first as! MDCAppBarViewController
    XCTAssertNotNil(injectedAppBarViewController)
    XCTAssertNil(injectedAppBarViewController.traitCollectionDidChangeBlock)
  }

  func testPushingAViewControllerAssignsTraitCollectionDidChangeBlock() {
    // Given
    let viewController = UIViewController()
    let block: ((MDCFlexibleHeaderViewController, UITraitCollection?) -> Void)? = { _, _ in }
    navigationController.traitCollectionDidChangeBlockForAppBarController = block

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    let injectedAppBarViewController = viewController.children.first as! MDCAppBarViewController
    XCTAssertNotNil(injectedAppBarViewController)
    XCTAssertNotNil(injectedAppBarViewController.traitCollectionDidChangeBlock)
  }

  func testPushingAnAppBarContainerViewControllerDoesNotAssignTraitCollectionDidChangeBlock() {
    // Given
    let viewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: viewController)
    var blockSemaphore = false
    let block: ((MDCFlexibleHeaderViewController, UITraitCollection?) -> Void)? =
      { _, _ in
        blockSemaphore = true
      }
    container.appBarViewController.traitCollectionDidChangeBlock = block

    // When
    navigationController.pushViewController(container, animated: false)
    container.appBarViewController.traitCollectionDidChange(nil)

    // Then
    XCTAssertTrue(blockSemaphore)
  }

  func
    testPushingAContainedAppBarContainerViewControllerDoesNotAssignTraitCollectionDidChangeBlock()
  {
    // Given
    let viewController = UIViewController()
    let container = MDCAppBarContainerViewController(contentViewController: viewController)
    let nestedContainer = UIViewController()
    nestedContainer.addChild(container)
    nestedContainer.view.addSubview(container.view)
    container.didMove(toParent: nestedContainer)
    var blockSemaphore = false
    let block: ((MDCFlexibleHeaderViewController, UITraitCollection?) -> Void)? =
      { _, _ in
        blockSemaphore = true
      }
    container.appBarViewController.traitCollectionDidChangeBlock = block

    // When
    navigationController.pushViewController(nestedContainer, animated: false)
    container.appBarViewController.traitCollectionDidChange(nil)

    // Then
    XCTAssertTrue(blockSemaphore)
  }

  // MARK: - The rest

  func testStatusBarStyleIsFetchedFromFlexibleHeaderViewController() {
    // Given
    let viewController = UIViewController()

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    let appBar = navigationController.appBar(for: viewController)

    XCTAssertNotNil(appBar, "Could not retrieve the injected App Bar.")

    if let appBar = appBar {
      XCTAssertEqual(
        navigationController.childForStatusBarStyle,
        appBar.headerViewController,
        "The navigation controller should be using the injected app bar's flexible"
          + "header view controller for status bar style updates.")
    }
  }

  func testInfersFirstTrackingScrollViewByDefault() {
    // Given
    let viewController = UIViewController()
    let scrollView1 = UIScrollView()
    viewController.view.addSubview(scrollView1)
    let scrollView2 = UIScrollView()
    viewController.view.addSubview(scrollView2)

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    guard let appBarViewController = navigationController.appBarViewController(for: viewController)
    else {
      XCTFail("No app bar view controller found.")
      return
    }
    XCTAssertEqual(appBarViewController.headerView.trackingScrollView, scrollView1)
  }

  func testDelegateCanReturnNilTrackingScrollView() {
    // Given
    let viewController = UIViewController()
    let scrollView1 = UIScrollView()
    viewController.view.addSubview(scrollView1)
    let scrollView2 = UIScrollView()
    viewController.view.addSubview(scrollView2)
    let delegate = MockAppBarNavigationControllerDelegate()
    navigationController.delegate = delegate

    // When
    delegate.trackingScrollView = nil
    navigationController.pushViewController(viewController, animated: false)

    // Then
    guard let appBarViewController = navigationController.appBarViewController(for: viewController)
    else {
      XCTFail("No app bar view controller found.")
      return
    }
    XCTAssertNil(appBarViewController.headerView.trackingScrollView)
  }

  func testDelegateCanPickDifferentTrackingScrollView() {
    // Given
    let viewController = UIViewController()
    let scrollView1 = UIScrollView()
    viewController.view.addSubview(scrollView1)
    let scrollView2 = UIScrollView()
    viewController.view.addSubview(scrollView2)
    let delegate = MockAppBarNavigationControllerDelegate()
    navigationController.delegate = delegate

    // When
    delegate.trackingScrollView = scrollView2
    navigationController.pushViewController(viewController, animated: false)

    // Then
    guard let appBarViewController = navigationController.appBarViewController(for: viewController)
    else {
      XCTFail("No app bar view controller found.")
      return
    }
    XCTAssertEqual(appBarViewController.headerView.trackingScrollView, scrollView2)
  }
}
