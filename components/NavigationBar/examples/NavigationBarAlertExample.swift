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

import UIKit
import MaterialComponents.MaterialNavigationBar_ColorThemer 
import MaterialComponents.MaterialNavigationBar

open class NavigationBarAlertExample: UIViewController {
  let navBar = MDCNavigationBar()
  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201907)
  let exampleView = ExampleInstructionsViewNavigationBarTypicalUseSwift()

  open override func viewDidLoad() {
    super.viewDidLoad()

    title = "Navigation Bar"
    navBar.observe(navigationItem)

    view.backgroundColor = colorScheme.backgroundColor

    view.addSubview(navBar)
    MDCNavigationBarColorThemer.applySemanticColorScheme(colorScheme, to: navBar)
    navBar.translatesAutoresizingMaskIntoConstraints = false

    self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.navBar.topAnchor).isActive =
      true

    let viewBindings = ["navBar": navBar]

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[navBar]|",
        options: [],
        metrics: nil,
        views: viewBindings))

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Show alert", style: .plain, target: self, action: #selector(showPopoverAlert(_:)))
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  @objc func showPopoverAlert(_ sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alertController.modalPresentationStyle = .popover
    alertController.popoverPresentationController?.sourceView = navBar
    alertController.popoverPresentationController?.sourceRect = navBar.rect(
      forTrailing: sender, in: navBar)

    alertController.addAction(
      UIAlertAction(title: "Sample action 1", style: .default, handler: nil))
    alertController.addAction(
      UIAlertAction(title: "Sample action 2", style: .default, handler: nil))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

    present(alertController, animated: true, completion: nil)
  }
}

// MARK: - CatalogByConvention
extension NavigationBarAlertExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Bar", "Popover Alert"],
      "primaryDemo": false,
      "presentable": false,
      "snapshotDelay": 1.0,
      "thresholdPercentage": 4.0,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}

// MARK: - SnapshotTestingByConvention

extension NavigationBarAlertExample {
  @objc func testAlertIsAnchoredOverBarButton() {
    showPopoverAlert(navigationItem.rightBarButtonItem!)
  }
}
