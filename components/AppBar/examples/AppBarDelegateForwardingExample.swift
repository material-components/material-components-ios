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
    self.init(style: .plain)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)

    self.appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName: UIColor.white ]

    self.addChildViewController(appBar.headerViewController)

    self.title = "Delegate Forwarding"

    let color = UIColor(white: 0.1, alpha:1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = UIColor.white
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // UITableViewController's tableView.delegate is self by default. We're setting it here for
    // emphasis.
    self.tableView.delegate = self

    appBar.headerViewController.headerView.trackingScrollView = self.tableView
    appBar.addSubviewsToParent()

    self.tableView.layoutMargins = UIEdgeInsets.zero
    self.tableView.separatorInset = UIEdgeInsets.zero
  }

  // The following four methods must be forwarded to the tracking scroll view in order to implement
  // the Flexible Header's behavior.

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == self.appBar.headerViewController.headerView.trackingScrollView {
      self.appBar.headerViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == self.appBar.headerViewController.headerView.trackingScrollView {
      self.appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    let headerView = self.appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = self.appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                               targetContentOffset: targetContentOffset)
    }
  }

  // MARK: Typical setup

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Delegate Forwarding (Swift)"

    self.addChildViewController(appBar.headerViewController)

    let color = UIColor(
      red: CGFloat(0x03) / CGFloat(255),
      green: CGFloat(0xA9) / CGFloat(255),
      blue: CGFloat(0xF4) / CGFloat(255),
      alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = UIColor.white
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
  override var childViewControllerForStatusBarHidden: UIViewController? {
    return appBar.headerViewController
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarDelegateForwardingExample {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
      if cell == nil {
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      }
      cell!.layoutMargins = UIEdgeInsets.zero
      return cell!
  }

}
