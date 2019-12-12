// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

import MaterialComponentsBeta.MaterialTabs_TabBarView
import MaterialComponents.MaterialContainerScheme

class TabBarViewExample: UIViewController {

  static let title = "TabBarView (Swift)"

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  lazy var tabBar: MDCTabBarView = {
    let tabBar = MDCTabBarView()
    tabBar.items = self.tabBarItems
    tabBar.tabBarDelegate = self
    tabBar.translatesAutoresizingMaskIntoConstraints = false
    return tabBar
  }()

  let itemIcons = [
    UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate),
    UIImage(named: "Favorite")?.withRenderingMode(.alwaysTemplate),
    UIImage(named: "Cake")?.withRenderingMode(.alwaysTemplate),
    UIImage(named: "Email")?.withRenderingMode(.alwaysTemplate),
    UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate)
  ]

  let itemTitles = ["Home", "Unselectable", "Cake", "Email", "Search"]

  lazy var tabBarItems: [UITabBarItem] = {
    return zip(itemTitles, itemIcons)
      .enumerated()
      .map { (index, titleIconPair) in
        let (title, icon) = titleIconPair
        return UITabBarItem(title: title, image: icon, tag: index)
    }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = TabBarViewExample.title

    applyFixForInjectedAppBar()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor;
    view.addSubview(tabBar)
    if #available(iOS 11.0, *) {
      view.layoutMarginsGuide.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    } else {
      topLayoutGuide.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }
    view.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor).isActive = true

    applyThemingToTabBarView()
  }

  // MARK: Private

  private func applyThemingToTabBarView() {
    tabBar.barTintColor = containerScheme.colorScheme.surfaceColor
    tabBar.setTitleColor(containerScheme.colorScheme.onSurfaceColor.withAlphaComponent(0.6),
                         for: .normal)
    tabBar.setTitleColor(containerScheme.colorScheme.primaryColor, for: .selected)
    tabBar.setImageTintColor(containerScheme.colorScheme.onSurfaceColor, for: .normal)
    tabBar.setImageTintColor(containerScheme.colorScheme.primaryColor, for: .selected)
    tabBar.setTitleFont(containerScheme.typographyScheme.button, for: .normal)
    tabBar.setTitleFont(.systemFont(ofSize: 16), for: .selected)
    tabBar.selectionIndicatorStrokeColor = containerScheme.colorScheme.primaryColor
    tabBar.rippleColor = containerScheme.colorScheme.primaryColor.withAlphaComponent(0.1)
    tabBar.bottomDividerColor = containerScheme.colorScheme.onSurfaceColor.withAlphaComponent(0.12)
  }

  private func applyFixForInjectedAppBar() {
    // The injected AppBar has a bug where it will attempt to manipulate the Tab bar. To prevent
    // that bug, we need to inject a scroll view into the view hierarchy before the tab bar. The App
    // Bar will manipulate with that one instead.
    let bugFixScrollView = UIScrollView()
    bugFixScrollView.isUserInteractionEnabled = false
    bugFixScrollView.isHidden = true
    view.addSubview(bugFixScrollView)
  }
}

extension TabBarViewExample: MDCTabBarViewDelegate {
  func tabBarView(_ tabBarView: MDCTabBarView, shouldSelect item: UITabBarItem) -> Bool {
    return tabBar.items.index(of: item) != 1
  }

  func tabBarView(_ tabBarView: MDCTabBarView, didSelect item: UITabBarItem) {
    print("Item \(item.title!) was selected.")
  }
}

extension TabBarViewExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs" : ["Tab Bar", TabBarViewExample.title],
      "primaryDemo" : false,
      "presentable" : false,
    ]
  }
}
