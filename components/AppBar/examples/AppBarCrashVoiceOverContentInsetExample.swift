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

/// To demonstrate the crash, run this example with VoiceOver on:
///
/// 1. Run MDCDragons on a phone with VoiceOver turned on.
/// 2. Tap App Bar -> App Bar Crash: Voiceover + Content Inset
/// 3. Crash.
class AppBarCrashVoiceOverContentInsetExample: UITableViewController {

  let appBarViewController = MDCAppBarViewController()

  deinit {
    // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
    appBarViewController.headerView.trackingScrollView = nil
  }

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "App Bar Crash: Voiceover + Content Inset"
    self.addChild(appBarViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBarViewController.headerView.observesTrackingScrollViewScrollEvents = true
    appBarViewController.headerView.trackingScrollView = self.tableView
    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Right", style: .done, target: nil, action: nil)

    // Causes Crash
    self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
  }

}

// MARK: Catalog by convention
extension AppBarCrashVoiceOverContentInsetExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "App Bar Crash: Voiceover + Content Inset"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

// MARK: - Typical application code (not Material-specific)

// MARK: UITableViewDataSource
extension AppBarCrashVoiceOverContentInsetExample {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
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
