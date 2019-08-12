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

#import <Foundation/Foundation.h>

#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialShapeScheme.h>
#import <MaterialComponents/MaterialTypographyScheme.h>

@class MDCContainerScheme;

/**
 A container scheme that exposes properties for all supported Material Theming subsystem schemes.
 */
@protocol MDCContainerScheming

/**
 The color scheme to use for the container scheme.
 */
@property(nonatomic, nonnull, readonly) id<MDCColorScheming> colorScheme;

/**
 The typography scheme to use for the container scheme.
 */
@property(nonatomic, nonnull, readonly) id<MDCTypographyScheming> typographyScheme;

/**
 The shape scheme to use for the container scheme.
 */
@property(nonatomic, nullable, readonly) id<MDCShapeScheming> shapeScheme;

@optional

/**
 Returns a mutable copy of the receiver.

 @note This protocol will eventually require conformance to NSMutableCopying and this method will
 become required.
 */
- (nonnull MDCContainerScheme *)mutableCopy;

/**
 Returns a mutable copy of the receiver with the given zone.

 @note This method's protocol will eventually require conformance to NSMutableCopying and this
 method will become required.
 */
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

@end

/**
 MDCContainerScheme is a class conforming to MDCContainerScheming that contains
 schemes values for theming systems.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCContainerScheme
    : NSObject<MDCContainerScheming, NSMutableCopying>

/**
 Defaults to @c MDCColorSchemeDefaultsMaterial201804
 */
@property(nonatomic, nonnull, readwrite) MDCSemanticColorScheme *colorScheme;

/**
 Defaults to @c MDCTypographySchemeDefaultsMaterial201804
 */
@property(nonatomic, nonnull, readwrite) MDCTypographyScheme *typographyScheme;

/**
 Defaults to @c nil
 */
@property(nonatomic, nullable, readwrite) MDCShapeScheme *shapeScheme;

@end

@interface MDCContainerScheme (TraitCollectionSupport)

/**
 Returns a copy of this scheme configured with the given trait collection.

 @see MDCTypographyScheme's +resolveScheme:forTraitCollection: for more details.
 */
+ (nonnull MDCContainerScheme *)resolveScheme:(nonnull id<MDCContainerScheming>)scheme
                           forTraitCollection:(nonnull UITraitCollection *)traitCollection;

@end
