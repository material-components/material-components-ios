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

@protocol MDCSemanticColorScheming <MDCColorScheme>
/**
 Displayed most frequently across your app.
 */
@property(nonnull, readonly) UIColor *primaryColor;

/**
 A tonal variation of primary color.
 */
@property(nonnull, readonly) UIColor *primaryColorLightVariant;

/**
 A tonal variation of primary color.
 */
@property(nonnull, readonly) UIColor *primaryColorDarkVariant;

/**
 Accents select parts of your UI.
 */
@property(nullable, readonly) UIColor *secondaryColor;

/**
 The color used to indicate error status. Defaults to a red color.
*/
@property(nonnull, readonly) UIColor *errorColor;

@end

@interface MDCSemanticColorScheme : NSObject <MDCSemanticColorScheming>

@property(nonnull, readonly, nonatomic) UIColor *primaryColor;
@property(nonnull, readonly, nonatomic) UIColor *primaryColorLightVariant;
@property(nonnull, readonly, nonatomic) UIColor *primaryColorDarkVariant;
@property(nullable, readonly, nonatomic) UIColor *secondaryColor;
@property(nonnull, readonly, nonatomic) UIColor *errorColor;

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
 @param secondaryColor Accents select parts of your UI. If @c nil, defaults to @c primaryColor.
 @param errorColor The color used to indicate error status. If @c nil, defaults to a red color.
*/
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                    primaryColorLightVariant:(nonnull UIColor *)primaryColorLightVariant
                     primaryColorDarkVariant:(nonnull UIColor *)primaryColorDarkVariant
                              secondaryColor:(nullable UIColor *)secondaryColor
                                  errorColor:(nullable UIColor *)errorColor;

@end
