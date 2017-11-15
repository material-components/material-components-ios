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

#import "MDCBottomSheetTransition.h"

#import "MDCBottomSheetPresentationController.h"

@interface MDCBottomSheetTransition() <MDMTransitionWithPresentation>
@end

@implementation MDCBottomSheetTransition {
// TODO( https://github.com/material-components/material-components-ios/issues/2418 ):
// Remove once MDCBottomSheetPresentationController is private.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  __weak MDCBottomSheetPresentationController *_presentationController;
#pragma clang diagnostic pop
}

- (void)startWithContext:(id<MDMTransitionContext>)context {
  [context transitionDidEnd]; // No-op. All of the magic is handled by the presentation controller.
}

#pragma mark - MDMTransitionWithCustomDuration

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
    presentingViewController:(UIViewController *)presenting
    sourceViewController:(__unused UIViewController *)source {
// TODO( https://github.com/material-components/material-components-ios/issues/2418 ):
// Remove once MDCBottomSheetPresentationController is private.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  MDCBottomSheetPresentationController *presentationController =
      [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                           presentingViewController:presenting];
  _presentationController = presentationController;
#pragma clang diagnostic pop
  presentationController.trackingScrollView = self.trackingScrollView;
  return presentationController;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _trackingScrollView = trackingScrollView;

  _presentationController.trackingScrollView = self.trackingScrollView;
}

- (UIModalPresentationStyle)defaultModalPresentationStyle {
  return UIModalPresentationCustom;
}

@end
