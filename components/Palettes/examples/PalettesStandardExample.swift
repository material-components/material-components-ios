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

class PalettesStandardExampleViewController: PalettesExampleViewController {
  convenience init() {
    self.init(style: .grouped)
    self.palettes = [
      ("Red", MDCPalette.red()),
      ("Pink", MDCPalette.pink()),
      ("Purple", MDCPalette.purple()),
      ("Deep Purple", MDCPalette.deepPurple()),
      ("Indigo", MDCPalette.indigo()),
      ("Blue", MDCPalette.blue()),
      ("Light Blue", MDCPalette.lightBlue()),
      ("Cyan", MDCPalette.cyan()),
      ("Teal", MDCPalette.teal()),
      ("Green", MDCPalette.green()),
      ("Light Green", MDCPalette.lightGreen()),
      ("Lime", MDCPalette.lime()),
      ("Yellow", MDCPalette.yellow()),
      ("Amber", MDCPalette.amber()),
      ("Orange", MDCPalette.orange()),
      ("Deep Orange", MDCPalette.deepOrange()),
      ("Brown", MDCPalette.brown()),
      ("Grey", MDCPalette.grey()),
      ("Blue Grey", MDCPalette.blueGrey())
    ]
  }
}

// MARK: Catalog by convention
extension PalettesStandardExampleViewController {
  class func catalogBreadcrumbs() -> [String] {
    return ["Palettes", "Standard Palettes"]
  }

  class func catalogDescription() -> String {
    return "The Palettes component provides sets of reference colors that work well together."
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }
}
