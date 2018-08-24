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

import UIKit
import MaterialComponentsAlpha.MaterialNavigationDrawer

class BottomDrawerNoHeaderExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()

  let contentViewController = DrawerContentViewController()
  let bottomDrawerTransitionController = MDCBottomDrawerTransitionController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    contentViewController.colorScheme = colorScheme
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // This shows that it is possible to present the content view controller directly without
    // the need of the MDCBottomDrawerViewController wrapper. To present the view controller
    // inside the drawer, both the transition controller and the custom presentation controller
    // of the drawer need to be set.
    contentViewController.transitioningDelegate = bottomDrawerTransitionController
    contentViewController.modalPresentationStyle = .custom
    present(contentViewController, animated: true, completion: nil)
  }

}

extension BottomDrawerNoHeaderExample {

  @objc class func catalogDescription() -> String {
    return "Navigation Drawer"
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Navigation Drawer", "Bottom Drawer No Header"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

}
