// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSemanticColorScheme.h"

#import "MaterialColor.h"

static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [UIColor colorWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                         green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                          blue:(CGFloat)((colorValue & 0xFF) / 255.0)
                         alpha:1];
}

@implementation MDCSemanticColorScheme

- (instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults {
  self = [super init];
  if (self) {
    UIColor *white = ColorFromRGB(0xFFFFFF);
    UIColor *black = ColorFromRGB(0x000000);
    UIColor *darkGrey = ColorFromRGB(0x121212);
    UIColor *darkBlue = ColorFromRGB(0x3700B3);
    UIColor *teal = ColorFromRGB(0x03DAC6);
    UIColor *lightTeal = ColorFromRGB(0x66FFF9);
    switch (defaults) {
      case MDCColorSchemeDefaultsMaterial201804:
        _primaryColor = ColorFromRGB(0x6200EE);
        _primaryColorVariant = darkBlue;
        _secondaryColor = teal;
        _errorColor = ColorFromRGB(0xB00020);
        _surfaceColor = white;
        _backgroundColor = white;
        _onPrimaryColor = white;
        _onSecondaryColor = black;
        _onSurfaceColor = black;
        _onBackgroundColor = black;
        _elevationOverlayEnabledForDarkMode = NO;
        break;
      case MDCColorSchemeDefaultsMaterialDark201907:
        _primaryColor = ColorFromRGB(0xBB86FC);
        _primaryColorVariant = darkBlue;
        _secondaryColor = teal;
        _errorColor = ColorFromRGB(0xCF6679);
        _surfaceColor = darkGrey;
        _backgroundColor = darkGrey;
        _onPrimaryColor = black;
        _onSecondaryColor = black;
        _onSurfaceColor = white;
        _onBackgroundColor = white;
        _elevationOverlayEnabledForDarkMode = YES;
        break;
      case MDCColorSchemeDefaultsMaterial201907: {
        UIColor *primaryColorDark =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0xEFB7FF)
                                                 normal:ColorFromRGB(0xBB86FC)];
        UIColor *primaryColorLight =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0x0000BA)
                                                 normal:ColorFromRGB(0x6200EE)];
        _primaryColor = [UIColor colorWithUserInterfaceStyleDarkColor:primaryColorDark
                                                         defaultColor:primaryColorLight];
        UIColor *primaryColorVariantDark =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0xBE9EFF) normal:darkBlue];
        UIColor *primaryColorVariantLight =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0x000088) normal:darkBlue];
        _primaryColorVariant =
            [UIColor colorWithUserInterfaceStyleDarkColor:primaryColorVariantDark
                                             defaultColor:primaryColorVariantLight];
        _secondaryColor = [UIColor colorWithAccessibilityContrastHigh:lightTeal normal:teal];
        UIColor *errorColorVariantDark =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0x9B374D)
                                                 normal:ColorFromRGB(0xCF6679)];
        UIColor *errorColorVariantLight =
            [UIColor colorWithAccessibilityContrastHigh:ColorFromRGB(0x790000)
                                                 normal:ColorFromRGB(0xB00020)];
        _errorColor = [UIColor colorWithUserInterfaceStyleDarkColor:errorColorVariantDark
                                                       defaultColor:errorColorVariantLight];
        UIColor *surfaceColorDark = [UIColor colorWithAccessibilityContrastHigh:black
                                                                         normal:darkGrey];
        _surfaceColor = [UIColor colorWithUserInterfaceStyleDarkColor:surfaceColorDark
                                                         defaultColor:white];
        UIColor *backgroundColorDark = [UIColor colorWithAccessibilityContrastHigh:black
                                                                            normal:darkGrey];
        _backgroundColor = [UIColor colorWithUserInterfaceStyleDarkColor:backgroundColorDark
                                                            defaultColor:white];
        _onPrimaryColor = [UIColor colorWithUserInterfaceStyleDarkColor:black defaultColor:white];
        _onSecondaryColor = black;
        _onSurfaceColor = [UIColor colorWithUserInterfaceStyleDarkColor:white defaultColor:black];
        _onBackgroundColor = _onSurfaceColor;
        _elevationOverlayEnabledForDarkMode = YES;
        break;
      }
    }
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  MDCSemanticColorScheme *copy = [[MDCSemanticColorScheme alloc] init];
  copy.primaryColor = self.primaryColor;
  copy.primaryColorVariant = self.primaryColorVariant;
  copy.secondaryColor = self.secondaryColor;
  copy.surfaceColor = self.surfaceColor;
  copy.backgroundColor = self.backgroundColor;
  copy.errorColor = self.errorColor;
  copy.onPrimaryColor = self.onPrimaryColor;
  copy.onSecondaryColor = self.onSecondaryColor;
  copy.onSurfaceColor = self.onSurfaceColor;
  copy.onBackgroundColor = self.onBackgroundColor;
  copy.elevationOverlayEnabledForDarkMode = self.elevationOverlayEnabledForDarkMode;
  return copy;
}

@end
