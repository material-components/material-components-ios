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

#import "MDCAppBarViewController+MaterialTheming.h"

@implementation MDCAppBarViewController (MaterialTheming)

- (void)applyPrimaryThemeWithScheme:(id<MDCContainerScheming>)containerScheme {
  [self applyDefaultShadowLayerBehavior];
  self.headerView.backgroundColor = containerScheme.colorScheme.primaryColor;
  self.navigationBar.leadingBarItemsTintColor = containerScheme.colorScheme.onPrimaryColor;
  self.navigationBar.trailingBarItemsTintColor = containerScheme.colorScheme.onPrimaryColor;
  self.navigationBar.allowAnyTitleFontSize = YES;
  self.navigationBar.titleFont = containerScheme.typographyScheme.headline6;
  self.navigationBar.titleTextColor = containerScheme.colorScheme.onPrimaryColor;
}

- (void)applySurfaceThemeWithScheme:(id<MDCContainerScheming>)containerScheme {
  [self applyDefaultShadowLayerBehavior];
  self.headerView.backgroundColor = containerScheme.colorScheme.surfaceColor;
  self.navigationBar.leadingBarItemsTintColor = containerScheme.colorScheme.onSurfaceColor;
  self.navigationBar.trailingBarItemsTintColor =
      [containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.54];
  self.navigationBar.allowAnyTitleFontSize = YES;
  self.navigationBar.titleFont = containerScheme.typographyScheme.headline6;
  self.navigationBar.titleTextColor =
      [containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
}

- (void)applyDefaultShadowLayerBehavior {
  __weak MDCAppBarViewController *weakSelf = self;
  MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock =
      ^(CALayer *_Nonnull shadowLayer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        weakSelf.headerView.elevation = elevation;
        [(MDCShadowLayer *)shadowLayer setElevation:elevation];
      };
  [self.headerView setShadowLayer:[MDCShadowLayer layer] intensityDidChangeBlock:intensityBlock];
}

@end
