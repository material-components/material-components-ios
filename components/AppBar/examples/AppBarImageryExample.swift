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

class AppBarImagerySwiftExample: UITableViewController {
  let appBar = MDCAppBar()

  override func viewDidLoad() {
    super.viewDidLoad()

    let headerView = appBar.headerViewController.headerView

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

    // We want navigation bar + status bar tint color to be white, so we set tint color here and
    // implement -preferredStatusBarStyle.
    headerView.tintColor = UIColor.white
    appBar.navigationBar.titleTextAttributes =
      [ NSForegroundColorAttributeName: UIColor.white ]

    // Allow the header to show more of the image.
    headerView.maximumHeight = 200

    headerView.trackingScrollView = self.tableView
    self.tableView.delegate = appBar.headerViewController

    appBar.addSubviewsToParent()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    // Ensure that our status bar is white.
    return .lightContent
  }

  // MARK: Typical configuration

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Imagery (Swift)"

    self.addChildViewController(appBar.headerViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func headerBackgroundImage() -> UIImage {
    let bundle = Bundle(for: AppBarImagerySwiftExample.self)
    let imagePath = bundle.path(forResource: "mdc_theme", ofType: "png")!
    return UIImage(contentsOfFile: imagePath)!
  }
}

// MARK: Catalog by convention
extension AppBarImagerySwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "Imagery (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
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
      var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
      if cell == nil {
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      }
      cell!.layoutMargins = UIEdgeInsets.zero
      return cell!
  }
}
