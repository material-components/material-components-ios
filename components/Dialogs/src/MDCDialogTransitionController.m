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

static const NSTimeInterval MDCDialogTransitionDuration = 0.27;

static const CGFloat MDCDialogScaleFactor = 0.8;

- (instancetype)init {
  self = [super init];
  if (self) {
    self.dialogOpacityAnimationDuration = MDCDialogTransitionDuration;
    self.dialogScaleAnimationDuration = 0.0f;
    self.scrimOpacityAnimationDuration = MDCDialogTransitionDuration;
  }
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (__unused id<UIViewControllerContextTransitioning>)transitionContext {
  return MAX(MAX(self.dialogOpacityAnimationDuration, self.dialogScaleAnimationDuration),
             self.scrimOpacityAnimationDuration);
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
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

  if (presenting) {
    [containerView addSubview:toView];
  }

  CGFloat startingAlpha = presenting ? 0 : 1;
  CGFloat endingAlpha = presenting ? 1 : 0;

  animatingView.frame = [transitionContext finalFrameForViewController:animatingViewController];

  UIViewAnimationOptions options =
      UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;

  // Scale animation
  CGAffineTransform startingTransform =
      presenting ? CGAffineTransformMakeScale(MDCDialogScaleFactor, MDCDialogScaleFactor)
                 : CGAffineTransformIdentity;
  CGAffineTransform endingTransform = CGAffineTransformIdentity;
  animatingView.transform = startingTransform;
  UIViewAnimationOptions scaleAnimationOptions = options | UIViewAnimationOptionCurveEaseOut;
  [UIView animateWithDuration:self.dialogScaleAnimationDuration
                        delay:0
                      options:scaleAnimationOptions
                   animations:^{
                     animatingView.transform = endingTransform;
                   }
                   completion:nil];

  // Opacity animation(s)
  if ([animatingViewController.presentationController
          isKindOfClass:[MDCDialogPresentationController class]]) {
    MDCDialogPresentationController *presentationController =
        (MDCDialogPresentationController *)animatingViewController.presentationController;

    UIColor *startingColor = presenting ? UIColor.clearColor : presentationController.scrimColor;
    UIColor *endingColor = presenting ? presentationController.scrimColor : UIColor.clearColor;

    UIColor *startingTrackingColor =
        presenting ? UIColor.clearColor : presentationController.dialogShadowColor;
    UIColor *endingTrackingColor =
        presenting ? presentationController.dialogShadowColor : UIColor.clearColor;

    presentationController.scrimColor = startingColor;
    presentationController.dialogShadowColor = startingTrackingColor;
    [UIView animateWithDuration:self.scrimOpacityAnimationDuration
                          delay:0
                        options:options
                     animations:^{
                       presentationController.scrimColor = endingColor;
                       presentationController.dialogShadowColor = endingTrackingColor;
                     }
                     completion:nil];
    presentationController.presentedView.alpha = startingAlpha;
    [UIView animateWithDuration:self.dialogOpacityAnimationDuration
                          delay:0.0
                        options:options
                     animations:^{
                       presentationController.presentedView.alpha = endingAlpha;
                     }
                     completion:nil];
  } else {
    [UIView animateWithDuration:self.dialogOpacityAnimationDuration
                          delay:0.0
                        options:options
                     animations:^{
                       animatingView.alpha = endingAlpha;
                     }
                     completion:nil];
  }

  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW,
                    (int64_t)([self transitionDuration:transitionContext] * NSEC_PER_SEC)),
      dispatch_get_main_queue(), ^{
        // If we're dismissing, remove the presented view from the hierarchy
        if (!presenting) {
          [fromView removeFromSuperview];
        }

        // From ADC : UIViewControllerContextTransitioning
        // When you do create transition animations, always call the
        // completeTransition: from an appropriate completion block to let UIKit know
        // when all of your animations have finished.
        [transitionContext completeTransition:YES];
      });
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
