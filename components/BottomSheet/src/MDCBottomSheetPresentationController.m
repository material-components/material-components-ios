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

#import "MDCBottomSheetPresentationController.h"

@implementation MDCBottomSheetPresentationController {
  UIView *_dimmingView;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _dimmingView = [[UIView alloc] init];
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (void)presentationTransitionWillBegin {
  UIView *containerView = [self containerView];
  [containerView insertSubview:_dimmingView atIndex:0];

  NSDictionary *views = NSDictionaryOfVariableBindings(_dimmingView);

  [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dimmingView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];
  [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dimmingView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];

  id <UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];

  // Fade in the dimming view during the transition.
  [_dimmingView setAlpha:0.0];
  [transitionCoordinator animateAlongsideTransition:
   ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     [_dimmingView setAlpha:1.0];
   } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  if (!completed) {
    [_dimmingView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {
  id <UIViewControllerTransitionCoordinator> transitionCoordinator =
    [[self presentingViewController] transitionCoordinator];

  [transitionCoordinator animateAlongsideTransition:
   ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     [_dimmingView setAlpha:0.0];
   } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [_dimmingView removeFromSuperview];
  }
}

@end
