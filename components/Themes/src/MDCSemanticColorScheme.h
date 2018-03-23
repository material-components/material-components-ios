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
 A simple color scheme that provides more semantic context for the colors it uses. Unlike
 @c MDCColorScheme, there are no optional properties, so more consistent theming can be applied.
 */
@protocol MDCSemanticColorScheming

/**
 Displayed most frequently across your app.
 */
@property(nonnull, readonly, nonatomic) UIColor *primaryColor;

/**
 A tonal variation of primary color.
 */
@property(nonnull, readonly, nonatomic) UIColor *primaryColorLightVariant;

/**
 A tonal variation of primary color.
 */
@property(nonnull, readonly, nonatomic) UIColor *primaryColorDarkVariant;

/**
 Accents select parts of your UI.
 */
@property(nonnull, readonly, nonatomic) UIColor *secondaryColor;

/**
 The color used to indicate error status.
*/
@property(nonnull, readonly, nonatomic) UIColor *errorColor;

@end

@interface MDCSemanticColorScheme : NSObject <MDCSemanticColorScheming, MDCColorScheme>

#pragma mark - MDCColorScheme compatibility

// Bound to @c primaryColorLightVariant
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryLightColor;

// Bound to @c primaryColorDarkVariant
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryDarkColor;

#pragma mark - Initializers

/**
 Creates a new color scheme with the provided color parameters.

 @param primaryColor Displayed most frequently across your app.
 @param primaryColorLightVariant A tonal variation of @c primaryColor.
 @param primaryColorDarkVariant A tonal variation of @c primaryColor.
 @param secondaryColor Accents select parts of your UI.
 @param errorColor The color used to indicate error status.
*/
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                    primaryColorLightVariant:(nonnull UIColor *)primaryColorLightVariant
                     primaryColorDarkVariant:(nonnull UIColor *)primaryColorDarkVariant
                              secondaryColor:(nonnull UIColor *)secondaryColor
                                  errorColor:(nonnull UIColor *)errorColor;

@end
