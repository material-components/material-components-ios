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

static const NSTimeInterval MDCBottomSheetTransitionDuration = 0.25;

@interface MDCBottomSheetTransitionController () <UIViewControllerAnimatedTransitioning>
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
  return self;
}

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(__unused UIViewController *)dismissed {
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:
    (nullable __unused id <UIViewControllerContextTransitioning>)transitionContext {
  return MDCBottomSheetTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  // We're only implementing UIViewControllerAnimatedTransitioning so that we can customize the
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

- (CGRect)frameOfPresentedViewController:(UIViewController *)presentedViewController
                         inContainerView:(UIView *)containerView {
  CGSize containerSize = containerView.frame.size;
  CGSize preferredSize = presentedViewController.preferredContentSize;

  if (preferredSize.width > 0 && preferredSize.width < containerSize.width) {
    CGFloat width = preferredSize.width;
    CGFloat leftPad = (containerSize.width - width) / 2;
    return CGRectMake(leftPad, 0, width, containerSize.height);
  } else {
    return containerView.frame;
  }
}

@end
