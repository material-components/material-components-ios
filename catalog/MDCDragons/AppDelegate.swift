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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    UIApplication.shared.statusBarStyle = .lightContent
    let tree = CBCCreateNavigationTree()
    var rootNodeViewController: UIViewController

    /**
     To have your example show up as the initial view controller, you need it to implement
     the method `@objc class func catalogIsDebug() -> Bool` and have it return true.
     That way it will become the debugLeaf and be presented first.
     */
    if let debugLeaf = tree.debugLeaf {
      rootNodeViewController = debugLeaf.createExampleViewController()
    } else {
      rootNodeViewController = MDCDragonsController(node: tree)
    }
    let navigationController = UINavigationController(rootViewController: rootNodeViewController)
    navigationController.interactivePopGestureRecognizer?.delegate = navigationController
    
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    return true
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
