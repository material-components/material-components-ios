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
#import "private/MDCBottomDrawerHeaderMask.h"

@interface MDCBottomDrawerViewController () <MDCBottomDrawerPresentationControllerDelegate>

/** The transition controller. */
@property(nonatomic) MDCBottomDrawerTransitionController *transitionController;
@property(nonatomic) MDCBottomDrawerHeaderMask *maskLayer;

@end

@implementation MDCBottomDrawerViewController {
  NSMutableDictionary<NSNumber *, NSNumber *> *_topCornersRadius;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _transitionController = [[MDCBottomDrawerTransitionController alloc] init];
    _topCornersRadius = [NSMutableDictionary dictionary];
    _topCornersRadius[@(MDCBottomDrawerStateCollapsed)] = @(0.f);
    _maskLayer = [[MDCBottomDrawerHeaderMask alloc] initWithMaximumCornerRadius:0.f
                                                            minimumCornerRadius:0.f];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  _maskLayer.minimumCornerRadius = [self getMinimumCornerRadius];
  [_maskLayer applyMask];
}

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  return _transitionController;
}

- (UIModalPresentationStyle)modalPresentationStyle {
  return UIModalPresentationCustom;
}

- (UIScrollView *)trackingScrollView {
  return _transitionController.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _transitionController.trackingScrollView = trackingScrollView;
}

- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState {
  _topCornersRadius[@(drawerState)] = @(radius);

  if (drawerState == MDCBottomDrawerStateCollapsed) {
    _maskLayer.maximumCornerRadius = radius;
  } else {
    _maskLayer.minimumCornerRadius = [self getMinimumCornerRadius];
  }
}

- (CGFloat)getMinimumCornerRadius {
  return [self contentReachesFullScreen]
             ? [self topCornersRadiusForDrawerState:MDCBottomDrawerStateFullScreen]
             : [self topCornersRadiusForDrawerState:MDCBottomDrawerStateExpanded];
}

- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState {
  NSNumber *topCornersRadius = _topCornersRadius[@(drawerState)];
  if (topCornersRadius != nil) {
    return (CGFloat)[topCornersRadius doubleValue];
  }
  return 0.f;
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
  if ([self shouldPresentFullScreen]) {
    return YES;
  }
  return CGRectGetHeight(self.view.bounds) <=
         self.headerViewController.preferredContentSize.height +
             self.contentViewController.preferredContentSize.height;
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
  [_maskLayer animateWithPercentage:1.f - transitionRatio];
}

- (void)bottomDrawerWillChangeState:
            (nonnull MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState {
  _drawerState = drawerState;
  CGFloat minimumCornerRadius = [self getMinimumCornerRadius];
  if (_maskLayer.minimumCornerRadius != minimumCornerRadius) {
    _maskLayer.minimumCornerRadius = minimumCornerRadius;
    [_maskLayer applyMask];
  }
}

@end
