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

class AppBarInterfaceBuilderSwiftExample: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  let appBar = MDCAppBar()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonAppBarInterfaceBuilderSwiftExampleSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    commonAppBarInterfaceBuilderSwiftExampleSetup()
  }

  func commonAppBarInterfaceBuilderSwiftExampleSetup() {
    addChildViewController(appBar.headerViewController)
    let headerColor = UIColor(white: 0.2, alpha:1)
    appBar.headerViewController.headerView.backgroundColor = headerColor

    let mutator = MDCAppBarTextColorAccessibilityMutator()
    mutator.mutate(appBar)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    appBar.headerViewController.headerView.trackingScrollView = scrollView

    scrollView.delegate = appBar.headerViewController

    appBar.addSubviewsToParent()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    // Ensure that our status bar is white.
    return .lightContent
  }
}

// MARK: Catalog by convention
extension AppBarInterfaceBuilderSwiftExample {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["App Bar", "Interface Builder (Swift)"]
  }

  @objc class func catalogStoryboardName() -> String {
    return "AppBarInterfaceBuilderSwiftExampleController"
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  func catalogShouldHideNavigation() -> Bool {
    return true
  }

}
