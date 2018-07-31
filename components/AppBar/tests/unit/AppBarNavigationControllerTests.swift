/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
import MaterialComponents.MaterialAppBar

class AppBarNavigationControllerTests: XCTestCase {

  var navigationController: MDCAppBarNavigationController!
  override func setUp() {
    super.setUp()

    navigationController = MDCAppBarNavigationController()
  }

  func testPushingAViewControllerInjectsAnAppBar() {
    // Given
    let viewController = UIViewController()

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    XCTAssertEqual(viewController.childViewControllers.count, 1,
                   "Expected there to be exactly one child view controller added to the view"
                    + " controller.")

    XCTAssertEqual(navigationController.topViewController, viewController,
                   "The navigation controller's top view controller is supposed to be the pushed"
                    + " view controller, but it is \(viewController).")

    XCTAssertTrue(viewController.childViewControllers.first is MDCFlexibleHeaderViewController,
                  "The injected view controller is not a flexible header view controller, it is"
                    + "\(String(describing: viewController.childViewControllers.first)) instead.")

    if let headerViewController
        = viewController.childViewControllers.first as? MDCFlexibleHeaderViewController {
      XCTAssertEqual(headerViewController.headerView.frame.height,
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
    XCTAssertEqual(container.childViewControllers.count, 2,
                   "An App Bar container view controller should have exactly two child view"
                    + " controllers. A failure of this assertion implies that the navigation"
                    + " controller may have injected another App Bar.")
  }

  func testPushingAViewControllerWithAFlexibleHeaderDoesNotInjectAnAppBar() {
    // Given
    let viewController = UIViewController()
    let fhvc = MDCFlexibleHeaderViewController()
    viewController.addChildViewController(fhvc)
    viewController.view.addSubview(fhvc.view)
    fhvc.didMove(toParentViewController: viewController)

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    XCTAssertEqual(viewController.childViewControllers.count, 1,
                   "The navigation controller may have injected another App Bar when it shouldn't"
                    + " have.")
  }

  func testStatusBarStyleIsFetchedFromFlexibleHeaderViewController() {
    // Given
    let viewController = UIViewController()

    // When
    navigationController.pushViewController(viewController, animated: false)

    // Then
    let appBar = navigationController.appBar(for: viewController)

    XCTAssertNotNil(appBar, "Could not retrieve the injected App Bar.")

    if let appBar = appBar {
      XCTAssertEqual(navigationController.childViewControllerForStatusBarStyle,
                     appBar.headerViewController,
                     "The navigation controller should be using the injected app bar's flexible"
                      + "header view controller for status bar style updates.")
    }
  }
}


