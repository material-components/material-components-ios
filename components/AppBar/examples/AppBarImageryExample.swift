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

class AppBarImagerySwiftExample: UITableViewController {
  let appBar = MDCAppBar()

  override func viewDidLoad() {
    super.viewDidLoad()

    let headerView = appBar.headerViewController.headerView

    // Create our custom image view and add it to the header view.
    let imageView = UIImageView(image: self.headerBackgroundImage())
    imageView.frame = headerView.bounds

    // Ensure that the image view resizes in reaction to the header view bounds changing.
    imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    // Ensure that the image view is below other App Bar views (headerStackView).
    headerView.insertSubview(imageView, atIndex: 0)

    // Scales up the image while the header is over-extending.
    imageView.contentMode = .ScaleAspectFill

    // The header view does not clip to bounds by default so we ensure that the image is clipped.
    imageView.clipsToBounds = true

    // We want navigation bar + status bar tint color to be white, so we set tint color here and
    // implement -preferredStatusBarStyle.
    headerView.tintColor = UIColor.whiteColor()

    // Allow the header to show more of the image.
    headerView.maximumHeight = 200

    headerView.trackingScrollView = self.tableView
    self.tableView.delegate = appBar.headerViewController

    appBar.addSubviewsToParent()
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    // Ensure that our status bar is white.
    return .LightContent
  }

  // MARK: Typical configuration

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.title = "Imagery (Swift)"

    self.addChildViewController(appBar.headerViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func headerBackgroundImage() -> UIImage {
    let bundle = NSBundle(forClass: AppBarImagerySwiftExample.self)
    let imagePath = bundle.pathForResource("mdc_theme", ofType: "png")!
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
