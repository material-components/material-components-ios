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
#import "MDCColorScheme.h"

/**
 A simple color scheme that provides semantic context for the colors it uses. There are no optional
 properties and all colors must be provided, supporting more reliable color theming.
 */
@protocol MDCColorScheming

/**
 Displayed most frequently across your app.
 */
@property(nonnull, readonly, nonatomic) UIColor *primaryColor;

/**
 A tonal variation of primary color.
 */
@property(nonnull, readonly, nonatomic) UIColor *primaryColorVariant;

/**
 Accents select parts of your UI.
 */
@property(nonnull, readonly, nonatomic) UIColor *secondaryColor;

/**
 The color used to indicate error status.
 */
@property(nonnull, readonly, nonatomic) UIColor *errorColor;

/**
 The color of surfaces such as cards, sheets, menus.
 */
@property(nonnull, readonly, nonatomic) UIColor *surfaceColor;

/**
 The underlying color of an app’s content.
 */
@property(nonnull, readonly, nonatomic) UIColor *backgroundColor;

/**
 A color that passes accessibility guidelines for text/iconography when drawn on top of
 @c primaryColor.
 */
@property(nonnull, readonly, nonatomic) UIColor *onPrimaryColor;

/**
 A color that passes accessibility guidelines for text/iconography when drawn on top of
 @c secondaryColor.
 */
@property(nonnull, readonly, nonatomic) UIColor *onSecondaryColor;

/**
 A color that passes accessibility guidelines for text/iconography when drawn on top of
 @c surfaceColor.
 */
@property(nonnull, readonly, nonatomic) UIColor *onSurfaceColor;

/**
 A color that passes accessibility guidelines for text/iconography when drawn on top of
 @c backgroundColor.
 */
@property(nonnull, readonly, nonatomic) UIColor *onBackgroundColor;
@end

/**
 A simple implementation of @c MDCColorScheming that provides Material baseline values from which
 basic customizations can be made.
 */
@interface MDCSemanticColorScheme : NSObject <MDCColorScheming>

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
 Convenience initializer that calls @c initWithMaterialDefaults.
 */
- (nonnull instancetype)init;

/**
 Initializes an instance of MDCSemanticColorScheme with the Material baseline color values.
 */
- (nonnull instancetype)initWithMaterialDefaults;

/**
 Creates a new color scheme with the provided color parameters.

 @param primaryColor Displayed most frequently across your app.
 @param primaryColorVariant A tonal variation of @c primaryColor.
 @param secondaryColor Accents select parts of your UI.
 @param errorColor The color used to indicate error status.
 @param surfaceColor The color of surfaces such as cards, sheets, menus.
 @param backgroundColor The underlying color of an app’s content.
 @param onPrimaryColor A color that passes accessibility guidelines for text/iconography when drawn
        on top of @c primaryColor.
 @param onSecondaryColor A color that passes accessibility guidelines for text/iconography when
        drawn on top of @c secondaryColor.
 @param onSurfaceColor A color that passes accessibility guidelines for text/iconography when
        drawn on top of @c surfaceColor.
 @param onBackgroundColor A color that passes accessibility guidelines for text/iconography when
        drawn on top of @c backgroundColor.

 @returns a new color scheme with the provided values.
 */
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                         primaryColorVariant:(nonnull UIColor *)primaryColorVariant
                              secondaryColor:(nonnull UIColor *)secondaryColor
                                  errorColor:(nonnull UIColor *)errorColor
                                surfaceColor:(nonnull UIColor *)surfaceColor
                             backgroundColor:(nonnull UIColor *)backgroundColor
                              onPrimaryColor:(nonnull UIColor *)onPrimaryColor
                            onSecondaryColor:(nonnull UIColor *)onSecondaryColor
                              onSurfaceColor:(nonnull UIColor *)onSurfaceColor
                           onBackgroundColor:(nonnull UIColor *)onBackgroundColor
NS_DESIGNATED_INITIALIZER;

@end

@interface MDCSemanticColorScheme (NSSecureCoding) <NSSecureCoding>
@end
