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

import CoreGraphics
import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_Theming 
import MaterialComponents.MaterialTabs
import MaterialComponents.MaterialContainerScheme

// This example demonstrates the issue found in GitHub issue #5412
class AppBarJumpExample: UIViewController {

  lazy var appBarViewController: MDCAppBarViewController = self.makeAppBar()
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  fileprivate let firstTab = SiblingOfTrackingScrollViewViewController()
  fileprivate let secondTab = SiblingOfTrackingScrollViewViewController()
  private var currentTab: SiblingOfTrackingScrollViewViewController? = nil

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()

    tabBar.items = [
      UITabBarItem(title: "First", image: nil, tag: 0),
      UITabBarItem(title: "Second", image: nil, tag: 1),
    ]

    tabBar.delegate = self
    return tabBar
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Manual Tabs Jump"
    self.firstTab.title = "First"
    self.secondTab.title = "Second"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBarViewController.applyPrimaryTheme(withScheme: containerScheme)

    // Need to update the status bar style after applying the theme.
    setNeedsStatusBarAppearanceUpdate()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    switchToTab(firstTab)
  }

  fileprivate func switchToTab(_ tab: SiblingOfTrackingScrollViewViewController) {

    appBarViewController.headerView.trackingScrollWillChange(toScroll: tab.tableView)

    if let currentTab = currentTab {
      currentTab.headerView = nil
      currentTab.willMove(toParent: nil)
      currentTab.view.removeFromSuperview()
      currentTab.removeFromParent()
    }

    if let tabView = tab.view {
      tabView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      tabView.frame = view.bounds
    }

    view.addSubview(tab.view)
    view.sendSubviewToBack(tab.view)
    tab.didMove(toParent: self)

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

    addChild(appBarViewController)

    // Give the tab bar enough height to accomodate all possible item appearances.
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.sharedWithManyScrollViews = true

    appBarViewController.headerView.minimumHeight = 56
    appBarViewController.headerView.maximumHeight = 128

    appBarViewController.headerStackView.bottomBar = tabBar

    return appBarViewController
  }

  override var childForStatusBarStyle: UIViewController? {
    return appBarViewController
  }
}

extension AppBarJumpExample: MDCTabBarDelegate {
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    if item.tag == 0 {
      switchToTab(firstTab)
    } else {
      switchToTab(secondTab)
    }
  }
}

extension AppBarJumpExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Manual Tabs Jump"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
