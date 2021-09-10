// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_Theming 
import MaterialComponents.MaterialContainerScheme

// This example shows a bug when using an FlexibleHeader in a UITableViewController with expandable
// cells. This occurs both when VoiceOver is on and off.
// 1. (Optional) Turn VoiceOver on
// 2. Expand a cell by tapping it.
// 3. Scroll that expanded cell above the FlexibleHeader.
// 4. Tap another cell to expand it and collapse the previously selected cell.
//
// With the buggy behavior, the FlexibleHeader will shift off-screen unexpectedly.

class AppBarWithExpandableCells: UITableViewController {

  let appBarViewController = MDCAppBarViewController()
  var numberOfRows = 50
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  deinit {
    // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
    appBarViewController.headerView.trackingScrollView = nil
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override init(style: UITableView.Style) {
    super.init(style: style)
    commonInit()
  }

  func commonInit() {

    // Behavioral flags.
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false

    self.addChild(appBarViewController)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
    appBarViewController.headerView.observesTrackingScrollViewScrollEvents = true

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    appBarViewController.applyPrimaryTheme(withScheme: containerScheme)

    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    let headerView = appBarViewController.headerView
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

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    if indexPath == tableView.indexPathForSelectedRow {
      cell.textLabel?.text = "Cell #\(indexPath.item)\nline 2\nline 3"
    } else {
      cell.textLabel?.text = "Cell #\(indexPath.item)"
    }
    cell.textLabel?.numberOfLines = 0
    return cell
  }

  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.beginUpdates()
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.textLabel?.text = "Cell #\(indexPath.item)"
    }
    tableView.endUpdates()
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.beginUpdates()
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.textLabel?.text = "Cell #\(indexPath.item)\nline 2\nline 3"
    }
    tableView.endUpdates()
  }
}

extension AppBarWithExpandableCells {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Expandable cells"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
