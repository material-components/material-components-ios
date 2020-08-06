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

#import "private/MDCBottomDrawerContainerViewController.h"
#import "MDCBottomDrawerPresentationControllerDelegate.h"
#import "MDCBottomDrawerViewController.h"
#import "MaterialPalettes.h"

static CGFloat kTopHandleHeight = (CGFloat)2.0;
static CGFloat kTopHandleWidth = (CGFloat)24.0;
static CGFloat kTopHandleTopMargin = (CGFloat)5.0;

/** View that allows touches that aren't handled from within the view to be propagated up the
 responder chain. This is used to allow forwarding of tap events from the scrim view through to
 the delegate if that has been enabled on the VC. */
@interface MDCBottomDrawerScrimView : UIView
@end

@implementation MDCBottomDrawerScrimView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  // Cause the responder chain to keep bubbling up and propagate touches from the scrim view thru
  // to the presenting VC to possibly be handled by the drawer delegate.
  UIView *view = [super hitTest:point withEvent:event];
  return view == self ? nil : view;
}

@end

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

@implementation MDCBottomDrawerPresentationController {
  UIColor *_scrimColor;
}

@synthesize delegate;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _topHandleHidden = YES;
    _maximumInitialDrawerHeight = 0;
    _maximumDrawerHeight = 0;
    _drawerShadowColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.2];
    _elevation = MDCShadowElevationNavDrawer;
    _dismissOnBackgroundTap = YES;
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
  if (self.maximumInitialDrawerHeight > 0) {
    bottomDrawerContainerViewController.maximumInitialDrawerHeight =
        self.maximumInitialDrawerHeight;
  }
  if (self.maximumDrawerHeight > 0) {
    bottomDrawerContainerViewController.maximumDrawerHeight = self.maximumDrawerHeight;
  }
  bottomDrawerContainerViewController.shouldIncludeSafeAreaInContentHeight =
      self.shouldIncludeSafeAreaInContentHeight;
  bottomDrawerContainerViewController.shouldIncludeSafeAreaInInitialDrawerHeight =
      self.shouldIncludeSafeAreaInInitialDrawerHeight;
  bottomDrawerContainerViewController.shouldUseStickyStatusBar = self.shouldUseStickyStatusBar;
  bottomDrawerContainerViewController.shouldAdjustOnContentSizeChange =
      self.shouldAdjustOnContentSizeChange;
  bottomDrawerContainerViewController.shouldAlwaysExpandHeader = self.shouldAlwaysExpandHeader;
  bottomDrawerContainerViewController.elevation = self.elevation;
  bottomDrawerContainerViewController.drawerShadowColor = self.drawerShadowColor;
  bottomDrawerContainerViewController.adjustLayoutForIPadSlideOver =
      self.adjustLayoutForIPadSlideOver;
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

  self.scrimView = [[MDCBottomDrawerScrimView alloc] initWithFrame:self.containerView.bounds];
  self.scrimView.backgroundColor = self.scrimColor;
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

  if (self.adjustLayoutForIPadSlideOver) {
    [self setupBottomDrawerContainerViewControllerConstraints];
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

  // Need to calculate the initial position of the drawer since the layout pass will
  // not be complete before the animation begins.
  CGRect frame = [self targetFrameOfDrawerContentOnPresentation];
  [self.delegate bottomDrawerPresentTransitionWillBegin:self
                                        withCoordinator:transitionCoordinator
                                          targetYOffset:frame.origin.y];
}

/**
 Setup constraints so bottomDrawerContainerViewController has the correct size in iPad Slide Over.

 Without these constraints when the app is in iPad Slide Over, the view controller will
 have the wrong size that is equal to the screen when it should instead be the size of the Slide
 Over window.
 */
- (void)setupBottomDrawerContainerViewControllerConstraints {
  UIView *bottomDrawerView = self.bottomDrawerContainerViewController.view;
  UIView *bottomDrawerSuperview = bottomDrawerView.superview;

  bottomDrawerView.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [bottomDrawerView.leftAnchor constraintEqualToAnchor:bottomDrawerSuperview.leftAnchor],
    [bottomDrawerView.rightAnchor constraintEqualToAnchor:bottomDrawerSuperview.rightAnchor],
    [bottomDrawerView.topAnchor constraintEqualToAnchor:bottomDrawerSuperview.topAnchor],
    [bottomDrawerView.bottomAnchor constraintEqualToAnchor:bottomDrawerSuperview.bottomAnchor],
  ]];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  // Set up the tap recognizer.
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrimTapped)];
  [self.containerView addGestureRecognizer:tapGestureRecognizer];
  tapGestureRecognizer.delegate = self;

  self.bottomDrawerContainerViewController.animatingPresentation = NO;
  [self.bottomDrawerContainerViewController.view setNeedsLayout];
  if (!completed) {
    [self.scrimView removeFromSuperview];
    [self.topHandle removeFromSuperview];
  }

  [self.delegate bottomDrawerPresentTransitionDidEnd:self];
}

