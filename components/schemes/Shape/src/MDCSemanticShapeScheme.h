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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDCShapeCategory.h"

/**
 A simple color scheme that provides semantic context for the colors it uses. There are no optional
 properties and all colors must be provided, supporting more reliable color theming.
 */
@protocol MDCShapeScheming

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *smallContainerShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *mediumContainerShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *largeContainerShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *FABShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeCategory *chipShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeFamily *extFABShape;

/**

 */
@property(nonnull, readonly, nonatomic) MDCShapeFamily *expandedSheetShape;

@end

/**
 An enum of default color schemes that are supported.
 */
typedef NS_ENUM(NSInteger, MDCColorSchemeDefaults) {
  /**
   The Material defaults, circa April 2018.
   */
  MDCColorSchemeDefaultsMaterial201804
};

/**
 A simple implementation of @c MDCColorScheming that provides Material default color values from
 which basic customizations can be made.
 */
@interface MDCSemanticShapeScheme : NSObject <MDCShapeScheming>

// Redeclare protocol properties as readwrite
@property(nonnull, readwrite, nonatomic) UIColor *primaryColor;
@property(nonnull, readwrite, nonatomic) UIColor *primaryColorVariant;
@property(nonnull, readwrite, nonatomic) UIColor *secondaryColor;
@property(nonnull, readwrite, nonatomic) UIColor *errorColor;
@property(nonnull, readwrite, nonatomic) UIColor *surfaceColor;
@property(nonnull, readwrite, nonatomic) UIColor *backgroundColor;
@property(nonnull, readwrite, nonatomic) UIColor *onPrimaryColor;
@property(nonnull, readwrite, nonatomic) UIColor *onSecondaryColor;
@property(nonnull, readwrite, nonatomic) UIColor *onSurfaceColor;
@property(nonnull, readwrite, nonatomic) UIColor *onBackgroundColor;

/**
 Initializes the color scheme with the latest material defaults.
 */
- (nonnull instancetype)init;

/**
 Initializes the color scheme with the colors associated with the given defaults.
 */
- (nonnull instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults;

/**
 Blending a color over a background color using Alpha compositing technique.
 More info about Alpha compositing: https://en.wikipedia.org/wiki/Alpha_compositing

 @param color UIColor value that sits on top.
 @param backgroundColor UIColor on the background.
 */
+ (nonnull UIColor *)blendColor:(nonnull UIColor *)color
            withBackgroundColor:(nonnull UIColor *)backgroundColor;

@end
