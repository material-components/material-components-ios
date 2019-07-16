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

private func randomFloat() -> CGFloat {
  return CGFloat(arc4random()) / CGFloat(UInt32.max)
}

private func generateRandomPalettes(_ count: Int) -> [(name: String, palette: MDCPalette)] {
  var palettes = [(name: String, palette: MDCPalette)]()
  for _ in 1...count {
    let rgb = [randomFloat(), randomFloat(), randomFloat()]
    let name = String(format: "Generated from #%2X%2X%2X",
                      Int(rgb[0] * 255),
                      Int(rgb[1] * 255),
                      Int(rgb[2] * 255))
    let color = UIColor.init(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1)
    palettes.append((name, MDCPalette.init(generatedFrom: color)))
  }
  return palettes
}

class PalettesGeneratedExampleViewController: PalettesExampleViewController {
  fileprivate let numPalettes = 10

  convenience init() {
    self.init(style: .grouped)
    self.palettes = generateRandomPalettes(numPalettes)
  }
}

// MARK: - Catalog by convention
extension PalettesGeneratedExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Palettes", "Generated Palettes"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
