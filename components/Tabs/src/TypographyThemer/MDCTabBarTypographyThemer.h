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

#import "MaterialTabs.h"
#import "MaterialTypographyScheme.h"

/**
 Used to apply a typography scheme to theme MDCTabBar.
 */
@interface MDCTabBarTypographyThemer : NSObject

/**
 Applies a typography scheme to theme a MDCTabBar.

 @param typographyScheme The typography scheme to apply to MDCTabBar.
 @param tabBar A MDCTabBar instance to apply a color scheme.
 */
+ (void)applyTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme
                     toTabBar:(nonnull MDCTabBar *)tabBar;

@end
