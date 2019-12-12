// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

class AppBarImagerySwiftExample: UITableViewController {
  let appBarViewController = MDCAppBarViewController()
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  deinit {
    // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
    appBarViewController.headerView.trackingScrollView = nil
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let headerView = appBarViewController.headerView

    // Create our custom image view and add it to the header view.
    let imageView = UIImageView(image: self.headerBackgroundImage())
    imageView.frame = headerView.bounds

    // Ensure that the image view resizes in reaction to the header view bounds changing.
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    // Ensure that the image view is below other App Bar views (headerStackView).
    headerView.insertSubview(imageView, at: 0)

    // Scales up the image while the header is over-extending.
    imageView.contentMode = .scaleAspectFill

    // The header view does not clip to bounds by default so we ensure that the image is clipped.
    imageView.clipsToBounds = true

    appBarViewController.applyPrimaryTheme(withScheme: containerScheme)

    // Make sure navigation bar background color is clear so the image view is visible.
    appBarViewController.navigationBar.backgroundColor = UIColor.clear

    // Allow the header to show more of the image.
    headerView.maximumHeight = 200

    // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
    headerView.observesTrackingScrollViewScrollEvents = true

    headerView.trackingScrollView = self.tableView

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    // Ensure that our status bar is white.
    return .lightContent
  }

  // MARK: Typical configuration

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Imagery (Swift)"

    // Behavioral flags.
    appBarViewController.inferTopSafeAreaInsetFromViewController = true
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false

    self.addChild(appBarViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func headerBackgroundImage() -> UIImage? {
    return UIImage(named: "mdc_theme",
                   in: Bundle(for: AppBarImagerySwiftExample.self),
                   compatibleWith: nil)
  }
}

// MARK: Catalog by convention
extension AppBarImagerySwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Imagery (Swift)"],
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
extension AppBarImagerySwiftExample {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.selectionStyle = .none
    return cell
  }
}
