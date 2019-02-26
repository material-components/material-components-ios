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

enum StateTheme: String {

  case onWhite, onPrimary
  case outline, elevated

  // Some themes "inherit" attributes from other themes (only 1 level
  // of inheritance is supported at this point):
  var baseTheme: StateTheme? {
    switch self {
    case .outline: return .onWhite
    case .elevated: return .onWhite
    default: return nil
    }
  }
}

// State dictionary is a list of attributes. An attribute is a list of resources:
typealias ResourceDictionary = [String:String]
typealias AttributeDictionary = [String:ResourceDictionary]
typealias StateDictionary = [String:AttributeDictionary]

/**

 Material State Scheme

 The State Scheme map stores state-related values that determine appearance of states in components
 for multiple themes. Each theme includes a pre-defined list of attributes that determine its
 appearance. Currently supported state-related attributes include:
     overlay color, container color, content color, border color and elevation.

 Each of the 5 attributes includes a single value for each of the states it relates to. Values may
 be missing if they inherit from "normal"/"enabled" state. If no normal/enabled state value is
 defined, then these missing values are ignore.

 These single values are stored as ResourceDictionary types, which are converted by getters
 and returnd as color resources (a ColorResource instances) - for color values, or as
 ShadowElevation - for elevation values.

 Each attribute is stored as a AttributeDictionary, which is a map of states (string keys) to
 ResourceDictionaries (values).

 An entire theme (for isntance: the "onWhite" theme) is stored as a StateDictionary, which is a
 dictionary of these 5 main attribures, each mapped to a AttributeDictionary which describes
 all its states.

 The dictionary structure is private, and access to it is available through getters and setters
 which convert the dictionary string data to types used by themers or other schemes.

 Dictionary values used enums to convert between between Strings and real values. See the
 MDCControlState enumeration for the full list of states; See Resource.Color.Semantic for the
 list of semantic color names; See Resource.Color.Palette and Resource.Color.Palette.Tint for
 palette and tint enumberaionts; And StateTheme for the list of themes.

 Each shadowElevation attribute has a getter and a setter, converting ShadowElevation to
 strings and vice versa.

 Each color attribute has a getter which returns a ColorResource class. When a ColorResource is
 passed to an instance of MDCSemanticColotScheme, it is converted to a "real" UIColor, based on
 values from the color scheme (see StateExampleColorScheme.realColor()).

 Additionally, each color attribute has 2 setters, one accepting a palette and another accepting
 a semantic color name (enum). These setters may be used to override specific state values when
 required. Setters accepting hex values are not supported at this point and may be added in the
 future as need arise.

 Implementation notes:

 * State names use material names. The mapping to UIControlState is:
      "enabled" == "normal"
      "pressed" == "highlighted".

 * State names also include states that do not exist in UIControlState,
      like: dragged, active & error.

 * The "Enabled" state (aka: "normal") will act as the default value in UIControls when
   values for "selected" or "pressed" states are not provided in this map.  This is a default
   behavior of UIControl, and an active assumption in building this map (meaning, values will not
   be provided for the "selected" or "pressed" states if they suppose to inherit from the
   "enabled" state).

 * "Darker" and "ligher" variations are used in MDC for a generic contrast increase of the
    interactive states. These are overriden with specific values for each color combinations
    (check overrides in init(withDefaults:)).

   Note that components supporting non-UIControlState states, like dragged, active & error, must
   adopt this implementation to get correct theming for those states (they must use the "enabled"
   state, if provided, as a default to the dragged, active & error states, if the latters are
   not provided).
 */

class StateScheme {

  // MARK: Private Theme Dictionaries

