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

#import "MaterialColorScheme.h"
#import "MaterialTabs.h"

/**
 The Material Design color system's themer for instances of MDCTabBar.
 */
@interface MDCTabBarColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCTabBar using the primary mapping.

 Uses the primary color as the most important color for the component.

 @param colorScheme The color scheme to apply to the component instance.
 @param tabBar A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                          toTabs:(nonnull MDCTabBar *)tabBar;

/**
 Applies a color scheme's properties to an MDCTabBar using the surface mapping.

 Uses the surface color as the most important color for the component.

 @param colorScheme The color scheme to apply to the component instance.
 @param tabBar A component instance to which the color scheme should be applied.
 */
+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                    toTabs:(nonnull MDCTabBar *)tabBar;

@end

@interface MDCTabBarColorThemer (ToBeDeprecated)

/**
 Applies a color scheme to theme a MDCTabBar.

 @warning This method will soon be deprecated. Consider using @c +applySemanticColorScheme:toTabs:
 instead. Learn more at components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to MDCTabBar.
 @param tabBar A MDCTabBar instance to apply a color scheme. 
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
                toTabBar:(nonnull MDCTabBar *)tabBar;

@end
