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

#import <UIKit/UIKit.h>

#import "MaterialCards.h"
#import "MaterialColorScheme.h"

/**
 The Material Design color system's themer for instances of MDCCard and MDCCardCollectionCell.
 */
@interface MDCCardsColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCCard.

 @param colorScheme The color scheme to apply to the component instance.
 @param card A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                          toCard:(nonnull MDCCard *)card;

/**
 Applies a color scheme's properties to an MDCCardCollectionCell.

 @param colorScheme The color scheme to apply to the component instance.
 @param cardCell A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                      toCardCell:(nonnull MDCCardCollectionCell *)cardCell;

/**
 Applies a color scheme's properties to an MDCCard and styles it with a border stroke.

 @param colorScheme The color scheme to apply to MDCCard.
 @param card An MDCCard instance to which the color scheme should be applied.
 */
+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                     toCard:(nonnull MDCCard *)card;

/**
 Applies a color scheme's properties to an MDCCardCollectionCell and styles it with a border stroke.

 @param colorScheme The color scheme to apply to MDCCardCollectionCell.
 @param cardCell An MDCCardCollectionCell instance to which the color scheme should be applied.
 */
+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                 toCardCell:(nonnull MDCCardCollectionCell *)cardCell;

@end
