// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

import Foundation
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_Theming 
import MaterialComponents.MaterialContainerScheme

class AppBarThemingExample: UITableViewController {

  let appBarViewController = MDCAppBarViewController()
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  deinit {
    // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
    appBarViewController.headerView.trackingScrollView = nil
  }

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Theming"

    // Behavioral flags.
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false

    self.addChild(appBarViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBarViewController.applyPrimaryTheme(withScheme: containerScheme)
    appBarViewController.headerView.observesTrackingScrollViewScrollEvents = true
    appBarViewController.headerView.trackingScrollView = self.tableView
    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(
        title: "Toggle theme",
        style: .done,
        target: self,
        action: #selector(toggleTheme))
  }

  enum ThemeVariant {
    case primary
    case surface
  }

  var themeVariant: ThemeVariant = .primary

  @objc func toggleTheme() {
    switch themeVariant {
    case .primary:
      themeVariant = .surface
    case .surface:
      themeVariant = .primary
    }

    switch themeVariant {
    case .primary:
      appBarViewController.applyPrimaryTheme(withScheme: containerScheme)
    case .surface:
      appBarViewController.applySurfaceTheme(withScheme: containerScheme)
    }
  }

  override var childForStatusBarHidden: UIViewController? {
    return appBarViewController
  }

  override var childForStatusBarStyle: UIViewController? {
    return appBarViewController
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: Catalog by convention
extension AppBarThemingExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Theming"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarThemingExample {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {

    let cell =
      self.tableView.dequeueReusableCell(withIdentifier: "cell")
      ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.layoutMargins = .zero
    cell.textLabel?.text = "\(indexPath.row)"
    cell.selectionStyle = .none
    return cell
  }

}
