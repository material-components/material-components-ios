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

#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MDCAlertController+ButtonForAction.h"  // TODO(b/126884296): One-off transformation needs fixing in copy.bara.sky
#import "MaterialDialogs.h"
#import "MaterialShadowElevations.h"  // ComponentImport
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"
#import "MaterialTypographyScheme+Scheming.h"

static const CGFloat kCornerRadius = 4;

@implementation MDCAlertController (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // TODO(https://github.com/material-components/material-components-ios/issues/6637 ): Force-load
  // the view before setting the buttons fonts to ensure that they aren't overwritten in
  // -updateButtonFont. If the bug gets fixed, this hack can be removed.
  [self loadViewIfNeeded];

  // Color
  [self applyColorThemeWithScheme:scheme.colorScheme];

  // Typography
  [self applyTypographyThemeWithScheme:scheme.typographyScheme];

  // Other properties
  self.cornerRadius = kCornerRadius;
  self.elevation = MDCShadowElevationDialog;

  // Buttons
  for (MDCAlertAction *action in self.actions) {
    MDCButton *button = [self buttonForAction:action];
    // todo: b/117265609: Incorporate dynamic type support in semantic themers
    switch (action.emphasis) {
      case MDCActionEmphasisHigh:
        [button applyContainedThemeWithScheme:scheme];
        break;
      case MDCActionEmphasisMedium:
        [button applyOutlinedThemeWithScheme:scheme];
        break;
      case MDCActionEmphasisLow:  // fallthrough
      default:
        [button applyTextThemeWithScheme:scheme];
        break;
    }
  }
}

- (void)applyTypographyThemeWithScheme:(id<MDCTypographyScheming>)typographyScheme {
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  self.titleFont = typographyScheme.headline6;
  self.messageFont = typographyScheme.body1;
}

- (void)applyColorThemeWithScheme:(id<MDCColorScheming>)colorScheme {
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }

  self.titleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87];
  self.messageColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60];
  self.attributedLinkColor = colorScheme.primaryColor;
  self.titleIconTintColor = colorScheme.primaryColor;
  self.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.32];
  self.backgroundColor = colorScheme.surfaceColor;
}

@end
