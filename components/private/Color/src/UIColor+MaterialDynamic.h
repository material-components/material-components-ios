// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

@interface UIColor (MaterialDynamic)

/// Returns a color object that picks its value from given color objects dynamically
/// based on currently active traits. For pre iOS 13, this method returns the default
/// color object.
///
/// @param darkColor A color object returned when @c userInterfaceStyle is @c
/// UIUserInterfaceStyleDark based on currently active traits.
/// @param defaultColor A default color object.
+ (nonnull UIColor *)colorWithUserInterfaceStyleDarkColor:(nonnull UIColor *)darkColor
                                             defaultColor:(nonnull UIColor *)defaultColor;

/**
 Returns a dynamic color object that resolves to high contrast color when current
 @c accessibilityContrast is @c UIAccessibilityContrastHigh, and to normal contrast color
 when @c accessibilityContrast is @c UIAccessibilityContrastNormal.

 The high contrast color and normal contrast color can be dynamic color objects. This method can
 be used together with @c colorWithUserInterfaceStyleDarkColor:defaultColor:.

 For pre iOS 13, this method always returns the normal contrast color.

 @param highContrastColor A color object for high contrast color.
 @param normalContrastColor A default color object for normal contrast color.
 */
+ (nonnull UIColor *)colorWithAccessibilityContrastHigh:(nonnull UIColor *)highContrastColor
                                                 normal:(nonnull UIColor *)normalContrastColor;

/**
 Returns the version of the current color that takes the specified traits into account.

 @note On pre-iOS 13 the orginal color is returned.

 @param traitCollection The traits to use when resolving the color information.
 @return The version of the color to display for the specified traits.
 */
- (nonnull UIColor *)mdc_resolvedColorWithTraitCollection:
    (nonnull UITraitCollection *)traitCollection;

@end
