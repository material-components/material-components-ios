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

#import "MDCCardThemer.h"

#import "MaterialCards+ColorThemer.h"
#import "MaterialCards+ShapeThemer.h"

static const MDCShadowElevation kNormalElevation = 1.f;
static const MDCShadowElevation kHighlightedElevation = 4.f;
static const MDCShadowElevation kSelectedElevation = 4.f;
static const CGFloat kBorderWidth = 1.f;

@implementation MDCCardThemer

+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
             toCard:(nonnull MDCCard *)card {
  [card setShadowElevation:kNormalElevation forState:UIControlStateNormal];
  [card setShadowElevation:kHighlightedElevation forState:UIControlStateHighlighted];
  card.interactable = YES;
  [MDCCardsColorThemer applySemanticColorScheme:scheme.colorScheme toCard:card];
  [MDCCardsShapeThemer applyShapeScheme:scheme.shapeScheme toCard:card];
}

+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
         toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  [cardCell setShadowElevation:kNormalElevation forState:MDCCardCellStateNormal];
  [cardCell setShadowElevation:kHighlightedElevation forState:MDCCardCellStateHighlighted];
  [cardCell setShadowElevation:kSelectedElevation forState:MDCCardCellStateSelected];
  cardCell.interactable = YES;
  [MDCCardsColorThemer applySemanticColorScheme:scheme.colorScheme toCardCell:cardCell];
  [MDCCardsShapeThemer applyShapeScheme:scheme.shapeScheme toCardCell:cardCell];
}

+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                                toCard:(nonnull MDCCard *)card {
  NSUInteger maximumStateValue =
      UIControlStateNormal | UIControlStateSelected | UIControlStateHighlighted |
      UIControlStateDisabled;
  for (NSUInteger state = 0; state <= maximumStateValue; ++state) {
    [card setBorderWidth:kBorderWidth forState:state];
  }
  [card setShadowElevation:kHighlightedElevation forState:UIControlStateHighlighted];
  [MDCCardsColorThemer applyOutlinedVariantWithColorScheme:scheme.colorScheme toCard:card];
  [MDCCardsShapeThemer applyShapeScheme:scheme.shapeScheme toCard:card];
}

+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                            toCardCell:(nonnull MDCCardCollectionCell *)cardCell {
  for (MDCCardCellState state = MDCCardCellStateNormal; state <= MDCCardCellStateSelected;
       state++) {
    [cardCell setBorderWidth:kBorderWidth forState:state];
  }
  [cardCell setShadowElevation:kHighlightedElevation forState:MDCCardCellStateHighlighted];
  [cardCell setShadowElevation:kSelectedElevation forState:MDCCardCellStateSelected];


  [MDCCardsColorThemer applyOutlinedVariantWithColorScheme:scheme.colorScheme toCardCell:cardCell];
  [MDCCardsShapeThemer applyShapeScheme:scheme.shapeScheme toCardCell:cardCell];
}

@end

