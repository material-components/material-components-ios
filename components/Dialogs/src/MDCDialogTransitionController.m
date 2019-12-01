// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCDialogTransitionController.h"

#import "MDCDialogPresentationController.h"

@implementation MDCDialogTransitionController

// The default duration of the dialog fade-in or fade-out animation
static const NSTimeInterval kDefaultOpacityTransitionDuration = 0.2f;

// The default duration of the dialog scale-up or scale-down animation
static const NSTimeInterval kDefaultScaleTransitionDuration = 0.f;

// The default starting X and Y scale of the presented dialog
static const CGFloat kDefaultInitialScaleFactor = 1.0f;

- (instancetype)init {
  self = [super init];
  if (self) {
    _opacityAnimationDuration = kDefaultOpacityTransitionDuration;
    _scaleAnimationDuration = kDefaultScaleTransitionDuration;
    _dialogInitialScaleFactor = kDefaultInitialScaleFactor;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (__unused id<UIViewControllerContextTransitioning>)transitionContext {
  return MAX(self.opacityAnimationDuration, self.scaleAnimationDuration);
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  [CATransaction begin];
  [CATransaction setAnimationDuration:[self transitionDuration:transitionContext]];

  // If a view in the transitionContext is nil, it likely hasn't been loaded by its ViewController
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

  UIViewController *toPresentingViewController = toViewController.presentingViewController;
  BOOL presenting = (toPresentingViewController == fromViewController) ? YES : NO;

  UIViewController *animatingViewController = presenting ? toViewController : fromViewController;
  UIView *animatingView = presenting ? toView : fromView;

  UIView *containerView = transitionContext.containerView;

  [CATransaction setCompletionBlock:^{
    // If we're dismissing, remove the presented view from the hierarchy
    if (!presenting) {
      [fromView removeFromSuperview];
    }

    // From ADC : UIViewControllerContextTransitioning
    // When you do create transition animations, always call the
    // completeTransition: from an appropriate completion block to let UIKit know
    // when all of your animations have finished.
    [transitionContext completeTransition:YES];
  }];

  if (presenting) {
    [containerView addSubview:toView];
  }

  CGFloat startingAlpha = presenting ? 0 : 1;
  CGFloat endingAlpha = presenting ? 1 : 0;

  animatingView.frame = [transitionContext finalFrameForViewController:animatingViewController];

  UIViewAnimationOptions options =
      UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;

  // Opacity animation
  animatingView.alpha = startingAlpha;
  [UIView animateWithDuration:self.opacityAnimationDuration
                        delay:0
                      options:options
                   animations:^{
                     animatingView.alpha = endingAlpha;
                   }
                   completion:nil];

  // Scale animation
  MDCDialogPresentationController *presentationController = nil;
  if ([animatingViewController.presentationController
          isKindOfClass:[MDCDialogPresentationController class]]) {
    presentationController =
        (MDCDialogPresentationController *)animatingViewController.presentationController;
  }

  CGAffineTransform startingTransform =
      presenting
          ? CGAffineTransformMakeScale(self.dialogInitialScaleFactor, self.dialogInitialScaleFactor)
          : CGAffineTransformIdentity;
  CGAffineTransform endingTransform = CGAffineTransformIdentity;
  animatingView.transform = startingTransform;
  presentationController.dialogTransform = startingTransform;
  UIViewAnimationOptions scaleAnimationOptions = options | UIViewAnimationOptionCurveEaseOut;
  [UIView animateWithDuration:self.scaleAnimationDuration
                        delay:0
                      options:scaleAnimationOptions
                   animations:^{
                     animatingView.transform = endingTransform;
                     presentationController.dialogTransform = endingTransform;
                   }
                   completion:nil];

  [CATransaction commit];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(__unused UIViewController *)source {
  return [[MDCDialogPresentationController alloc] initWithPresentedViewController:presented
                                                         presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(__unused UIViewController *)presented
                         presentingController:(__unused UIViewController *)presenting
                             sourceController:(__unused UIViewController *)source {
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
    (__unused UIViewController *)dismissed {
  return self;
}

@end
