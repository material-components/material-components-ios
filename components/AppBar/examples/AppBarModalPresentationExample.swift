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

class AppBarModalPresentationSwiftExamplePresented: UITableViewController {

  let appBar = MDCAppBar()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Modal Presentation (Swift)"

    self.addChildViewController(appBar.headerViewController)

    let color = UIColor(
      red: CGFloat(0x03) / CGFloat(255),
      green: CGFloat(0xA9) / CGFloat(255),
      blue: CGFloat(0xF4) / CGFloat(255),
      alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName: UIColor.white ]
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBar.headerViewController.headerView.trackingScrollView = self.tableView
    self.tableView.delegate = appBar.headerViewController

    appBar.addSubviewsToParent()

    self.tableView.layoutMargins = UIEdgeInsets.zero
    self.tableView.separatorInset = UIEdgeInsets.zero

    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Touch", style: .done, target: nil, action: nil)

    self.navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Dismiss", style: .done, target: nil, action: nil)
  }

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

class AppBarModalPresentationSwiftExample: UITableViewController {

  let appBar = MDCAppBar()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Modal Presentation (Swift)"

    self.addChildViewController(appBar.headerViewController)

    let color = UIColor(
      red: CGFloat(0x03) / CGFloat(255),
      green: CGFloat(0xA9) / CGFloat(255),
      blue: CGFloat(0xF4) / CGFloat(255),
      alpha: 1)
    appBar.headerViewController.headerView.backgroundColor = color
    appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName: UIColor.white ]
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBar.headerViewController.headerView.trackingScrollView = self.tableView
    self.tableView.delegate = appBar.headerViewController

    appBar.addSubviewsToParent()

    self.tableView.layoutMargins = UIEdgeInsets.zero
    self.tableView.separatorInset = UIEdgeInsets.zero

    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Detail", style: .done, target: nil, action: nil)
  }


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

// MARK: Catalog by convention
extension AppBarModalPresentationSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "Modal Presentation (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarModalPresentationSwiftExample {

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
