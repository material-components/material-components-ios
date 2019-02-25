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

// Note: Make sure to update [semanticResourceFromName:] when changing or adding values
typedef NS_ENUM(NSInteger, MDCColorResourceSemantic) {
  MDCColorResourceSemanticNone,
  MDCColorResourceSemanticPrimary,
  MDCColorResourceSemanticOnPrimary,
  MDCColorResourceSemanticSurface,
  MDCColorResourceSemanticOnSurface,
  MDCColorResourceSemanticOverlay,
  MDCColorResourceSemanticBackground,
  MDCColorResourceSemanticOnBackground,
  MDCColorResourceSemanticOutline,
  MDCColorResourceSemanticError,
};

// Note: Make sure to update [paletteResourceFromName:] when changing or adding values
typedef NS_ENUM(NSInteger, MDCColorResourcePalette) {
  MDCColorResourcePaletteNone,
  MDCColorResourcePaletteGrey,
  MDCColorResourcePaletteBlue,
  MDCColorResourcePaletteBlueGrey,
  MDCColorResourcePaletteIndigo,
  MDCColorResourcePalettePurple,
  MDCColorResourcePaletteRed,
  MDCColorResourcePaletteOrange,
  MDCColorResourcePaletteYellow,
};

// Note: Make sure to update [paletteTintResourceFromName:] when changing or adding values
typedef NS_ENUM(NSInteger, MDCColorResourcePaletteTint) {
  MDCColorResourcePaletteTintNone,
  MDCColorResourcePaletteTint50,
  MDCColorResourcePaletteTint100,
  MDCColorResourcePaletteTint200,
  MDCColorResourcePaletteTint300,
  MDCColorResourcePaletteTint400,
  MDCColorResourcePaletteTint500,
  MDCColorResourcePaletteTint600,
  MDCColorResourcePaletteTint700,
  MDCColorResourcePaletteTint800,
  MDCColorResourcePaletteTint900,
};

static const CGFloat MDCColorResourceDefaultOpacity = 1.0;
static const CGFloat MDCColorResourceDefaultDim = 1.0;

/**
 MDCColorResource is a dynamic representation of color resources. It supports different
 formats of colors used in Material Theming. It is also used in serializing colors (in any of
 its supported formats) to and from a dictionary.

 ColorResource uses enumerations which allows it to be independent of specific color formats.
 StateScheme getters return ColorResource, which can be later converted by themers to an actual
 UIColor. Themers who pass a ColorResource to a color scheme, get an actual UIColor that is based
 on colors from those color schemes.

 The following color formats are currently supported:
 * Hex: Strings in format "#999999"
 * Semantic names: an MDCColorResourceSemantic enum that corresponds to an
                   MDCSemanticColorScheme color
 * Palette names: MDCColorResourcePalette and MDCColorResourcePaletteTint enumerations,
                  corresponding to MDCPalettes and tints.

 Additionally, MDCColorResource supports 2 color variations, applied to a color, in any format:
 * Opacity: alpha percentage of the base color
 * Dim: percentage of darkness (values between 0 & 1.0) or lightness (values between -1.0 and 0)
        of the base color. Examples: 0.25 means 25% darker color. -0.15 is 15% lighter color.
 * [TBD: Emphasis: High, Medium, Low]

 Note:
 Opacity and Dim are used to generate variations of the base color. This is needed
 mainly for expressing state colors when the makeup of colors in a colorScheme is
 unknown (as is in MDC).  These variations may fit many color schemes, but it can
 also be overridden if needed, especially in cases in which the color scheme does
 not produce a sufficiently accessible contrast ratio.
 */

@interface MDCColorResource : NSObject

@property(nonatomic, strong, readonly, nullable) NSString *hexColor;
@property(nonatomic, assign, readonly) MDCColorResourceSemantic semantic;
@property(nonatomic, assign, readonly) MDCColorResourcePalette palette;
@property(nonatomic, assign, readonly) MDCColorResourcePaletteTint tint;
@property(nonatomic, assign, readonly) CGFloat opacity;
@property(nonatomic, assign, readonly) CGFloat dim;

/// Initializes a color resource representing a semantic color
- (nonnull instancetype)initWithSemanticResource:(MDCColorResourceSemantic)semanticResource;

/// Initializes a color resource representing a semantic color, with given opacity or dim
- (nonnull instancetype)initWithSemanticResource:(MDCColorResourceSemantic)semanticResource
                                         opacity:(CGFloat)opacity
                                             dim:(CGFloat)dim;

/// Initializes a color resource representing a palette+tint color
- (nonnull instancetype)initWithPaletteResource:(MDCColorResourcePalette)palette
                                           tint:(MDCColorResourcePaletteTint)tint;

/// Initializes a color resource representing a palette+tint color, with given opacity or dim
- (nonnull instancetype)initWithPaletteResource:(MDCColorResourcePalette)palette
                                           tint:(MDCColorResourcePaletteTint)tint
                                        opacity:(CGFloat)opacity
                                            dim:(CGFloat)dim;

/// Initializes a color resource representing a hex color
- (nonnull instancetype)initWithHexString:(NSString *)hex;

/// Initializes a color resource representing a hex color, with given opacity or dim
- (nonnull instancetype)initWithHexString:(NSString *)hex opacity:(CGFloat)opacity dim:(CGFloat)dim;

/// returns the "name" of the semantic enumeration as a string value
- (nullable NSString *)semanticNameFromResource:(MDCColorResourceSemantic)semantic;

/// returns the "name" of the palette enumeration as a string value
- (nullable NSString *)paletteNameFromResource:(MDCColorResourcePalette)palette;

/// returns the "name" of the palette-tint enumeration as a string value
- (nullable NSString *)paletteTintNameFromResource:(MDCColorResourcePaletteTint)tint;

/**
 Converts the given string to a MDCColorResourceSemantic enumeration. Returns
 MDCColorResourceSemanticNone if the string doesn't match any enumeration value
 @param semanticName Expecting a hyphenated all lowercase semantic name, like "on-primary".
                           (names should match colors from the MDCColorScheming protocol)
 */
- (MDCColorResourceSemantic)semanticResourceFromName:(NSString *)semanticName;

/**
 Converts the given string to a MDCColorResourcePalette enumeration. Returns
 MDCColorResourcePaletteNone if the string doesn't match any enumeration value
 @param paletteName Expecting an all lowercase short palette name, like: "blue".
 */
- (MDCColorResourcePalette)paletteResourceFromName:(NSString *)paletteName;

/**
 Converts the given string to a MDCColorResourcePaletteTint enumeration. Returns
 MDCColorResourcePaletteTintNone if the string doesn't match any enumeration value
 @param tintName Expecting a valid digit-only tint number, like: "100" for tint100.
 */
- (MDCColorResourcePaletteTint)paletteTintResourceFromName:(NSString *)tintName;

@end
