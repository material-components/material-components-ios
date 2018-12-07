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

#import "MDCBottomDrawerTransitionController.h"

#import "MDCBottomDrawerPresentationController.h"

static const NSTimeInterval kOpenAnimationDuration = 0.34;
static const NSTimeInterval kCloseAnimationDuration = 0.3;
static const CGFloat kOpenAnimationSpringDampingRatio = (CGFloat)0.85;

@implementation MDCBottomDrawerTransitionController

#pragma mark UIViewControllerTransitioningDelegate

- (nullable id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
    (UIViewController *)dismissed {
  return self;
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  MDCBottomDrawerPresentationController *presentationController =
      [[MDCBottomDrawerPresentationController alloc] initWithPresentedViewController:presented
                                                            presentingViewController:presenting];
  presentationController.trackingScrollView = self.trackingScrollView;
  return presentationController;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (nullable id<UIViewControllerContextTransitioning>)transitionContext {
  BOOL presenting = [self isPresentingFromContext:transitionContext];
  if (presenting) {
    return kOpenAnimationDuration;
  }
  return kCloseAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  // If a view in the transitionContext is nil, it likely hasn't been loaded by its view controller
  // yet.  Ask for it directly to initiate a loadView on the ViewController.
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  if (fromView == nil) {
    fromView = fromViewController.view;
  }

  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  if (toView == nil) {
    toView = toViewController.view;
  }

  BOOL presenting = [self isPresentingFromContext:transitionContext];
  UIView *animatingView = presenting ? toView : fromView;
  UIView *containerView = transitionContext.containerView;

  if (presenting) {
    [containerView addSubview:animatingView];
    CGRect initialFrame = containerView.bounds;
    initialFrame.origin.y = CGRectGetHeight(containerView.bounds);
    animatingView.frame = initialFrame;
    [UIView animateWithDuration:kOpenAnimationDuration
        delay:0
        usingSpringWithDamping:kOpenAnimationSpringDampingRatio
        initialSpringVelocity:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          animatingView.frame = containerView.bounds;
        }
        completion:^(BOOL finished) {
          [transitionContext completeTransition:YES];
        }];
  } else {
    [UIView animateWithDuration:kCloseAnimationDuration
        animations:^{
          CGRect finalFrame = containerView.bounds;
          finalFrame.origin.y = CGRectGetHeight(containerView.bounds);
          animatingView.frame = finalFrame;
        }
        completion:^(BOOL finished) {
          [fromViewController.view removeFromSuperview];
          [transitionContext completeTransition:YES];
          [toViewController setNeedsStatusBarAppearanceUpdate];
        }];
  }
}

- (BOOL)isPresentingFromContext:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *toPresentingViewController = toViewController.presentingViewController;
  return (toPresentingViewController == fromViewController) ? YES : NO;
}

@end
