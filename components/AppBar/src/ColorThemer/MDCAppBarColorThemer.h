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

#import "MaterialAppBar.h"
#import "MaterialColorScheme.h"

/**
 The Material Design color system's themer for instances of MDCAppBar.
 */
@interface MDCAppBarColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCAppBar using the primary mapping.

 Uses the primary color as the most important color for the component.

 @param colorScheme The color scheme to apply to the component instance.
 @param appBar A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                        toAppBar:(nonnull MDCAppBar *)appBar;

/**
 Applies a color scheme's properties to an MDCAppBar using the surface mapping.

 Uses the surface color as the most important color for the component.

 @param colorScheme The color scheme to apply to the component instance.
 @param appBar A component instance to which the color scheme should be applied.
 */
+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                  toAppBar:(nonnull MDCAppBar *)appBar;

#pragma mark - Soon to be deprecated

/**
 Applies a color scheme's properties to an MDCAppBar.

 @warning This method will soon be deprecated. Consider using @c +applySemanticColorScheme:toAppBar:
 instead.

 @param colorScheme The color scheme to apply to the component instance.
 @param appBar A component instance to which the color scheme should be applied.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toAppBar:(nonnull MDCAppBar *)appBar;

@end
