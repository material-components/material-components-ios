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

class AppBarTypicalUseSwiftExample: UITableViewController {

  // Step 1: Create and initialize an App Bar.
  let appBar = MDCAppBar()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "App Bar (Swift)"

    // Step 2: Add the headerViewController as a child.
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

  override func viewDidLoad() {
    super.viewDidLoad()

    // Recommended step: Set the tracking scroll view.
    appBar.headerViewController.headerView.trackingScrollView = self.tableView

    // Choice: If you do not need to implement any delegate methods and you are not using a
    //         collection view, you can use the headerViewController as the delegate.
    // Alternative: See AppBarDelegateForwardingExample.
    self.tableView.delegate = appBar.headerViewController

    // Step 3: Register the App Bar views.
    appBar.addSubviewsToParent()

    self.tableView.layoutMargins = UIEdgeInsetsZero
    self.tableView.separatorInset = UIEdgeInsetsZero
  }

  // Optional step: If you allow the header view to hide the status bar you must implement this
  //                method and return the headerViewController.
  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    return appBar.headerViewController
  }

  // Optional step: The Header View Controller does basic inspection of the header view's background
  //                color to identify whether the status bar should be light or dark-themed.
  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    return appBar.headerViewController
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    // We don't know whether the navigation bar will be visible within the Catalog by Convention, so
    // we always hide the navigation bar when we're about to appear.
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: Catalog by convention
extension AppBarTypicalUseSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "App Bar (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarTypicalUseSwiftExample {

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
