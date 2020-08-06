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

#import "private/MDCBottomDrawerHeaderMask.h"
#import "MDCBottomDrawerTransitionController.h"
#import "MDCBottomDrawerViewControllerDelegate.h"
#import "MaterialMath.h"
#import "MaterialUIMetrics.h"

@interface MDCBottomDrawerViewController () <MDCBottomDrawerPresentationControllerDelegate>

/** The transition controller. */
@property(nonatomic) MDCBottomDrawerTransitionController *transitionController;
@property(nonatomic) MDCBottomDrawerHeaderMask *maskLayer;

@end

@implementation MDCBottomDrawerViewController {
  NSMutableDictionary<NSNumber *, NSNumber *> *_topCornersRadius;
  BOOL _isMaskAppliedFirstTime;

  // Used for forwarding touch events if enabled.
  __weak UIResponder *_cachedNextResponder;
  // Used for tracking the presentation/dismissal animations.
  BOOL _isDrawerClosed;
  CGFloat _lastOffset;
}

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;

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
  _maximumInitialDrawerHeight = 0;
  _maximumDrawerHeight = 0;
  _drawerShadowColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.2];
  _elevation = MDCShadowElevationNavDrawer;
  _mdc_overrideBaseElevation = -1;

  _dismissOnBackgroundTap = YES;
  _shouldForwardBackgroundTouchEvents = NO;
  _isDrawerClosed = YES;
  _lastOffset = NSNotFound;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  if (!_isMaskAppliedFirstTime) {
    _maskLayer.minimumCornerRadius = [self minimumCornerRadius];
    [_maskLayer applyMask];
    _isMaskAppliedFirstTime = YES;
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  return self.transitionController;
}

- (UIModalPresentationStyle)modalPresentationStyle {
  return UIModalPresentationCustom;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.presentingViewController.supportedInterfaceOrientations;
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

- (void)setMaximumInitialDrawerHeight:(CGFloat)maximumInitialDrawerHeight {
  _maximumInitialDrawerHeight = maximumInitialDrawerHeight;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.maximumInitialDrawerHeight = maximumInitialDrawerHeight;
  }
}

- (void)setMaximumDrawerHeight:(CGFloat)maximumDrawerHeight {
  _maximumDrawerHeight = maximumDrawerHeight;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.maximumDrawerHeight = maximumDrawerHeight;
  }
}

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _dismissOnBackgroundTap = dismissOnBackgroundTap;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.dismissOnBackgroundTap = self.dismissOnBackgroundTap;
  }
}

- (void)setShouldForwardBackgroundTouchEvents:(BOOL)shouldForwardBackgroundTouchEvents {
  _shouldForwardBackgroundTouchEvents = shouldForwardBackgroundTouchEvents;
  if (shouldForwardBackgroundTouchEvents) {
    [self setDismissOnBackgroundTap:NO];
  }
}

- (void)setElevation:(MDCShadowElevation)elevation {
  _elevation = elevation;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    BOOL elevationDidChange =
        !MDCCGFloatEqual(bottomDrawerPresentationController.elevation, elevation);
    if (elevationDidChange) {
      bottomDrawerPresentationController.elevation = elevation;
      [self.view mdc_elevationDidChange];
    }
  }
}

- (void)setShouldAlwaysExpandHeader:(BOOL)shouldAlwaysExpandHeader {
  _shouldAlwaysExpandHeader = shouldAlwaysExpandHeader;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.shouldAlwaysExpandHeader = shouldAlwaysExpandHeader;
  }
}

- (void)setDelegate:(id<MDCBottomDrawerViewControllerDelegate>)delegate {
  _delegate = delegate;
  if ([delegate isKindOfClass:[UIResponder class]]) {
    _cachedNextResponder = (UIResponder *)delegate;
  } else {
    _cachedNextResponder = nil;
  }
}

- (UIResponder *)nextResponder {
  // Allow the delegate to opt-in to the responder chain to handle events.
  if (self.shouldForwardBackgroundTouchEvents && _cachedNextResponder) {
    return _cachedNextResponder;
  }

  // Otherwise, just follow the normal path.
  return [super nextResponder];
}

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (void)setDrawerShadowColor:(UIColor *)drawerShadowColor {
  _drawerShadowColor = drawerShadowColor;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.drawerShadowColor = drawerShadowColor;
  }
}

- (void)setShouldIncludeSafeAreaInContentHeight:(BOOL)shouldIncludeSafeAreaInContentHeight {
  _shouldIncludeSafeAreaInContentHeight = shouldIncludeSafeAreaInContentHeight;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.shouldIncludeSafeAreaInContentHeight =
        shouldIncludeSafeAreaInContentHeight;
  }
}

- (void)setShouldIncludeSafeAreaInInitialDrawerHeight:
    (BOOL)shouldIncludeSafeAreaInInitialDrawerHeight {
  _shouldIncludeSafeAreaInInitialDrawerHeight = shouldIncludeSafeAreaInInitialDrawerHeight;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.shouldIncludeSafeAreaInInitialDrawerHeight =
        shouldIncludeSafeAreaInInitialDrawerHeight;
  }
}

