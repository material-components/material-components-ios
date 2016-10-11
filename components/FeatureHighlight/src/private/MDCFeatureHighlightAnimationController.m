//
//  MDCFeatureHighlightAnimationController.m
//  Pods
//
//  Created by Sam Morrison on 10/10/16.
//
//

#import "MDCFeatureHighlightAnimationController.h"

#import "../MDCFeatureHighlightViewController.h"
#import "MDCFeatureHighlightView.h"

@implementation MDCFeatureHighlightAnimationController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
  return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

  MDCFeatureHighlightViewController *highlightController = nil;
  MDCFeatureHighlightView *highlightView = nil;
  UIViewController *presentingController = nil;
  if ([fromViewController isKindOfClass:[MDCFeatureHighlightViewController class]]) {
    highlightController = (MDCFeatureHighlightViewController *)fromViewController;
    highlightView = (MDCFeatureHighlightView *)fromView;
    presentingController = toViewController;
  } else {
    highlightController = (MDCFeatureHighlightViewController *)toViewController;
    highlightView = (MDCFeatureHighlightView *)toView;
    presentingController = fromViewController;
  }

  BOOL presenting = (highlightController == toViewController);

  if (presenting) {
    [transitionContext.containerView addSubview:toView];
    toView.frame = [transitionContext finalFrameForViewController:highlightController];
  }

  NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
  UIViewAnimationOptions options =
      UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;

  if (presenting) {
    [highlightView animateDiscover];
  } else {
    switch (self.dismissStyle) {
      case MDCFeatureHighlightDismissAccepted:
        [highlightView animateAccepted];
        break;

      case MDCFeatureHighlightDismissRejected:
        [highlightView animateRejected];
        break;
    }
  }
  [UIView animateWithDuration:transitionDuration
                        delay:0.0
                      options:options
                   animations:^{
                     if (!presenting) {
                       fromView.transform = CGAffineTransformIdentity;
                     }
                   }
                   completion:^(BOOL finished) {
                     // If we're dismissing, remove the highlight view from the hierarchy
                     if (!presenting) {
                       [fromView removeFromSuperview];
                     }

                     // UIViewController's presented with a modalPresentationStyle other than
                     // UIModalPresentationFullScreen don't receive frame updates for status bar
                     // height changes.
                     // TODO(samnm): cache the original value
//                     highlightController.modalPresentationStyle = UIModalPresentationFullScreen;

                     [transitionContext completeTransition:YES];
                   }];
}

@end
