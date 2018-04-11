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

import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialThemes
import UIKit

private func createSchemeWithPalette(_ palette: MDCPalette) -> MDCSemanticColorScheme {
  let scheme = MDCSemanticColorScheme()
  scheme.primaryColor = palette.tint500
  scheme.primaryColorVariant = palette.tint900
  scheme.secondaryColor = scheme.primaryColor
  return scheme
}

class MDCThemePickerViewController: UITableViewController {
  convenience init() {
    self.init(style: .plain)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

    view.backgroundColor = .white
  }

  private let colorSchemeRows = [
    (
      name: "Blue",
      colorScheme: { return createSchemeWithPalette(MDCPalette.blue) }
    ),
    (
      name: "Red",
      colorScheme: { return createSchemeWithPalette(MDCPalette.red) }
    ),
    (
      name: "Green",
      colorScheme: { return createSchemeWithPalette(MDCPalette.green) }
    ),
    (
      name: "Amber",
      colorScheme: { return createSchemeWithPalette(MDCPalette.amber) }
    ),
    (
      name: "Pink",
      colorScheme: { return createSchemeWithPalette(MDCPalette.pink) }
    ),
    (
      name: "Orange",
      colorScheme: { return createSchemeWithPalette(MDCPalette.orange) }
    )
  ]
  private let cellReuseIdentifier = "cell"

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colorSchemeRows.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    let row = colorSchemeRows[indexPath.row]
    cell.textLabel?.text = row.name
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = colorSchemeRows[indexPath.row]
    let colorScheme = row.colorScheme
    AppTheme.globalTheme = AppTheme(colorScheme: colorScheme())

    navigationController?.popViewController(animated: true)
  }
}

// MARK: Catalog by convention
extension MDCThemePickerViewController {
  class func catalogBreadcrumbs() -> [String] {
    return ["Themes", "Change current theme"]
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }
}
