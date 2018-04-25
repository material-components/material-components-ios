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
    [("Settings", MDCIcons.imageFor_ic_settings()?.withRenderingMode(.alwaysTemplate)),
     ("Themes", MDCIcons.imageFor_ic_color_lens()?.withRenderingMode(.alwaysTemplate)),
     ("Help", MDCIcons.imageFor_ic_help_outline()?.withRenderingMode(.alwaysTemplate))]
  let cellIdentifier = "MenuCell"
  let iconColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    self.tableView.separatorStyle = .none
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let cellData = tableData[indexPath.item]
    cell.textLabel?.text = cellData.0
    cell.textLabel?.textColor = iconColor
    cell.imageView?.image = cellData.1
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