  private lazy var onWhite: StateDictionary = [
    "overlay": [
      "selected": ["semanticColor": "overlay", "opacity": "0.12"],
      "pressed": ["semanticColor": "overlay", "opacity": "0.10"],
      "dragged": ["semanticColor": "overlay", "opacity": "0.08"]
    ],
    "container": [
      "enabled": ["semanticColor": "surface"],
    ],
    "content": [
      "enabled": ["semanticColor": "on-surface"],
      "interactive": ["semanticColor": "on-surface", "darker": "0.2"],  // 20% darker onSurface
      "disabled": ["palette": "grey", "tint": "800", "opacity": "0.38"],
      "error": ["semanticColor": "error"],
    ],
    "border": [
      "focused": ["semanticColor": "overlay"],
    ],
    "shadowElevation": [
      "dragged": ["shadowElevation": "3"],
    ]
  ]

  private lazy var onPrimary: StateDictionary = [
    "overlay": [
      "selected": ["semanticColor": "overlay", "opacity": "0.24"],
      "pressed": ["semanticColor": "overlay", "opacity": "0.20"],
      "dragged": ["semanticColor": "overlay", "opacity": "0.16"]
    ],
    "container": [
      "enabled": ["semanticColor": "primary"],
      "disabled": ["palette": "grey", "tint": "800", "opacity": "0.12"],
    ],
    "content": [
      "enabled": ["semanticColor": "on-primary"],
      "interactive": ["semanticColor": "on-primary", "darker": "-0.2"],  // 20% lighter onPrimary
      "disabled": ["palette": "grey", "tint": "800", "opacity": "0.38"],
      "error": ["semanticColor": "error"],
    ],
    "border": [
      "focused": ["semanticColor": "overlay"],    // is this correct?
    ],
    "shadowElevation": [
      "pressed": ["shadowElevation": "2"],
      "dragged": ["shadowElevation": "3"],
    ]
  ]

  // This "theme" inherits all unspecified propertie from "onWhite"
  private lazy var outlined: StateDictionary = [
    "border": [
      "enabled": ["palette": "grey", "tint": "300"],
      "interactive": ["semanticColor": "on-surface", "darker": "0.2"],  // 20% darker onSurface
      "focused": ["semanticColor": "overlay"],
      "disabled": ["palette": "grey", "tint": "800", "opacity": "0.12"],
      "error": ["semanticColor": "error"],
    ],
  ]

  // This "theme" inherits all unspecified propertie from "onWhite"
  private var elevated: StateDictionary = [
    "shadowElevation": [
      "enabled": ["shadowElevation": "1"],
      "selected": ["shadowElevation": "1"],
      "active": ["shadowElevation": "1"],
      "pressed": ["shadowElevation": "3"],
      "dragged": ["shadowElevation": "4"],
    ]
  ]

  // MARK: Initializers

  init(withDefaults defaults: MDCColorSchemeDefaults) {

    // Overriding the calculated value of interactive states color - for all themes
    switch defaults {
    case .material201804:
      setContentColor(palette: .grey, tint: .tint900, forState: .interactive, forTheme: .onWhite)
      setBorderColor(palette: .grey, tint: .tint900, forState: .interactive, forTheme: .outline)
    }
  }

  // MARK: Attributes setters using UIColor

  // Color setter which accept a palette and tint + opacity for the given theme + state
  func setOverlayColor(palette: Resource.Color.Palette, tint: Resource.Color.Palette.Tint, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(palette: palette, tint: tint, opacity: opacity)
    setColor(attribute: "overlay", colorResource: resource, forState: state, forTheme: theme)
  }

  func setContainerColor(palette: Resource.Color.Palette, tint: Resource.Color.Palette.Tint, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(palette: palette, tint: tint, opacity: opacity)
    setColor(attribute: "container", colorResource: resource, forState: state, forTheme: theme)
  }

  func setContentColor(palette: Resource.Color.Palette, tint: Resource.Color.Palette.Tint, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(palette: palette, tint: tint, opacity: opacity)
    setColor(attribute: "content", colorResource: resource, forState: state, forTheme: theme)
  }

  func setBorderColor(palette: Resource.Color.Palette, tint: Resource.Color.Palette.Tint, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(palette: palette, tint: tint, opacity: opacity)
    setColor(attribute: "border", colorResource: resource, forState: state, forTheme: theme)
  }

  // MARK: Attribute setters Using Semantic Color Names

