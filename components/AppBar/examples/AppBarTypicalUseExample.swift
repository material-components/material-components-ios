/*
Copyright 2016-present Google Inc. All Rights Reserved.

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

// Step 1: Your view controller must conform to MDCAppBarParenting.
class AppBarTypicalUseSwiftExample: UITableViewController, MDCAppBarParenting {

  // Step 2: Define the required properties.
  var headerStackView: MDCHeaderStackView?
  var navigationBar: MDCNavigationBar?
  var headerViewController: MDCFlexibleHeaderViewController?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Typical use"

    // Step 3: Initialize the App Bar's parent.
    MDCAppBarPrepareParent(self)

    let color = UIColor(
      red: CGFloat(0x39) / CGFloat(255),
      green: CGFloat(0xA4) / CGFloat(255),
      blue: CGFloat(0xDD) / CGFloat(255),
      alpha: 1)
    self.headerViewController!.headerView.backgroundColor = color
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Recommended step: Set the tracking scroll view.
    self.headerViewController!.headerView.trackingScrollView = self.tableView

    // Optional step: If you do not need to implement any delegate methods, you can use the
    //                headerViewController as the delegate.
    self.tableView.delegate = self.headerViewController!

    // Step 4: Register the App Bar views.
    MDCAppBarAddViews(self)
  }

  // Optional step: If you allow the header view to hide the status bar you must implement this
  //                method and return the headerViewController.
  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    return self.headerViewController
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
  class func catalogHierarchy() -> [String] {
    return ["App Bar", "Swift", "Typical use"]
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
      cell!.textLabel!.text = "\(indexPath.row)"
      return cell!
  }

}
