// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomDrawerColorThemer.h"

static const CGFloat kScrimAlpha = (CGFloat)0.32;

@implementation MDCBottomDrawerColorThemer

+ (void)applySemanticColorScheme:(id<MDCColorScheming>)colorScheme
                  toBottomDrawer:(nonnull MDCBottomDrawerViewController *)bottomDrawer {
//  if (colorScheme.shouldLightenElevatedSurfacesWithDarkMode) {
//    CGFloat finalElevation = bottomDrawer.mdc_absoluteElevation + bottomDrawer.mdc_elevation;
//    id<MDCColorScheming> resolvedColorScheme =
//        [colorScheme resolvedSchemeForTraitCollection:bottomDrawer.traitCollection elevation:finalElevation];
//    bottomDrawer.headerViewController.view.backgroundColor = resolvedColorScheme.surfaceColor;
//    bottomDrawer.contentViewController.view.backgroundColor = resolvedColorScheme.surfaceColor;
//  }
  bottomDrawer.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kScrimAlpha];
}

@end
