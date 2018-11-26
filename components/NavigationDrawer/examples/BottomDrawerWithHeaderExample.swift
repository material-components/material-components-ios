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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialBottomAppBar_ColorThemer
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialNavigationDrawer

class BottomDrawerWithHeaderExample: UIViewController, MDCBottomDrawerViewControllerDelegate {

  var colorScheme = MDCSemanticColorScheme()
  let bottomAppBar = MDCBottomAppBarView()
   var fullScreen: Bool = true

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentViewController()
  var bottomDrawerViewController = MDCBottomDrawerViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor

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

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    layoutBottomAppBar()
  }

  @objc func presentNavigationDrawer() {
    let bottomNav = MDCBottomDrawerViewController()
    bottomDrawerViewController = bottomNav
    layoutContentViewController()
    bottomDrawerViewController.setTopCornersRadius(24, for: .collapsed)
    bottomDrawerViewController.setTopCornersRadius(8, for: .expanded)
    bottomDrawerViewController.isTopHandleHidden = false
    bottomDrawerViewController.topHandleColor = UIColor.lightGray
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.delegate = self
    MDCBottomDrawerColorThemer.applySemanticColorScheme(colorScheme,
                                                        toBottomDrawer: bottomDrawerViewController)
    present(bottomDrawerViewController, animated: true, completion: nil)
  }

  private func layoutContentViewController() {
    let button = MDCButton(frame: .zero)
    button.setTitle("Expand", for: .normal)
    button.sizeToFit()
    button.addTarget(self, action: #selector(expandBottomDrawer), for: .touchUpInside)
    button.center = CGPoint(x: view.frame.width / 2, y: 50)
    button.backgroundColor = colorScheme.primaryColor
    contentViewController.view.addSubview(button)
  }

  @objc func expandBottomDrawer() {
    var height: CGFloat = 0
    if (!fullScreen) {
      height = 100
    } else {
      height = 2000
    }
    bottomDrawerViewController.animate(toPreferredContentHeight: height, withDuration: 1.5) { _ in
      if let drawerHeader =
        self.bottomDrawerViewController.headerViewController as? DrawerHeaderViewController {
        drawerHeader.titleLabel.text = "Done animating"
      }
      self.fullScreen = !self.fullScreen
    }
    UIView.animate(withDuration: 1.5, animations: {
      self.bottomDrawerViewController.headerViewController?.view.backgroundColor =
        self.colorScheme.primaryColor
    })
  }

  func bottomDrawerControllerDidChangeTopInset(_ controller: MDCBottomDrawerViewController,
                                               topInset: CGFloat) {
    headerViewController.titleLabel.center =
      CGPoint(x: headerViewController.view.frame.size.width / 2,
              y: (headerViewController.view.frame.size.height + topInset) / 2)
  }
}

extension BottomDrawerWithHeaderExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer"],
      "primaryDemo": false,
      "presentable": false,
      "debug": true,
    ]
  }
}
