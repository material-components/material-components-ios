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
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var colorScheme: (MDCColorScheme & NSObjectProtocol)!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = MDCCatalogWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.statusBarStyle = .lightContent

    let tree = CBCCreateNavigationTree()

    // Some code (like catalog tile images) depend on this property being non-nil
    prepareScheme()

    let rootNodeViewController = MDCCatalogComponentsController(node: tree)
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)

    // In the event that an example view controller hides the navigation bar we generally want to
    // ensure that the edge-swipe pop gesture can still take effect. This may be overly-assumptive
    // but we'll explore other alternatives when we have a concrete example of this approach causing
    // problems.
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController

    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()

    return true
  }

  func prepareScheme() {
    colorScheme = MDCBasicColorScheme(primaryColor: MDCPalette.lightBlue.tint500,
                                      primaryLightColor: MDCPalette.lightBlue.tint700,
                                      primaryDarkColor: MDCPalette.lightBlue.tint300,
                                      secondaryColor: MDCPalette.lime.accent200!,
                                      secondaryLightColor: MDCPalette.lime.accent400!,
                                      secondaryDarkColor: MDCPalette.lime.accent100!)
  }
}


extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
