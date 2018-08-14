/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialApplication.h"
#import "MDCFeatureHighlightAnimationController.h"

#import "MDCFeatureHighlightView+Private.h"

const NSTimeInterval kMDCFeatureHighlightPresentationDuration = 0.35f;
const NSTimeInterval kMDCFeatureHighlightDismissalDuration = 0.2f;

@implementation MDCFeatureHighlightAnimationController

- (NSTimeInterval)transitionDuration:
    (nullable __unused id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.presenting) {
    return kMDCFeatureHighlightPresentationDuration;
  } else {
    return kMDCFeatureHighlightDismissalDuration;
  }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

  MDCFeatureHighlightView *highlightView = nil;
  if ([fromView isKindOfClass:[MDCFeatureHighlightView class]]) {
    highlightView = (MDCFeatureHighlightView *)fromView;
  } else if ([toView isKindOfClass:[MDCFeatureHighlightView class]]) {
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

  BOOL presenting = self.presenting;
  void (^animations)(void) = ^void(void) {
    // We have to perform an animation on highlightView in this block or else UIKit
    // will not know we are performing an animation and will call the completion block
    // immediately, causing our CAAnimations to be cut short.
    if (presenting) {
      [highlightView layoutAppearing];
    } else {
      [highlightView layoutDisappearing];
    }
  };

  void (^completion)(BOOL finished) = ^void(BOOL finished) {
    // If we're dismissing, remove the highlight view from the hierarchy
    if (!presenting) {
      [fromView removeFromSuperview];
    }
    [transitionContext completeTransition:YES];
  };

  UIApplicationState applicationState = [UIApplication mdc_safeSharedApplication].applicationState;
  if (applicationState == UIApplicationStateActive) {
    [UIView animateWithDuration:transitionDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:animations
                     completion:completion];
  } else {
    animations();
    completion(YES);
  }
}

@end
