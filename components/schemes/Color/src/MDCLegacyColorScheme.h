/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

/**
 A color scheme comprised of set of primary and secondary colors. Material design guidelines
 recommend using primary and secondary colors with light and dark color variants.
 */
@protocol MDCColorScheme <NSObject>

/** The main, primary color used for a theme. */
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryColor;

@optional

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

@end

/**
 A basic color scheme comprised of set of primary and secondary colors with light and dark color
 variants.
 */
@interface MDCBasicColorScheme : NSObject <MDCColorScheme, NSCopying>

@property(nonatomic, strong, nonnull, readonly) UIColor *primaryColor;
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryLightColor;
@property(nonatomic, strong, nonnull, readonly) UIColor *primaryDarkColor;
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryColor;
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryLightColor;
@property(nonatomic, strong, nonnull, readonly) UIColor *secondaryDarkColor;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes and returns a color scheme given primary, primary light, primary dark, secondary,
 secondary light and secondary dark colors.
 */
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                           primaryLightColor:(nonnull UIColor *)primaryLightColor
                            primaryDarkColor:(nonnull UIColor *)primaryDarkColor
                              secondaryColor:(nonnull UIColor *)secondaryColor
                         secondaryLightColor:(nonnull UIColor *)secondaryLightColor
                          secondaryDarkColor:(nonnull UIColor *)secondaryDarkColor
    NS_DESIGNATED_INITIALIZER;

/**
 Initializes and returns a color scheme given a primary color. Primary light and primary dark colors
 are automatically generated. Secondary colors take on primary colors.
 */
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor;

/**
 Initializes and returns a color scheme given primary, primary light and primary dark colors.
 Secondary colors take on primary colors.
 */
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                           primaryLightColor:(nonnull UIColor *)primaryLightColor
                            primaryDarkColor:(nonnull UIColor *)primaryDarkColor;

/**
 Initializes and returns a color scheme given primary and secondary colors. Light and dark colors
 are automatically generated.
 */
- (nonnull instancetype)initWithPrimaryColor:(nonnull UIColor *)primaryColor
                              secondaryColor:(nonnull UIColor *)secondaryColor;

@end
