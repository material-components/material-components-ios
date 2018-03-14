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

#import "MDCButtonTitleColorAccessibilityMutator.h"

#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialButtons.h"
#import "MaterialTypography.h"
#import "MaterialPalettes.h"

@implementation MDCButtonTitleColorAccessibilityMutator

+ (UIColor *)passingPaletteColorForColor:(UIColor *)color
                            onBackground:(UIColor *)background
                                 options:(MDFTextAccessibilityOptions)options
                      searchDarkerColors:(BOOL)searchDarkerColors {

  if (searchDarkerColors && [MDCPalette nextDarkerColorInPaletteForColor:color]) {
    UIColor *nextDarkerColor = [MDCPalette nextDarkerColorInPaletteForColor:color];
    if ([MDFTextAccessibility textColor:nextDarkerColor
                passesOnBackgroundColor:background
                                options:options]) {
      return nextDarkerColor;
    }
    return [[self class] passingPaletteColorForColor:nextDarkerColor
                                        onBackground:background
                                             options:options
                                  searchDarkerColors:YES];
  }
  if (!searchDarkerColors && [MDCPalette nextLighterColorInPaletteForColor:color]) {
    UIColor *nextLighterColor = [MDCPalette nextLighterColorInPaletteForColor:color];
    if ([MDFTextAccessibility textColor:nextLighterColor
                passesOnBackgroundColor:background
                                options:options]) {
      return nextLighterColor;
    }
    return [[self class] passingPaletteColorForColor:nextLighterColor
                                        onBackground:background
                                             options:options
                                  searchDarkerColors:NO];
  }
  return nil;
}

+ (UIColor *)passingPaletteColorForColor:(UIColor *)color
                            onBackground:(UIColor *)background
                                 options:(MDFTextAccessibilityOptions) options {
  CGFloat colorContrast = [MDFTextAccessibility contrastRatioForTextColor:color
                                                        onBackgroundColor:background];
  if ([MDCPalette nextDarkerColorInPaletteForColor:color]) {
    UIColor *nextDarkerColor = [MDCPalette nextDarkerColorInPaletteForColor:color];
    CGFloat darkerContrast =
        [MDFTextAccessibility contrastRatioForTextColor:nextDarkerColor
                                      onBackgroundColor:background];
    if (darkerContrast > colorContrast) {
      return [[self class] passingPaletteColorForColor:color
                                          onBackground:background
                                               options:options
                                    searchDarkerColors:YES];
    }
  }
  if ([MDCPalette nextLighterColorInPaletteForColor:color]) {
    UIColor *nextLighterColor = [MDCPalette nextLighterColorInPaletteForColor:color];
    CGFloat lighterContrast =
        [MDFTextAccessibility contrastRatioForTextColor:nextLighterColor
                                      onBackgroundColor:background];
    if (lighterContrast > colorContrast) {
      return [[self class] passingPaletteColorForColor:color
                                          onBackground:background
                                               options:options
                                    searchDarkerColors:NO];
    }
  }
  return nil;
}

+ (void)changeTitleColorOfButton:(MDCButton *)button {
  // This ensures title colors will be accessible against the buttons backgrounds.
  UIControlState allControlStates = UIControlStateNormal | UIControlStateHighlighted |
      UIControlStateDisabled | UIControlStateSelected;
  MDFTextAccessibilityOptions options = 0;
  if ([MDFTextAccessibility isLargeForContrastRatios:button.titleLabel.font]) {
    options = MDFTextAccessibilityOptionsLargeFont;
  }
  for (NSUInteger controlState = 0; controlState <= allControlStates; ++controlState) {
    UIColor *backgroundColor = [button backgroundColorForState:controlState];
    if ([self isTransparentColor:backgroundColor]) {
      // TODO(randallli): We could potentially traverse the view heirarchy instead.
      backgroundColor = button.underlyingColorHint;
    }
    if (backgroundColor) {
      UIColor *existingColor = [button titleColorForState:controlState];
      if (![MDFTextAccessibility textColor:existingColor
                   passesOnBackgroundColor:backgroundColor
                                   options:options]) {

        UIColor *color = [[self class] passingPaletteColorForColor:existingColor
                                                      onBackground:backgroundColor
                                                           options:options];
        if (!color) {
          color = [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                                   targetTextAlpha:[MDCTypography buttonFontOpacity]
                                                           options:options];
        }
        [button setTitleColor:color forState:controlState];
      }
    }
  }
}

/** Returns YES if the color is transparent (including a nil color). */
+ (BOOL)isTransparentColor:(UIColor *)color {
  return !color || [color isEqual:[UIColor clearColor]] || CGColorGetAlpha(color.CGColor) == 0.0f;
}


@end
