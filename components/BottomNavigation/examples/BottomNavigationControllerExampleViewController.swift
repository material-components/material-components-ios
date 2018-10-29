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

@available(iOSApplicationExtension 9.0, *)
class BottomNavigationControllerExampleViewController: MDCBottomNavigationBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let viewController1 = BaseCellExample()
    viewController1.tabBarItem = UITabBarItem(title: "Item 1", image: UIImage(named: "Home"), tag: 0)

    let viewController2 = PageControlSwiftExampleViewController()
    viewController2.tabBarItem = UITabBarItem(title: "Item 2", image: UIImage(named: "Favorite"), tag: 1)

    let viewController3 = MaskedTransitionTypicalUseSwiftExample()
    viewController3.tabBarItem = UITabBarItem(title: "Item 3", image: UIImage(named: "Search"), tag: 2)

    viewControllers = [viewController1, viewController2, viewController3]

    selectedViewController = viewController1
  }

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Controller"],
      "presentable": true
    ]
  }
}
