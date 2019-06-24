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

#import "MDCTabBarColorThemer.h"

static const CGFloat kUnselectedTitleOpacity = (CGFloat)0.6;
static const CGFloat kUnselectedImageOpacity = (CGFloat)0.54;
static const CGFloat kBottomDividerOpacity = (CGFloat)0.12;

@implementation MDCTabBarColorThemer

+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                          toTabs:(nonnull MDCTabBar *)tabBar {
  tabBar.barTintColor = colorScheme.primaryColor;
  tabBar.tintColor = colorScheme.onPrimaryColor;
  [tabBar setTitleColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  [tabBar setImageTintColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedImageOpacity];
  [tabBar setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [tabBar setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
  tabBar.bottomDividerColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kBottomDividerOpacity];
}

+ (void)applySurfaceVariantWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme
                                    toTabs:(nonnull MDCTabBar *)tabBar {
  tabBar.barTintColor = colorScheme.surfaceColor;
  tabBar.tintColor = colorScheme.primaryColor;
  [tabBar setTitleColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  [tabBar setImageTintColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedImageOpacity];
  [tabBar setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [tabBar setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
  tabBar.bottomDividerColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kBottomDividerOpacity];
}

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme toTabBar:(MDCTabBar *)tabBar {
  if ([colorScheme respondsToSelector:@selector(primaryLightColor)]) {
    tabBar.unselectedItemTintColor = colorScheme.primaryLightColor;
    tabBar.inkColor = colorScheme.primaryLightColor;
    tabBar.rippleColor = colorScheme.primaryLightColor;
  }
  if ([colorScheme respondsToSelector:@selector(primaryDarkColor)]) {
    tabBar.selectedItemTintColor = colorScheme.primaryDarkColor;
  }
}

@end
