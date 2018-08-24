/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCBottomDrawerPresentationController.h"

#import "MDCBottomDrawerViewController.h"
#import "private/MDCBottomDrawerContainerViewController.h"

static UIColor *MDCBottomDrawerOverlayBackgroundColor(void) {
  return [UIColor colorWithWhite:0 alpha:0.4f];
}

@interface MDCBottomDrawerPresentationController () <UIGestureRecognizerDelegate>

/**
 A semi-transparent scrim view that darkens the visible main view when the drawer is displayed.
 */
@property(nonatomic) UIView *scrimView;

/**
 The bottom drawer container view controller.
 */
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;

@end

@implementation MDCBottomDrawerPresentationController

- (UIView *)presentedView {
  return self.bottomDrawerContainerViewController.view;
}

- (void)presentationTransitionWillBegin {
  UIView *containerView = [self containerView];

  MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController =
      [[MDCBottomDrawerContainerViewController alloc]
          initWithOriginalPresentingViewController:self.presentingViewController
                                trackingScrollView:self.trackingScrollView];
  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    MDCBottomDrawerViewController *bottomDrawerViewController =
        (MDCBottomDrawerViewController *)self.presentedViewController;
    bottomDrawerContainerViewController.contentViewController =
        bottomDrawerViewController.contentViewController;
    bottomDrawerContainerViewController.headerViewController =
        bottomDrawerViewController.headerViewController;
  } else {
    bottomDrawerContainerViewController.contentViewController = self.presentedViewController;
  }
  bottomDrawerContainerViewController.animatingPresentation = YES;
  self.bottomDrawerContainerViewController = bottomDrawerContainerViewController;

  self.scrimView = [[UIView alloc] initWithFrame:self.containerView.bounds];
  self.scrimView.backgroundColor = MDCBottomDrawerOverlayBackgroundColor();
  self.scrimView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.scrimView.accessibilityIdentifier = @"Close drawer";
  self.scrimView.accessibilityTraits |= UIAccessibilityTraitButton;

  [containerView addSubview:self.scrimView];
  [containerView addSubview:self.bottomDrawerContainerViewController.view];

  // Set up the tap recognizer to dimiss the drawer by.
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrawer)];
  [containerView addGestureRecognizer:tapGestureRecognizer];
  tapGestureRecognizer.delegate = self;

  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];

  // Fade in the scrim view during the transition.
  self.scrimView.alpha = 0.0;
  [transitionCoordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.scrimView.alpha = 1.0;
      }
                      completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  self.bottomDrawerContainerViewController.animatingPresentation = NO;
  [self.bottomDrawerContainerViewController.view setNeedsLayout];
  if (!completed) {
    [self.scrimView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {
  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];
  [transitionCoordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.scrimView.alpha = 0.0;
      }
                      completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.scrimView removeFromSuperview];
  }
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];

  [self.bottomDrawerContainerViewController.view layoutIfNeeded];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  // We close the drawer on rotation or window splitting.
  [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Private

- (void)hideDrawer {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  return [self.bottomDrawerContainerViewController gestureRecognizer:gestureRecognizer
                                                  shouldReceiveTouch:touch];
}

@end
