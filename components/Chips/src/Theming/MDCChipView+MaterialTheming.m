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

#import "MDCChipView+MaterialTheming.h"

#import "MaterialChips+ColorThemer.h"
#import "MaterialChips+ShapeThemer.h"
#import "MaterialChips+TypographyThemer.h"

@implementation MDCChipView (MaterialTheming)

#pragma mark - Standard Chip

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (!shapeScheme) {
    shapeScheme = [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  }
  [self applyThemeWithShapeScheme:shapeScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyThemeWithTypographyScheme:typographyScheme];

  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:0 forState:state];
  }
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [MDCChipViewColorThemer applySemanticColorScheme:colorScheme toChipView:self];
}

- (void)applyThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  [MDCChipViewShapeThemer applyShapeScheme:shapeScheme toChipView:self];
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  [MDCChipViewTypographyThemer applyTypographyScheme:typographyScheme toChipView:self];
}

#pragma mark - Outlined Chip

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyOutlinedThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (!shapeScheme) {
    shapeScheme = [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  }
  [self applyThemeWithShapeScheme:shapeScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyThemeWithTypographyScheme:typographyScheme];

  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:1 forState:state];
  }
}

- (void)applyOutlinedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [MDCChipViewColorThemer applyOutlinedVariantWithColorScheme:colorScheme toChipView:self];
}

@end
