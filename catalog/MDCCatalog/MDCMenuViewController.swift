/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

import UIKit
import MaterialComponents.MDCIcons

class MDCMenuViewController: UITableViewController {

  let tableData =
    [(title: "Settings", icon: MDCIcons.imageFor_ic_settings()?.withRenderingMode(.alwaysTemplate)),
     (title: "Themes", icon: MDCIcons.imageFor_ic_color_lens()?.withRenderingMode(.alwaysTemplate)),
     (title: "Help", icon: MDCIcons.imageFor_ic_help_outline()?.withRenderingMode(.alwaysTemplate))]
  let cellIdentifier = "MenuCell"
  let iconColor = AppTheme.globalTheme.colorScheme.onSurfaceColor.withAlphaComponent(0.61)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    self.tableView.separatorStyle = .none
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let cellData = tableData[indexPath.item]
    cell.textLabel?.text = cellData.title
    cell.textLabel?.textColor = iconColor
    cell.imageView?.image = cellData.icon
    cell.imageView?.tintColor = iconColor
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.dismiss(animated: true, completion: nil)
  }

}

