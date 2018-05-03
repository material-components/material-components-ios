/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCCardThemer.h"

#import "MaterialCards+ColorThemer.h"

static const MDCShadowElevation kElevation = 0.f;
static const MDCShadowElevation kSelectedElevation = 4.f;
static const MDCShadowElevation kHighlightedElevation = 8.f;
static const CGFloat kBorderWidth = 1.f;

@implementation MDCCardThemer

+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
             toCard:(nonnull MDCCard *)card {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [card setBorderWidth:0.f forState:state];
    [card setShadowElevation:0.f forState:state];
  }
  [MDCCardsColorThemer applySemanticColorScheme:scheme.colorScheme toCard:card];
}

+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
         toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  for (MDCCardCellState state = MDCCardCellStateNormal;
       state <= MDCCardCellStateSelected;
       state++) {
    [cardCell setShadowElevation:0.f forState:state];
    [cardCell setBorderWidth:0.f forState:state];
  }
  [MDCCardsColorThemer applySemanticColorScheme:scheme.colorScheme toCardCell:cardCell];
}

+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                                toCard:(nonnull MDCCard *)card {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [card setShadowElevation:kElevation forState:state];
    [card setBorderWidth:kBorderWidth forState:state];
  }
  [card setShadowElevation:kHighlightedElevation forState:UIControlStateHighlighted];
  [MDCCardsColorThemer applyOutlinedVariantWithColorScheme:scheme.colorScheme toCard:card];
}

+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                            toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  [cardCell setShadowElevation:kElevation forState:MDCCardCellStateNormal];
  [cardCell setShadowElevation:kSelectedElevation forState:MDCCardCellStateSelected];
  [cardCell setShadowElevation:kHighlightedElevation forState:MDCCardCellStateHighlighted];
  [cardCell setBorderWidth:kBorderWidth forState:MDCCardCellStateNormal];
  [cardCell setBorderWidth:kBorderWidth forState:MDCCardCellStateSelected];
  [cardCell setBorderWidth:kBorderWidth forState:MDCCardCellStateHighlighted];
  [MDCCardsColorThemer applyOutlinedVariantWithColorScheme:scheme.colorScheme toCardCell:cardCell];
}

@end

