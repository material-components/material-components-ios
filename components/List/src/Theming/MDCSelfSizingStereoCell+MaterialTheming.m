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

#import "MDCSelfSizingStereoCell+MaterialTheming.h"

#import "MaterialTypography.h"

static const CGFloat kHighAlpha = (CGFloat)0.87;
static const CGFloat kInkAlpha = (CGFloat)0.16;

@implementation MDCSelfSizingStereoCell (MaterialTheming)

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  id<MDCColorScheming> colorScheme = scheme.colorScheme;
  if (!colorScheme) {
    colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyThemeWithColorScheme:colorScheme];

  id<MDCTypographyScheming> typographyScheme = scheme.typographyScheme;
  if (!typographyScheme) {
    typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyThemeWithTypographyScheme:typographyScheme];
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.titleLabel.textColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  self.detailLabel.textColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  self.leadingImageView.tintColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  self.trailingImageView.tintColor =
      [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  UIColor *rippleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha];
  self.inkColor = rippleColor;
  self.rippleColor = rippleColor;
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  UIFont *titleFont = typographyScheme.subtitle1;
  UIFont *detailFont = typographyScheme.body2;

  if (typographyScheme.useCurrentContentSizeCategoryWhenApplied) {
    titleFont = [titleFont mdc_scaledFontForTraitEnvironment:self];
    detailFont = [detailFont mdc_scaledFontForTraitEnvironment:self];
  }

  self.titleLabel.font = titleFont;
  self.detailLabel.font = detailFont;
}

@end
