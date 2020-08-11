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

#if !targetEnvironment(macCatalyst)

import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MaterialButtons_ButtonThemer 
import MaterialComponents.MaterialButtons

/// In this example we present a tableview with a height that is longer than the
/// BottomSheetTableViewExample. For a more comprehensive example see BottomSheetTypicalUseExample.m.
class BottomSheetLongTableViewExample: UIViewController {
  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  @objc var typographyScheme = MDCTypographyScheme()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Table View Menu"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor

    let button = MDCButton()
    button.setTitle("Show bottom sheet", for: .normal)
    button.addTarget(
      self,
      action: #selector(BottomSheetTableViewExample.didTapFloatingButton),
      for: .touchUpInside)

    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = colorScheme
    buttonScheme.typographyScheme = typographyScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)

    button.sizeToFit()
    button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    button.autoresizingMask = [
      .flexibleLeftMargin,
      .flexibleTopMargin,
      .flexibleRightMargin,
      .flexibleBottomMargin,
    ]

    view.addSubview(button)
  }

  @objc func didTapFloatingButton(_ sender: MDCFloatingButton) {
    let menu = BottomSheetTableViewMenu(style: .plain)
    let bottomSheet = MDCBottomSheetController(contentViewController: menu)
    bottomSheet.isScrimAccessibilityElement = true
    bottomSheet.scrimAccessibilityLabel = "Close"
    bottomSheet.trackingScrollView = menu.tableView
    present(bottomSheet, animated: true)
  }
}

private class BottomSheetTableViewMenu: UITableViewController {

  let tableData = [
    "Action 1",
    "Action 2",
    "Action 3",
    "Action 4",
    "Action 5",
    "Action 6",
    "Action 7",
    "Action 8",
    "Action 9",
    "Action 10",
    "Action 11",
    "Action 12",
    "Action 13",
  ]
  let cellIdentifier = "MenuCell"

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    self.tableView.separatorStyle = .none
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let cellData = tableData[indexPath.item]
    cell.textLabel?.text = cellData
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: Catalog by convention
extension BottomSheetLongTableViewExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Bottom Sheet", "Long Table View Menu"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

#endif
