// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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
import UIKit
import MaterialComponents.MaterialNavigationRail

@available(iOS 13.0, *)
class NavigationRailViewTypicalUse: UIViewController, NavigationRailViewDelegate {
  var navigationRail: NavigationRailView = NavigationRailView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationRail.items = [
      UITabBarItem(title: "Item 1", image: UIImage(systemName: "heart"), tag: 100),
      UITabBarItem(title: "Item 2", image: UIImage(systemName: "heart"), tag: 100),
      UITabBarItem(title: "Item 3", image: UIImage(systemName: "heart"), tag: 100),
      UITabBarItem(title: "Item 4", image: UIImage(systemName: "heart"), tag: 100),
    ]
    view.addSubview(navigationRail)
    navigationRail.translatesAutoresizingMaskIntoConstraints = false
    navigationRail.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    navigationRail.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    navigationRail.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    navigationRail.widthAnchor.constraint(equalToConstant: 80).isActive = true
    navigationRail.delegate = self
  }

  func navigationRail(_ navigationRail: NavigationRailView, didSelect item: UITabBarItem) {
    if let value = item.badgeValue, let num = Int(value) {
      item.badgeValue = "\(num+1)"
    } else {
      item.badgeValue = "1"
    }
  }

}

@available(iOS 13.0, *)
extension NavigationRailViewTypicalUse {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Rail", "View Typical Use"],
      "description": "Navigation Rail",
      "primaryDemo": false,
      "presentable": true,
      "debug": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
