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

#import <Foundation/Foundation.h>
#import "MDCColorResource.h"
#import "MDCControlState.h"
#import "MaterialColorScheme.h"

/**
  MDCStateSchemeTheme lists the themes of the StateScheme. Each
  theme has its own set of state-related information.
  Themers typically use a single theme to theme all states of components.
  For instnace, a text and hairline button themers will use the "OnWhite" theme for
  all state information. A contained button themer will use the "OnPrimary" theme.

  Note that some themes, like outline and elevated may not have state information
  for all attributes, and will inherit attributes they don't have from a  base
  theme (either OnWhite and OnPrimary).
  Note: Theme inheritence is calculated in [self baseThemeDictionary:]
*/
typedef NS_ENUM(NSInteger, MDCStateSchemeTheme) {
  MDCStateSchemeThemeOnWhite,    // full theme
  MDCStateSchemeThemeOnPrimary,  // full theme
  MDCStateSchemeThemeOutlined,   // inherits from: onWhite
  MDCStateSchemeThemeElevated    // inherits from: onWhite
};

/**

 Material State Scheme

 The State Scheme map stores state-related values that determine appearance of states in components.
 The map supports multiple themes, like OnWhite or OnPrimary. Each theme includes a pre-defined list
 of attributes that determine its appearance. Currently supported state-related attributes include:
 overlay color, container color, content color, border color and elevation.

 Each of the 5 attributes includes a single value for each of the states it relates to. Values may
 be missing if they inherit from "normal"/"enabled" state. If no normal/enabled state value is
 defined, then these missing values are ignored.

 These single values are stored internally as ResourceDictionary types, which are converted by
 getters and returnd as a ColorResource instances - for color values, or as ShadowElevation type -
 for elevation values.

 The actual attributes are stored as AttributeDictionary types, which is a mapping of states
 (keys) to ResourceDictionaries (values).

 An entire theme (for isntance: the "onWhite" theme) is stored as a StateDictionary, which is a
 dictionary of these 5 main attribures, each mapped to a AttributeDictionary which describes
 all its states.

 The dictionary structure is private, and access to it is available through getters and setters
 which convert the dictionary string data to types used by themers or other schemes.

 Dictionary values use enums to convert between the archived format (NSString) and the "real"/actual
 values. The enumerations include: the MDCControlState enumeration lists states;
 MDCColorResourceSemantic lists semantic color names; MDCColorResourcePalette and
 MDCColorResourcePaletteTint list palettes and tints; MDCStateSchemeTheme lists all themes.

 Each shadowElevation attribute has a getter and a setter, converting ShadowElevation to
 strings and vice versa.

 Each color attribute has a getter which returns a MDCColorResource class. MDCSemanticColotScheme's
 realColorWithResource: converts a color resource to an actual color taken from the color
 scheme.

 Attributes also have setters. Setters are used to override specific state values as needed, for
 instance, when a contrast ratio is too low for some color schemes. Overrides for Material's default
 color scheme are updated in the StateScheme's initializer.

 Each color attribute has 2 setters, one accepting a palette color (enum) and another accepting
 a semantic color name (enum). These setters may be used to override specific state values when
 required. Setters accepting hex values are not supported at this point and may be added in the
 future as need arise.

 Implementation notes:

 * State names use material names. The mapping to UIControlState is:
   "enabled" == "normal"
   "pressed" == "highlighted".
   All other state names are the same for both Material theming and UIControl.

 * State names also include states that do not exist in UIControlState,
   like: dragged, active & error.

 * The "Enabled" state (aka: "normal") acts as the default value in UIControls when values for
   other states, like "selected" or "pressed", are not provided in this map.  This is a default
   behavior of UIControl, and an active assumption in building this map (meaning, values will not
   be provided for states if they meant to be inherit from the "enabled/nomral" state).

   Note that components supporting non-UIControlState states, like Dragged, Active or Error, must
   adopt this implementation to get correct theming for those states (they must use the "enabled"
   state, if provided, as a default to the dragged, active & error states, if the latters are
   not provided).

 * "Darker" and "ligher" variations are used in MDC for a generic contrast increase of the
   interactive states. These are overriden with specific values for each color combinations
   (check overrides in init(withDefaults:)).

 */

@interface MDCStateScheme : NSObject

/**
 Initializes the state scheme with override specific to the given default color scheme.
 */
- (nonnull instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults;

#pragma mark - getters

/// Returns a Color Resource representing an overlay color, for the given state & theme
- (MDCColorResource *)overlayColorResourceForState:(MDCControlState)state
                                             theme:(MDCStateSchemeTheme)theme;

/// Returns a Color Resource representing a container color, for the given state & theme
- (MDCColorResource *)containerColorResourceForState:(MDCControlState)state
                                               theme:(MDCStateSchemeTheme)theme;

/// Returns a Color Resource representing a content color, for the given state & theme
- (MDCColorResource *)contentColorResourceForState:(MDCControlState)state
                                             theme:(MDCStateSchemeTheme)theme;

/// Returns a Color Resource representing a border color, for the given state & theme
- (MDCColorResource *)borderColorResourceForState:(MDCControlState)state
                                            theme:(MDCStateSchemeTheme)theme;

#pragma mark - setters by semantic name

/// An overlay color setter, accepting a semantic color, for the given state & theme
- (void)setOverlayColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                 opacity:(CGFloat)opacity
                                forState:(MDCControlState)state
                                 inTheme:(MDCStateSchemeTheme)theme;

/// A container color setter, accepting a semantic color, for the given state & theme
- (void)setContainerColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                   opacity:(CGFloat)opacity
                                  forState:(MDCControlState)state
                                   inTheme:(MDCStateSchemeTheme)theme;

/// A content color setter, accepting a semantic color, for the given state & theme
- (void)setContentColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                 opacity:(CGFloat)opacity
                                forState:(MDCControlState)state
                                 inTheme:(MDCStateSchemeTheme)theme;

/// A border color setter, accepting a semantic color, for the given state & theme
- (void)setBorderColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                opacity:(CGFloat)opacity
                               forState:(MDCControlState)state
                                inTheme:(MDCStateSchemeTheme)theme;

@end
