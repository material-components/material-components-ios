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

#import "MDCBannerView+MaterialTheming.h"
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialButtons+Theming.h>

static CGFloat const kBannerViewTextViewOpacityDefault = (CGFloat)0.87;
static CGFloat const kBannerViewDividerOpacityDefault = (CGFloat)0.12;

@implementation MDCBannerView (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme {
  // Color
  [self applyThemeWithColorScheme:scheme.colorScheme];

  // Typography
  [self applyThemeWithTypographyScheme:scheme.typographyScheme];

  // Apply Text Theme to buttons on Banner by default.
  [self.leadingButton applyTextThemeWithScheme:scheme];
  [self.trailingButton applyTextThemeWithScheme:scheme];

  self.showsDivider = YES;
}

#pragma mark - Internal Helpers

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.backgroundColor = colorScheme.surfaceColor;
  self.textView.textColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kBannerViewTextViewOpacityDefault];
  self.dividerColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kBannerViewDividerOpacityDefault];
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  self.textView.font = typographyScheme.body2;
}

@end
