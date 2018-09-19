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

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialTabs

// An example that demonstrates the behavior of an App Bar with Tabs and manually swapped tab view
// controllers. This example is distinct from a typical tab bar view controller in that it does not
// make use of a horizontally-paging scroll view. This example also makes use of the
// canAlwaysExpandToMaximumHeight API to allow the header to maintain its expanded state when
// swapping between tabs.
class AppBarManualTabsExample: UIViewController {

  lazy var appBarViewController: MDCAppBarViewController = self.makeAppBar()
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  fileprivate let firstTab = SimpleTableViewController()
  fileprivate let secondTab = SimpleTableViewController()
  private var currentTab: SimpleTableViewController? = nil

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
    appBarViewController.didMove(toParentViewController: self)

    switchToTab(firstTab)
  }

  fileprivate func switchToTab(_ tab: SimpleTableViewController) {
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
    tab.didMove(toParentViewController: self)

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

private class SimpleTableViewController: UITableViewController {

  var headerView: MDCFlexibleHeaderView?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel!.text = "\(title!): Row \(indexPath.item)"
    return cell
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidScroll()
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidEndDecelerating()
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    headerView?.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    headerView?.trackingScrollDidEndDraggingWillDecelerate(decelerate)
  }
}
