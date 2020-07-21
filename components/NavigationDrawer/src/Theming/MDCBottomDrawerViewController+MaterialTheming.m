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

#import "MaterialElevation.h"
#import "MDCBottomDrawerViewController+MaterialTheming.h"

static const CGFloat kCollapsedCornerRadius = 8.0f;
static const CGFloat kFullScreenCornerRadius = 0.0f;
static const CGFloat kScrimAlpha = 0.32f;
static const CGFloat kTopHandleAlpha = 0.12f;

@implementation MDCBottomDrawerViewController (MaterialTheming)

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme {
  [self applyThemeWithScheme:scheme applyToTrackingScrollView:NO];
}

- (void)applyThemeWithScheme:(id<MDCContainerScheming>)scheme
    applyToTrackingScrollView:(BOOL)applyToTrackingScrollView {
  [self applyColorThemeWithColorScheme:scheme.colorScheme
             applyToTrackingScrollView:applyToTrackingScrollView];
  [self setTopCornersRadius:kCollapsedCornerRadius forDrawerState:MDCBottomDrawerStateCollapsed];
  [self setTopCornersRadius:kFullScreenCornerRadius forDrawerState:MDCBottomDrawerStateFullScreen];
}

- (void)applyColorThemeWithColorScheme:(id<MDCColorScheming>)colorScheme
             applyToTrackingScrollView:(BOOL)applyToTrackingScrollView {
  [MDCBottomDrawerViewController
      mdc_setResolvedBackgroundColorForBottomDrawer:self
                          applyToTrackingScrollView:applyToTrackingScrollView
                                         withScheme:colorScheme];
  if (colorScheme.elevationOverlayEnabledForDarkMode) {
    self.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _Nonnull object,
                                         CGFloat absoluteElevation) {
      if ([object isKindOfClass:[MDCBottomDrawerViewController class]]) {
        MDCBottomDrawerViewController *bottomDrawer = (MDCBottomDrawerViewController *)object;
        [MDCBottomDrawerViewController
            mdc_setResolvedBackgroundColorForBottomDrawer:bottomDrawer
                                applyToTrackingScrollView:applyToTrackingScrollView
                                               withScheme:colorScheme];
      }
    };
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
      self.traitCollectionDidChangeBlock = ^(MDCBottomDrawerViewController *_Nonnull bottomDrawer,
                                             UITraitCollection *_Nullable previousTraitCollection) {
        if ([bottomDrawer.traitCollection
                hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
          [MDCBottomDrawerViewController
              mdc_setResolvedBackgroundColorForBottomDrawer:bottomDrawer
                                  applyToTrackingScrollView:applyToTrackingScrollView
                                                 withScheme:colorScheme];
        }
      };
    }
#endif
  }
  self.scrimColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kScrimAlpha];
  self.topHandleColor = [colorScheme.onSurfaceColor colorWithAlphaComponent:kTopHandleAlpha];
}

+ (void)mdc_setResolvedBackgroundColorForBottomDrawer:(MDCBottomDrawerViewController *)bottomDrawer
                            applyToTrackingScrollView:(BOOL)applyToTrackingScrollView
                                           withScheme:(id<MDCColorScheming>)scheme {
  UIColor *backgroundColor = [scheme.backgroundColor
      mdc_resolvedColorWithTraitCollection:bottomDrawer.traitCollection
                                 elevation:bottomDrawer.view.mdc_absoluteElevation];
  bottomDrawer.headerViewController.view.backgroundColor = backgroundColor;
  bottomDrawer.contentViewController.view.backgroundColor = backgroundColor;
  if (applyToTrackingScrollView) {
    bottomDrawer.trackingScrollView.backgroundColor = backgroundColor;
  }
}

@end
