/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import Foundation
import MaterialComponents

// This example builds upon AppBarTypicalUseExample.

class AppBarDelegateForwardingExample: UITableViewController {

  let appBar = MDCAppBar()

  convenience init() {
    self.init(style: .Plain)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)

    self.appBar.navigationBar.tintColor = UIColor.whiteColor()
    appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName : UIColor.whiteColor() ]

    self.addChildViewController(appBar.headerViewController)

    self.title = "Delegate Forwarding"

    let color = UIColor(
      red: CGFloat(0x03) / CGFloat(255),
      green: CGFloat(0xA9) / CGFloat(255),
      blue: CGFloat(0xF4) / CGFloat(255),
      alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    let config = MDCAppBarAccessibilityConfigurator()
    config.applyAccessibilityConfigurationOnAppBar(appBar)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // UITableViewController's tableView.delegate is self by default. We're setting it here for
    // emphasis.
    self.tableView.delegate = self

    appBar.headerViewController.headerView.trackingScrollView = self.tableView
    appBar.addSubviewsToParent()

    self.tableView.layoutMargins = UIEdgeInsetsZero
    self.tableView.separatorInset = UIEdgeInsetsZero
  }

  // The following four methods must be forwarded to the tracking scroll view in order to implement
  // the Flexible Header's behavior.

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if scrollView == self.appBar.headerViewController.headerView.trackingScrollView {
      self.appBar.headerViewController.headerView.trackingScrollViewDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if scrollView == self.appBar.headerViewController.headerView.trackingScrollView {
      self.appBar.headerViewController.headerView.trackingScrollViewDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let headerView = self.appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = self.appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollViewWillEndDraggingWithVelocity(velocity, targetContentOffset: targetContentOffset)
    }
  }

  // MARK: Typical setup

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Delegate Forwarding (Swift)"

    self.addChildViewController(appBar.headerViewController)

    let color = UIColor(
      red: CGFloat(0x03) / CGFloat(255),
      green: CGFloat(0xA9) / CGFloat(255),
      blue: CGFloat(0xF4) / CGFloat(255),
      alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = UIColor.whiteColor()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: Catalog by convention
extension AppBarDelegateForwardingExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "Delegate Forwarding (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

extension AppBarDelegateForwardingExample {
  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    return appBar.headerViewController
  }

  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    return appBar.headerViewController
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarDelegateForwardingExample {

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }

  override func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell = self.tableView.dequeueReusableCellWithIdentifier("cell")
      if cell == nil {
        cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
      }
      cell!.layoutMargins = UIEdgeInsetsZero
      return cell!
  }

}
