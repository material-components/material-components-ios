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

import Foundation

/**
 Creating a new StateExampleColorScheming in order to add a couple of colors and
 the realColor(colorResource:) method, which converts a color resource to an actual UIColor.

 Note: onPrimaryColorVariant and onSurfaceColorVariant are not used in state theming.
 */
protocol StateExampleColorScheming: MDCColorScheming {
  var MDCColorScheme: MDCColorScheming { get }

  var primaryColor: UIColor { get set }
  var secondaryColor: UIColor { get set }
  var errorColor: UIColor { get set }
  var surfaceColor: UIColor { get set }
  var backgroundColor: UIColor { get set }
  var onPrimaryColor: UIColor { get set }
  var onSecondaryColor: UIColor { get set }
  var onSurfaceColor: UIColor { get set }
  var onBackgroundColor: UIColor { get set }

  // New semantic color names
  var overlayColor: UIColor { get set }
  var outlineColor: UIColor { get set }   // Adding outline for now, to align with GM
}

/**
 Creating a new StateExampleColorScheme which (a) defines and uses the overlayColor, (b) creates
 all the default colors schemes used by the example [TBD], and (c) includes a realColor() function
 which converts a ColorResource to UIColor.
 */
class StateExampleColorScheme: StateExampleColorScheming {
  let MDCColorScheme: MDCColorScheming

  var primaryColor: UIColor
  var primaryColorVariant: UIColor // Required to conform to MDCColorScheming protocol. Not used in prototype.
  var secondaryColor: UIColor
  var errorColor: UIColor
  var surfaceColor: UIColor
  var backgroundColor: UIColor
  var onPrimaryColor: UIColor
  var onSecondaryColor: UIColor
  var onSurfaceColor: UIColor
  var onBackgroundColor: UIColor

  // New semantic color names
  var overlayColor: UIColor
  var outlineColor: UIColor

  init(withDefaults defaults: MDCColorSchemeDefaults) {

    MDCColorScheme = MDCSemanticColorScheme(defaults: .material201804)

    switch defaults {

    case .material201804:

      // State system colors
      surfaceColor = MDCColorScheme.surfaceColor
      onSurfaceColor = MDCColorScheme.onSurfaceColor

      backgroundColor = MDCColorScheme.backgroundColor
      onBackgroundColor = MDCColorScheme.onBackgroundColor

      // Assigning new values. No mapping in MDCColorScheme.
      overlayColor = MDCPalette.grey.tint800
      outlineColor = MDCPalette.grey.tint300

      primaryColor = MDCColorScheme.primaryColor
      onPrimaryColor = MDCColorScheme.onPrimaryColor
      primaryColorVariant = MDCColorScheme.primaryColorVariant

      errorColor = MDCColorScheme.errorColor

      // Colors not used in state theming
      secondaryColor = MDCColorScheme.secondaryColor
      onSecondaryColor = MDCColorScheme.onSecondaryColor
    }
  }
}

extension StateExampleColorScheme {
  
  /// Converting a ColorResource to a real color, taken from the current color scheme.
  func realColor(colorResource: ColorResource) -> UIColor? {

    // Convert the resource to a UIColor, using one of the color formats
    guard let color: UIColor = {
      if let hexString = colorResource.hexColor {
        // Convert a hext string to a UIColor
        return UIColor(hexString: hexString)
      } else if let palette = colorResource.palette, let tint = colorResource.tint {
        // Convert a palette + tint values to a UIColor
        let palette: MDCPalette = {
          switch palette {
          case .grey: return MDCPalette.grey
          case .blueGrey: return MDCPalette.blueGrey
          case .indigo: return MDCPalette.indigo
          case .blue: return MDCPalette.blue
          case .purple: return MDCPalette.purple
          case .red: return MDCPalette.red
          case .orange: return MDCPalette.orange
          case .yellow: return MDCPalette.yellow
          }
        }()
        switch tint {
        case .tint50: return palette.tint50
        case .tint100: return palette.tint100
        case .tint200: return palette.tint200
        case .tint300: return palette.tint300
        case .tint400: return palette.tint400
        case .tint500: return palette.tint500
        case .tint600: return palette.tint600
        case .tint700: return palette.tint700
        case .tint800: return palette.tint800
        case .tint900: return palette.tint900
        }
      } else if let semanticName = colorResource.semanticColorName {
        // Convert a semantic name to a UIColor
        switch semanticName {
        case .primary: return primaryColor
        case .onPrimary: return onPrimaryColor
        case .surface: return surfaceColor
        case .onSurface: return onSurfaceColor
        case .background: return backgroundColor
        case .onBackground: return onBackgroundColor
        case .outline: return outlineColor
        case .overlay: return overlayColor
        case .error: return errorColor
        }
      }
      return nil
      }() else {
        return nil
    }
    // Add opacity and hue variations
    if let opacity = colorResource.opacity, opacity < CGFloat(1.0) {
      return color.withAlphaComponent(opacity)
    } else if let percent = colorResource.darker {
      return percent > 0 ? color.darker(amount: percent) : color.lighter(amount: -percent)
    } else {
      return color
    }
  }

}
