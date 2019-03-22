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
import CoreGraphics

import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialAppBar_TypographyThemer
import MaterialComponents.MaterialTabs
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialFlexibleHeader_CanAlwaysExpandToMaximumHeight

// An example that demonstrates the behavior of an App Bar with Tabs and manually swapped tab view
// controllers. This example is distinct from a typical tab bar view controller in that it does not
// make use of a horizontally-paging scroll view. This example also makes use of the
// canAlwaysExpandToMaximumHeight API to allow the header to maintain its expanded state when
// swapping between tabs.
class AppBarManualTabsExample: UIViewController {

  lazy var appBarViewController: MDCAppBarViewController = self.makeAppBar()
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  fileprivate let firstTab = SimpleInheritedTableViewController()
  fileprivate let secondTab = SimpleInheritedTableViewController()
  private var currentTab: SimpleInheritedTableViewController? = nil

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()

    tabBar.items = [
      UITabBarItem(title: "First", image: nil, tag:0),
      UITabBarItem(title: "Second", image: nil, tag:1)
    ]

    tabBar.delegate = self
    return tabBar
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Tab Bar Example"
    self.firstTab.title = "First"
    self.secondTab.title = "Second"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    MDCAppBarColorThemer.applyColorScheme(colorScheme, to: appBarViewController)
    MDCAppBarTypographyThemer.applyTypographyScheme(typographyScheme, to: appBarViewController)

    // Need to update the status bar style after applying the theme.
    setNeedsStatusBarAppearanceUpdate()

    view.backgroundColor = colorScheme.backgroundColor
    view.addSubview(appBarViewController.view)
    #if swift(>=4.2)
    appBarViewController.didMove(toParent: self)
    #else
    appBarViewController.didMove(toParentViewController: self)
    #endif

    switchToTab(firstTab)
  }

  fileprivate func switchToTab(_ tab: SimpleInheritedTableViewController) {
    appBarViewController.headerView.trackingScrollWillChange(toScroll: tab.tableView)

    if let currentTab = currentTab {
      currentTab.headerView = nil
      currentTab.willMove(toParentViewController: nil)
      currentTab.view.removeFromSuperview()
      currentTab.removeFromParentViewController()
    }

    if let tabView = tab.view {
      tabView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      tabView.frame = view.bounds
    }

    view.addSubview(tab.tableView)
    view.sendSubview(toBack: tab.tableView)

    #if swift(>=4.2)
    tab.didMove(toParent: self)
    #else
    tab.didMove(toParentViewController: self)
    #endif

    tab.headerView = appBarViewController.headerView

    appBarViewController.headerView.trackingScrollView = tab.tableView
    currentTab = tab
  }

  @objc func changeAlignmentDidTouch(sender: UIButton) {
    firstTab.title = "First"
    switchToTab(firstTab)
  }

  @objc func changeAppearance(fromSender sender: UIButton) {
    secondTab.title = "Second"
    switchToTab(secondTab)
  }

  // MARK: Private

  private func makeAppBar() -> MDCAppBarViewController {
    let appBarViewController = MDCAppBarViewController()

    addChildViewController(appBarViewController)

    // Give the tab bar enough height to accomodate all possible item appearances.
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.canAlwaysExpandToMaximumHeight = true
    appBarViewController.headerView.sharedWithManyScrollViews = true

    appBarViewController.headerView.minimumHeight = 56
    appBarViewController.headerView.maximumHeight = 128

    appBarViewController.headerStackView.bottomBar = tabBar

    return appBarViewController
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBarViewController
  }
}

extension AppBarManualTabsExample: MDCTabBarDelegate {
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    if item.tag == 0 {
      switchToTab(firstTab)
    } else {
      switchToTab(secondTab)
    }
  }
}

extension AppBarManualTabsExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Manual tabs"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
