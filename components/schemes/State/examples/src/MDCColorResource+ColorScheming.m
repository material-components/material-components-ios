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

#import "MDCColorResource+ColorScheming.h"
#import "MaterialPalettes.h"

/// Convenience UIColor extension methods
@interface UIColor (Private)

/// Initialize a UIColor from a hex string
- (nullable instancetype)initWithHexString:(NSString *)hexString;

/// Initialize a UIColor from a hex string and an alpha value
- (nullable instancetype)initWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/// Returns a darker color by given amount
- (nonnull UIColor *)darker:(CGFloat)amount;

/// Returns a lighter color by given amount
- (nonnull UIColor *)lighter:(CGFloat)amount;

@end

@implementation MDCColorResource (ColorScheming)

/// Converting a ColorResource to a UIColor, based on the current color scheme.
- (UIColor *)colorWithColorScheme:(MDCStateExampleColorScheme *)colorScheme {
  UIColor *color = nil;

  if (self.hexColor != nil) {
    // Convert a hext string to a UIColor
    color = [[UIColor alloc] initWithHexString:self.hexColor];

  } else if (self.palette != MDCColorResourcePaletteNone &&
             self.tint != MDCColorResourcePaletteTintNone) {
    MDCPalette *palette = nil;

    // Convert a palette & a tint to a UIColor
    switch (self.palette) {
      case MDCColorResourcePaletteGrey:
        palette = MDCPalette.greyPalette;
        break;
      case MDCColorResourcePaletteBlueGrey:
        palette = MDCPalette.blueGreyPalette;
        break;
      case MDCColorResourcePaletteIndigo:
        palette = MDCPalette.indigoPalette;
        break;
      case MDCColorResourcePaletteBlue:
        palette = MDCPalette.bluePalette;
        break;
      case MDCColorResourcePalettePurple:
        palette = MDCPalette.purplePalette;
        break;
      case MDCColorResourcePaletteRed:
        palette = MDCPalette.redPalette;
        break;
      case MDCColorResourcePaletteOrange:
        palette = MDCPalette.orangePalette;
        break;
      case MDCColorResourcePaletteYellow:
        palette = MDCPalette.yellowPalette;
        break;
      case MDCColorResourcePaletteNone:
        return nil;
    }
    switch (self.tint) {
      case MDCColorResourcePaletteTint50:
        color = palette.tint50;
        break;
      case MDCColorResourcePaletteTint100:
        color = palette.tint100;
        break;
      case MDCColorResourcePaletteTint200:
        color = palette.tint200;
        break;
      case MDCColorResourcePaletteTint300:
        color = palette.tint300;
        break;
      case MDCColorResourcePaletteTint400:
        color = palette.tint400;
        break;
      case MDCColorResourcePaletteTint500:
        color = palette.tint500;
        break;
      case MDCColorResourcePaletteTint600:
        color = palette.tint600;
        break;
      case MDCColorResourcePaletteTint700:
        color = palette.tint700;
        break;
      case MDCColorResourcePaletteTint800:
        color = palette.tint800;
        break;
      case MDCColorResourcePaletteTint900:
        color = palette.tint900;
        break;
      case MDCColorResourcePaletteTintNone:
        return nil;
    }
  } else if (self.semantic != MDCColorResourceSemanticNone) {
    // Convert a semantic name to a UIColor
    switch (self.semantic) {
      case MDCColorResourceSemanticPrimary:
        color = colorScheme.primaryColor;
        break;
      case MDCColorResourceSemanticOnPrimary:
        color = colorScheme.onPrimaryColor;
        break;
      case MDCColorResourceSemanticSurface:
        color = colorScheme.surfaceColor;
        break;
      case MDCColorResourceSemanticOnSurface:
        color = colorScheme.onSurfaceColor;
        break;
      case MDCColorResourceSemanticBackground:
        color = colorScheme.backgroundColor;
        break;
      case MDCColorResourceSemanticOnBackground:
        color = colorScheme.onBackgroundColor;
        break;
      case MDCColorResourceSemanticOverlay:
        color = colorScheme.overlayColor;
        break;
      case MDCColorResourceSemanticOutline:
        color = colorScheme.outlineColor;
        break;
      case MDCColorResourceSemanticError:
        color = colorScheme.errorColor;
        break;
      case MDCColorResourceSemanticNone:
        return nil;
    }
  }

  // Add opacity and dim variations
  if (self.opacity < 1.0) {
    return [color colorWithAlphaComponent:self.opacity];
  } else if (self.dim < 1.0 && self.dim >= 0.0) {
    return [color darker:self.dim];
  } else if (self.dim > -1.0 && self.dim < 0.0) {
    return [color lighter:-self.dim];
  } else {
    return color;
  }
}
@end

#pragma mark - UIColor helper methods

@implementation UIColor (Private)

/// Initialize a UIColor from a hex string
- (nullable instancetype)initWithHexString:(NSString *)hexString {
  return [self initWithHexString:hexString alpha:1.0];
}

/// Initialize a UIColor from a hex string and an alpha value
- (nullable instancetype)initWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  NSString *cString =
      [[hexString stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]
          uppercaseString];

  if ([cString hasPrefix:@"#"]) {
    cString = [cString substringFromIndex:1];
  }

  if (cString.length != 6) {
    return nil;
  }

  UInt32 rgbValue = 0;
  [[[NSScanner alloc] initWithString:cString] scanHexInt:&rgbValue];
  return [self initWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                     green:((rgbValue & 0x00FF00) >> 8) / 255.0
                      blue:(rgbValue & 0x0000FF) / 255.0
                     alpha:alpha];
}

/// Returns a darker color by given amount
- (nonnull UIColor *)darker:(CGFloat)amount {
  return [self colorWithHue:1 - amount];
}

/// Returns a lighter color by given amount
- (nonnull UIColor *)lighter:(CGFloat)amount {
  return [self colorWithHue:1 + amount];
}

/// Returns a darker color if amount is positive, or a lighter color if amount is negative
- (nonnull UIColor *)colorWithHue:(CGFloat)multiplier {
  CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
  [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
  return [[UIColor alloc] initWithHue:hue
                           saturation:saturation
                           brightness:brightness * multiplier
                                alpha:alpha];
}

@end
