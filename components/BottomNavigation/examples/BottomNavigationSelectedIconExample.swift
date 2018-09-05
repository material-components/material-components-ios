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
import MaterialComponents.MaterialBottomNavigation_ColorThemer
import MaterialComponents.MaterialTypographyScheme

// Example to show different icons for selected and unselected states
class BottomNavigationSelectedIconExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  let bottomNavBar = MDCBottomNavigationBar()

  override func viewDidLoad() {
    colorScheme.backgroundColor = .white
    view.backgroundColor = colorScheme.backgroundColor

    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    let tabBarItem2 = UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 1)
    tabBarItem2.selectedImage = nil
    let tabBarItem3 = UITabBarItem(title: "Favorites", image: UIImage(named: "Cake"), tag: 2)
    tabBarItem3.selectedImage = UIImage(named: "Favorite")
    bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
    bottomNavBar.selectedItem = tabBarItem1
    view.addSubview(bottomNavBar)

    MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
                                                               toBottomNavigation: bottomNavBar)
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
}


// MARK: - Catalog by Conventions
extension BottomNavigationSelectedIconExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Selected"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
