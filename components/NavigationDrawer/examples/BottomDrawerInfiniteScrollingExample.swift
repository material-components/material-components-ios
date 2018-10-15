// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponentsAlpha.MaterialNavigationDrawer
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme

class BottomDrawerInfiniteScrollingExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  let button = MDCButton()

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentTableViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    contentViewController.colorScheme = colorScheme

    button.setTitle("Show Navigation Drawer", for: .normal)
    button.sizeToFit()
    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = colorScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)
    button.addTarget(self, action: #selector(presentNavigationDrawer), for: .touchUpInside)
    view.addSubview(button)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    button.center = view.center
  }

  @objc private func presentNavigationDrawer() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.trackingScrollView = contentViewController.tableView
    present(bottomDrawerViewController, animated: true, completion: nil)
  }
}

class DrawerContentTableViewController: UITableViewController {
  var colorScheme: MDCSemanticColorScheme!

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: tableView.contentSize.height)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.primaryColor
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    self.tableView.isScrollEnabled = false
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "cell #\(indexPath.item)"
    cell.backgroundColor = colorScheme.surfaceColor
    if #available(iOS 10.0, *) {
      cell.textLabel?.adjustsFontForContentSizeCategory = true
    }
    print(cell.textLabel?.text ?? "")
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

extension BottomDrawerInfiniteScrollingExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer Infinite Scrolling"],
      "description": "Navigation Drawer",
      "primaryDemo": true,
      "presentable": true,
    ]
  }
}
