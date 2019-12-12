// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCLegacyColorScheme.h"

@class MDCTonalPalette;

#pragma mark - Soon to be deprecated

/**
 A tonal color scheme is a color scheme based on a primary tonal color palette and secondary tonal
 color palette. The tonal color palettes are used for the color scheme color properties.

 @warning This class will soon be deprecated. Consider using MDCColorScheming instead.
 */
@interface MDCTonalColorScheme : NSObject <MDCColorScheme, NSCopying>

/** The main, primary color used for a theme. */
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryColor;

/**
 A slightly lighter version of the primary color. Given tonal variations of a color, this color is
 typically two color swatches lighter than the primary color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryLightColor;

/**
 A slightly darker version of the primary color. Given tonal variations of a color, this color is
 typically two color swatches darker than the primary color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryDarkColor;

/** The secondary, accent color used for a theme. */
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryColor;

/**
 A slightly lighter version of the secondary color. Given tonal variations of a color, this color is
 typically two color swatches lighter than the secondary color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryLightColor;

/**
 A slightly darker version of the secondary color. Given tonal variations of a color, this color is
 typically two color swatches darker than the secondary color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryDarkColor;

/**
 The primary tonal palette that provides colors for the color scheme primary colors.
 */
@property(nonatomic, strong, nonnull, readonly) MDCTonalPalette *primaryTonalPalette;

/**
 The secondary tonal palette that provides colors for the color scheme secondary colors.
 */
@property(nonatomic, strong, nonnull, readonly) MDCTonalPalette *secondaryTonalPalette;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes and returns a color scheme given a primary and secondary tonal palette.
 */
- (nonnull instancetype)initWithPrimaryTonalPalette:(nonnull MDCTonalPalette *)primaryTonalPalette
                              secondaryTonalPalette:(nonnull MDCTonalPalette *)secondaryTonalPalette
    NS_DESIGNATED_INITIALIZER;

@end
