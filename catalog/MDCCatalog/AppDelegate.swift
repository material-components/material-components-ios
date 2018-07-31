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
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialIcons_ic_more_horiz

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MDCAppBarNavigationControllerDelegate {

  var window: UIWindow?

  let navigationController = MDCAppBarNavigationController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)

    // The navigation tree will only take examples that implement
    // and return YES to catalogIsPresentable.
    let tree = CBCCreatePresentableNavigationTree()

    navigationController.delegate = self

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    navigationController.pushViewController(rootNodeViewController, animated: false)

    // In the event that an example view controller hides the navigation bar we generally want to
    // ensure that the edge-swipe pop gesture can still take effect. This may be overly-assumptive
    // but we'll explore other alternatives when we have a concrete example of this approach causing
    // problems.
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)

    return true
  }

  func themeDidChange(notification: NSNotification) {
    guard let colorScheme = notification.userInfo?[AppTheme.globalThemeNotificationColorSchemeKey]
      as? MDCColorScheming else {
        return
    }
    for viewController in navigationController.childViewControllers {
      guard let appBar = navigationController.appBar(for: viewController) else {
        continue
      }

      MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)
    }
  }

  // MARK: MDCAppBarNavigationControllerInjectorDelegate

  func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                  willAdd appBar: MDCAppBar,
                                  asChildOf viewController: UIViewController) {
    MDCAppBarColorThemer.applySemanticColorScheme(AppTheme.globalTheme.colorScheme, to: appBar)
    MDCAppBarTypographyThemer.applyTypographyScheme(AppTheme.globalTheme.typographyScheme,
                                                    to: appBar)

    if let injectee = viewController as? CatalogAppBarInjectee {
      injectee.appBarNavigationControllerInjector(willAdd: appBar)
    }
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

protocol CatalogAppBarInjectee {
  func appBarNavigationControllerInjector(willAdd appBar: MDCAppBar)
}

extension UINavigationController {
  func presentMenu() {
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
