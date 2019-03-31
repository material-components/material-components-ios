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

import CoreGraphics
import UIKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialAppBar_TypographyThemer
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialFlexibleHeader_CanAlwaysExpandToMaximumHeight
import MaterialComponents.MaterialTabs
import MaterialComponents.MaterialTypographyScheme

// This example demonstrates issues with flexible header tabs and animations.
class AppBarAnimatedJumpExample: UIViewController {

  lazy var appBarViewController: MDCAppBarViewController = self.makeAppBar()
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  fileprivate let tabs = [
    SimpleComposedTableViewController(title: "First"),
    SimpleComposedTableViewController(title: "Second"),
    SimpleComposedTableViewController(title: "Third"),
  ]
  private var currentTab: SimpleComposedTableViewController? = nil

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()

    tabBar.items = self.tabs.map { $0.tabBarItem }

    tabBar.delegate = self
    return tabBar
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Tab Bar Example"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    for (offset, tab) in zip(0..., tabs) {
      tab.tabBarItem.tag = offset
    }

    MDCAppBarColorThemer.applyColorScheme(colorScheme, to: appBarViewController)
    MDCAppBarTypographyThemer.applyTypographyScheme(typographyScheme, to: appBarViewController)

    // Need to update the status bar style after applying the theme.
    appBarViewController.view.isOpaque = false
    setNeedsStatusBarAppearanceUpdate()

    view.isOpaque = false
    view.backgroundColor = colorScheme.backgroundColor
    view.addSubview(appBarViewController.view)
    #if swift(>=4.2)
    appBarViewController.didMove(toParent: self)
    #else
    appBarViewController.didMove(toParentViewController: self)
    #endif

    switchToTab(tabs[0], animated: false)
  }

  fileprivate func switchToTab(_ tab: SimpleComposedTableViewController, animated: Bool = true) {

    appBarViewController.headerView.trackingScrollWillChange(toScroll: tab.tableView)

    // Hide old tab.
    let removeOld: (() -> Void)
    let animateOut: (() -> Void)
    if let currentTab = currentTab {
      currentTab.willMove(toParentViewController: nil)

      animateOut = {
        currentTab.view.alpha = 0
      }

      removeOld = {
        currentTab.headerView = nil
        currentTab.view.removeFromSuperview()
        currentTab.removeFromParentViewController()
      }
    } else {
      removeOld = {}
      animateOut = {}
    }

    if let tabView = tab.view {
      tabView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      tabView.frame = view.bounds
    }

    // Show new tab.
    view.addSubview(tab.view)
    view.sendSubview(toBack: tab.view)
    #if swift(>=4.2)
    tab.didMove(toParent: self)
    #else
    tab.didMove(toParentViewController: self)
    #endif
    tab.headerView = self.appBarViewController.headerView

    tab.view.alpha = 0
    let animateIn = {
      tab.view.alpha = 1
    }

    let finishMove = {
      self.appBarViewController.headerView.trackingScrollView = tab.tableView
      self.currentTab = tab
    }

    if animated {
      UIView.animate(withDuration: 1, animations: {
        animateOut()
        animateIn()
      }, completion: { _ in
        removeOld()
        finishMove()
      })
    } else {
      animateOut()
      removeOld()
      animateIn()
      finishMove()
    }
  }

  @objc func changeAlignmentDidTouch(sender: UIButton) {
    tabs[0].title = "First"
    switchToTab(tabs[0])
  }

  @objc func changeAppearance(fromSender sender: UIButton) {
    tabs[1].title = "Second"
    switchToTab(tabs[1])
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

extension AppBarAnimatedJumpExample: MDCTabBarDelegate {
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    switchToTab(tabs[item.tag])
  }
}

extension AppBarAnimatedJumpExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Manual Tabs Jump (Animated)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

