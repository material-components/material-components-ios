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
#import "MaterialShapeScheme.h"

/**
 The Material Design shape system's themer for instances of MDCCard and MDCCardCollectionCell.

 @warning This API will eventually be deprecated. See the individual method documentation for
 details on replacement APIs.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCCardsShapeThemer : NSObject
@end

@interface MDCCardsShapeThemer (ToBeDeprecated)

/**
 Applies a shape scheme's properties to an MDCCard.

 @param shapeScheme The shape scheme to apply to the component instance.
 @param card A component instance to which the shape scheme should be applied.

 @warning This API will eventually be deprecated. The replacement API is any of `MDCCard`'s theming
 extensions.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme toCard:(nonnull MDCCard *)card;

/**
 Applies a shape scheme's properties to an MDCCardCollectionCell.

 @param shapeScheme The shape scheme to apply to the component instance.
 @param cardCell A component instance to which the shape scheme should be applied.

 @warning This API will eventually be deprecated. The replacement API is any of
 `MDCCardCollectionCell`'s theming extensions.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
              toCardCell:(nonnull MDCCardCollectionCell *)cardCell;

@end
