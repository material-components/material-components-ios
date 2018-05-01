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

#import "MaterialColorScheme.h"
#import "MaterialSlider.h"

#import <Foundation/Foundation.h>

/**
 The Material Design color system's themer for instances of MDCSlider.
 */
@interface MDCSliderColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCSlider.

 @param colorScheme The color scheme to apply to the component instance.
 @param slider A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toSlider:(nonnull MDCSlider *)slider;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme to theme a MDCSlider.

 @warning This method will soon be deprecated. Consider using @c +applySemanticColorScheme:toSlider:
 instead.

 @param colorScheme The color scheme to apply to MDCSlider.
 @param slider A MDCSlider instance to apply a color scheme.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toSlider:(nonnull MDCSlider *)slider;

/**
 A default color scheme for sliders displayed on light backgrounds. The primary color is blue and
 the primary light and primary dark are gray.

 @warning This method will soon be deprecated. Consider using MDCSemanticColorScheme instead.
 */
+ (nonnull MDCBasicColorScheme *)defaultSliderLightColorScheme;

/**
 A default color scheme for sliders displayed on dark backgrounds. The primary color is blue and
 the primary light and primary dark are white.

 @warning This method will soon be deprecated. Consider using MDCSemanticColorScheme instead.
 */
+ (nonnull MDCBasicColorScheme *)defaultSliderDarkColorScheme;


@end