- (void)setShouldUseStickyStatusBar:(BOOL)shouldUseStickyStatusBar {
  _shouldUseStickyStatusBar = shouldUseStickyStatusBar;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.shouldUseStickyStatusBar = shouldUseStickyStatusBar;
  }
}

- (void)setShouldAdjustOnContentSizeChange:(BOOL)shouldAdjustOnContentSizeChange {
  _shouldAdjustOnContentSizeChange = shouldAdjustOnContentSizeChange;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.shouldAdjustOnContentSizeChange =
        shouldAdjustOnContentSizeChange;
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

- (void)bottomDrawerPresentTransitionDidEnd:
    (MDCBottomDrawerPresentationController *)presentationController {
  if ([self.delegate respondsToSelector:@selector(bottomDrawerControllerDidEndOpenTransition:)]) {
    [self.delegate bottomDrawerControllerDidEndOpenTransition:self];
  }
}

- (void)bottomDrawerDismissTransitionDidEnd:
    (MDCBottomDrawerPresentationController *)presentationController {
  _isDrawerClosed = YES;
  if ([self.delegate respondsToSelector:@selector(bottomDrawerControllerDidEndCloseTransition:)]) {
    [self.delegate bottomDrawerControllerDidEndCloseTransition:self];
  }
}

- (void)bottomDrawerDidTapScrim:(MDCBottomDrawerPresentationController *)presentationController {
  if ([self.delegate respondsToSelector:@selector(bottomDrawerControllerDidTapScrim:)]) {
    [self.delegate bottomDrawerControllerDidTapScrim:self];
  }
}

- (void)bottomDrawerPresentTransitionWillBegin:
            (MDCBottomDrawerPresentationController *)presentationController
                               withCoordinator:
                                   (id<UIViewControllerTransitionCoordinator>)transitionCoordinator
                                 targetYOffset:(CGFloat)targetYOffset {
  _isDrawerClosed = NO;
  _lastOffset = targetYOffset;
  if ([self.delegate respondsToSelector:@selector
                     (bottomDrawerControllerWillTransitionOpen:withCoordinator:targetYOffset:)]) {
    [self.delegate bottomDrawerControllerWillTransitionOpen:self
                                            withCoordinator:transitionCoordinator
                                              targetYOffset:targetYOffset];
  }
}

- (void)bottomDrawerDismissTransitionWillBegin:
            (MDCBottomDrawerPresentationController *)presentationController
                               withCoordinator:
                                   (id<UIViewControllerTransitionCoordinator>)transitionCoordinator
                                 targetYOffset:(CGFloat)targetYOffset {
  _lastOffset = targetYOffset;
  if ([self.delegate respondsToSelector:@selector
                     (bottomDrawerControllerWillTransitionClosed:withCoordinator:targetYOffset:)]) {
    [self.delegate bottomDrawerControllerWillTransitionClosed:self
                                              withCoordinator:transitionCoordinator
                                                targetYOffset:targetYOffset];
  }
}

- (void)bottomDrawerTopDidChangeYOffset:
            (MDCBottomDrawerPresentationController *)presentationController
                                yOffset:(CGFloat)yOffset {
  // Only forward changes along if the drawer is actually still on screen and the offset has
  // changed. This will avoid sending thru duplicated offset changes or changes where the
  // real value will be calculated soon (aka set to zero for prep, then layout pass happens).
  if (!_isDrawerClosed && _lastOffset != yOffset &&
      [self.delegate respondsToSelector:@selector(bottomDrawerControllerDidChangeTopYOffset:
                                                                                    yOffset:)]) {
    [self.delegate bottomDrawerControllerDidChangeTopYOffset:self yOffset:yOffset];
  }
  _lastOffset = yOffset;
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
  CGFloat topInset = MDCFixedStatusBarHeightOnPreiPhoneXDevices;
  if (@available(iOS 11.0, *)) {
    topInset = self.view.safeAreaInsets.top;
  }

  if ([self contentReachesFullScreen]) {
    topInset -= ((CGFloat)1.0 - transitionToTop) * topInset;
  } else {
    topInset = (CGFloat)0.0;
  }
  if (!self.topHandleHidden) {
    topInset = MAX(topInset, (CGFloat)7.0);
  }

  if ([self.delegate respondsToSelector:@selector(bottomDrawerControllerDidChangeTopInset:
                                                                                 topInset:)]) {
    [self.delegate bottomDrawerControllerDidChangeTopInset:self topInset:topInset];
  }
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

- (void)setAdjustLayoutForIPadSlideOver:(BOOL)adjustLayoutForIPadSlideOver {
  _adjustLayoutForIPadSlideOver = adjustLayoutForIPadSlideOver;
  if ([self.presentationController isKindOfClass:[MDCBottomDrawerPresentationController class]]) {
    MDCBottomDrawerPresentationController *bottomDrawerPresentationController =
        (MDCBottomDrawerPresentationController *)self.presentationController;
    bottomDrawerPresentationController.adjustLayoutForIPadSlideOver =
        self.adjustLayoutForIPadSlideOver;
  }
}

@end
