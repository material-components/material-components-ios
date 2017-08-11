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

    let color = UIColor(white: 0.2, alpha:1)
    appBar.headerViewController.headerView.backgroundColor = color
    let mutator = MDCAppBarTextColorAccessibilityMutator()
    mutator.mutate(appBar)
    self.modalPresentationStyle = .formSheet
    self.modalTransitionStyle = .coverVertical
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
      UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissSelf))
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

  @objc func dismissSelf() {
    self.dismiss(animated: true, completion: nil)
  }
}

class AppBarModalPresentationSwiftExample: UITableViewController {

  let appBar = MDCAppBar()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Modal Presentation (Swift)"

    self.addChildViewController(appBar.headerViewController)

    let color = UIColor(white: 0.2, alpha:1)
    appBar.headerViewController.headerView.backgroundColor = color
    let mutator = MDCAppBarTextColorAccessibilityMutator()
    mutator.mutate(appBar)
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
      UIBarButtonItem(title: "Detail", style: .done, target: self, action: #selector(presentModal))
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

  @objc func presentModal() {
    let modalVC = AppBarModalPresentationSwiftExamplePresented()
    self.present(modalVC, animated: true, completion: nil)
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
