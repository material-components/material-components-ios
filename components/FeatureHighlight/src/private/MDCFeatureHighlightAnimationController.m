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
  return self.presenting ? 0.35 : 0.2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

  MDCFeatureHighlightView *highlightView = nil;
  if ([fromView isKindOfClass:[MDCFeatureHighlightView class]]) {
    highlightView = (MDCFeatureHighlightView *)fromView;
  } else {
    highlightView = (MDCFeatureHighlightView *)toView;
  }

  if (self.presenting) {
    [transitionContext.containerView addSubview:toView];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
  }

  NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

  [highlightView layoutIfNeeded];
  if (self.presenting) {
    [highlightView animateDiscover:transitionDuration];
  } else {
    switch (self.dismissStyle) {
      case MDCFeatureHighlightDismissAccepted:
        [highlightView animateAccepted:transitionDuration];
        break;

      case MDCFeatureHighlightDismissRejected:
        [highlightView animateRejected:transitionDuration];
        break;
    }
  }
  [UIView animateWithDuration:transitionDuration
                        delay:0.0
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{
                     // We have to perform an animation on highlightView in this block or else UIKit
                     // will not know we are performing an animation and will cancel our
                     // CAAnimations.
                     if (self.presenting) {
                       [highlightView layoutAppearing];
                     } else {
                       [highlightView layoutDisappearing];
                     }
                   }
                   completion:^(BOOL finished) {
                     // If we're dismissing, remove the highlight view from the hierarchy
                     if (!self.presenting) {
                       [fromView removeFromSuperview];
                     }
                     [transitionContext completeTransition:YES];
                   }];
}

@end
