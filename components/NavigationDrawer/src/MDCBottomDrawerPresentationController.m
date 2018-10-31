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

#import "MDCBottomDrawerPresentationController.h"

#import "MDCBottomDrawerViewController.h"
#import "private/MDCBottomDrawerContainerViewController.h"

@interface MDCBottomDrawerPresentationController () <UIGestureRecognizerDelegate,
                                                     MDCBottomDrawerContainerViewControllerDelegate>

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

@synthesize delegate;

- (UIView *)presentedView {
  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    return super.presentedView;
  } else {
    // Override the presentedView property getter to return our container view controller's
    // view instead of the default.
    return self.bottomDrawerContainerViewController.view;
  }
}

- (void)presentationTransitionWillBegin {
  MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController =
      [[MDCBottomDrawerContainerViewController alloc]
          initWithOriginalPresentingViewController:self.presentingViewController
                                trackingScrollView:self.trackingScrollView];
  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    // If in fact the presentedViewController is an MDCBottomDrawerViewController,
    // we then know there is a content and an (optional) header view controller.
    // We pass those view controllers to the MDCBottomDrawerContainerViewController that
    // consists of the drawer logic.
    MDCBottomDrawerViewController *bottomDrawerViewController =
        (MDCBottomDrawerViewController *)self.presentedViewController;
    self.delegate = bottomDrawerViewController;
    bottomDrawerContainerViewController.contentViewController =
        bottomDrawerViewController.contentViewController;
    bottomDrawerContainerViewController.headerViewController =
        bottomDrawerViewController.headerViewController;
    self.delegate = bottomDrawerViewController;
  } else {
    bottomDrawerContainerViewController.contentViewController = self.presentedViewController;
  }
  bottomDrawerContainerViewController.animatingPresentation = YES;
  self.bottomDrawerContainerViewController = bottomDrawerContainerViewController;
  self.bottomDrawerContainerViewController.delegate = self;

  self.scrimView = [[UIView alloc] initWithFrame:self.containerView.bounds];
  self.scrimView.backgroundColor =
      self.scrimColor ?: [UIColor colorWithWhite:0 alpha:(CGFloat)0.32];
  self.scrimView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.scrimView.accessibilityIdentifier = @"Close drawer";
  self.scrimView.accessibilityTraits |= UIAccessibilityTraitButton;

  [self.containerView addSubview:self.scrimView];

  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    [self.presentedView addSubview:self.bottomDrawerContainerViewController.view];
  } else {
    [self.containerView addSubview:self.bottomDrawerContainerViewController.view];
  }

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
  // Set up the tap recognizer to dimiss the drawer by.
  UITapGestureRecognizer *tapGestureRecognizer =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrawer)];
  [self.containerView addGestureRecognizer:tapGestureRecognizer];
  tapGestureRecognizer.delegate = self;

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
       withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [self.bottomDrawerContainerViewController viewWillTransitionToSize:size
                                           withTransitionCoordinator:coordinator];
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _scrimColor = scrimColor;
  self.scrimView.backgroundColor = scrimColor;
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

#pragma mark - MDCBottomDrawerContainerViewControllerDelegate

- (void)bottomDrawerContainerViewControllerWillChangeState:
            (MDCBottomDrawerContainerViewController *)containerViewController
                                               drawerState:(MDCBottomDrawerState)drawerState {
  id<MDCBottomDrawerPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:@selector(bottomDrawerWillChangeState:drawerState:)]) {
    [strongDelegate bottomDrawerWillChangeState:self drawerState:drawerState];
  }
}

- (void)bottomDrawerContainerViewControllerTopTransitionRatio:
            (MDCBottomDrawerContainerViewController *)containerViewController
                                              transitionRatio:(CGFloat)transitionRatio {
  id<MDCBottomDrawerPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:@selector(bottomDrawerTopTransitionRatio:
                                                                  transitionRatio:)]) {
    [strongDelegate bottomDrawerTopTransitionRatio:self transitionRatio:transitionRatio];
  }
}

@end
