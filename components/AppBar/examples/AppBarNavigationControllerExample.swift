// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

class AppBarNavigationControllerExampleViewController:
    UIViewController,
    MDCAppBarNavigationControllerDelegate {

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Navigation Controller"
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor

    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Present", style: .done, target: self, action: #selector(presentModal))
  }

  @objc func presentModal() {
    let contentViewController = PresentedViewController()
    let navigationController = MDCAppBarNavigationController()
    navigationController.shouldSetNavigationBarHiddenHideAppBar = true
    navigationController.delegate = self
    navigationController.pushViewController(contentViewController, animated: false)

    contentViewController.navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "Dismiss",
                        style: .done,
                        target: self,
                        action: #selector(dismissModal))

    // Explicitly use the full-screen style to validate safe area insets behavior.
    navigationController.modalPresentationStyle = .fullScreen

    self.present(navigationController, animated: true, completion: nil)
  }

  @objc func dismissModal() {
    dismiss(animated: true)
  }

  // MARK: - MDCAppBarNavigationControllerDelegate

  func appBarNavigationController(_ navigationController: MDCAppBarNavigationController,
                                  willAdd appBarViewController: MDCAppBarViewController,
                                  asChildOf viewController: UIViewController) {
    appBarViewController.applyPrimaryTheme(withScheme: self.containerScheme)
  }
}

private class PresentedViewController: UITableViewController {

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Presented"

    self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(title: "Toggle",
                        style: .done,
                        target: self,
                        action: #selector(toggleVisibility))
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK - Actions

  @objc func toggleVisibility() {
    guard let navigationController = navigationController else {
      return
    }
    navigationController.setNavigationBarHidden(!navigationController.isNavigationBarHidden,
                                                animated: true)
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    return self.tableView.dequeueReusableCell(withIdentifier: "cell") ??
      UITableViewCell(style: .default, reuseIdentifier: "cell")
  }

  // MARK - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    toggleVisibility()

    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: Catalog by convention
extension AppBarNavigationControllerExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["App Bar", "Navigation Controller"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
