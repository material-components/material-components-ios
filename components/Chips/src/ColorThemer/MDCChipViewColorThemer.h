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

#import "MaterialChips.h"
#import "MaterialColorScheme.h"

#import <Foundation/Foundation.h>

/**
 The Material Design color system's themer for instances of MDCChipView.
 */
@interface MDCChipViewColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCChipView.

 @param colorScheme The color scheme to apply to the component instance.
 @param chipView A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                      toChipView:(nonnull MDCChipView *)chipView;

/**
 Applies a color scheme's properties to the component instance with the outlined style.

 @param colorScheme The color scheme to apply to the component instance.
 @param chipView @c A component instance to which the color scheme should be applied.
 */
+ (void)applyOutlinedVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                 toChipView:(nonnull MDCChipView *)chipView;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme's properties to a stroked MDCChipView.

 @warning This method will soon be deprecated. Consider using
 @c +applyOutlinedVariantWithColorScheme:toChipView: instead.
 
 @param colorScheme The color scheme to apply to the component instance.
 @param strokedChipView A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
               toStrokedChipView:(nonnull MDCChipView *)strokedChipView;

@end
