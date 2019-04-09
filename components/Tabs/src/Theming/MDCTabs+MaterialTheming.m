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

#import "MDCTabs+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialTypographyScheme.h>

static const CGFloat kUnselectedTitleOpacity = (CGFloat)0.6;
static const CGFloat kUnselectedImageOpacity = (CGFloat)0.6;
static const CGFloat kBottomDividerOpacity = (CGFloat)0.12;

@implementation MDCTabBar (MaterialTheming)

- (void)applyPrimaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  [self applySemanticThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  [self applyThemeWithTypographyScheme:typographyScheme];
}

- (void)applySurfaceVariantThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  [self applySurfaceVariantThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  [self applyThemeWithTypographyScheme:typographyScheme];
}

- (void)applySemanticThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.primaryColor;
  self.tintColor = colorScheme.onPrimaryColor;
  [self setTitleColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  [self setImageTintColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedImageOpacity];
  [self setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [self setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
  self.bottomDividerColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kBottomDividerOpacity];
}

- (void)applySurfaceVariantThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.surfaceColor;
  self.tintColor = colorScheme.primaryColor;
  [self setTitleColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  [self setImageTintColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedTitleOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedImageOpacity];
  [self setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [self setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
  self.bottomDividerColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kBottomDividerOpacity];
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  self.selectedItemTitleFont = typographyScheme.button;
  self.unselectedItemTitleFont = typographyScheme.button;
}

@end
