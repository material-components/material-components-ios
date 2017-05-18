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

#import "MaterialBottomSheet.h"

@interface MDCBottomSheetController ()
    <MDCBottomSheetPresentationControllerDelegate, UIViewControllerTransitioningDelegate>
@end

@implementation MDCBottomSheetController {
  MDCBottomSheetTransitionController *_transitionController;
}

- (nonnull instancetype)initWithContentViewController:
    (nonnull UIViewController *)contentViewController {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _contentViewController = contentViewController;

    super.transitioningDelegate = self;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.contentViewController.view.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.contentViewController.view.frame = self.view.bounds;

  [self addChildViewController:self.contentViewController];
  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.contentViewController.view layoutIfNeeded];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.contentViewController.supportedInterfaceOrientations;
}

- (BOOL)accessibilityPerformEscape {
  [self dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

- (CGSize)preferredContentSize {
  return self.contentViewController.preferredContentSize;
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize {
  [self.contentViewController setPreferredContentSize:preferredContentSize];
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCBottomSheetController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCBottomSheetController.modalPresentationStyle cannot be changed.");
  return;
}

- (UIPresentationController *)
    presentationControllerForPresentedViewController:(UIViewController *)presented
                            presentingViewController:(UIViewController *)presenting
                                sourceViewController:(UIViewController *)source {
  MDCBottomSheetPresentationController *presentationController =
      [[MDCBottomSheetPresentationController alloc] initWithPresentedViewController:presented
                                                           presentingViewController:presenting];
  presentationController.delegate = self;
  return presentationController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  return _transitionController;
}

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(UIViewController *)dismissed {
  return _transitionController;
}

- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull MDCBottomSheetPresentationController *)bottomSheet {
  [self.delegate bottomSheetControllerDidDismissBottomSheet:self];
}

@end
