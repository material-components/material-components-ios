// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

import Foundation
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialBottomNavigation_Theming
import MaterialComponents.MaterialContainerScheme

class BottomNavigationNilBadges : UIViewController, MDCBottomNavigationBarDelegate {

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  // Create a bottom navigation bar to add to a view.
  let bottomNavBar = MDCBottomNavigationBar()
  let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
  let tabBarItem2 = UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 0)

  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Bottom Navigation (Swift)"  
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    view.addSubview(bottomNavBar)
    bottomNavBar.delegate = self

    // Always show bottom navigation bar item titles.
    bottomNavBar.titleVisibility = .always

    // Cluster and center the bottom navigation bar items.
    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    tabBarItem1.accessibilityValue = "New items"

    bottomNavBar.items = [ tabBarItem1, tabBarItem2 ]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2

    // Test that
    tabBarItem1.badgeValue = ""
    tabBarItem2.badgeValue = nil

    // Theme the bottom navigation bar.
    bottomNavBar.applyPrimaryTheme(withScheme: containerScheme)
  }
  
  func layoutBottomNavBar() {
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    var bottomNavBarFrame = CGRect(x: 0,
                                   y: view.bounds.height - size.height,
                                   width: size.width,
                                   height: size.height)
    if #available(iOS 11.0, *) {
      bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
      bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
    }
    bottomNavBar.frame = bottomNavBarFrame
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutBottomNavBar()
  }

  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomNavBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  func bottomNavigationBar(
    _ bottomNavigationBar: MDCBottomNavigationBar,
    didSelect item: UITabBarItem
  ) {
    if (item == tabBarItem1) {
      tabBarItem1.badgeValue = nil
      tabBarItem1.accessibilityValue = ""
    }
  }
}

// MARK: Catalog by convention
extension BottomNavigationNilBadges {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Badge Value Test"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
