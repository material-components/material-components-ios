/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

import Foundation
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialBottomNavigation_ColorThemer

class BottomNavigationNilBadges : UIViewController {

  let appBarViewController = MDCAppBarViewController()
  var colorScheme = MDCSemanticColorScheme()

  // Create a bottom navigation bar to add to a view.
  let bottomNavBar = MDCBottomNavigationBar()

  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Bottom Navigation (Swift)"

    self.addChildViewController(appBarViewController)
    let color = UIColor(white: 0.2, alpha:1)
    appBarViewController.headerView.backgroundColor = color
    appBarViewController.navigationBar.tintColor = .white
    appBarViewController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    commonBottomNavigationTypicalUseSwiftExampleInit()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func commonBottomNavigationTypicalUseSwiftExampleInit() {
    view.backgroundColor = .lightGray
    view.addSubview(bottomNavBar)

    // Always show bottom navigation bar item titles.
    bottomNavBar.titleVisibility = .always

    // Cluster and center the bottom navigation bar items.
    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 0)
    bottomNavBar.items = [ tabBarItem1, tabBarItem2 ]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2;

    // Test that
    tabBarItem1.badgeValue = "";
    tabBarItem2.badgeValue = nil;
  }
  
  func layoutBottomNavBar() {
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    let bottomNavBarFrame = CGRect(x: 0,
                                   y: view.bounds.height - size.height,
                                   width: size.width,
                                   height: size.height)
    bottomNavBar.frame = bottomNavBarFrame
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutBottomNavBar()
  }

  #if swift(>=3.2)
  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomNavBar()
  }
  #endif

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParentViewController: self)

    // Theme the bottom navigation bar.
    MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
                                                               toBottomNavigation: bottomNavBar);
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: Catalog by convention
extension BottomNavigationNilBadges {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Badge Value Test"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
