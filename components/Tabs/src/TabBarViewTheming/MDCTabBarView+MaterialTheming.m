// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialTabs+TabBarView.h"
#import "MDCTabBarView+MaterialTheming.h"

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme+Scheming.h"

static const CGFloat kPrimaryThemeUnselectedOpacity = 0.74f;
static const CGFloat kPrimaryThemeBottomDividerOpacity = 0.12f;
static const CGFloat kSurfaceThemeUnselectedOpacity = 0.6f;

@implementation MDCTabBarView (MaterialTheming)

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
  self.bottomDividerColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeBottomDividerOpacity];
  self.selectionIndicatorStrokeColor = colorScheme.onPrimaryColor;
  [self setTitleColor:colorScheme.onPrimaryColor forState:UIControlStateSelected];
  [self setImageTintColor:colorScheme.onPrimaryColor forState:UIControlStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onPrimaryColor colorWithAlphaComponent:kPrimaryThemeUnselectedOpacity];
  [self setTitleColor:unselectedTitleColor forState:UIControlStateNormal];
  [self setImageTintColor:unselectedImageColor forState:UIControlStateNormal];
}

- (void)applySurfaceThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.barTintColor = colorScheme.surfaceColor;
  self.bottomDividerColor = colorScheme.onSurfaceColor;
  self.selectionIndicatorStrokeColor = colorScheme.primaryColor;
  [self setTitleColor:colorScheme.primaryColor forState:UIControlStateSelected];
  [self setImageTintColor:colorScheme.primaryColor forState:UIControlStateSelected];
  UIColor *unselectedTitleColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  UIColor *unselectedImageColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kSurfaceThemeUnselectedOpacity];
  [self setTitleColor:unselectedTitleColor forState:UIControlStateNormal];
  [self setImageTintColor:unselectedImageColor forState:UIControlStateNormal];
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  [self setTitleFont:typographyScheme.button forState:UIControlStateNormal];
  [self setTitleFont:typographyScheme.button forState:UIControlStateSelected];
}

@end
