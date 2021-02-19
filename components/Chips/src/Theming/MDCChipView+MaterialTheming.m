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

#import "MaterialChips.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"
#import "MaterialTypography.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme+Scheming.h"

static const CGFloat kChipViewBaselineShapePercentageValue = (CGFloat)0.5;

@implementation MDCChipView (MaterialTheming)

#pragma mark - Common Values

- (void)applyPaddingValues {
  self.contentPadding = UIEdgeInsetsMake(0, 4, 0, 8);
  self.titlePadding = UIEdgeInsetsMake(0, 8, 0, 4);
  self.accessoryPadding = UIEdgeInsetsMake(0, 4, 0, 0);
  self.imagePadding = UIEdgeInsetsZero;
}

#pragma mark - Standard Chip

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  [self applyThemeWithColorScheme:scheme.colorScheme];
  [self applyThemeWithShapeScheme:scheme.shapeScheme];
  [self applyThemeWithTypographyScheme:scheme.typographyScheme];

  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:0 forState:state];
  }
  [self applyPaddingValues];
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetUIControlStatesForChipTheming];

  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface16Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.16];

  UIColor *backgroundColor = [MDCSemanticColorScheme blendColor:onSurface12Opacity
                                            withBackgroundColor:colorScheme.surfaceColor];
  UIColor *selectedBackgroundColor = [MDCSemanticColorScheme blendColor:onSurface12Opacity
                                                    withBackgroundColor:backgroundColor];
  UIColor *textColor = [MDCSemanticColorScheme blendColor:onSurface87Opacity
                                      withBackgroundColor:backgroundColor];
  UIColor *selectedTextColor = [MDCSemanticColorScheme blendColor:onSurface87Opacity
                                              withBackgroundColor:selectedBackgroundColor];

  [self setInkColor:onSurface16Opacity forState:UIControlStateNormal];
  [self setTitleColor:textColor forState:UIControlStateNormal];
  [self setBackgroundColor:backgroundColor forState:UIControlStateNormal];

  [self setTitleColor:selectedTextColor forState:UIControlStateSelected];
  [self setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];

  [self setTitleColor:[textColor colorWithAlphaComponent:(CGFloat)0.38]
             forState:UIControlStateDisabled];
  [self setBackgroundColor:[backgroundColor colorWithAlphaComponent:(CGFloat)0.38]
                  forState:UIControlStateDisabled];
}

- (void)applyThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  MDCCornerTreatment *cornerTreatment =
      [MDCCornerTreatment cornerWithRadius:kChipViewBaselineShapePercentageValue
                                 valueType:MDCCornerTreatmentValueTypePercentage];
  [rectangleShape setCorners:cornerTreatment];
  self.shapeGenerator = rectangleShape;
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  UIFont *titleFont = typographyScheme.body2;
  if (typographyScheme.useCurrentContentSizeCategoryWhenApplied) {
    titleFont = [titleFont mdc_scaledFontForTraitEnvironment:self];
  }
  self.titleFont = titleFont;
}

#pragma mark - Outlined Chip

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applyOutlinedThemeWithColorScheme:scheme.colorScheme];
  [self applyThemeWithShapeScheme:scheme.shapeScheme];
  [self applyThemeWithTypographyScheme:scheme.typographyScheme];

  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderWidth:1 forState:state];
  }
  [self applyPaddingValues];
}

- (void)applyOutlinedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  [self resetUIControlStatesForChipTheming];

  UIColor *onSurface12Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
  UIColor *onSurface87Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *onSurface16Opacity = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.16];
  UIColor *selectedBackgroundColor = [MDCSemanticColorScheme blendColor:onSurface12Opacity
                                                    withBackgroundColor:colorScheme.surfaceColor];
  UIColor *borderColor = [MDCSemanticColorScheme blendColor:onSurface12Opacity
                                        withBackgroundColor:colorScheme.surfaceColor];
  UIColor *textColor = [MDCSemanticColorScheme blendColor:onSurface87Opacity
                                      withBackgroundColor:colorScheme.surfaceColor];
  UIColor *selectedTextColor = [MDCSemanticColorScheme blendColor:onSurface87Opacity
                                              withBackgroundColor:selectedBackgroundColor];

  [self setInkColor:onSurface16Opacity forState:UIControlStateNormal];
  [self setTitleColor:textColor forState:UIControlStateNormal];
  [self setBackgroundColor:colorScheme.surfaceColor forState:UIControlStateNormal];
  [self setBorderColor:borderColor forState:UIControlStateNormal];

  [self setTitleColor:selectedTextColor forState:UIControlStateSelected];
  [self setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];
  [self setBorderColor:[UIColor clearColor] forState:UIControlStateSelected];

  [self setTitleColor:[textColor colorWithAlphaComponent:(CGFloat)0.38]
             forState:UIControlStateDisabled];
  [self setBackgroundColor:[colorScheme.surfaceColor colorWithAlphaComponent:(CGFloat)0.38]
                  forState:UIControlStateDisabled];
  [self setBorderColor:[borderColor colorWithAlphaComponent:(CGFloat)0.38]
              forState:UIControlStateDisabled];
}

#pragma mark - Private

- (void)resetUIControlStatesForChipTheming {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBackgroundColor:nil forState:state];
    [self setTitleColor:nil forState:state];
    [self setBorderColor:nil forState:state];
  }
}

@end
