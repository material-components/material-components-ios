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

#import "MDCMaskedTransitionController.h"

#import "private/MDCMaskedPresentationController.h"
#import "private/MDCMaskedTransition.h"
#import "private/MDCMaskedTransitionMotionForContext.h"

@implementation MDCMaskedTransitionController

- (instancetype)initWithSourceView:(UIView *)sourceView {
  self = [self init];
  if (self) {
    _sourceView = sourceView;
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  if (_sourceView == nil) {
    return nil;
  }
  return [[MDCMaskedTransition alloc] initWithSourceView:self.sourceView
                                               direction:MDMTransitionDirectionForward];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
    (UIViewController *)dismissed {
  if (_sourceView == nil) {
    return nil;
  }
  MDCMaskedTransitionMotionSpec motionSpecification = MDCMaskedTransitionMotionSpecForContext(
      dismissed.presentingViewController.view.superview, dismissed);
  if (motionSpecification.shouldSlideWhenCollapsed) {
    return nil;
  }
  return [[MDCMaskedTransition alloc] initWithSourceView:self.sourceView
                                               direction:MDMTransitionDirectionBackward];
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  return [[MDCMaskedPresentationController alloc]
      initWithPresentedViewController:presented
             presentingViewController:presenting
        calculateFrameOfPresentedView:self.calculateFrameOfPresentedView
                           sourceView:self.sourceView];
}

@end
