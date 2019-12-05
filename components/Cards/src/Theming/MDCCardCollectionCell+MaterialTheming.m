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

#import "MDCCardCollectionCell+MaterialTheming.h"

static const MDCShadowElevation kNormalElevation = 1;
static const MDCShadowElevation kHighlightedElevation = 1;
static const MDCShadowElevation kSelectedElevation = 1;
static const CGFloat kBorderWidth = 1;
static const CGFloat kStrokeVariantBorderOpacity = (CGFloat)0.37;

@implementation MDCCardCollectionCell (MaterialTheming)

#pragma mark - Standard Card

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  [self setShadowElevation:kNormalElevation forState:MDCCardCellStateNormal];
  [self setShadowElevation:kHighlightedElevation forState:MDCCardCellStateHighlighted];
  [self setShadowElevation:kSelectedElevation forState:MDCCardCellStateSelected];
  self.interactable = YES;  // To achieve baseline themed, the card should be interactable.
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.backgroundColor = colorScheme.surfaceColor;
  [self setImageTintColor:colorScheme.primaryColor forState:MDCCardCellStateNormal];
}

- (void)applyThemeWithShapeScheme:(id<MDCShapeScheming>)shapeScheme {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  rectangleShape.topLeftCorner = shapeScheme.mediumComponentShape.topLeftCorner;
  rectangleShape.topRightCorner = shapeScheme.mediumComponentShape.topRightCorner;
  rectangleShape.bottomLeftCorner = shapeScheme.mediumComponentShape.bottomLeftCorner;
  rectangleShape.bottomRightCorner = shapeScheme.mediumComponentShape.bottomRightCorner;
  self.shapeGenerator = rectangleShape;
}

#pragma mark - Outlined Card

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyOutlinedThemeWithColorScheme:colorScheme];

  id<MDCShapeScheming> shapeScheme = scheme.shapeScheme;
  if (shapeScheme) {
    [self applyThemeWithShapeScheme:shapeScheme];
  } else {
    self.layer.cornerRadius = (CGFloat)4;
  }

  for (MDCCardCellState state = MDCCardCellStateNormal; state <= MDCCardCellStateSelected;
       state++) {
    [self setBorderWidth:kBorderWidth forState:state];
    [self setShadowElevation:0 forState:state];
  }
}

- (void)applyOutlinedThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [self setBorderColor:nil forState:state];
  }

  self.backgroundColor = colorScheme.surfaceColor;
  UIColor *borderColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kStrokeVariantBorderOpacity];
  [self setBorderColor:borderColor forState:MDCCardCellStateNormal];
}

@end
