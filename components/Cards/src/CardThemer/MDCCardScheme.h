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

#import "MaterialCards.h"
#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"

#import <Foundation/Foundation.h>

/**
 Defines a readonly immutable interface for cards style data to be applied by a themer.

 @warning This API will eventually be deprecated. The replacement API is: `MDCContainerScheming`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@protocol MDCCardScheming

/** The color scheme to apply to cards. */
@property(nonnull, readonly, nonatomic) id<MDCColorScheming> colorScheme;

/** The shape scheme to apply to cards. */
@property(nonnull, readonly, nonatomic) id<MDCShapeScheming> shapeScheme;

@end

/**
 Defines the cards style data that will be applied to a card by a themer.

 @warning This API will eventually be deprecated. The replacement API is: `MDCContainerScheme`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCCardScheme : NSObject <MDCCardScheming>

// Redeclare protocol properties as readwrite
@property(nonnull, readwrite, nonatomic) MDCSemanticColorScheme *colorScheme;
@property(nonnull, readwrite, nonatomic) MDCShapeScheme *shapeScheme;

@end
