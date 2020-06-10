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

#import <MaterialComponents/MaterialButtons+Theming.h>
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialElevation.h>
#import <MaterialComponents/MaterialTypography.h>

// The opacity value applied to text view.
static CGFloat const kTextViewOpacity = (CGFloat)0.87;
// The opacity value applied to divider.
static CGFloat const kDividerOpacity = (CGFloat)0.12;

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
  if (colorScheme.elevationOverlayEnabledForDarkMode) {
    UIColor *elevationSurfaceColor =
        [colorScheme.surfaceColor mdc_resolvedColorWithTraitCollection:self.traitCollection
                                                             elevation:self.mdc_absoluteElevation];
    self.backgroundColor = elevationSurfaceColor;
  } else {
    self.backgroundColor = colorScheme.surfaceColor;
  }
  self.textView.textColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kTextViewOpacity];
  self.dividerColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kDividerOpacity];
  self.imageView.tintColor = colorScheme.primaryColor;

  if (colorScheme.elevationOverlayEnabledForDarkMode) {
    self.mdc_elevationDidChangeBlock =
        ^(id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation) {
          if ([object isKindOfClass:[MDCBannerView class]]) {
            MDCBannerView *bannerView = (MDCBannerView *)object;
            UIColor *elevationSurfaceColor = [colorScheme.surfaceColor
                mdc_resolvedColorWithTraitCollection:bannerView.traitCollection
                                           elevation:bannerView.mdc_absoluteElevation];
            bannerView.backgroundColor = elevationSurfaceColor;
          }
        };
    self.traitCollectionDidChangeBlock = ^(MDCBannerView *_Nonnull bannerView,
                                           UITraitCollection *_Nullable previousTraitCollection) {
      bannerView.backgroundColor = [colorScheme.surfaceColor
          mdc_resolvedColorWithTraitCollection:bannerView.traitCollection
                       previousTraitCollection:previousTraitCollection
                                     elevation:bannerView.mdc_absoluteElevation];
    };
  }
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  UIFont *textFont = typographyScheme.body2;

  if (typographyScheme.useCurrentContentSizeCategoryWhenApplied) {
    textFont = [textFont mdc_scaledFontForTraitEnvironment:self];
  }
  self.textView.font = textFont;
}

@end
