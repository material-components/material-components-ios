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

#import "MDCBottomSheetController.h"

#import "MDCBottomSheetPresentationController.h"
#import "MDCBottomSheetTransition.h"
#import "UIViewController+MaterialBottomSheet.h"

#import <MotionTransitioning/MotionTransitioning.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface MDCBottomSheetController () <MDCBottomSheetPresentationControllerDelegate>
#pragma clang diagnostic pop
@end

@implementation MDCBottomSheetController {
  MDCBottomSheetTransition *_transition;
}

- (nonnull instancetype)initWithContentViewController:
    (nonnull UIViewController *)contentViewController {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _contentViewController = contentViewController;

    _transition = [[MDCBottomSheetTransition alloc] init];
    self.mdm_transitionController.transition = _transition;
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

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

- (UIScrollView *)trackingScrollView {
  return _transition.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _transition.trackingScrollView = trackingScrollView;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull __unused MDCBottomSheetPresentationController *)bottomSheet {
#pragma clang diagnostic pop
  [self.delegate bottomSheetControllerDidDismissBottomSheet:self];
}

@end
