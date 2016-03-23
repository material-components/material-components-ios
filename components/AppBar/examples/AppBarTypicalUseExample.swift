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

class AppBarTypicalUseSwiftExample: UITableViewController, MDCAppBarParenting {

  var headerStackView: MDCHeaderStackView?
  var navigationBar: MDCNavigationBar?
  var headerViewController: MDCFlexibleHeaderViewController?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Hello"
    MDCAppBarPrepareParent(self)

    let color = UIColor(
      red: CGFloat(0x39) / CGFloat(255),
      green: CGFloat(0xA4) / CGFloat(255.0),
      blue: CGFloat(0xDD) / CGFloat(255.0),
      alpha: 1)
    self.headerViewController!.headerView.backgroundColor = color
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.delegate = self.headerViewController!
    self.headerViewController!.headerView.trackingScrollView = self.tableView

    MDCAppBarAddViews(self)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    return self.headerViewController
  }

  // MARK: UITableViewDataSource

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

  // MARK: Catalog by convention

  class func catalogHierarchy() -> [String] {
    return ["App Bar", "Swift", "Typical use"]
  }
}
