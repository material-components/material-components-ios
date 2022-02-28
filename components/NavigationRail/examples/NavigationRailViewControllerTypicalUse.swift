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
class NavigationRailViewControllerTypicalUse: UIViewController, NavigationRailViewControllerDelegate
{
  var navigationRailController: NavigationRailViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    let vc1 = UIViewController()
    vc1.view.backgroundColor = .systemTeal
    vc1.tabBarItem = UITabBarItem(
      title: "Item 1", image: UIImage(systemName: "seal"),
      selectedImage: UIImage(systemName: "seal.fill"))
    let vc2 = UIViewController()
    vc2.view.backgroundColor = .systemIndigo
    vc2.tabBarItem = UITabBarItem(
      title: "Item 2", image: UIImage(systemName: "heart"),
      selectedImage: UIImage(systemName: "heart.fill"))
    let vc3 = UIViewController()
    vc3.view.backgroundColor = .systemBlue
    vc3.tabBarItem = UITabBarItem(
      title: "Item 3", image: UIImage(systemName: "eye"),
      selectedImage: UIImage(systemName: "eye.fill"))
    navigationRailController = NavigationRailViewController()
    navigationRailController.modalPresentationStyle = .fullScreen
    navigationRailController.setViewControllers([vc1, vc2, vc3], animated: true)
    navigationRailController.delegate = self
    let config = NavigationRailConfiguration.railConfiguration()
    config.isMenuButtonVisible = true
    config.isFloatingActionButtonVisible = true
    navigationRailController.navigationRail.configuration = config

    self.view?.addSubview(navigationRailController.view)
    self.addChild(navigationRailController)
    navigationRailController.didMove(toParent: self)
  }

  func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didTapMenuButton menuButton: UIButton
  ) {
    print("tapped menu button!")
  }

  func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didTapFloatingActionButton floatingActionButton: UIButton
  ) {
    print("tapped FAB button!")
  }

  func navigationRailViewController(
    _ navigationRailViewController: NavigationRailViewController,
    didSelect viewController: UIViewController
  ) {
    print("selected new item!")
  }

}

@available(iOS 13.0, *)
extension NavigationRailViewControllerTypicalUse {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Rail", "VC Typical Use"],
      "description": "Navigation Rail",
      "primaryDemo": true,
      "presentable": true,
      "debug": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
