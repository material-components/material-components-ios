// Copyrigh 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialBottomNavigation_BottomNavigationController 
import MaterialComponents.MaterialBottomNavigation_Theming 
import MaterialComponents.MaterialContainerScheme

@available(iOS 12.0, *)
class BottomNavigationHideShowExample: UIViewController {
  static let cellReuseIdentifier = "cell"
  static let numberOfCells = 40

  @objc var containerScheme = MDCContainerScheme()

  let bottomNavBarController = MDCBottomNavigationBarController()
  lazy var tableViewController: UITableViewController = {
    let tableViewController = UITableViewController()
    tableViewController.tableView.register(
      UITableViewCell.self,
      forCellReuseIdentifier: BottomNavigationHideShowExample.cellReuseIdentifier)
    tableViewController.tableView.dataSource = self
    return tableViewController
  }()

  lazy var rightBarButtonItem = UIBarButtonItem(
    title: "Hide", style: .plain, target: self, action: #selector(toggleBottomBar))

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = rightBarButtonItem

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    bottomNavBarController.navigationBar.applyPrimaryTheme(withScheme: containerScheme)

    bottomNavBarController.willMove(toParent: self)
    view.addSubview(bottomNavBarController.view)
    addChild(bottomNavBarController)
    bottomNavBarController.didMove(toParent: self)
    bottomNavBarController.navigationBar.titleVisibility = .always

    let viewController1 = tableViewController
    viewController1.title = "Chat"

    let viewController2 = UIViewController()
    viewController2.title = "Mail"
    viewController2.view.backgroundColor = .blue

    let viewController3 = UIViewController()
    viewController3.title = "Meetings"
    viewController3.view.backgroundColor = .green

    bottomNavBarController.viewControllers = [viewController1, viewController2, viewController3]
  }

  @objc func toggleBottomBar(animated: Bool = true) {
    bottomNavBarController.setNavigationBarHidden(
      !bottomNavBarController.isNavigationBarHidden,
      animated: animated)
    rightBarButtonItem.title = bottomNavBarController.isNavigationBarHidden ? "Show" : "Hide"
  }
}

@available(iOS 12.0, *)
extension BottomNavigationHideShowExample: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return BottomNavigationHideShowExample.numberOfCells
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: BottomNavigationHideShowExample.cellReuseIdentifier, for: indexPath)
    let isLastRow = indexPath.row == (BottomNavigationHideShowExample.numberOfCells - 1)
    cell.textLabel?.text = isLastRow ? "Last row" : nil
    return cell
  }
}

// MARK: Catalog by convention
@available(iOS 12.0, *)
extension BottomNavigationHideShowExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Navigation", "Show/Hide"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc class func minimumOSVersion() -> OperatingSystemVersion {
    return OperatingSystemVersion(majorVersion: 12, minorVersion: 0, patchVersion: 0)
  }
}

// MARK: Snapshot Testing by Convention
@available(iOS 12.0, *)
extension BottomNavigationHideShowExample {
  @objc func testAdjustsContentInsetsForHiddenBottomBar() {
    toggleBottomBar(animated: false)
    let lastIndexPath = IndexPath(
      row: BottomNavigationHideShowExample.numberOfCells - 1, section: 0)
    tableViewController.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
  }
}
