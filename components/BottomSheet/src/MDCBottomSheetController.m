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

@interface MDCBottomSheetController () <MDCBottomSheetPresentationControllerDelegate>
@end

@implementation MDCBottomSheetController {
  MDCBottomSheetTransitionController *_transitionController;
}

- (nonnull instancetype)initWithContentViewController:
    (nonnull UIViewController *)contentViewController {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _contentViewController = contentViewController;
    _transitionController = [[MDCBottomSheetTransitionController alloc] init];

    super.transitioningDelegate = _transitionController;
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

  self.mdc_bottomSheetPresentationController.delegate = self;

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
  self.contentViewController.preferredContentSize = preferredContentSize;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
    (__unused id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCBottomSheetController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCBottomSheetController.modalPresentationStyle cannot be changed.");
  return;
}

- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull __unused MDCBottomSheetPresentationController *)bottomSheet {
  [self.delegate bottomSheetControllerDidDismissBottomSheet:self];
}

@end
