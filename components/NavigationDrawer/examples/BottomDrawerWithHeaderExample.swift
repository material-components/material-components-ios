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
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialNavigationDrawer
import MaterialComponents.MaterialColorScheme

class BottomDrawerWithHeaderExample: UIViewController, MDCBottomDrawerViewControllerDelegate {

  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  let bottomAppBar = MDCBottomAppBarView()

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor

    bottomAppBar.isFloatingButtonHidden = true
    let barButtonLeadingItem = UIBarButtonItem()
    let menuImage = UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate)
    barButtonLeadingItem.image = menuImage
    barButtonLeadingItem.target = self
    barButtonLeadingItem.action = #selector(presentNavigationDrawer)
    bottomAppBar.leadingBarButtonItems = [barButtonLeadingItem]

    bottomAppBar.barTintColor = colorScheme.surfaceColor
    let barItemTintColor = colorScheme.onSurfaceColor.withAlphaComponent(0.6)
    bottomAppBar.leadingBarItemsTintColor = barItemTintColor
    bottomAppBar.trailingBarItemsTintColor = barItemTintColor
    bottomAppBar.floatingButton.setBackgroundColor(colorScheme.primaryColor, for: .normal)
    bottomAppBar.floatingButton.setTitleColor(colorScheme.onPrimaryColor, for: .normal)
    bottomAppBar.floatingButton.setImageTintColor(colorScheme.onPrimaryColor, for: .normal)

    view.addSubview(bottomAppBar)
  }

  private func layoutBottomAppBar() {
    let size = bottomAppBar.sizeThatFits(view.bounds.size)
    var bottomBarViewFrame = CGRect(
      x: 0,
      y: view.bounds.size.height - size.height,
      width: size.width,
      height: size.height)
    bottomBarViewFrame.size.height += view.safeAreaInsets.bottom
    bottomBarViewFrame.origin.y -= view.safeAreaInsets.bottom
    bottomAppBar.frame = bottomBarViewFrame
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    layoutBottomAppBar()
  }

  @objc func presentNavigationDrawer() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.setTopCornersRadius(24, for: .collapsed)
    bottomDrawerViewController.setTopCornersRadius(8, for: .expanded)
    bottomDrawerViewController.isTopHandleHidden = false
    bottomDrawerViewController.topHandleColor = UIColor.lightGray
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.delegate = self
    bottomDrawerViewController.headerViewController?.view.backgroundColor = colorScheme.surfaceColor
    bottomDrawerViewController.contentViewController?.view.backgroundColor =
      colorScheme.surfaceColor
    bottomDrawerViewController.scrimColor = colorScheme.onSurfaceColor.withAlphaComponent(0.32)
    present(bottomDrawerViewController, animated: true, completion: nil)
  }

  func bottomDrawerControllerDidChangeTopInset(
    _ controller: MDCBottomDrawerViewController,
    topInset: CGFloat
  ) {
    headerViewController.titleLabel.center =
      CGPoint(
        x: headerViewController.view.frame.size.width / 2,
        y: (headerViewController.view.frame.size.height + topInset) / 2)
  }
}

extension BottomDrawerWithHeaderExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
