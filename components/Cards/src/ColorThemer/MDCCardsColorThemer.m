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

#import "MDCCardsColorThemer.h"
#import "MDCDarkMode.h"

static const CGFloat kStrokeVariantBorderOpacity = (CGFloat)0.37;

@implementation MDCCardsColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                          toCard:(nonnull MDCCard *)card {
//  if (colorScheme.shouldLightenElevatedSurfacesWithDarkMode) {
//    card.backgroundColor = colorScheme.surfaceColor;
//        [colorScheme surfaceColorWithElevation:[card shadowElevationForState:UIControlStateNormal]];
//  } else {
//    card.backgroundColor = colorScheme.surfaceColor;
//  }
  card.backgroundColor = colorScheme.surfaceColor;
  card.backgroundColor.mdc_elevation = 4;
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                      toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  if (colorScheme.shouldLightenElevatedSurfacesWithDarkMode) {
    cardCell.backgroundColor = [colorScheme surfaceColorWithElevation:
                            [cardCell shadowElevationForState:MDCCardCellStateNormal]];
  } else {
    cardCell.backgroundColor = colorScheme.surfaceColor;
  }
  [cardCell setImageTintColor:colorScheme.primaryColor forState:MDCCardCellStateNormal];
}

+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                     toCard:(nonnull MDCCard *)card {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [card setBorderColor:nil forState:state];
  }

  card.backgroundColor = colorScheme.surfaceColor;
  UIColor *borderColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kStrokeVariantBorderOpacity];
  [card setBorderColor:borderColor forState:UIControlStateNormal];
}

+ (void)applyOutlinedVariantWithColorScheme:(id<MDCColorScheming>)colorScheme
                                 toCardCell:(MDCCardCollectionCell *)cardCell {
  NSUInteger maximumStateValue = UIControlStateNormal | UIControlStateSelected |
                                 UIControlStateHighlighted | UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [cardCell setBorderColor:nil forState:state];
  }

  cardCell.backgroundColor = colorScheme.surfaceColor;
  UIColor *borderColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kStrokeVariantBorderOpacity];
  [cardCell setBorderColor:borderColor forState:MDCCardCellStateNormal];
}

@end
