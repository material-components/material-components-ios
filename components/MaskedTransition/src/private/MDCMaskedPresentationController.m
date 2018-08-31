// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCMaskedPresentationController.h"

#import <MotionTransitioning/MotionTransitioning.h>
#import <MotionAnimator/MotionAnimator.h>

#import "MDCMaskedTransitionMotionForContext.h"

@implementation MDCMaskedPresentationController {
  CGRect (^_calculateFrameOfPresentedView)(UIPresentationController *);
  CGFloat _initialSourceViewAlpha;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                  calculateFrameOfPresentedView:(CGRect (^)(UIPresentationController *))calculateFrameOfPresentedView
                                     sourceView:(UIView *)sourceView {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _scrimView = [[UIView alloc] init];
    _scrimView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                   | UIViewAutoresizingFlexibleHeight);
    _scrimView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];

    _calculateFrameOfPresentedView = [calculateFrameOfPresentedView copy];
    _sourceView = sourceView;
  }
  return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
  if (_calculateFrameOfPresentedView) {
    return _calculateFrameOfPresentedView(self);
  } else {
    return self.containerView.bounds;
  }
}

- (BOOL)shouldRemovePresentersView {
  // We don't have access to the container view when this method is called, so we can only guess as
  // to whether we'll be presenting full screen by checking for the presence of a frame calculation
  // block.
  BOOL definitelyFullscreen = _calculateFrameOfPresentedView == nil;

  // Returning true here will cause UIKit to invoke viewWillDisappear and viewDidDisappear on the
  // presenting view controller, and the presenting view controller's view will be removed on
  // completion of the transition.
  return definitelyFullscreen;
}

- (void)presentationTransitionWillBegin {
  self.scrimView.frame = self.containerView.bounds;
  [self.containerView addSubview:self.scrimView];

  _initialSourceViewAlpha = self.sourceView.alpha;

  MDCMaskedTransitionMotionSpec motionSpecification =
      MDCMaskedTransitionMotionSpecForContext(self.containerView, self.presentedViewController);

  MDCMaskedTransitionMotionTiming motionTiming = motionSpecification.expansion;

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  [animator animateWithTiming:motionTiming.scrimFade
                      toLayer:self.scrimView.layer
                   withValues:@[ @0, @1 ]
                      keyPath:MDMKeyPathOpacity];
}

- (void)dismissalTransitionWillBegin {
  MDCMaskedTransitionMotionSpec motionSpecification =
      MDCMaskedTransitionMotionSpecForContext(self.containerView, self.presentedViewController);
  if (motionSpecification.shouldSlideWhenCollapsed) {
    // Immediately reveal the source view because our presented view controller isn't collapsing
    // back to it.
    self.sourceView.alpha = _initialSourceViewAlpha;

    [self.presentedViewController.transitionCoordinator
        animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
          self.scrimView.alpha = 0;
        } completion:nil];

  } else {
    MDCMaskedTransitionMotionTiming motionTiming = motionSpecification.collapse;

    MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
    [animator animateWithTiming:motionTiming.scrimFade
                        toLayer:self.scrimView.layer
                     withValues:@[ @1, @0 ]
                        keyPath:MDMKeyPathOpacity];
  }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.scrimView removeFromSuperview];
    self.scrimView = nil;

    self.sourceView.alpha = _initialSourceViewAlpha;
    self.sourceView = nil;

  } else {
    self.scrimView.alpha = 1;
    self.sourceView.alpha = 0;
  }
}

@end
