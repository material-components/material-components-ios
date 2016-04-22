/*
Copyright 2016-present Google Inc. All Rights Reserved.

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

// This example is primarily a visual example of the various Typography fonts. The code below is a
// standard UIKit table view configuration using Auto Layout for height calculation.

class TypographyFontListExampleViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.separatorStyle = .None

    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 50
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return strings.count
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fonts.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell")
    if cell == nil {
      cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
    }
    cell!.textLabel!.text = strings[indexPath.section]
    cell!.textLabel!.font = fonts[indexPath.row]
    cell!.textLabel!.alpha = fontOpacities[indexPath.row]
    cell!.textLabel!.numberOfLines = 0
    cell!.textLabel!.lineBreakMode = .ByWordWrapping

    if cell!.textLabel!.font.pointSize > 100 && indexPath.section == 0 {
      cell!.textLabel!.text = "MDC"
    }

    cell!.detailTextLabel!.text = fontStyleNames[indexPath.row]
    cell!.detailTextLabel!.font = MDCTypography.captionFont()
    cell!.detailTextLabel!.alpha = MDCTypography.captionFontOpacity()
    cell!.selectionStyle = .None

    return cell!
  }

  convenience init() {
    self.init(style: .Plain)
  }

  override init(style: UITableViewStyle) {
    super.init(style: style)

    self.title = "Font list"
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  let strings = [
    "Material Design Components",
    "A quick brown fox jumped over the lazy dog.",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    "abcdefghijklmnopqrstuvwxyz",
    "1234567890",
    "!@#$%^&*()-=_+[]\\;',./<>?:\""
  ]

  let fonts = [

    // Common UI fonts.
    MDCTypography.headlineFont(),
    MDCTypography.titleFont(),
    MDCTypography.subheadFont(),
    MDCTypography.body2Font(),
    MDCTypography.body1Font(),
    MDCTypography.captionFont(),
    MDCTypography.buttonFont(),

    // Display fonts (extra large fonts)
    MDCTypography.display1Font(),
    MDCTypography.display2Font(),
    MDCTypography.display3Font(),
    MDCTypography.display4Font()
  ]

  let fontOpacities = [

    // Common UI fonts.
    MDCTypography.headlineFontOpacity(),
    MDCTypography.titleFontOpacity(),
    MDCTypography.subheadFontOpacity(),
    MDCTypography.body2FontOpacity(),
    MDCTypography.body1FontOpacity(),
    MDCTypography.captionFontOpacity(),
    MDCTypography.buttonFontOpacity(),

    // Display fonts (extra large fonts)
    MDCTypography.display1FontOpacity(),
    MDCTypography.display2FontOpacity(),
    MDCTypography.display3FontOpacity(),
    MDCTypography.display4FontOpacity()
  ]

  let fontStyleNames = [

    // Common UI fonts.
    "Headline Font",
    "Title Font",
    "Subhead Font",
    "Body 2 Font",
    "Body 1 Font",
    "Caption Font",
    "Button Font",

    // Display fonts (extra large fonts)
    "Display 1 Font",
    "Display 2 Font",
    "Display 3 Font",
    "Display 4 Font"
  ]
}

// MARK: Catalog by convention
extension TypographyFontListExampleViewController {
  class func catalogBreadcrumbs() -> [String] {
    return ["Typography and Fonts", "Typography"]
  }

  class func catalogDescription() -> String {
    return "The Typography component provides methods for displaying text using the type sizes and"
      + " opacities from the Material Design specifications."
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }
}
