// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

import MaterialComponents.MaterialPalettes
import MDFTextAccessibility

/// Returns a high-contrast color for text against @c backgroundColor. If no such color can be found,
/// returns black.
///
/// @params backgroundColor the background color to use for contrast calculations.
///
/// @returns a color with sufficiently-high contrast against @c backgroundColor, else just returns
///          black.
func TextColorFor(backgroundColor: UIColor) -> UIColor {
  if let safeColor = MDFTextAccessibility.textColor(
    fromChoices: [.black, .white],
    onBackgroundColor: backgroundColor,
    options: [.enhancedContrast, .preferDarker])
  {
    return safeColor
  } else if let safeColor = MDFTextAccessibility.textColor(
    fromChoices: [.black, .white],
    onBackgroundColor: backgroundColor,
    options: .preferDarker)
  {
    return safeColor
  }
  return .black
}

typealias ExampleTone = (name: String, tone: UIColor)

func ExampleTonesForPalette(_ palette: MDCPalette) -> [ExampleTone] {
  var tones: [ExampleTone] = [
    (MDCPaletteTint.tint100Name.rawValue, palette.tint100),
    (MDCPaletteTint.tint300Name.rawValue, palette.tint300),
    (MDCPaletteTint.tint500Name.rawValue, palette.tint500),
    (MDCPaletteTint.tint700Name.rawValue, palette.tint700),
  ]

  if let accent = palette.accent400 {
    tones.append((MDCPaletteAccent.accent400Name.rawValue, accent))
  }

  return tones
}

class PalettesExampleViewController: UITableViewController {
  var palettes: [(name: String, palette: MDCPalette)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorStyle = .none
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 50
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return palettes.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let palette = palettes[section].palette
    return ExampleTonesForPalette(palette).count
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "cell")
      ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    let paletteInfo = palettes[indexPath.section]
    let tones = ExampleTonesForPalette(paletteInfo.palette)
    cell.textLabel?.text = tones[indexPath.row].name
    cell.backgroundColor = tones[indexPath.row].tone
    if let cellBackgroundColor = cell.backgroundColor {
      cell.textLabel?.textColor = TextColorFor(backgroundColor: cellBackgroundColor)
    }
    cell.selectionStyle = .none

    return cell
  }
  override func tableView(
    _ tableView: UITableView, willDisplayHeaderView view: UIView,
    forSection section: Int
  ) {
    if let headerView = view as? UITableViewHeaderFooterView {
      if let backgroundColor = headerView.backgroundColor != nil
        ? headerView.backgroundColor
        : tableView.backgroundColor
      {
        headerView.textLabel?.textColor = TextColorFor(backgroundColor: backgroundColor)
      } else {
        headerView.textLabel?.textColor = .black
      }
    }
  }

  override func tableView(
    _ tableView: UITableView,
    titleForHeaderInSection section: Int
  ) -> String? {
    return palettes[section].name
  }

  convenience init() {
    self.init(style: .grouped)
  }

  override init(style: UITableView.Style) {
    super.init(style: style)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
