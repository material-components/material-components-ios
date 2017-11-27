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
#import "MDCDialogTransitionMotionSpec.h"

#import <MotionAnimator/MotionAnimator.h>

@interface MDCDialogTransition() <MDMTransitionWithPresentation>
@end

@implementation MDCDialogTransition {
  MDCDialogPresentationController *_presentationController;
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
  _presentationController =
      [[MDCDialogPresentationController alloc] initWithPresentedViewController:presented
                                                      presentingViewController:presenting];
  _presentationController.dismissOnBackgroundTap = self.dismissOnBackgroundTap;
  return _presentationController;
}

- (UIModalPresentationStyle)defaultModalPresentationStyle {
  return UIModalPresentationCustom;
}

#pragma mark - MDMTransition

- (void)startWithContext:(id<MDMTransitionContext>)context {
  [context transitionDidEnd]; // All animations are handled in the presentation controller.
}

#pragma mark - Public

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _dismissOnBackgroundTap = dismissOnBackgroundTap;

  _presentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

@end
