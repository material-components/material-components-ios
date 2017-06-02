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
import MaterialComponents

@UIApplicationMain
class MDCAppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var colorScheme: MDCBasicColorScheme?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)

    let tree = CBCCreateNavigationTree()

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)

    // In the event that an example view controller hides the navigation bar we generally want to
    // ensure that the edge-swipe pop gesture can still take effect. This may be overly-assumptive
    // but we'll explore other alternatives when we have a concrete example of this approach causing
    // problems.
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    colorScheme = MDCBasicColorScheme(primaryColor: UIColor.init(white: 0.2, alpha: 1),
                                      primaryLightColor: .init(white: 0.7, alpha: 1),
                                      primaryDarkColor: .init(white: 0, alpha: 1))

    MDCActivityIndicatorColorThemer.apply(colorScheme, to: MDCActivityIndicator.appearance())
    MDCButtonBarColorThemer.apply(colorScheme, to: MDCButtonBar.appearance())
    MDCButtonColorThemer.apply(colorScheme, to: MDCButton.appearance())
    MDCFeatureHighlightColorThemer.apply(colorScheme, to: MDCFeatureHighlightView.appearance())
    MDCFlexibleHeaderColorThemer.apply(colorScheme, to: MDCFlexibleHeaderView.appearance())
    MDCHeaderStackViewColorThemer.apply(colorScheme, to: MDCHeaderStackView.appearance())
    MDCNavigationBarColorThemer.apply(colorScheme, to: MDCNavigationBar.appearance())

    return true
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
