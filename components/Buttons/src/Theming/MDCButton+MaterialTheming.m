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
#import <MaterialComponents/MaterialButtons+TypographyThemer.h>
#import <MaterialComponents/MaterialShadowElevations.h>

@implementation MDCButton (MaterialTheming)

#pragma mark - Contained Button Themers

- (void)applyContainedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyContainedThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyContainedThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyContainedThemeWithTypographyScheme:typographyScheme];

  [self setElevation:MDCShadowElevationRaisedButtonResting forState:UIControlStateNormal];
  [self setElevation:MDCShadowElevationRaisedButtonPressed forState:UIControlStateHighlighted];
  [self setElevation:MDCShadowElevationNone forState:UIControlStateDisabled];
  self.minimumSize = CGSizeMake(0, 36);
}

- (void)applyContainedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [MDCContainedButtonColorThemer applySemanticColorScheme:colorScheme toButton:self];
}

- (void)applyContainedThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:self];
}

- (void)applyContainedThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

#pragma mark - Outlined Button Themers

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyOutlinedThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyOutlinedThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyOutlinedThemeWithTypographyScheme:typographyScheme];

  self.minimumSize = CGSizeMake(0, 36);
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:1 forState:state];
  }
}

- (void)applyOutlinedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [MDCOutlinedButtonColorThemer applySemanticColorScheme:colorScheme toButton:self];
}

- (void)applyOutlinedThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:self];
}

- (void)applyOutlinedThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

#pragma mark - Text Button Themers

- (void)applyTextThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyTextThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyTextThemeWithTypographyScheme:typographyScheme];

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
  [MDCTextButtonColorThemer applySemanticColorScheme:colorScheme toButton:self];
}

- (void)applyTextThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:self];
}

- (void)applyTextThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCButtonShapeThemer applyShapeScheme:shapeScheme toButton:self];
}

@end
