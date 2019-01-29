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
#import "MaterialPalettes.h"
#import "private/MDCBottomDrawerContainerViewController.h"

static CGFloat kTopHandleHeight = (CGFloat)2.0;
static CGFloat kTopHandleWidth = (CGFloat)24.0;
static CGFloat kTopHandleTopMargin = (CGFloat)5.0;

@interface MDCBottomDrawerPresentationController () <UIGestureRecognizerDelegate,
                                                     MDCBottomDrawerContainerViewControllerDelegate>

/**
 A semi-transparent scrim view that darkens the visible main view when the drawer is displayed.
 */
@property(nonatomic) UIView *scrimView;

/**
 The top handle view at the top of the drawer to provide a visual affordance for scrollability.
 */
@property(nonatomic) UIView *topHandle;

/**
 The bottom drawer container view controller.
 */
@property(nonatomic) MDCBottomDrawerContainerViewController *bottomDrawerContainerViewController;

@end

@implementation MDCBottomDrawerPresentationController

@synthesize delegate;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _topHandleHidden = YES;
  }
  return self;
}

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

  self.topHandle =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTopHandleWidth, kTopHandleHeight)];
  self.topHandle.layer.cornerRadius = kTopHandleHeight * (CGFloat)0.5;
  self.topHandle.backgroundColor = self.topHandleColor ?: MDCPalette.greyPalette.tint300;
  self.topHandle.hidden = self.topHandleHidden;
  self.topHandle.translatesAutoresizingMaskIntoConstraints = NO;
  UIView *handleSuperview = nil;
  if (bottomDrawerContainerViewController.headerViewController) {
    handleSuperview = bottomDrawerContainerViewController.headerViewController.view;
  } else {
    handleSuperview = bottomDrawerContainerViewController.contentViewController.view;
  }
  [handleSuperview addSubview:self.topHandle];
  [NSLayoutConstraint constraintWithItem:self.topHandle
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:handleSuperview
                               attribute:NSLayoutAttributeTop
                              multiplier:1.0
                                constant:kTopHandleTopMargin]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.topHandle
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:handleSuperview
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.topHandle
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:kTopHandleWidth]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.topHandle
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                                constant:kTopHandleHeight]
      .active = YES;
  if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
    [self.presentedView addSubview:self.bottomDrawerContainerViewController.view];
    [self.presentedViewController addChildViewController:self.bottomDrawerContainerViewController];
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
    [self.topHandle removeFromSuperview];
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
    if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
      CGRect newFrame = CGRectStandardize(
          self.bottomDrawerContainerViewController.contentViewController.view.frame);
      newFrame.size.height -= self.bottomDrawerContainerViewController.addedHeight;
      self.bottomDrawerContainerViewController.contentViewController.view.frame = newFrame;
      [self.bottomDrawerContainerViewController removeFromParentViewController];
    }
    [self.scrimView removeFromSuperview];
    [self.topHandle removeFromSuperview];
  }
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];

  [self.bottomDrawerContainerViewController.view layoutIfNeeded];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [self.bottomDrawerContainerViewController viewWillTransitionToSize:size
                                           withTransitionCoordinator:coordinator];
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _scrimColor = scrimColor;
  self.scrimView.backgroundColor = scrimColor;
}

- (void)setTopHandleHidden:(BOOL)topHandleHidden {
  _topHandleHidden = topHandleHidden;
  self.topHandle.hidden = topHandleHidden;
}

- (void)setTopHandleColor:(UIColor *)topHandleColor {
  _topHandleColor = topHandleColor;
  self.topHandle.backgroundColor = topHandleColor;
}

- (BOOL)contentReachesFullscreen {
  return self.bottomDrawerContainerViewController.contentReachesFullscreen;
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
    self.topHandle.alpha = (CGFloat)1.0 - transitionRatio;
  }
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated {
  [self.bottomDrawerContainerViewController setContentOffsetY:contentOffsetY animated:animated];
}

- (void)expandToFullscreenWithDuration:(CGFloat)duration
                            completion:(void (^__nullable)(BOOL finished))completion {
  [self.bottomDrawerContainerViewController expandToFullscreenWithDuration:duration
                                                                completion:completion];
}

@end
