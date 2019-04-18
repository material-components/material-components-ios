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

#import "MDCTabBar+MaterialTheming.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kPrimaryThemeUnselectedOpacity = (CGFloat)0.74;
static const CGFloat kSurfaceThemeUnselectedOpacity = (CGFloat)0.6;

@implementation MDCTabBar (MaterialTheming)

- (void)applyPrimaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  [self applyPrimaryThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  [self applyThemeWithTypographyScheme:typographyScheme];
}

- (void)applySurfaceThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  [self applySurfaceThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  [self applyThemeWithTypographyScheme:typographyScheme];
}

- (void)applyPrimaryThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.primaryColor;
  self.tintColor = colorScheme.onPrimaryColor;
  [self setTitleColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  [self setImageTintColor:colorScheme.onPrimaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  [self setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [self setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
}

- (void)applySurfaceThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.surfaceColor;
  self.tintColor = colorScheme.primaryColor;
  [self setTitleColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  [self setImageTintColor:colorScheme.primaryColor forState:MDCTabBarItemStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  [self setTitleColor:unselectedTitleColor forState:MDCTabBarItemStateNormal];
  [self setImageTintColor:unselectedImageColor forState:MDCTabBarItemStateNormal];
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  self.selectedItemTitleFont = typographyScheme.button;
  self.unselectedItemTitleFont = typographyScheme.button;
}

@end
