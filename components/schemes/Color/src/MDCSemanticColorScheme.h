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
 An enum of default color schemes that are supported.
 */
typedef NS_ENUM(NSInteger, MDCColorSchemeDefaults) {
  /**
   The Material defaults, circa April 2018.
   */
  MDCColorSchemeDefaultsMaterial
};

/**
 A simple implementation of @c MDCColorScheming that provides Material default color values from
 which basic customizations can be made.
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
 Initializes the color scheme with the latest material defaults.
 */
- (nonnull instancetype)init;

/**
 Initializes a new instance of MDCSemanticColorScheme with the given defaults.
 */
- (nonnull instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults;

@end
