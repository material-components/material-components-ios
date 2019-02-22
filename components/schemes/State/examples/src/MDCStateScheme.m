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

#import "MDCStateScheme.h"
#import "MaterialStates.h"

typedef NSDictionary<NSString *, NSString *> MDCResourceDictionary;
typedef NSDictionary<NSString *, MDCResourceDictionary *> MDCAttributeDictionary;
typedef NSDictionary<NSString *, MDCAttributeDictionary *> MDCStateDictionary;
typedef NSMutableDictionary<NSString *, MDCResourceDictionary *> MDCAttributeMutableDictionary;
typedef NSDictionary<NSString *, MDCAttributeMutableDictionary *> MDCStateMutableDictionary;

@interface MDCColorResource (Private)

/**
 A private extension of MDCColorResource which converts a dictionary (of type ResourceDictionary)
 to an MDCColorResource instance, returning nil if the entry cannot be converted.
 ResourceDictionaries with the following color formats are supported:
 * "semanticColor" is verified against the list of semantic colors in MDCSemanticColorScheming.
 * "palette" and "tint" are verified againts valid Palette names and tints.
 * "hex" strings are verified as a valid 6-digit hex values (leading with an optional #).
 */
- (nonnull instancetype)initWithResourceDictionary:(MDCResourceDictionary *)dictionary;
- (MDCResourceDictionary *)toDictionary;

@end

@interface MDCStateScheme ()
@property(nonatomic, strong, nonnull) MDCStateMutableDictionary *onWhite;
@property(nonatomic, strong, nonnull) MDCStateMutableDictionary *onPrimary;
@property(nonatomic, strong, nonnull) MDCStateMutableDictionary *outlined;
@property(nonatomic, strong, nonnull) MDCStateMutableDictionary *elevated;

@end

@implementation MDCStateScheme

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    [self initializeStateDictionaries];
  }
  return self;
}

- (void)initializeStateDictionaries {
  self.onWhite = [NSMutableDictionary dictionaryWithDictionary:@{
    @"overlay" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"selected" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.12"}],
      @"pressed" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.10"}],
      @"dragged" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.08"}],
    }],
    @"container" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"surface"}],
    }],
    @"content" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" :
          [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"on-surface"}],
      @"interactive" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"on-surface", @"dim" : @"0.2"}],
      @"disabled" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"palette" : @"grey", @"tint" : @"800", @"opacity" : @"0.38"}],
      @"error" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"error"}],
    }],
    @"border" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"focused" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"overlay"}],
    }],
    @"shadowElevation" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"dragged" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"3"}],
    }]
  }];

  self.onPrimary = [NSMutableDictionary dictionaryWithDictionary:@{
    @"overlay" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"selected" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.24"}],
      @"pressed" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.20"}],
      @"dragged" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay", @"opacity" : @"0.16"}],
    }],
    @"container" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"primary"}],
      @"disabled" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"palette" : @"grey", @"tint" : @"800", @"opacity" : @"0.12"}],
    }],
    @"content" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" :
          [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"on-primary"}],
      @"interactive" : [NSMutableDictionary dictionaryWithDictionary:@{
        @"semanticColor" : @"on-primary",
        @"dim" : @"-0.2"
      }],  // 20% lighter onPrimary
      @"disabled" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"palette" : @"grey", @"tint" : @"800", @"opacity" : @"0.38"}],
      @"error" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"error"}],
    }],
    @"border" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"focused" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"overlay"}],  // is this correct?
    }],
    @"shadowElevation" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"pressed" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"2"}],
      @"dragged" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"3"}],
    }]
  }];

  // The outlined theme inherits all unlisted attributes from "onWhite" (see baseThemeDictionary:)
  // Attributes are inherited in their entirety. If an attribute is listed in the child theme, all
  // its states are taken from the child theme, and all parent states are ignored for those
  // attributes. Attributes that are not listed in the child theme, will be taken from the parent.
  self.outlined = [NSMutableDictionary dictionaryWithDictionary:@{
    @"border" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" :
          [NSMutableDictionary dictionaryWithDictionary:@{@"palette" : @"grey", @"tint" : @"300"}],
      @"interactive" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"semanticColor" : @"on-surface", @"dim" : @"0.2"}],
      @"focused" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"overlay"}],
      @"disabled" : [NSMutableDictionary
          dictionaryWithDictionary:@{@"palette" : @"grey", @"tint" : @"800", @"opacity" : @"0.12"}],
      @"error" : [NSMutableDictionary dictionaryWithDictionary:@{@"semanticColor" : @"error"}],
    }]
  }];

  // The elevated theme inherits all unspecified propertie from "onWhite" (see
  // baseThemeDictionary:)
  self.elevated = [NSMutableDictionary dictionaryWithDictionary:@{
    @"shadowElevation" : [NSMutableDictionary dictionaryWithDictionary:@{
      @"enabled" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"1"}],
      @"selected" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"1"}],
      @"active" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"1"}],
      @"pressed" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"3"}],
      @"dragged" : [NSMutableDictionary dictionaryWithDictionary:@{@"shadowElevation" : @"4"}],
    }]
  }];
}

