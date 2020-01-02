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

import Foundation
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialContainerScheme

/// Example to showcase a reorder of the tabs from an user action
class BottomNavigationResetExample: UIViewController {

  @objc var containerScheme = MDCContainerScheme()

  let bottomNavBar = MDCBottomNavigationBar()

  // The tabs that will be reordered later
  let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
  let tabBarItem2 =
    UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 1)
  let tabBarItem3 =
    UITabBarItem(title: "Favorites", image: UIImage(named: "Favorite"), tag: 2)
  let tabBarItem4 = UITabBarItem(title: "Cake", image: UIImage(named: "Cake"), tag: 3)

  let buttonOne = MDCButton()
  let buttonTwo = MDCButton()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func layoutButtons() {
    buttonOne.center = CGPoint(x: view.center.x,
                                     y: view.center.y - buttonOne.bounds.height / 2 - 16)
    buttonTwo.center = CGPoint(x: view.center.x,
                                     y: view.center.y + buttonTwo.bounds.height / 2 + 16)

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
    layoutButtons()
    layoutBottomNavBar()
  }

  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    layoutBottomNavBar()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    view.addSubview(bottomNavBar)

    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2

    // Layout buttons
    buttonOne.setTitle("Reorder One", for: .normal)
    buttonOne.sizeToFit()
    buttonOne.addTarget(self, action: #selector(reorderItems), for: .touchUpInside)
    view.addSubview(buttonOne)

    buttonTwo.setTitle("Reorder Two", for: .normal)
    buttonTwo.sizeToFit()
    buttonTwo.addTarget(self, action: #selector(reorderItemsAndSetSelected), for: .touchUpInside)
    view.addSubview(buttonTwo)

    bottomNavBar.applyPrimaryTheme(withScheme: containerScheme)
  }

  @objc func reorderItems(_ button: UIButton) {
    bottomNavBar.items = [tabBarItem2, tabBarItem3, tabBarItem1]
  }

  @objc func reorderItemsAndSetSelected(_ button: UIButton) {
    bottomNavBar.items = [tabBarItem3, tabBarItem1, tabBarItem2, tabBarItem4]
    bottomNavBar.selectedItem = tabBarItem3
  }
}

// MARK: Catalog by convention
extension BottomNavigationResetExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Reorder (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