  // Color setter which accept a semantic color name + opacity for the given theme + state
  func setOverlayColor(semanticColorName: Resource.Color.Semantic, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(semanticColorName: semanticColorName, opacity: opacity)
    setColor(attribute: "overlay", colorResource: resource, forState: state, forTheme: theme)
  }

  func setContainerColor(semanticColorName: Resource.Color.Semantic, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(semanticColorName: semanticColorName, opacity: opacity)
    setColor(attribute: "container", colorResource: resource, forState: state, forTheme: theme)
  }

  func setContentColor(semanticColorName: Resource.Color.Semantic, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(semanticColorName: semanticColorName, opacity: opacity)
    setColor(attribute: "content", colorResource: resource, forState: state, forTheme: theme)
  }

  func setBorderColor(semanticColorName: Resource.Color.Semantic, opacity: CGFloat? = nil, forState state: MDCControlState, forTheme theme: StateTheme) {
    let resource = ColorResource(semanticColorName: semanticColorName, opacity: opacity)
    setColor(attribute: "border", colorResource: resource, forState: state, forTheme: theme)
  }

  // MARK: Color Attributes Getters

  // Overlay color getter, returning a State color, which can be transofrmed to a realColor by a colorScheme
  func overlayColorResource(forState state: MDCControlState, forTheme theme: StateTheme) -> ColorResource? {
    return color(attribute: "overlay", forState: state, forTheme: theme)
  }

  func containerColorResource(forState state: MDCControlState, forTheme theme: StateTheme) -> ColorResource? {
    return color(attribute: "container", forState: state, forTheme: theme)
  }

  func contentColorResource(forState state: MDCControlState, forTheme theme: StateTheme) -> ColorResource? {
    return color(attribute: "content", forState: state, forTheme: theme)
  }

  func borderColorResource(forState state: MDCControlState, forTheme theme: StateTheme) -> ColorResource? {
    return color(attribute: "border", forState: state, forTheme: theme)
  }

  // MARK: shadowElevation Attribute Setters & Getters

  func shadowElevation(forState state: MDCControlState, forTheme theme: StateTheme) -> ShadowElevation? {
    guard let stateDictionary: StateDictionary = {
      if let baseTheme = theme.baseTheme {
        // Themes that inherit from other themes. Assuming a single level of inheritance.
        return themeDictionary(theme) ?? themeDictionary(baseTheme)
      } else {
        // Base themes with no inheritance
        return themeDictionary(theme)
      }
    }() else { return nil }
    guard let attributeInfo = attribute(named: "shadowElevation", forState: state, dictionary: stateDictionary)
      else { return nil }
    if let elevationString = attributeInfo["shadowElevation"],
      let shadowElevation = Double(elevationString) {
      return ShadowElevation(rawValue: CGFloat(shadowElevation))
    }
    return nil
  }

  func setShadowElevation(_ elevation: ShadowElevation, forState state: MDCControlState, forTheme theme: StateTheme) {
    setShadowElevation(String(describing: elevation.rawValue), forState: state, forTheme: theme)
  }

  // MARK: Private utility methods

  /// Return the StateDictionary of the requested theme
  private func themeDictionary(_ theme: StateTheme) -> StateDictionary? {
    switch theme {
    case .onWhite: return onWhite
    case .onPrimary: return onPrimary
    case .outline: return outlined
    case .elevated: return elevated
    }
  }

  /// Returns the ResourceDictionary of the requested attribute name, for the requested state and theme.
  /// If the given state is an interactive state, and the speicifc state value is
  /// missing, the interactive state will be returned (if the value exists).
  private func attribute(named name: String, forState state: MDCControlState, dictionary: StateDictionary) -> ResourceDictionary? {
    guard let attributeInfo = dictionary[name] else { return nil }
    if let stateInfo = attributeInfo[state.name] {
      return stateInfo
    } else if state.isInteractive, let stateInfo = attributeInfo["interactive"] {
      return stateInfo
    }
    return nil
  }