- (nonnull instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults {
  // First initialize the state dictionary
  self = [self init];
  if (self) {
    // Override specific values as needed
    switch (defaults) {
      case MDCColorSchemeDefaultsMaterial201804:
        // TODO: Add overrides for MDCColorSchemeDefaultsMaterial201804:
        //[self setContentColor:...];
        //[self setBorderColor:...];
        break;
    }
  }
  return self;
}

#pragma mark - Color Attributes Getters

- (MDCColorResource *)overlayColorResourceForState:(MDCControlState)state
                                             theme:(MDCStateSchemeTheme)theme {
  return [self colorForAttributeNamed:@"overlay" state:state theme:theme];
}

- (MDCColorResource *)containerColorResourceForState:(MDCControlState)state
                                               theme:(MDCStateSchemeTheme)theme {
  return [self colorForAttributeNamed:@"container" state:state theme:theme];
}

- (MDCColorResource *)contentColorResourceForState:(MDCControlState)state
                                             theme:(MDCStateSchemeTheme)theme {
  return [self colorForAttributeNamed:@"content" state:state theme:theme];
}

- (MDCColorResource *)borderColorResourceForState:(MDCControlState)state
                                            theme:(MDCStateSchemeTheme)theme {
  return [self colorForAttributeNamed:@"border" state:state theme:theme];
}

#pragma mark - Color Setters By Semantic Name

- (void)setOverlayColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                 opacity:(CGFloat)opacity
                                forState:(MDCControlState)state
                                 inTheme:(MDCStateSchemeTheme)theme {
  MDCColorResource *resource =
      [[MDCColorResource alloc] initWithSemanticResource:semanticName
                                                 opacity:opacity
                                                     dim:MDCColorResourceDefaultDim];
  [self setColorResource:resource forAttribute:@"overlay" state:state theme:theme];
}

- (void)setContainerColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                   opacity:(CGFloat)opacity
                                  forState:(MDCControlState)state
                                   inTheme:(MDCStateSchemeTheme)theme {
  MDCColorResource *resource =
      [[MDCColorResource alloc] initWithSemanticResource:semanticName
                                                 opacity:opacity
                                                     dim:MDCColorResourceDefaultDim];
  [self setColorResource:resource forAttribute:@"container" state:state theme:theme];
}

- (void)setContentColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                 opacity:(CGFloat)opacity
                                forState:(MDCControlState)state
                                 inTheme:(MDCStateSchemeTheme)theme {
  MDCColorResource *resource =
      [[MDCColorResource alloc] initWithSemanticResource:semanticName
                                                 opacity:opacity
                                                     dim:MDCColorResourceDefaultDim];
  [self setColorResource:resource forAttribute:@"content" state:state theme:theme];
}

- (void)setBorderColorWithSemanticColor:(MDCColorResourceSemantic)semanticName
                                opacity:(CGFloat)opacity
                               forState:(MDCControlState)state
                                inTheme:(MDCStateSchemeTheme)theme {
  MDCColorResource *resource =
      [[MDCColorResource alloc] initWithSemanticResource:semanticName
                                                 opacity:opacity
                                                     dim:MDCColorResourceDefaultDim];
  [self setColorResource:resource forAttribute:@"border" state:state theme:theme];
}

#pragma mark - private helpers

/// Return the StateDictionary of the requested theme
- (nullable MDCStateDictionary *)themeDictionary:(MDCStateSchemeTheme)theme {
  switch (theme) {
    case MDCStateSchemeThemeOnWhite:
      return self.onWhite;
    case MDCStateSchemeThemeOnPrimary:
      return self.onPrimary;
    case MDCStateSchemeThemeOutlined:
      return self.outlined;
    case MDCStateSchemeThemeElevated:
      return self.elevated;
  }
}

/// Returns the "parent" theme a theme inherits from. Top level themes, like onWhite and onPrimary
/// return nil since they do not inherit from other themes.
- (nullable MDCStateDictionary *)baseThemeDictionary:(MDCStateSchemeTheme)theme {
  switch (theme) {
    case MDCStateSchemeThemeOutlined:
      return self.onWhite;
    case MDCStateSchemeThemeElevated:
      return self.onWhite;
    default:
      return nil;
  }
}

/// Returns the ResourceDictionary of the requested attribute, for the requested state and theme.
/// If the given state is an interactive state, and the speicifc state value is
/// missing, the interactive state will be returned (if the value exists).
/// Will return nil if the requested info is not found in the dictionary
- (nullable MDCResourceDictionary *)attributeNamed:(NSString *)name
                                             state:(MDCControlState)state
                                        dictionary:(MDCStateDictionary *)dictionary {
  MDCAttributeDictionary *attributeInfo = dictionary[name];
  if (attributeInfo == nil) {
    return nil;
  }

  NSString *stateName = [self controlStateName:state];
  if (attributeInfo[stateName] != nil) {
    // Quering the state info by the name of the requested state
    return attributeInfo[stateName];
  } else if ([self controlStateIsInteractive:state]) {
    // fallback for "interactive" states if the value for the requested name is nil.
    return attributeInfo[@"interactive"];
  }
  // TODO: for non ui-controlState states, like dragged, error, active, etc - verify if
  //       we need to return the "enabled" state here, or is this the responsibility of
  //       the components?
  return nil;
}

/// Returns the ColorResource of the requested attribute, for the requested state and theme.
- (nullable MDCColorResource *)colorForAttributeNamed:(NSString *)name
                                                state:(MDCControlState)state
                                                theme:(MDCStateSchemeTheme)theme {
  // Get parent (base) and main dictionaries of the requested theme.
  MDCStateDictionary *baseThemeDictionary = [self baseThemeDictionary:theme];
  MDCStateDictionary *themeDictionary = [self themeDictionary:theme];

  // Get the attribute from the main dictionary
  MDCResourceDictionary *attribute = [self attributeNamed:name
                                                    state:state
                                               dictionary:themeDictionary];

  // If the attribute is not found in the main dictionary, get it from the parent (if exists).
  if (attribute == nil && baseThemeDictionary != nil) {
    attribute = [self attributeNamed:name state:state dictionary:baseThemeDictionary];
  }

  // If we found the attribute in either dictionary - return it as an MDCColorResource
  if (attribute != nil) {
    return [[MDCColorResource alloc] initWithResourceDictionary:attribute];
  }

  // The requested attribute was not found
  return nil;
}

/// Updates the ColorResource for the requested attribute, in the requested state and theme.
- (void)setColorResource:(MDCColorResource *)resource
            forAttribute:(NSString *)attributeName
                   state:(MDCControlState)state
                   theme:(MDCStateSchemeTheme)theme {
  NSString *stateName = [self controlStateName:state];

  switch (theme) {
    case MDCStateSchemeThemeOnWhite:
      if (self.onWhite[attributeName] != nil) {
        self.onWhite[attributeName][stateName] = [resource toDictionary];
      }
      break;

    case MDCStateSchemeThemeOnPrimary:
      if (self.onPrimary[attributeName] != nil) {
        self.onPrimary[attributeName][stateName] = [resource toDictionary];
      }
      break;

    default:
      break;
  }
}

- (bool)controlStateIsInteractive:(MDCControlState)controlState {
  return (controlState & MDCControlStateHighlighted) != 0 ||
         (controlState & MDCControlStateSelected) != 0 ||
         (controlState & MDCControlStateActive) != 0 ||
         (controlState & MDCControlStateFocused) != 0 ||
         (controlState & MDCControlStateDragged) != 0;
}

- (NSString *)controlStateName:(MDCControlState)controlState {
  switch (controlState) {
    case MDCControlStateNormal:
      return @"normal";
      break;
    case MDCControlStateHighlighted:
      return @"pressed";
      break;
    case MDCControlStateSelected:
      return @"selected";
      break;
    case MDCControlStateActive:
      return @"active";
      break;
    case MDCControlStateFocused:
      return @"focused";
      break;
    case MDCControlStateDragged:
      return @"dragged";
      break;
    case MDCControlStateDisabled:
      return @"disabled";
      break;
    case MDCControlStateError:
      return @"error";
      break;
    case MDCControlStateInteractive:
      return @"interactive";
      break;
  }
}

@end

@implementation MDCColorResource (Private)

/// Converting a scheme dictionary to an MDCColorResource instance
- (nonnull instancetype)initWithResourceDictionary:(MDCResourceDictionary *)dictionary {
  CGFloat opacity = MDCColorResourceDefaultOpacity;
  if (dictionary[@"opacity"].length > 0) {
    // value is converted to float, and truncated to no more than 2 percision digits
    float floatValue = [dictionary[@"opacity"] floatValue];
    opacity = round(floatValue * 100.0) / 100.0;
  }

  CGFloat dim = MDCColorResourceDefaultDim;
  if (dictionary[@"dim"].length > 0) {
    dim = [dictionary[@"dim"] floatValue];
  }

  NSString *semanticName = dictionary[@"semanticColor"];
  if (semanticName.length > 0) {
    MDCColorResourceSemantic semantic = [self semanticResourceFromName:semanticName];
    if (semantic == MDCColorResourceSemanticNone) {
      return nil;  // provided semantic name is invalid.
    }
    return [self initWithSemanticResource:semantic opacity:opacity dim:dim];
  }

  NSString *paletteName = dictionary[@"palette"];
  NSString *tintName = dictionary[@"tint"];
  if (paletteName.length || tintName.length) {
    MDCColorResourcePalette palette = [self paletteResourceFromName:paletteName];
    MDCColorResourcePaletteTint tint = [self paletteTintResourceFromName:tintName];
    if (palette == MDCColorResourcePaletteNone || tint == MDCColorResourcePaletteTintNone) {
      return nil;  // provided palette and/or tint are invalid
    }

    return [self initWithPaletteResource:palette tint:tint opacity:opacity dim:dim];
  }

  NSString *hexColor = dictionary[@"hexColor"];
  if (!hexColor.length) {
    return [self initWithHexString:hexColor opacity:opacity dim:dim];
  }

  return nil;
}

/// Converting a  MDCColorResource to a MDCResourceDictionary dictionary
- (MDCResourceDictionary *)toDictionary {
  NSMutableDictionary<NSString *, NSString *> *dictionary = [[NSMutableDictionary alloc] init];
  dictionary[@"semanticColor"] = [self semanticNameFromResource:self.semantic];
  dictionary[@"palette"] = [self paletteNameFromResource:self.palette];
  dictionary[@"tint"] = [self paletteTintNameFromResource:self.tint];
  if (self.hexColor != nil) {
    dictionary[@"hexColor"] = self.hexColor;
  }
  if (self.opacity != MDCColorResourceDefaultOpacity) {
    dictionary[@"opacity"] = [NSString stringWithFormat:@"%f", self.opacity];
  }
  if (self.dim != MDCColorResourceDefaultDim) {
    dictionary[@"dim"] = [NSString stringWithFormat:@"%f", self.dim];
  }
  return dictionary;
}

@end
