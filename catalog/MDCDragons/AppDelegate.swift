/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit
import CatalogByConvention

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var splitViewController: UISplitViewController?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.statusBarStyle = .lightContent

    let componentsRoot = CBCCreateNavigationTree()
    let rootNodeViewController: UIViewController
    /**
     To have your example show up as the initial view controller, you need it to implement
     the method `@objc class func catalogIsDebug() -> Bool` and have it return true.
     That way it will become the debugLeaf and be presented first.
     */
    if let debugLeaf = componentsRoot.debugLeaf {
      rootNodeViewController = debugLeaf.createExampleViewController()
    } else {
      rootNodeViewController = MDCDragonsController(node: componentsRoot)
    }
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController
    navigationController.tabBarItem.title = "Components"

    /**
     The app should implement a split view controller as the root view controller unless the target device
     is an iPhone, in which case the root VC should be a navigation controller .
     */
    if UIDevice.current.userInterfaceIdiom == .phone {
      self.window?.rootViewController = navigationController
      self.window?.makeKeyAndVisible()
    } else {
      splitViewController = AppDelegate.makeSplitViewExamplesHierarchy(
        navigationController: navigationController)
      splitViewController?.delegate = self
      self.window?.rootViewController = splitViewController
      self.window?.makeKeyAndVisible()
    }
    return true
  }

  public static func makeSplitViewExamplesHierarchy(navigationController: UINavigationController)
    -> UISplitViewController
  {
    let splitViewController = UISplitViewController()
    splitViewController.minimumPrimaryColumnWidth = 250
    splitViewController.maximumPrimaryColumnWidth = 250

    let initialDetailVC = InitialSecondaryViewController()
    initialDetailVC.navigationItem.setLeftBarButton(
      splitViewController.displayModeButtonItem, animated: false)
    initialDetailVC.navigationItem.leftItemsSupplementBackButton = true

    splitViewController.preferredDisplayMode = .automatic
    splitViewController.viewControllers = [
      navigationController,
      UINavigationController(rootViewController: initialDetailVC),
    ]
    installKeyCommands(splitViewController: splitViewController)
    return splitViewController
  }

  static func installKeyCommands(splitViewController: UISplitViewController) {
    let sidebarCommand =
      UIKeyCommand(
        input: "l",
        modifierFlags: [.command, .shift],
        action: #selector(splitViewController.toggleSideBarView))
    sidebarCommand.discoverabilityTitle = "Show Sidebar"
    splitViewController.addKeyCommand(sidebarCommand)
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

/// Implements UISplitViewControllerDelegate  to have the secondary view controller
/// become the main view controller in compact environments.
extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(
    _ splitViewController: UISplitViewController,
    collapseSecondary secondaryViewController: UIViewController,
    onto primaryViewController: UIViewController
  ) -> Bool {
    return true
  }
}

/// Initial view controller to be set in an iPad environment as the secondary view controller.
class InitialSecondaryViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    splitViewController?.toggleSideBarView()
  }
}

/// Extend UISplitViewController to support toggling the sidebar to appear or hide when needed.
extension UISplitViewController {
  @objc func toggleSideBarView() {
    let barButtonItem = displayModeButtonItem
    if let action = barButtonItem.action {
      UIApplication.shared.sendAction(action, to: barButtonItem.target, from: nil, for: nil)
    }
  }
}
