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

#import "MDCBottomNavigationBar+MaterialTheming.h"

#import "MaterialColorScheme.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypographyScheme.h"

static const CGFloat kUnselectedPrimaryAlpha = 0.74f;
static const CGFloat kUnselectedSurfaceAlpha = 0.6f;

@implementation MDCBottomNavigationBar (MaterialTheming)

- (void)applyPrimaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applyPrimaryThemeWithColorScheme:scheme.colorScheme];
  [self applyThemeWithTypographyScheme:scheme.typographyScheme];
  self.elevation = MDCShadowElevationBottomNavigationBar;
  self.itemsContentVerticalMargin = 0;
}

- (void)applyPrimaryThemeWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.primaryColor;
  self.selectedItemTintColor = colorScheme.onPrimaryColor;
  self.selectedItemTitleColor = colorScheme.onPrimaryColor;
  self.unselectedItemTintColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kUnselectedPrimaryAlpha];
}

- (void)applySurfaceThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  [self applySurfaceThemeWithColorScheme:scheme.colorScheme];
  [self applyThemeWithTypographyScheme:scheme.typographyScheme];
  self.elevation = MDCShadowElevationBottomNavigationBar;
  self.itemsContentVerticalMargin = 0;
}

- (void)applySurfaceThemeWithColorScheme:(nonnull id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.surfaceColor;
  self.selectedItemTintColor = colorScheme.primaryColor;
  self.selectedItemTitleColor = colorScheme.primaryColor;
  self.unselectedItemTintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kUnselectedSurfaceAlpha];
}

- (void)applyThemeWithTypographyScheme:(nonnull id<MDCTypographyScheming>)typographyScheme {
  self.itemTitleFont = typographyScheme.caption;
}

@end
