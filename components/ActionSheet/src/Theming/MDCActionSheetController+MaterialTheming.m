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

#import "MDCActionSheetController+MaterialTheming.h"

#import "MaterialAvailability.h"
#import "MaterialColor.h"
#import "MaterialShadowElevations.h"

static const CGFloat kHighAlpha = (CGFloat)0.87;
static const CGFloat kMediumAlpha = (CGFloat)0.6;
static const CGFloat kRippleAlpha = (CGFloat)0.16;

@implementation MDCActionSheetController (MaterialTheming)

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

- (UIColor *)dynamicColorWithColor:(UIColor *)color elevation:(CGFloat)elevation {
  UIColor *darkModeColor = [color mdc_resolvedColorWithElevation:elevation];
  return [UIColor colorWithUserInterfaceStyleDarkColor:darkModeColor defaultColor:color];
}

- (void)applyThemeWithColorScheme:(id<MDCColorScheming>)colorScheme {
  self.elevation = MDCShadowElevationModalActionSheet;
  [self applyBackgroundColorToActionSheet:self withColorScheme:colorScheme];
  if (self.message && ![self.message isEqualToString:@""]) {
    // If there is a message then this can be high opacity and won't clash with actions.
    self.titleTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  } else {
    self.titleTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  }
  self.messageTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  self.imageRenderingMode = UIImageRenderingModeAlwaysTemplate;
  self.actionTintColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha];
  self.actionTextColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha];
  self.rippleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kRippleAlpha];
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    self.traitCollectionDidChangeBlock = ^(MDCActionSheetController *_Nonnull actionSheet,
                                           UITraitCollection *_Nullable previousTraitCollection) {
      if ([actionSheet.traitCollection
              hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
        [actionSheet applyBackgroundColorToActionSheet:actionSheet withColorScheme:colorScheme];
      }
    };
    self.mdc_elevationDidChangeBlock =
        ^(id<MDCElevatable> _Nonnull object, CGFloat absoluteElevation) {
          if ([object isKindOfClass:[MDCActionSheetController class]]) {
            MDCActionSheetController *actionSheet = (MDCActionSheetController *)object;
            [actionSheet applyBackgroundColorToActionSheet:actionSheet withColorScheme:colorScheme];
          }
        };
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)applyBackgroundColorToActionSheet:(MDCActionSheetController *)actionSheet
                          withColorScheme:(id<MDCColorScheming>)colorScheme {
  if (colorScheme.elevationOverlayEnabledForDarkMode) {
    actionSheet.backgroundColor =
        [self dynamicColorWithColor:colorScheme.surfaceColor
                          elevation:actionSheet.view.mdc_absoluteElevation];
  } else {
    actionSheet.backgroundColor = colorScheme.surfaceColor;
  }
}

- (void)applyThemeWithTypographyScheme:(id<MDCTypographyScheming>)typographyScheme {
  self.titleFont = typographyScheme.subtitle1;
  self.messageFont = typographyScheme.body2;
  self.actionFont = typographyScheme.subtitle1;
}

@end
