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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

API_DEPRECATED_BEGIN("🤖👀 Use colors with dynamic providers that handle elevation instead. "
                     "See go/material-ios-color/gm2-migration and "
                     "go/material-ios-shadow/gm2-migration for more info. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

/**
 Provides extension to UIColor for Material Elevation usage.
 */
@interface UIColor (MaterialElevation)

/**
 Returns a color that takes the specified elevation value into account.
 The color is the blended color of Surface and Elevation Overlay in
 https://material.io/design/color/dark-theme.html#properties
 Negative elevation is treated as 0.
 Pattern-based UIColor is not supported.
 @param elevation The @c mdc_absoluteElevation value to use when resolving the color.
 */
- (nonnull UIColor *)mdc_resolvedColorWithElevation:(CGFloat)elevation;

/**
 Returns a color that takes the specified elevation value and traits into account when there is a
 color appearance difference between current traits and previous traits. When userInterfaceStyle is
 UIUserInterfaceStyleDark in currentTraitCollection, elevation will be used to resolve the color.

 Negative elevation is treated as 0.
 Pattern-based UIColor is not supported.
 UIColor in UIExtendedGrayColorSpace will be resolved to UIExtendedSRGBColorSpace.

 @param traitCollection The traits to use when resolving the color.
 @param previousTraitCollection The previous traits to use when comparing color appearance.
 @param elevation The @c mdc_absoluteElevation to use when resolving the color.
 */
- (nonnull UIColor *)
    mdc_resolvedColorWithTraitCollection:(nonnull UITraitCollection *)traitCollection
                 previousTraitCollection:(nonnull UITraitCollection *)previousTraitCollection
                               elevation:(CGFloat)elevation;

/**
 Returns a color that takes the specified elevation value and traits into account.
 When userInterfaceStyle is UIUserInterfaceStyleDark in traitCollection, elevation will be used
 to resolve the color.
 Negative elevation is treated as 0.
 Pattern-based UIColor is not supported.
 UIColor in UIExtendedGrayColorSpace will be resolved to UIExtendedSRGBColorSpace.

 @param traitCollection The traits to use when resolving the color.
 @param elevation The @c mdc_absoluteElevation to use when resolving the color.
 */
- (nonnull UIColor *)mdc_resolvedColorWithTraitCollection:
                         (nonnull UITraitCollection *)traitCollection
                                                elevation:(CGFloat)elevation;
@end

API_DEPRECATED_END
