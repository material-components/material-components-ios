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

static const CGFloat kStrokeVariantBorderOpacity = (CGFloat)0.37;

@implementation MDCCardsColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                          toCard:(nonnull MDCCard *)card {
  card.backgroundColor = colorScheme.surfaceColor;
}

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                      toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  cardCell.backgroundColor = colorScheme.surfaceColor;
}

+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                     toCard:(nonnull MDCCard *)card {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
          UIControlStateDisabled;
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
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
          UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [cardCell setBorderColor:nil forState:state];
  }
  
  cardCell.backgroundColor = colorScheme.surfaceColor;
  UIColor *borderColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kStrokeVariantBorderOpacity];
  [cardCell setBorderColor:borderColor forState:MDCCardCellStateNormal];
}

@end