  /// Returns the ColorResource of the requested attribute, for the requested state and theme.
  private func color(attribute attributeName: String, forState state: MDCControlState, forTheme theme: StateTheme) -> ColorResource? {
    guard let stateDictionary: StateDictionary = {
      if let baseTheme = theme.baseTheme {
        // Themes that inherit from other themes. Assuming a single level of inheritance.
        return themeDictionary(theme) ?? themeDictionary(baseTheme)
      } else {
        // Base themes with no inheritance
        return themeDictionary(theme)
      }
    }() else { return nil }
    guard let attributeInfo = attribute(named: attributeName, forState: state, dictionary: stateDictionary) else { return nil }
    return ColorResource(dictionary: attributeInfo)
  }

  /// Updates the ColorResource for the requested attribute, in the requested state and theme.
  private func setColor(attribute: String, colorResource: ColorResource, forState state: MDCControlState, forTheme theme: StateTheme) {
    switch theme {
    case .onWhite:
      onWhite[attribute]?[state.name] = colorResource.toDictionary()
    case .onPrimary:
      onPrimary[attribute]?[state.name] = colorResource.toDictionary()
    default: return
    }
  }

  /// Updates the ShadowElevation for the requested state and theme. (The attribute is always "shadowElevation")
  private func setShadowElevation(_ elevation: String, forState state: MDCControlState, forTheme theme: StateTheme) {
    switch theme {
    case .onWhite:
      onWhite["shadowElevation"]?[state.name] = ["shadowElevation": elevation]
    case .onPrimary:
      onPrimary["shadowElevation"]?[state.name] = ["shadowElevation": elevation]
    default: return
    }
  }
}

// MARK: ColorResource extension

private extension ColorResource {

  /**
    Converting a ResourceDictionary to a ColorResource, returning nil if the entry cannot
    be converted to a ColorResource. The representations of colors are supported:
    * "semanticColor" is verified against the list of semantic colors in MDCSemanticColorScheming.
    * "palette" and "tint" are verified againts valid Palette names and tints.
    * "hex" strings are verified as a valid 6-digit hex values (leading with an optional #).
   */
  init?(dictionary: ResourceDictionary) {

    let opacity: CGFloat? = {
      if let opacityString = dictionary["opacity"], let opacity = Double(opacityString) {
        return CGFloat(opacity)
      }
      return nil
    }()

    let darker: CGFloat? = {
      if let darkerString = dictionary["darker"], let darker = Double(darkerString) {
        return CGFloat(darker)
      }
      return nil
    }()

    if let semanticName = dictionary["semanticColor"] {
      // Verify semanticName is a valid semantic color
      guard let semanticColorName = Resource.Color.Semantic(rawValue: semanticName) else { return nil }
      self.init(semanticColorName: semanticColorName, opacity: opacity, darker: darker)
    } else if let hexColor = dictionary["hexColor"] {
      self.init(hex: hexColor, opacity: opacity, darker: darker)
    } else if let palette = dictionary["palette"], let tint = dictionary["tint"] {
      guard let palette = Resource.Color.Palette(rawValue: palette),
        let tint = Resource.Color.Palette.Tint(rawValue: tint) else { return nil }
      self.init(palette: palette, tint: tint, opacity: opacity, darker: darker)
    } else {
      return nil
    }
  }

  /// Serializing ColorResource to an ResourceDictionary dictionary
  func toDictionary() -> ResourceDictionary {
    var attributeDictionary: ResourceDictionary = [:]
    if let semanticColorName = self.semanticColorName {
      attributeDictionary["semanticColor"] = semanticColorName.rawValue
    } else if let palette = self.palette, let tint = self.tint {
      attributeDictionary["palette"] = palette.rawValue
      attributeDictionary["tint"] = tint.rawValue
    } else if let hexColor = self.hexColor {
      attributeDictionary["hexColor"] = hexColor
    }
    if let opacity = self.opacity {
      attributeDictionary["opacity"] = String(describing: opacity)
    }
    if let darker = self.darker {
      attributeDictionary["darker"] = String(describing: darker)
    }
    return attributeDictionary
  }
}
