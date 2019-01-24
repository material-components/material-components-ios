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

import MaterialComponentsBeta.MaterialBottomNavigationBeta

@available(iOS 9.0, *)
class BottomNavigationControllerExampleViewController: MDCBottomNavigationBarController {

  public var colorScheme: MDCColorScheme? {
    didSet {
      apply(colorScheme: colorScheme)
    }
  }

  public var typographyScheme: MDCTypographyScheme? {
    didSet {
      apply(typographyScheme: typographyScheme)
    }
  }

  override func viewDidLoad() {
    guard #available(iOS 9, *) else {
      // The catalog circumvents the controller's guards to ensure that it is only used if
      // iOS 9+ is available. This is a work around to ensure that the catalog does not crash.
      // Remove when MDC is upgraded to iOS 9 as a minimum deployment target.
      return
    }

    super.viewDidLoad()

    let viewController1 = BaseCellExample()
    viewController1.tabBarItem = UITabBarItem(title: "Item 1", image: UIImage(named: "Home"), tag: 0)

    let viewController2 = PageControlSwiftExampleViewController()
    viewController2.tabBarItem = UITabBarItem(title: "Item 2", image: UIImage(named: "Favorite"), tag: 1)

    let viewController3 = PalettesGeneratedExampleViewController()
    viewController3.tabBarItem = UITabBarItem(title: "Item 3", image: UIImage(named: "Search"), tag: 2)

    viewControllers = [ viewController1, viewController2, viewController3 ]
  }

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Bottom Navigation Controller (iOS 9+)"],
      "presentable": false
    ]
  }
}

// MARK: Private Functions

@available(iOS 9.0, *)
extension BottomNavigationControllerExampleViewController {
  fileprivate func apply(colorScheme: MDCColorScheme?) {
    guard let scheme = colorScheme else { return }
    MDCBottomNavigationBarColorThemer.apply(scheme, to: self.navigationBar)
  }

  fileprivate func apply(typographyScheme: MDCTypographyScheme?) {
    guard let scheme = typographyScheme else { return }
    MDCBottomNavigationBarTypographyThemer.applyTypographyScheme(scheme, to: self.navigationBar)
  }
}
