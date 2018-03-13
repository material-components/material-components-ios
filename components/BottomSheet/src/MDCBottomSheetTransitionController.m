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

#import "MDCBottomSheetTransitionController.h"

#import "MDCBottomSheetPresentationController.h"
#import "private/MDCBottomSheetMotionSpec.h"

@interface MDCBottomSheetTransition : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithPresenting:(BOOL)presenting;
@end

@implementation MDCBottomSheetTransitionController

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(__unused UIViewController *)source {
  MDCBottomSheetPresentationController *presentationController =
      [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                           presentingViewController:presenting];
  presentationController.trackingScrollView = self.trackingScrollView;
  return presentationController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(__unused UIViewController *)presented
                         presentingController:(__unused UIViewController *)presenting
                             sourceController:(__unused UIViewController *)source {
  return [[MDCBottomSheetTransition alloc] initWithPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(__unused UIViewController *)dismissed {
  return [[MDCBottomSheetTransition alloc] initWithPresenting:NO];
}

@end

@implementation MDCBottomSheetTransition {
  BOOL _presenting;
}

- (instancetype)initWithPresenting:(BOOL)presenting {
  self = [super init];
  if (self) {
    _presenting = presenting;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (nullable __unused id <UIViewControllerContextTransitioning>)transitionContext {
  return MDCBottomSheetMotionSpec.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  if (fromView == nil) {
    fromView = fromViewController.view;
  }
  if (fromView != nil && fromView == fromViewController.view) {
    CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
    if (!CGRectIsEmpty(finalFrame)) {
      fromView.frame = finalFrame;
    }
  }

  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  if (toView == nil) {
    toView = toViewController.view;
  }
  if (toView != nil && toView == toViewController.view) {
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    if (!CGRectIsEmpty(finalFrame)) {
      toView.frame = finalFrame;
    }

    if (toView.superview == nil) {
      if (_presenting) {
        [transitionContext.containerView addSubview:toView];
      } else {
        [transitionContext.containerView insertSubview:toView atIndex:0];
      }
    }
  }

  // We're primarily implementing UIViewControllerAnimatedTransitioning so that we can customize the
  // transition's duration - all of the actual animation logic happens in
  // MDCBottomSheetPresentationController (which can't customize the duration). In order to make
  // UIKit believe that we're actually animating something, we create a temporary bogus view and
  // animate it for the desired duration. This ensures that UIKit's default animations animate
  // alongside our bogus animation (and therefor the corresponding duration).

  UIView *bogusView = [[UIView alloc] init];
  [transitionContext.containerView addSubview:bogusView];

  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    bogusView.alpha = 0;

  } completion:^(BOOL finished) {
    [bogusView removeFromSuperview];

    [transitionContext completeTransition:YES];
  }];
}

@end
