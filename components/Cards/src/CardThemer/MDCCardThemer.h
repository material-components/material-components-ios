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

#import "MDCCardScheme.h"

#import "MaterialCards.h"

#import <Foundation/Foundation.h>

/** Applies material style to MDCCard objects. */
@interface MDCCardThemer : NSObject

/**
 Applies the material card style using the card scheme data.
 
 @param scheme The card style data that should be used to change the @c card.
 @param card A MDCCard instance to apply the @c scheme
 */
+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
             toCard:(nonnull MDCCard *)card;

/**
 Applies the material card style using the card scheme data.
 
 @param scheme The card style data that should be used to change the @c card.
 @param cardCell A MDCCardCollectionCell instance to apply the @c scheme
 */
+ (void)applyScheme:(nonnull id<MDCCardScheming>)scheme
         toCardCell:(nonnull MDCCardCollectionCell *)cardCell;

/**
 Applies the material outlined card style using the card scheme data.
 
 @param scheme The card style data that should be used to change the @c card.
 @param card A MDCCard instance to apply the @c scheme
 */
+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                                toCard:(nonnull MDCCard *)card;

/**
 Applies the material outlined card style using the card scheme data.
 
 @param scheme The card style data that should be used to change the @c card.
 @param cardCell A MDCCardCollectionCell instance to apply the @c scheme
 */
+ (void)applyOutlinedVariantWithScheme:(nonnull id<MDCCardScheming>)scheme
                            toCardCell:(nonnull MDCCardCollectionCell *)cardCell;

@end

