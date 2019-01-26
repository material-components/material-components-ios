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

#import "MDCBottomDrawerViewController.h"

#import "MDCBottomDrawerTransitionController.h"
#import "MaterialUIMetrics.h"
#import "private/MDCBottomDrawerHeaderMask.h"

@interface MDCBottomDrawerViewController () <MDCBottomDrawerPresentationControllerDelegate>

/** The transition controller. */
@property(nonatomic) MDCBottomDrawerTransitionController *transitionController;
@property(nonatomic) MDCBottomDrawerHeaderMask *maskLayer;

@end

@implementation MDCBottomDrawerViewController {
  NSMutableDictionary<NSNumber *, NSNumber *> *_topCornersRadius;
  BOOL _isMaskAppliedFirstTime;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    [self commonMDCBottomDrawerViewControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomDrawerViewControllerInit];
  }
  return self;
}

- (void)commonMDCBottomDrawerViewControllerInit {
  _transitionController = [[MDCBottomDrawerTransitionController alloc] init];
  _topCornersRadius = [NSMutableDictionary dictionary];
  _topCornersRadius[@(MDCBottomDrawerStateCollapsed)] = @(0);
  _maskLayer = [[MDCBottomDrawerHeaderMask alloc] initWithMaximumCornerRadius:0
                                                          minimumCornerRadius:0];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  if (!_isMaskAppliedFirstTime) {
    _maskLayer.minimumCornerRadius = [self minimumCornerRadius];
    [_maskLayer applyMask];
    _isMaskAppliedFirstTime = YES;
  }
}

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  return self.transitionController;
}

- (UIModalPresentationStyle)modalPresentationStyle {
  return UIModalPresentationCustom;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _trackingScrollView = trackingScrollView;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.trackingScrollView = trackingScrollView;
  }
  // Rather than have the client manually disable scrolling on the internal scroll view for
  // the drawer to work properly, we can disable it if a trackingScrollView is provided.
  [trackingScrollView setScrollEnabled:NO];
}

- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState {
  _topCornersRadius[@(drawerState)] = @(radius);

  if (drawerState == MDCBottomDrawerStateCollapsed) {
    _maskLayer.maximumCornerRadius = radius;
  } else {
    _maskLayer.minimumCornerRadius = [self minimumCornerRadius];
  }
}

- (CGFloat)minimumCornerRadius {
  return [self contentReachesFullScreen]
             ? [self topCornersRadiusForDrawerState:MDCBottomDrawerStateFullScreen]
             : [self topCornersRadiusForDrawerState:MDCBottomDrawerStateExpanded];
}

- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState {
  NSNumber *topCornersRadius = _topCornersRadius[@(drawerState)];
  if (topCornersRadius != nil) {
    return (CGFloat)[topCornersRadius doubleValue];
  }
  return 0;
}

- (void)setHeaderViewController:(UIViewController<MDCBottomDrawerHeader> *)headerViewController {
  _headerViewController = headerViewController;
  _maskLayer.view = headerViewController.view;
}

- (void)setContentViewController:(UIViewController *)contentViewController {
  _contentViewController = contentViewController;
  if (!_headerViewController) {
    _maskLayer.view = contentViewController.view;
  }
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _scrimColor = scrimColor;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.scrimColor = scrimColor;
  }
}

- (BOOL)isAccessibilityMode {
  return UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
}
- (BOOL)isMobileLandscape {
  return self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact;
}
- (BOOL)shouldPresentFullScreen {
  return [self isAccessibilityMode] || [self isMobileLandscape];
}

- (BOOL)contentReachesFullScreen {
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    return bottomDrawerPresentationController.contentReachesFullscreen;
  }
  return [self shouldPresentFullScreen];
}

- (void)setTopHandleHidden:(BOOL)topHandleHidden {
  _topHandleHidden = topHandleHidden;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.topHandleHidden = topHandleHidden;
  }
}

- (void)setTopHandleColor:(UIColor *)topHandleColor {
  _topHandleColor = topHandleColor;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.topHandleColor = topHandleColor;
  }
}

#pragma mark UIAccessibilityAction

// Adds the Z gesture for dismissal.
- (BOOL)accessibilityPerformEscape {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

- (void)bottomDrawerTopTransitionRatio:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                       transitionRatio:(CGFloat)transitionRatio {
  [_maskLayer animateWithPercentage:1 - transitionRatio];
  if (self.delegate) {
    [self contentDrawerTopInset:transitionRatio];
  }
}

- (void)bottomDrawerWillChangeState:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState {
  _drawerState = drawerState;
  CGFloat minimumCornerRadius = [self minimumCornerRadius];
  if (_maskLayer.minimumCornerRadius != minimumCornerRadius) {
    _maskLayer.minimumCornerRadius = minimumCornerRadius;
    [_maskLayer applyMask];
  }
}

- (void)contentDrawerTopInset:(CGFloat)transitionToTop {
  CGFloat topInset = MDCDeviceTopSafeAreaInset();
  if ([self contentReachesFullScreen]) {
    topInset -= ((CGFloat)1.0 - transitionToTop) * topInset;
  } else {
    topInset = (CGFloat)0.0;
  }
  if (!self.topHandleHidden) {
    topInset = MAX(topInset, (CGFloat)7.0);
  }
  [self.delegate bottomDrawerControllerDidChangeTopInset:self topInset:topInset];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated {
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    [bottomDrawerPresentationController setContentOffsetY:contentOffsetY animated:animated];
  }
}

- (void)expandToFullscreenWithDuration:(CGFloat)duration
                            completion:(void (^__nullable)(BOOL finished))completion {
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    [bottomDrawerPresentationController expandToFullscreenWithDuration:duration
                                                            completion:completion];
  }
}

@end
