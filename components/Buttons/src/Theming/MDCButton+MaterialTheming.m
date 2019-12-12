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

#import "MDCButton+MaterialTheming.h"

#import <MaterialComponents/MaterialButtons+ColorThemer.h>
#import <MaterialComponents/MaterialButtons+ShapeThemer.h>
#import <MaterialComponents/MaterialShadowElevations.h>

@implementation MDCButton (MaterialTheming)

#pragma mark - Contained Button Themers

- (void)applyContainedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applyContainedThemeWithColorScheme:scheme.colorScheme];
  [self applyContainedThemeWithTypographyScheme:scheme.typographyScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyContainedThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  [self setElevation:MDCShadowElevationRaisedButtonResting forState:UIControlStateNormal];
  [self setElevation:MDCShadowElevationRaisedButtonPressed forState:UIControlStateHighlighted];
  [self setElevation:MDCShadowElevationNone forState:UIControlStateDisabled];
  self.minimumSize = CGSizeMake(0, 36);
}

- (void)applyContainedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetButtonColorsForAllStates];

  [self setBackgroundColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [self setBackgroundColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12]
                  forState:UIControlStateDisabled];
  [self setTitleColor:colorScheme.onPrimaryColor forState:UIControlStateNormal];
  [self setTitleColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
             forState:UIControlStateDisabled];
  [self setImageTintColor:colorScheme.onPrimaryColor forState:UIControlStateNormal];
  [self setImageTintColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
                 forState:UIControlStateDisabled];
  self.disabledAlpha = 1;
  self.inkColor = [colorScheme.onPrimaryColor colorWithAlphaComponent:(CGFloat)0.32];
}

- (void)applyContainedThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  if (self.enableTitleFontForState) {
    [self resetTitleFontForAllStates];
    [self setTitleFont:typographyScheme.button forState:UIControlStateNormal];
  } else {
    self.titleLabel.font = typographyScheme.button;
  }
}

- (void)applyContainedThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

#pragma mark - Outlined Button Themers

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applyOutlinedThemeWithColorScheme:scheme.colorScheme];
  [self applyOutlinedThemeWithTypographyScheme:scheme.typographyScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyOutlinedThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  self.minimumSize = CGSizeMake(0, 36);
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:1 forState:state];
  }
}

- (void)applyOutlinedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetButtonColorsForAllStates];

  UIColor *disabledContentColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38];
  UIColor *borderColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  [self setBackgroundColor:UIColor.clearColor forState:UIControlStateNormal];
  [self setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [self setTitleColor:disabledContentColor forState:UIControlStateDisabled];
  self.disabledAlpha = 1;
  [self setImageTintColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [self setImageTintColor:disabledContentColor forState:UIControlStateDisabled];
  self.inkColor = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.12];
  [self setBorderColor:borderColor forState:UIControlStateNormal];
}

- (void)applyOutlinedThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  if (self.enableTitleFontForState) {
    [self resetTitleFontForAllStates];
    [self setTitleFont:typographyScheme.button forState:UIControlStateNormal];
  } else {
    self.titleLabel.font = typographyScheme.button;
  }
}

- (void)applyOutlinedThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

#pragma mark - Text Button Themers

- (void)applyTextThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applyTextThemeWithColorScheme:scheme.colorScheme];
  [self applyTextThemeWithTypographyScheme:scheme.typographyScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyTextThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4.0;
  }

  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setElevation:MDCShadowElevationNone forState:state];
  }
  self.minimumSize = CGSizeMake(0, 36);
}

- (void)applyTextThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetUIControlStatesForButtonTheming];

  [self setBackgroundColor:UIColor.clearColor forState:UIControlStateNormal];
  [self setBackgroundColor:UIColor.clearColor forState:UIControlStateDisabled];
  [self setTitleColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [self setTitleColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
             forState:UIControlStateDisabled];
  [self setImageTintColor:colorScheme.primaryColor forState:UIControlStateNormal];
  [self setImageTintColor:[colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.38]
                 forState:UIControlStateDisabled];
  self.disabledAlpha = 1;
  self.inkColor = [colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.16];
}

- (void)applyTextThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  if (self.enableTitleFontForState) {
    [self resetTitleFontForAllStates];
    [self setTitleFont:typographyScheme.button forState:UIControlStateNormal];
  } else {
    self.titleLabel.font = typographyScheme.button;
  }
}

- (void)applyTextThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

#pragma mark - General helpers

- (void)resetTitleFontForAllStates {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setTitleFont:nil forState:state];
  }
}

- (void)resetButtonColorsForAllStates {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBackgroundColor:nil forState:state];
    [self setTitleColor:nil forState:state];
    [self setImageTintColor:nil forState:state];
    [self setBorderColor:nil forState:state];
  }
}

- (void)resetUIControlStatesForButtonTheming {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBackgroundColor:nil forState:state];
    [self setTitleColor:nil forState:state];
  }
}

@end
