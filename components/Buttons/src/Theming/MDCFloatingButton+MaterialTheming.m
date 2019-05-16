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

#import <MaterialComponents/MaterialButtons+ColorThemer.h>
#import <MaterialComponents/MaterialButtons+ShapeThemer.h>

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

- (void)applySecondaryThemeWithColorScheme:(id<MDCColorScheming>)scheme {
  [MDCFloatingButtonColorThemer applySemanticColorScheme:scheme toButton:self];
}

- (void)applySecondaryThemeWithShapeScheme:(id<MDCShapeScheming>)scheme {
  [MDCFloatingButtonShapeThemer applyShapeScheme:scheme toButton:self];
}

- (void)applySecondaryThemeWithTypographyScheme:(id<MDCTypographyScheming>)scheme {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setTitleFont:nil forState:state];
  }
  [self setTitleFont:scheme.button forState:UIControlStateNormal];
}

@end
