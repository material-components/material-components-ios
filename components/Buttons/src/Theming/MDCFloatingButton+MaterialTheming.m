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

#import "MDCFloatingButton+MaterialTheming.h"

#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"
#import "MaterialTypographyScheme+Scheming.h"

static const CGFloat kFloatingButtonBaselineShapePercentageValue = (CGFloat)0.5;

@implementation MDCFloatingButton (MaterialTheming)

- (void)applySecondaryThemeWithScheme:(id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applySecondaryThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (!shapeScheme) {
    shapeScheme = [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  }
  [self applySecondaryThemeWithShapeScheme:shapeScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applySecondaryThemeWithTypographyScheme:typographyScheme];

  [self setElevation:MDCShadowElevationFABResting forState:UIControlStateNormal];
  [self setElevation:MDCShadowElevationFABPressed forState:UIControlStateHighlighted];
  [self setElevation:MDCShadowElevationNone forState:UIControlStateDisabled];
}

- (void)applySecondaryThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetUIControlStatesForButtonTheming];
  [self setBackgroundColor:colorScheme.secondaryColor forState:UIControlStateNormal];
  [self setTitleColor:colorScheme.onSecondaryColor forState:UIControlStateNormal];
  [self setImageTintColor:colorScheme.onSecondaryColor forState:UIControlStateNormal];

  self.disabledAlpha = 1;
}

- (void)applySecondaryThemeWithShapeScheme:(id<MDCShapeScheming>)scheme {
  // This is an override of the default scheme to fit the baseline values.
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [MDCCornerTreatment cornerWithRadius:kFloatingButtonBaselineShapePercentageValue
                                 valueType:MDCCornerTreatmentValueTypePercentage];
  [rectangleShape setCorners:cornerTreatment];
  self.shapeGenerator = rectangleShape;

  [self setContentEdgeInsets:UIEdgeInsetsMake(16, 16, 16, 16)
                    forShape:MDCFloatingButtonShapeDefault
                      inMode:MDCFloatingButtonModeNormal];
}

- (void)applySecondaryThemeWithTypographyScheme:(id<MDCTypographyScheming>)scheme {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setTitleFont:nil forState:state];
  }
  [self setTitleFont:scheme.button forState:UIControlStateNormal];
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toButton:(nonnull MDCFloatingButton *)button {
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
