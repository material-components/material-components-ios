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

class PalettesExampleViewController: UITableViewController {
  private let palettes = [
    ("Red", MDCPalette.redPalette),
    ("Pink", MDCPalette.pinkPalette),
    ("Purple", MDCPalette.purplePalette),
    ("Deep Purple", MDCPalette.deepPurplePalette),
    ("Indigo", MDCPalette.indigoPalette),
    ("Blue", MDCPalette.bluePalette),
    ("Light Blue", MDCPalette.lightBluePalette),
    ("Cyan", MDCPalette.cyanPalette),
    ("Teal", MDCPalette.tealPalette),
    ("Green", MDCPalette.greenPalette),
    ("Light Green", MDCPalette.lightGreenPalette),
    ("Lime", MDCPalette.limePalette),
    ("Yello", MDCPalette.yellowPalette),
    ("Amber", MDCPalette.amberPalette),
    ("Orange", MDCPalette.orangePalette),
    ("Deep Orange", MDCPalette.deepOrangePalette),
    ("Brown", MDCPalette.brownPalette),
    ("Grey", MDCPalette.greyPalette),
    ("Blue Grey", MDCPalette.blueGreyPalette),
  ]

  // Note that not all palettes have accent colors.
  private let tones = [
    (MDCPaletteTint100Name, { (palette: MDCPalette) -> UIColor in palette.tint100 }),
    (MDCPaletteTint300Name, { (palette: MDCPalette) -> UIColor in palette.tint300 }),
    (MDCPaletteTint500Name, { (palette: MDCPalette) -> UIColor in palette.tint500 }),
    (MDCPaletteTint700Name, { (palette: MDCPalette) -> UIColor in palette.tint700 }),
    (MDCPaletteAccent400Name, { (palette: MDCPalette) -> UIColor in palette.accent400! }),
  ]

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
    let palette = palettes[section].1()
    return palette.accent200 != nil ? 5 : 4;
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell")
    if cell == nil {
      cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
    }
    cell!.textLabel!.text = palettes[indexPath.section].0 + " " + tones[indexPath.row].0
    cell!.textLabel!.numberOfLines = 0
    cell!.textLabel!.lineBreakMode = .ByWordWrapping

    let palette = palettes[indexPath.section].1()
    let tone = tones[indexPath.row].1(palette)
    cell!.backgroundColor = tone
    cell!.selectionStyle = .None

    return cell!
  }

  convenience init() {
    self.init(style: .Plain)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)

    self.title = "Palettes"
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Catalog by convention
extension PalettesExampleViewController {
  class func catalogBreadcrumbs() -> [String] {
    return ["Palettes", "Palettes"]
  }

  class func catalogDescription() -> String {
    return "The Palettes component provides sets of reference colors that work well together."
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }
}
