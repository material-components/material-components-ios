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

import UIKit
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialNavigationDrawer_ColorThemer 
import MaterialComponents.MaterialNavigationDrawer
import MaterialComponents.MaterialColorScheme

class BottomDrawerSwappingScrollViewsExample: UIViewController {
  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  let bottomAppBar = MDCBottomAppBarView()

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = SwappingScrollViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    contentViewController.colorScheme = colorScheme

    bottomAppBar.isFloatingButtonHidden = true
    let barButtonLeadingItem = UIBarButtonItem()
    let menuImage = UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate)
    barButtonLeadingItem.image = menuImage
    barButtonLeadingItem.target = self
    barButtonLeadingItem.action = #selector(presentNavigationDrawer)
    bottomAppBar.leadingBarButtonItems = [barButtonLeadingItem]

    bottomAppBar.barTintColor = colorScheme.surfaceColor
    let barItemTintColor = colorScheme.onSurfaceColor.withAlphaComponent(0.6)
    bottomAppBar.leadingBarItemsTintColor = barItemTintColor
    bottomAppBar.trailingBarItemsTintColor = barItemTintColor
    bottomAppBar.floatingButton.setBackgroundColor(colorScheme.primaryColor, for: .normal)
    bottomAppBar.floatingButton.setTitleColor(colorScheme.onPrimaryColor, for: .normal)
    bottomAppBar.floatingButton.setImageTintColor(colorScheme.onPrimaryColor, for: .normal)

    view.addSubview(bottomAppBar)
  }

  private func layoutBottomAppBar() {
    let size = bottomAppBar.sizeThatFits(view.bounds.size)
    var bottomBarViewFrame = CGRect(
      x: 0,
      y: view.bounds.size.height - size.height,
      width: size.width,
      height: size.height)
    bottomBarViewFrame.size.height += view.safeAreaInsets.bottom
    bottomBarViewFrame.origin.y -= view.safeAreaInsets.bottom
    bottomAppBar.frame = bottomBarViewFrame
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    layoutBottomAppBar()
  }

  @objc private func presentNavigationDrawer() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.contentViewController = contentViewController
    contentViewController.setDrawer(drawer: bottomDrawerViewController)
    bottomDrawerViewController.headerViewController = headerViewController
    MDCBottomDrawerColorThemer.applySemanticColorScheme(
      colorScheme,
      toBottomDrawer: bottomDrawerViewController)
    present(bottomDrawerViewController, animated: true, completion: nil)
  }
}

class SwappingScrollViewController: UIViewController, UITableViewDataSource {
  @objc var colorScheme: MDCSemanticColorScheme!
  weak var drawerVC: MDCBottomDrawerViewController!
  var tableView1: UITableView!
  var tableView2: UITableView!

  override func loadView() {
    super.loadView()

    self.view.backgroundColor = .white

    tableView1 = UITableView()
    tableView1.dataSource = self
    self.view.addSubview(tableView1)

    tableView2 = UITableView()
    tableView2.dataSource = self

    tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    let switchButton = UIButton(type: .system)
    switchButton.setTitle("Switch Scroll View", for: .normal)
    switchButton.addTarget(self, action: #selector(switchScrollView(sender:)), for: .touchUpInside)
    switchButton.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 48)

    tableView1.tableHeaderView = switchButton
  }

  func setDrawer(drawer: MDCBottomDrawerViewController) {
    drawerVC = drawer

    // Default to the first scroll view for initial presentation.
    drawer.trackingScrollView = tableView1
  }

  @objc func switchScrollView(sender: AnyObject) {
    tableView1.removeFromSuperview()

    // Switch active scroll views
    self.view.addSubview(tableView2)
    drawerVC.trackingScrollView = tableView2
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    tableView1.frame = self.view.bounds
    tableView2.frame = self.view.bounds

    self.preferredContentSize = CGSize(width: 0, height: tableView1.contentSize.height)
  }

  @available(iOS 11.0, *)
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()

    self.preferredContentSize = CGSize(width: 0, height: tableView1.contentSize.height)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    if tableView == tableView1 {
      cell.textLabel?.text = "Scroll View 1"
    } else {
      cell.textLabel?.text = "Scroll View 2"
    }

    return cell
  }
}

extension BottomDrawerSwappingScrollViewsExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer Swapping ScrollViews"],
      "description": "Navigation Drawer",
      "presentable": true,
    ]
  }
}
