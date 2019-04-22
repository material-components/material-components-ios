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

#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

#import <Foundation/Foundation.h>

/**
 MDCButtonScheming represents the design parameters for an MDCButton.

 An instance of this protocol can be applied to an instance of MDCButton using any of the
 MDC*ButtonThemer APIs.

 @warning This API will eventually be deprecated. The replacement API is: `MDCContainerScheming`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@protocol MDCButtonScheming

/**
 The color scheme to be applied to a button.
 */
@property(nonnull, readonly, nonatomic) id<MDCColorScheming> colorScheme;

/**
 The shape scheme to be applied to a button.
 */
@property(nonnull, readonly, nonatomic) id<MDCShapeScheming> shapeScheme;

/**
 The typography scheme to be applied to a button.
 */
@property(nonnull, readonly, nonatomic) id<MDCTypographyScheming> typographyScheme;

/**
 The corner radius to be applied to a button.
 */
@property(readonly, nonatomic) CGFloat cornerRadius;

/**
 The minimum height to be applied to a button.
 */
@property(readonly, nonatomic) CGFloat minimumHeight;

@end

/**
 An MDCButtonScheme is a mutable representation of the design parameters for an MDCButton.

 @warning This API will eventually be deprecated. The replacement API is: `MDCContainerScheme`.
 Learn more at docs/theming.md#migration-guide-themers-to-theming-extensions
 */
@interface MDCButtonScheme : NSObject <MDCButtonScheming>

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

/**
 A mutable representation of corner radius.

 By default, this is 4.
 */
@property(readwrite, nonatomic) CGFloat cornerRadius;

/**
 A mutable representation of minimum height.

 By default, this is 36.
 */
@property(readwrite, nonatomic) CGFloat minimumHeight;

@end
