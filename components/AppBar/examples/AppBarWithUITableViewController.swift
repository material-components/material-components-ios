/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MDCAppBarColorThemer

// This example shows a bug when using an MDCFlexibleHeaderView in a UITableViewController.
// When you scroll downwards until the header is down to its minimum size, try selecting
// a cell in the UITableView, and you will see the header shift slightly downwards as a response
// to the UITableView manipulation (addition of a cell animated).

class AppBarWithUITableViewController: UITableViewController {

  let appBar = MDCAppBar()
  var numberOfRows = 50

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.addChildViewController(appBar.headerViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addChildViewController(appBar.headerViewController)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)
    self.addChildViewController(appBar.headerViewController)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    appBar.addSubviewsToParent()

    let colorScheme = MDCSemanticColorScheme()
    MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    let headerView = appBar.headerViewController.headerView
    headerView.trackingScrollView = self.tableView
    headerView.maximumHeight = 300
    headerView.minimumHeight = 100
  }

  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "Cell #\(indexPath.item)"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath(item: indexPath.item+1, section: 0)], with: .automatic)
    numberOfRows += 1
    tableView.endUpdates()
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
  }

}

extension AppBarWithUITableViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "AppBar+UITableViewController"]
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
