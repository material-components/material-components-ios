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

#import "MDCDialogTransition.h"

#import "MDCDialogPresentationController.h"
#import "private/MDCDialogTransitionMotionSpec.h"

#import <MotionAnimator/MotionAnimator.h>

@interface MDCDialogTransition() <MDMTransitionWithCustomDuration, MDMTransitionWithPresentation>
@end

@implementation MDCDialogTransition {
  __weak MDCDialogPresentationController *_presentationController;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _dismissOnBackgroundTap = YES;
  }
  return self;
}

#pragma mark - MDMTransitionWithPresentation

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
    presentingViewController:(UIViewController *)presenting
    sourceViewController:(__unused UIViewController *)source {
  if (_presentationController) {
    return _presentationController;
  }
  MDCDialogPresentationController *presentationController =
      [[MDCDialogPresentationController alloc] initWithPresentedViewController:presented
                                                      presentingViewController:presenting];
  presentationController.dismissOnBackgroundTap = self.dismissOnBackgroundTap;
  _presentationController = presentationController;
  return presentationController;
}

- (UIModalPresentationStyle)defaultModalPresentationStyle {
  return UIModalPresentationCustom;
}

#pragma mark - MDMTransitionWithCustomDuration

- (NSTimeInterval)transitionDurationWithContext:(id<MDMTransitionContext>)context {
  if (context.direction == MDMTransitionDirectionForward) {
    return MDCDialogTransitionMotionSpec.appearance.transitionDuration;
  } else {
    return MDCDialogTransitionMotionSpec.disappearance.transitionDuration;
  }
}

#pragma mark - MDMTransition

- (void)startWithContext:(id<MDMTransitionContext>)context {
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [context transitionDidEnd];
  }];

  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  animator.shouldReverseValues = context.direction == MDMTransitionDirectionBackward;

  MDMMotionTiming contentOpacity;
  if (context.direction == MDMTransitionDirectionForward) {
    contentOpacity = MDCDialogTransitionMotionSpec.appearance.contentOpacity;
  } else {
    contentOpacity = MDCDialogTransitionMotionSpec.disappearance.contentOpacity;
  }

  [animator animateWithTiming:contentOpacity
                      toLayer:context.presentationController.presentedView.layer
                   withValues:@[@0, @1]
                      keyPath:MDMKeyPathOpacity];

  [CATransaction commit];
}

#pragma mark - Public

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _dismissOnBackgroundTap = dismissOnBackgroundTap;

  _presentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

@end
