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

import UIKit
import MaterialComponentsAlpha.MaterialNavigationDrawer
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialBottomAppBar_ColorThemer
import MaterialComponents.MaterialColorScheme

class BottomDrawerNoHeaderExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  let bottomAppBar = MDCBottomAppBarView()
  
  let contentViewController = DrawerContentViewController()
  let bottomDrawerTransitionController = MDCBottomDrawerTransitionController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    contentViewController.view.backgroundColor = colorScheme.primaryColor

    bottomAppBar.isFloatingButtonHidden = true
    let barButtonLeadingItem = UIBarButtonItem()
    let menuImage = UIImage(named:"Menu")?.withRenderingMode(.alwaysTemplate)
    barButtonLeadingItem.image = menuImage
    barButtonLeadingItem.target = self
    barButtonLeadingItem.action = #selector(presentNavigationDrawer)
    bottomAppBar.leadingBarButtonItems = [ barButtonLeadingItem ]
    MDCBottomAppBarColorThemer.applySurfaceVariant(withSemanticColorScheme: colorScheme,
                                                   to: bottomAppBar)
    view.addSubview(bottomAppBar)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    layoutBottomAppBar()
  }

  private func layoutBottomAppBar() {
    let size = bottomAppBar.sizeThatFits(view.bounds.size)
    var bottomBarViewFrame = CGRect(x: 0,
                                    y: view.bounds.size.height - size.height,
                                    width: size.width,
                                    height: size.height)
    if #available(iOS 11.0, *) {
      bottomBarViewFrame.size.height += view.safeAreaInsets.bottom
      bottomBarViewFrame.origin.y -= view.safeAreaInsets.bottom
    }
    bottomAppBar.frame = bottomBarViewFrame
  }

  @objc func presentNavigationDrawer() {
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

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer No Header"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

}
