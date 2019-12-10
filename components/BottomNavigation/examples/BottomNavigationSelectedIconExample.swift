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
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

// Example to show different icons for selected and unselected states
class BottomNavigationSelectedIconExample: UIViewController {
  @objc var containerScheme: MDCContainerScheming = {
    let containerScheme = MDCContainerScheme()
    containerScheme.colorScheme.backgroundColor = .white
    return containerScheme
  }()

  let bottomNavBar = MDCBottomNavigationBar()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let tabBarItem1 = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    let tabBarItem2 = UITabBarItem(title: "Messages", image: UIImage(named: "Email"), tag: 1)
    tabBarItem2.selectedImage = nil
    let tabBarItem3 = UITabBarItem(title: "Favorites", image: UIImage(named: "Cake"), tag: 2)
    tabBarItem3.selectedImage = UIImage(named: "Favorite")
    bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
    bottomNavBar.selectedItem = tabBarItem1
    view.addSubview(bottomNavBar)

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
}


// MARK: - Catalog by Conventions
extension BottomNavigationSelectedIconExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Selected"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
