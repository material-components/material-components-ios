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

#import "MaterialChips.h"
#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

#import <Foundation/Foundation.h>

/**
 MDCChipViewScheming represents the design parameters for an MDCChipView.

 An instance of this protocol can be applied to an instance of MDCChipView using any of the
 MDCChipViewThemer APIs.
 */
@protocol MDCChipViewScheming

/**
 The color scheme to apply to a chip view.
 */
@property(nonnull, readonly, nonatomic) id<MDCColorScheming> colorScheme;

/**
 The shape scheme to apply to a chip view.
 */
@property(nonnull, readonly, nonatomic) id<MDCShapeScheming> shapeScheme;

/**
 The typography scheme to apply to a chip view.
 */
@property(nonnull, readonly, nonatomic) id<MDCTypographyScheming> typographyScheme;

@end

/**
 An MDCChipViewScheme is a mutable representation of the design parameters for an MDCChipView.
 */
@interface MDCChipViewScheme : NSObject <MDCChipViewScheming>

/**
 A mutable representation of a color scheme.

 By default, this is initialized with the latest color scheme defaults.
 */
@property(nonnull, readwrite, nonatomic) id<MDCColorScheming> colorScheme;

/**
 A mutable representation of a shape scheme.

 By default, this is initialized with the latest shape scheme defaults.
 */
@property(nonnull, readwrite, nonatomic) id<MDCShapeScheming> shapeScheme;

/**
 A mutable representation of a typography scheme.

 By default, this is initialized with the latest typography scheme defaults.
 */
@property(nonnull, readwrite, nonatomic) id<MDCTypographyScheming> typographyScheme;

@end
