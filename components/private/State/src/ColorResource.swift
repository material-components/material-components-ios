// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

import UIKit

enum Resource {
  enum Color {
    enum Semantic: String {
      case primary = "primary", onPrimary = "on-primary", surface = "surface",
           onSurface = "on-surface", overlay = "overlay", error = "error",
           background = "background", onBackground = "on-background", outline = "outline"
    }
    enum Palette: String {

      case grey = "grey", blue = "blue", blueGrey = "bluegrey", indigo = "indigo", purple = "purple",
      red = "red", orange = "orange", yellow = "yellow"

      enum Tint: String {
        case tint50 = "50", tint100 = "100", tint200 = "200", tint300 = "300",
        tint400 = "400", tint500 = "500", tint600 = "600", tint700 = "700",
        tint800 = "800", tint900 = "900"
      }
    }
  }
}

/**
 ColorResource is a dynamic representation of a color-type resource. It supports different formats
 which represent colors in Material. It is also used in serialzing color, in any of the supported
 formats, to and from a dictionary.

 ColorResource uses enumerations to remain independent of a specific scheme implementaiton.
 It is produced by the state schemes, and built to be consumed by themers, which can then pass
 it to a color scheme to get a UIColor value specific to that color scheme.

 The following color formats are currently supported:
 * Hex: Strings in format "#999999"
 * Semantic names: an enum that corresponds to a color in MDCSemanticColorScheme
 * Palette names: enums of palettes and tints, corresponding to Material Palettes.

 Additionally, it supports 2 color variations, applied to a color, in any format:
 * Opacity: alpha percentage of the base color
 * Hue: percentage of darkness or lightness of the base color
 * [TBD: Emphasis: High, Medium, Low]

 Opacity and Hue are used to generate variations of the base colors. This is needed mainly in
 expressing states in components. The specific colors that these variations produce can later be
 overriden by specific color schemes to produce exact colors in case the default opacity/hue
 doesn't produce a sufficiently accessible color ratio.
 */
struct ColorResource: CustomStringConvertible {

  let hexColor: String?
  let semanticColorName: Resource.Color.Semantic?
  let palette: Resource.Color.Palette?
  let tint: Resource.Color.Palette.Tint?
  let opacity: CGFloat?
  let darker: CGFloat?

  /// Converting a semantic name to a ColorResource instance
  init(semanticColorName: Resource.Color.Semantic, opacity: CGFloat? = nil, darker: CGFloat? = nil) {
    self.semanticColorName = semanticColorName
    self.opacity = opacity
    self.darker = darker
    self.hexColor = nil
    self.palette = nil
    self.tint = nil
  }

  init(palette: Resource.Color.Palette, tint: Resource.Color.Palette.Tint, opacity: CGFloat? = nil, darker: CGFloat? = nil) {
    self.palette = palette
    self.tint = tint
    self.opacity = opacity
    self.darker = darker
    self.semanticColorName = nil
    self.hexColor = nil
  }

  /// Converting a hex string to a ColorResource instance
  init?(hex: String, opacity: CGFloat? = nil, darker: CGFloat? = nil) {
    // Verify the given string is a valid 6-digit hex number
    if let first = hex.first, first == "#" {
      guard hex.count == 7, Int(hex.dropFirst(), radix: 16) != nil else { return nil }
    } else {
      guard hex.count == 6, Int(hex, radix: 16) != nil else { return nil }
    }
    self.hexColor = hex
    self.opacity = opacity
    self.darker = darker
    self.semanticColorName = nil
    self.palette = nil
    self.tint = nil
  }

  /// Converting a UIColor color to a ColorResource instance
  init(realColor: UIColor, opacity: CGFloat? = nil, darker: CGFloat? = nil) {
    let (hexColor, alpha) = realColor.toHex()
    self.hexColor = hexColor
    self.opacity = opacity ?? alpha // provided opacity supersedes alpha if found in UIColor
    self.darker = darker
    self.semanticColorName = nil
    self.palette = nil
    self.tint = nil
  }

  var description: String {
    var desc = ""
    if let hex = self.hexColor {
      desc += " hexColor: \(hex)"
    }
    if let semantic = self.semanticColorName {
      desc += " semantic: \(semantic) (\(semantic.rawValue))"
    }
    if let palette = self.palette {
      desc += " palette: \(palette)"
    }
    if let tint = self.tint {
      desc += " tint: \(tint)"
    }
    if let opacity = self.opacity {
      desc += " opacity: \(opacity)"
    }
    if let darker = self.darker {
      desc += " darker: \(darker)"
    }
    return String(desc.dropFirst())
  }
}


/// Convenience UIColor extensions to serialize UIColors to and from string hex values.
extension UIColor {

  /// Returning UIColor as a hex string: #FFFFFF. Alpha values are ignored.
  var hex: String {
    let colorRef = cgColor.components
    let r = colorRef?[0] ?? 0
    let g = colorRef?[1] ?? 0
    let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0

    let hexString = String(
      format: "#%02lX%02lX%02lX",
      lroundf(Float(r * 255)),
      lroundf(Float(g * 255)),
      lroundf(Float(b * 255))
    )

    return hexString
  }

  /// Returning UIColor as a tuple with a hex string: #FFFFFF and an alpha value
  func toHex() -> (String, CGFloat?) {
    let colorRef = cgColor.components
    let r = colorRef?[0] ?? 0
    let g = colorRef?[1] ?? 0
    let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
    let a = cgColor.alpha

    let hexString = String(
      format: "#%02lX%02lX%02lX",
      lroundf(Float(r * 255)),
      lroundf(Float(g * 255)),
      lroundf(Float(b * 255))
    )

    return (hexString, a)
  }

  /// Initialize a UIColor using a hex string. The initializer fails if the string is invalid.
  convenience init?(hexString hex: String, a: CGFloat? = 1.0) {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
      return nil
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: a ?? 1.0
    )
  }
}

/// Convenience UIColor extensions to make UIColor darker or lighter by a given percentage
extension UIColor {

  func lighter(amount : CGFloat = 0.25) -> UIColor {
    return hueColor(withBrightness: 1 + amount)
  }

  func darker(amount : CGFloat = 0.25) -> UIColor {
    return hueColor(withBrightness: 1 - amount)
  }

  private func hueColor(withBrightness multiplier: CGFloat) -> UIColor {
    var hue         : CGFloat = 0
    var saturation  : CGFloat = 0
    var brightness  : CGFloat = 0
    var alpha       : CGFloat = 0

    getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    return UIColor( hue: hue,
                    saturation: saturation,
                    brightness: brightness * multiplier,
                    alpha: alpha )
  }
}
