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
import MaterialComponents.MaterialColorScheme

class BottomNavigationTypicalUseSwiftExample: UIViewController {

  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)

  // Create a bottom navigation bar to add to a view.
  let bottomNavBar = MDCBottomNavigationBar()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor
    view.addSubview(bottomNavBar)

    // Always show bottom navigation bar item titles.
    bottomNavBar.titleVisibility = .always

    // Cluster and center the bottom navigation bar items.
    bottomNavBar.alignment = .centered

    // Add items to the bottom navigation bar.
    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), tag: 0)
    let tabBarItem2 =
      UITabBarItem(title: "Messages", image: UIImage(named: "ic_email"), tag: 1)
    let tabBarItem3 =
      UITabBarItem(title: "Favorites", image: UIImage(named: "ic_favorite"), tag: 2)
    bottomNavBar.items = [tabBarItem1, tabBarItem2, tabBarItem3]

    // Select a bottom navigation bar item.
    bottomNavBar.selectedItem = tabBarItem2
    bottomNavBar.enableRippleBehavior = true
  }

  func layoutBottomNavBar() {
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    var bottomNavBarFrame = CGRect(
      x: 0,
      y: view.bounds.height - size.height,
      width: size.width,
      height: size.height)
    bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
    bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
    bottomNavBar.frame = bottomNavBarFrame
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutBottomNavBar()
  }
}

// MARK: Catalog by convention
extension BottomNavigationTypicalUseSwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
