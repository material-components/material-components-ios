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

// This example shows a bug when using an MDCFlexibleHeaderView in a UITableViewController.
// When you scroll downwards until the header is down to its minimum size, try selecting
// a cell in the UITableView, and you will see the header shift slightly downwards as a response
// to the UITableView manipulation (addition of a cell animated).

class AppBarWithUITableViewController: UITableViewController {

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
}

extension AppBarWithUITableViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "AppBar+UITableViewController"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
