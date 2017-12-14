/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCMaskedPresentationController.h"

#import <MotionTransitioning/MotionTransitioning.h>
#import <MotionAnimator/MotionAnimator.h>

#import "MDCMaskedTransitionMotionForContext.h"

@interface MDCMaskedPresentationController () <MDMTransition>
@end

@implementation MDCMaskedPresentationController {
  CGRect (^_calculateFrameOfPresentedView)(UIPresentationController *);
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController
                  calculateFrameOfPresentedView:(CGRect (^)(UIPresentationController *))calculateFrameOfPresentedView {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _calculateFrameOfPresentedView = [calculateFrameOfPresentedView copy];
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

- (void)dismissalTransitionWillBegin {
  if (!self.presentedViewController.mdm_transitionController.activeTransition) {
    [self.presentedViewController.transitionCoordinator
        animateAlongsideTransition:
            ^(__unused id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
              self.scrimView.alpha = 0;
            }           completion:nil];

    self.sourceView.alpha = 1;
  }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.scrimView removeFromSuperview];
    self.scrimView = nil;

    self.sourceView.alpha = 1;
    self.sourceView = nil;

  } else {
    self.scrimView.alpha = 1;
    self.sourceView.alpha = 0;
  }
}

- (void)startWithContext:(NSObject<MDMTransitionContext> *)context {
  MDCMaskedTransitionMotionSpecContext spec = MDCMaskedTransitionMotionSpecForContext(context);

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  animator.shouldReverseValues = context.direction == MDMTransitionDirectionBackward;

  MDCMaskedTransitionMotionTiming motion = (context.direction == MDMTransitionDirectionForward) ? spec.expansion : spec.collapse;

  if (!self.scrimView) {
    self.scrimView = [[UIView alloc] initWithFrame:context.containerView.bounds];
    self.scrimView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                       | UIViewAutoresizingFlexibleHeight);
    self.scrimView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    [context.containerView addSubview:self.scrimView];
  }

  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [context transitionDidEnd];
  }];

  [animator animateWithTiming:motion.scrimFade
                      toLayer:self.scrimView.layer
                   withValues:@[ @0, @1 ]
                      keyPath:@"opacity"];

  [CATransaction commit];
}

@end
