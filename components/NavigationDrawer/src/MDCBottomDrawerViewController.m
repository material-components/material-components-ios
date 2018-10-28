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

#import "MDCBottomDrawerPresentationController.h"
#import "MDCBottomDrawerTransitionController.h"

@interface MDCBottomDrawerViewController () <MDCBottomDrawerPresentationControllerDelegate>

/** The transition controller. */
@property(nonatomic) MDCBottomDrawerTransitionController *transitionController;

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
  }
  return self;
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

- (MDCBottomDrawerState)drawerState {
  return _transitionController.drawerState;
}

- (void)setTopCornersRadius:(CGFloat)radius forDrawerState:(MDCBottomDrawerState)drawerState {
  _topCornersRadius[@(drawerState)] = @(radius);

  [self updateTopCornersRadius];
}

- (void)updateTopCornersRadius {
//  CGFloat topCornersRadius = [self topCornersRadiusForDrawerState:self.drawerState];
//  _transitionController.topCornersRadius = topCornersRadius;
}

- (CGFloat)topCornersRadiusForDrawerState:(MDCBottomDrawerState)drawerState {
  NSNumber *topCornersRadius = _topCornersRadius[@(drawerState)];
  if (topCornersRadius != nil) {
    return (CGFloat)[topCornersRadius doubleValue];
  }
  return 0.f;
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

}

- (void)bottomDrawerWillChangeState:
    (nonnull MDCBottomDrawerPresentationController *)presentationController
                        drawerState:(MDCBottomDrawerState)drawerState {

}
@end
