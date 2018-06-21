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

import Foundation
import MaterialComponents

class BottomNavigationExplicitlySetColorExample: UIViewController {

  let appBar = MDCAppBar()
  var colorScheme = MDCSemanticColorScheme()

  let bottomNavBar = MDCBottomNavigationBar()

  let redButton = MDCButton()
  let blueButton = MDCButton()

  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Bottom Navigation Set Color (Swift)"

    self.addChildViewController(appBar.headerViewController)
    let color = UIColor(white: 0.2, alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = .white
    appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

    commonBottomNavigationExampleInit()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func commonBottomNavigationExampleInit() {
    view.backgroundColor = .lightGray
    view.addSubview(bottomNavBar)

    bottomNavBar.titleVisibility = .always

    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 0)
    let tabBarItem3 =
      UITabBarItem(title: "Favorites", image: UIImage(named: "Favorite"), tag: 0)
    bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2;

    // Layout buttons
    redButton.frame = CGRect(x: view.center.x - 72, y: view.center.y - 72, width: 144, height: 56)
    redButton.backgroundColor = .red
    redButton.setTitle("Red theme", for: .normal)
    redButton.addTarget(self, action: #selector(redTheme), for: .touchUpInside)
    view.addSubview(redButton)

    blueButton.frame = CGRect(x: view.center.x - 72, y: view.center.y + 16, width: 144, height: 56)
    blueButton.backgroundColor = .blue
    blueButton.setTitle("Blue theme", for: .normal)
    blueButton.addTarget(self, action: #selector(blueTheme), for: .touchUpInside)
    view.addSubview(blueButton)
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
    appBar.addSubviewsToParent()

    MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
                                                               toBottomNavigation: bottomNavBar)
    bottomNavBar.backgroundColor = .darkGray
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  @objc func redTheme(_ button: UIButton) {
    bottomNavBar.selectedItemTintColor = .red
    bottomNavBar.unselectedItemTintColor = .green
  }

  @objc func blueTheme(_ button: UIButton) {
    bottomNavBar.selectedItemTintColor = .blue
    bottomNavBar.unselectedItemTintColor = .yellow
  }
}

// MARK: Catalog by convention
extension BottomNavigationExplicitlySetColorExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Bottom Navigation", "Bottom Navigation Set Color (Swift)"]
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }
}
