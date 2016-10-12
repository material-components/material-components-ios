/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

import MaterialComponents

typealias ExampleTone = (name: String, tone: UIColor)

func ExampleTonesForPalette(palette: MDCPalette) -> [ExampleTone] {
  var tones : [ExampleTone] = [
    (MDCPaletteTint100Name, palette.tint100),
    (MDCPaletteTint300Name, palette.tint300),
    (MDCPaletteTint500Name, palette.tint500),
    (MDCPaletteTint700Name, palette.tint700),
    ]

  if let accent = palette.accent400 {
    tones.append((MDCPaletteAccent400Name, accent))
  }

  return tones
}

class PalettesExampleViewController: UITableViewController {
  var palettes : [(name: String, palette: MDCPalette)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorStyle = .None
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 50
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return palettes.count
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let palette = palettes[section].palette
    return ExampleTonesForPalette(palette).count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell")
    if cell == nil {
      cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
    }
    let paletteInfo = palettes[indexPath.section]
    let tones = ExampleTonesForPalette(paletteInfo.palette)
    cell!.textLabel!.text = tones[indexPath.row].name
    cell!.backgroundColor = tones[indexPath.row].tone
    cell!.selectionStyle = .None

    return cell!
  }

  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return palettes[section].name
  }

  convenience init() {
    self.init(style: .Grouped)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
