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

/**
 Themes @c MDCChipView objects to set their color properties to the appropriate color trait given a
 color scheme.
 */
@interface MDCChipViewColorThemer : NSObject

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param inputChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                 toInputChipView:(nonnull MDCChipView *)inputChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param strokedInputChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
          toStrokedInputChipView:(nonnull MDCChipView *)strokedInputChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param choiceChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                toChoiceChipView:(nonnull MDCChipView *)choiceChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param strokedChoiceChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
         toStrokedChoiceChipView:(nonnull MDCChipView *)strokedChoiceChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param actionChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                toActionChipView:(nonnull MDCChipView *)actionChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param strokedActionChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
         toStrokedActionChipView:(nonnull MDCChipView *)strokedActionChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param filterChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                toFilterChipView:(nonnull MDCChipView *)filterChipView;

/**
 Applies a color scheme's properties to @c MDCChipView.

 @param colorScheme The color scheme to apply to @c MDCChipView.
 @param strokedFilterChipView @c MDCChipView to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
         toStrokedFilterChipView:(nonnull MDCChipView *)strokedFilterChipView;

@end