- (void)dismissalTransitionWillBegin {
  self.bottomDrawerContainerViewController.animatingDismissal = YES;

  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [[self presentingViewController] transitionCoordinator];
  [transitionCoordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.scrimView.alpha = 0.0;
      }
                      completion:nil];

  [self.delegate bottomDrawerDismissTransitionWillBegin:self
                                        withCoordinator:transitionCoordinator
                                          targetYOffset:self.containerView.frame.size.height];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    if ([self.presentedViewController isKindOfClass:[MDCBottomDrawerViewController class]]) {
      CGRect newFrame = CGRectStandardize(
          self.bottomDrawerContainerViewController.contentViewController.view.frame);
      newFrame.size.height -= self.bottomDrawerContainerViewController.addedHeight;
      self.bottomDrawerContainerViewController.contentViewController.view.frame = newFrame;
      [self.bottomDrawerContainerViewController willMoveToParentViewController:nil];
      [self.bottomDrawerContainerViewController.view removeFromSuperview];
      [self.bottomDrawerContainerViewController removeFromParentViewController];
    }
    [self.scrimView removeFromSuperview];
    [self.topHandle removeFromSuperview];
  }

  self.bottomDrawerContainerViewController.animatingDismissal = NO;
  [self.delegate bottomDrawerDismissTransitionDidEnd:self];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];
  [self.bottomDrawerContainerViewController.view layoutIfNeeded];
}

/** Estimate the target frame of the drawer content upon presentation. */
- (CGRect)targetFrameOfDrawerContentOnPresentation {
  CGSize containerSize = self.containerView.frame.size;
  CGSize preferredSize = self.presentedViewController.preferredContentSize;

  // Layout has yet to be completed so let's calculate the preferred height.
  if (CGSizeEqualToSize(preferredSize, CGSizeZero)) {
    preferredSize.height = self.bottomDrawerContainerViewController.maximumInitialDrawerHeight;
    preferredSize.width = containerSize.width;
  }

  return CGRectMake(0, MAX(0.0f, containerSize.height - preferredSize.height), preferredSize.height,
                    preferredSize.width);
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [self.bottomDrawerContainerViewController viewWillTransitionToSize:size
                                           withTransitionCoordinator:coordinator];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _scrimColor = scrimColor;
  self.scrimView.backgroundColor = scrimColor;
}

- (UIColor *)scrimColor {
  return _scrimColor ?: [UIColor colorWithWhite:0 alpha:(CGFloat)0.32];
}

- (void)setTopHandleHidden:(BOOL)topHandleHidden {
  _topHandleHidden = topHandleHidden;
  self.topHandle.hidden = topHandleHidden;
}

- (void)setTopHandleColor:(UIColor *)topHandleColor {
  _topHandleColor = topHandleColor;
  self.topHandle.backgroundColor = topHandleColor;
}

- (void)setElevation:(MDCShadowElevation)elevation {
  _elevation = elevation;
  self.bottomDrawerContainerViewController.elevation = elevation;
}

- (void)setShouldAlwaysExpandHeader:(BOOL)shouldAlwaysExpandHeader {
  _shouldAlwaysExpandHeader = shouldAlwaysExpandHeader;
  self.bottomDrawerContainerViewController.shouldAlwaysExpandHeader = shouldAlwaysExpandHeader;
}

- (void)setShouldAdjustOnContentSizeChange:(BOOL)shouldAdjustOnContentSizeChange {
  _shouldAdjustOnContentSizeChange = shouldAdjustOnContentSizeChange;
  self.bottomDrawerContainerViewController.shouldAdjustOnContentSizeChange =
      shouldAdjustOnContentSizeChange;
}

- (void)setDrawerShadowColor:(UIColor *)drawerShadowColor {
  _drawerShadowColor = drawerShadowColor;
  self.bottomDrawerContainerViewController.drawerShadowColor = drawerShadowColor;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _trackingScrollView = trackingScrollView;
  self.bottomDrawerContainerViewController.trackingScrollView = trackingScrollView;
}

- (void)setMaximumInitialDrawerHeight:(CGFloat)maximumInitialDrawerHeight {
  _maximumInitialDrawerHeight = maximumInitialDrawerHeight;
  self.bottomDrawerContainerViewController.maximumInitialDrawerHeight =
      self.maximumInitialDrawerHeight;
}

- (void)setMaximumDrawerHeight:(CGFloat)maximumDrawerHeight {
  _maximumDrawerHeight = maximumDrawerHeight;
  self.bottomDrawerContainerViewController.maximumDrawerHeight = self.maximumDrawerHeight;
}

- (BOOL)contentReachesFullscreen {
  return self.bottomDrawerContainerViewController.contentReachesFullscreen;
}

#pragma mark - Private

- (void)hideDrawer {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrimTapped {
  [self.delegate bottomDrawerDidTapScrim:self];

  // Dismiss the drawer on tap if enabled.
  if (self.dismissOnBackgroundTap) {
    [self hideDrawer];
  }
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

- (void)bottomDrawerContainerViewControllerDidChangeYOffset:
            (MDCBottomDrawerContainerViewController *)containerViewController
                                                    yOffset:(CGFloat)yOffset {
  id<MDCBottomDrawerPresentationControllerDelegate> strongDelegate = self.delegate;
  if ([strongDelegate respondsToSelector:@selector(bottomDrawerTopDidChangeYOffset:yOffset:)]) {
    [strongDelegate bottomDrawerTopDidChangeYOffset:self yOffset:yOffset];
  }
}

- (void)bottomDrawerContainerViewControllerNeedsScrimAppearanceUpdate:
            (nonnull MDCBottomDrawerContainerViewController *)containerViewController
                    scrimShouldAdoptTrackingScrollViewBackgroundColor:
                        (BOOL)scrimShouldAdoptTrackingScrollViewBackgroundColor {
  if (self.trackingScrollView) {
    // This logic is to mitigate b/119714330. Dragging the drawer further up when already at the
    // bottom shows the scrim and the presenting view controller
    self.scrimView.backgroundColor = scrimShouldAdoptTrackingScrollViewBackgroundColor
                                         ? self.trackingScrollView.backgroundColor
                                         : self.scrimColor;
  }
}

@end
