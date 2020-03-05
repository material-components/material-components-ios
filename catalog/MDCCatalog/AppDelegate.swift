// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

import UIKit

import CatalogByConvention
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialAppBar_TypographyThemer
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialIcons_ic_more_horiz

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MDCAppBarNavigationControllerDelegate {

  private static let performPostLaunchSelector = "performPostLaunchSelector"

  var window: UIWindow?

  let navigationController = MDCAppBarNavigationController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)

    // The navigation tree will only take examples that implement
    // and return YES to catalogIsPresentable.
    let tree = CBCCreatePresentableNavigationTree()

    navigationController.delegate = self

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    navigationController.pushViewController(rootNodeViewController, animated: false)

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)

    if self.responds(to: Selector((AppDelegate.performPostLaunchSelector))) {
      self.perform(Selector((AppDelegate.performPostLaunchSelector)))
    }

    return true
  }

  @objc func themeDidChange(notification: NSNotification) {
    let colorScheme = AppTheme.containerScheme.colorScheme
    for viewController in navigationController.children {
      guard let appBar = navigationController.appBar(for: viewController) else {
        continue
      }

      MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)
    }
  }

  // MARK: MDCAppBarNavigationControllerInjectorDelegate

  func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                  willAdd appBarViewController: MDCAppBarViewController,
                                  asChildOf viewController: UIViewController) {
    MDCAppBarColorThemer.applyColorScheme(AppTheme.containerScheme.colorScheme,
                                                        to: appBarViewController)
    MDCAppBarTypographyThemer.applyTypographyScheme(AppTheme.containerScheme.typographyScheme,
                                                    to: appBarViewController)

    if let injectee = viewController as? CatalogAppBarInjectee {
      injectee.appBarNavigationControllerInjector(willAdd: appBarViewController)
    }
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

protocol CatalogAppBarInjectee {
  func appBarNavigationControllerInjector(willAdd appBarViewController: MDCAppBarViewController)
}

extension UINavigationController {
  @objc func presentMenu() {
    let menuViewController = MDCMenuViewController(style: .plain)
    let bottomSheet = MDCBottomSheetController(contentViewController: menuViewController)
    self.present(bottomSheet, animated: true, completion: nil)
  }

  func setMenuBarButton(for viewController: UIViewController) {
    let dotsImage = MDCIcons.imageFor_ic_more_horiz()?.withRenderingMode(.alwaysTemplate)
    let menuItem = UIBarButtonItem(image: dotsImage,
                                   style: .plain,
                                   target: self,
                                   action: #selector(presentMenu))
    menuItem.accessibilityLabel = "Menu"
    menuItem.accessibilityHint = "Opens catalog configuration options."
    viewController.navigationItem.rightBarButtonItem = menuItem
  }
}
