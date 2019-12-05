// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCDialogPresentationController.h"

#import "MaterialKeyboardWatcher.h"
#import "MaterialShadowLayer.h"
#import "private/MDCDialogShadowedView.h"

static CGFloat MDCDialogMinimumWidth = 280;
// TODO: Spec indicates 40 side margins and 280 minimum width.
// That is incompatible with a 320 wide device.
// Side margins set to 20 until we have a resolution
static UIEdgeInsets MDCDialogEdgeInsets = {24, 20, 24, 20};

@interface MDCDialogPresentationController ()

// View matching the container's bounds that dims the entire screen and catchs taps to dismiss.
@property(nonatomic) UIView *dimmingView;

// Tracking view that adds a shadow under the presented view. This view's frame should always match
// the presented view's.
@property(nonatomic) MDCDialogShadowedView *trackingView;

@end

@implementation MDCDialogPresentationController {
  UITapGestureRecognizer *_dismissGestureRecognizer;
  BOOL useDialogCornerRadius;
  CGFloat previousPresentedViewCornerRadius;
}

#pragma mark - UIPresentationController

// dismissOnBackgroundTap wraps the enable property of our gesture recognizer to
// avoid duplication.
- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _dismissGestureRecognizer.enabled = dismissOnBackgroundTap;
}

- (BOOL)dismissOnBackgroundTap {
  return _dismissGestureRecognizer.enabled;
}

// presentedViewCornerRadius wraps the cornerRadius property of our tracking view to avoid
// duplication.
- (void)setDialogCornerRadius:(CGFloat)cornerRadius {
  _trackingView.layer.cornerRadius = cornerRadius;
  useDialogCornerRadius = YES;
}

- (CGFloat)dialogCornerRadius {
  return _trackingView.layer.cornerRadius;
}

- (void)setScrimColor:(UIColor *)scrimColor {
  self.dimmingView.backgroundColor = scrimColor;
}

- (UIColor *)scrimColor {
  return self.dimmingView.backgroundColor;
}

- (void)setDialogElevation:(MDCShadowElevation)dialogElevation {
  _trackingView.elevation = dialogElevation;
}

- (CGFloat)dialogElevation {
  return _trackingView.elevation;
}

- (void)setDialogShadowColor:(UIColor *)dialogShadowColor {
  self.trackingView.shadowColor = dialogShadowColor;
}

- (UIColor *)dialogShadowColor {
  return self.trackingView.shadowColor;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    useDialogCornerRadius = NO;

    _dimmingView = [[UIView alloc] initWithFrame:CGRectZero];
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.32];
    _dimmingView.alpha = 0;
    _dismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(dismiss:)];
    [_dimmingView addGestureRecognizer:_dismissGestureRecognizer];

    _trackingView = [[MDCDialogShadowedView alloc] init];
    _trackingView.shadowColor = UIColor.blackColor;

    [self registerKeyboardNotifications];
  }

  return self;
}

- (void)dealloc {
  [self unregisterKeyboardNotifications];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (CGRect)frameOfPresentedViewInContainerView {
  CGRect containerBounds = CGRectStandardize(self.containerView.bounds);

  // For pre iOS 11 devices, we are assuming a safeAreaInset of UIEdgeInsetsZero
  UIEdgeInsets containerSafeAreaInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    containerSafeAreaInsets = self.containerView.safeAreaInsets;
  }

  // Take the larger of the Safe Area insets and the Material specified insets.
  containerSafeAreaInsets.top = MAX(containerSafeAreaInsets.top, MDCDialogEdgeInsets.top);
  containerSafeAreaInsets.left = MAX(containerSafeAreaInsets.left, MDCDialogEdgeInsets.left);
  containerSafeAreaInsets.right = MAX(containerSafeAreaInsets.right, MDCDialogEdgeInsets.right);
  containerSafeAreaInsets.bottom = MAX(containerSafeAreaInsets.bottom, MDCDialogEdgeInsets.bottom);

  // Take into account a visible keyboard
  CGFloat keyboardHeight = [MDCKeyboardWatcher sharedKeyboardWatcher].visibleKeyboardHeight;
  containerSafeAreaInsets.bottom = MAX(containerSafeAreaInsets.bottom, keyboardHeight);

  // Area that the presented dialog can use.
  CGRect standardPresentableBounds =
      UIEdgeInsetsInsetRect(containerBounds, containerSafeAreaInsets);

  CGRect presentedViewFrame = CGRectZero;
  presentedViewFrame.size = [self sizeForChildContentContainer:self.presentedViewController
                                       withParentContainerSize:standardPresentableBounds.size];

  presentedViewFrame.origin.x =
      containerSafeAreaInsets.left +
      (standardPresentableBounds.size.width - presentedViewFrame.size.width) * (CGFloat)0.5;
  presentedViewFrame.origin.y =
      containerSafeAreaInsets.top +
      (standardPresentableBounds.size.height - presentedViewFrame.size.height) * (CGFloat)0.5;

  presentedViewFrame.origin.x = (CGFloat)floor(presentedViewFrame.origin.x);
  presentedViewFrame.origin.y = (CGFloat)floor(presentedViewFrame.origin.y);

  return presentedViewFrame;
}

- (void)presentationTransitionWillBegin {
  // TODO: Follow the Material spec description of Autonomous surface creation for both
  // presentation and dismissal of the dialog.
  // https://material.io/guidelines/motion/choreography.html#choreography-creation

  // Ensure the same corner radius is used by both the tracking view and the view being presented
  if (useDialogCornerRadius) {
    // If dialogCornerRadius is set, use its value for the shadow layer as well as the presented
    // view layer, overriding any direct assignments to the presented view's cornerRadius.
    _trackingView.layer.cornerRadius = self.dialogCornerRadius;
    // Note: For MDCAlertController, this assumes that the "view" property points to the same
    // instance as the "alertView" property. Therefore, we are safe to not set its cornerRadius
    // property (its ".cornerRadius", rather then its "presentedView.layer.cornerRadius")
    previousPresentedViewCornerRadius = self.presentedView.layer.cornerRadius;
    self.presentedView.layer.cornerRadius = self.dialogCornerRadius;
  } else {
    // If dialogCornerRadius is not set, use the presented view's cornerRadius for the shadow layer.
    _trackingView.layer.cornerRadius = self.presentedView.layer.cornerRadius;
  }

  // Set the dimming view to the container's bounds and fully transparent.
  self.dimmingView.frame = self.containerView.bounds;
  self.dimmingView.alpha = 0;
  [self.containerView addSubview:self.dimmingView];

  // Set the shadowing view to the same frame as the presented view.
  CGRect presentedFrame = [self frameOfPresentedViewInContainerView];
  self.trackingView.frame = presentedFrame;
  self.trackingView.alpha = 0;
  [self.containerView addSubview:self.trackingView];

  // Fade-in chrome views to be fully visible.
  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [self.presentedViewController transitionCoordinator];
  if (transitionCoordinator) {
    [transitionCoordinator
        animateAlongsideTransition:^(
            __unused id<UIViewControllerTransitionCoordinatorContext> context) {
          self.dimmingView.alpha = 1;
          self.trackingView.alpha = 1;
        }
                        completion:NULL];
  } else {
    self.dimmingView.alpha = 1;
    self.trackingView.alpha = 1;
  }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
  if (completed) {
    // Stop the presenting view from being tapped for voiceover while this view is up.
    // Setting @c accessibilityViewIsModal on the presented view (or its parent) should be enough,
    // but it's not.
    // b/19519321
    self.presentingViewController.view.accessibilityElementsHidden = YES;
    self.presentedView.accessibilityViewIsModal = YES;
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, [self presentedView]);
  } else {
    // Transition was cancelled.
    [self.dimmingView removeFromSuperview];
    [self.trackingView removeFromSuperview];
  }
}

- (void)dismissalTransitionWillBegin {
  // Fade-out dimmingView and trackingView to be fully transparent.
  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [self.presentedViewController transitionCoordinator];
  if (transitionCoordinator != nil) {
    [transitionCoordinator
        animateAlongsideTransition:^(
            __unused id<UIViewControllerTransitionCoordinatorContext> context) {
          self.dimmingView.alpha = 0;
          self.trackingView.alpha = 0;
        }
                        completion:NULL];
  } else {
    self.dimmingView.alpha = 0;
    self.trackingView.alpha = 0;
  }
}

- (CGAffineTransform)dialogTransform {
  return self.trackingView.transform;
}

- (void)setDialogTransform:(CGAffineTransform)shadowTransform {
  self.trackingView.transform = shadowTransform;
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.dimmingView removeFromSuperview];
    [self.trackingView removeFromSuperview];

    // Re-enable accessibilityElements on the presenting view controller.
    self.presentingViewController.view.accessibilityElementsHidden = NO;

    if (useDialogCornerRadius) {
      // Restore cornerRadius in case it had changed during presentation
      self.presentedView.layer.cornerRadius = previousPresentedViewCornerRadius;
    }
  }

  [super dismissalTransitionDidEnd:completed];
}

/**
 Indicate that the presenting view controller's view should not be removed when the presentation
 animations finish.

 MDCDialogPresentationController does not cover the presenting view controller's content entirely
 so we must return NO.
 */
- (BOOL)shouldRemovePresentersView {
  return NO;
}

#pragma mark - UIContentContainer

/**
 Determines the size of the presented container's view based on available space and the preferred
 content size of the container.
 */
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container
               withParentContainerSize:(CGSize)parentSize {
  if (CGSizeEqualToSize(parentSize, CGSizeZero)) {
    return CGSizeZero;
  }

  CGSize targetSize = parentSize;

  const CGSize preferredContentSize = container.preferredContentSize;
  if (!CGSizeEqualToSize(preferredContentSize, CGSizeZero)) {
    targetSize = preferredContentSize;

    // If the targetSize.width is greater than 0.0 it must be at least MDCDialogMinimumWidth.
    if (0 < targetSize.width && targetSize.width < MDCDialogMinimumWidth) {
      targetSize.width = MDCDialogMinimumWidth;
    }
    // targetSize cannot exceed parentSize.
    targetSize.width = MIN(targetSize.width, parentSize.width);
    targetSize.height = MIN(targetSize.height, parentSize.height);
  }

  targetSize.width = (CGFloat)ceil(targetSize.width);
  targetSize.height = (CGFloat)ceil(targetSize.height);

  return targetSize;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator
      animateAlongsideTransition:^(
          __unused id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.frame = self.containerView.bounds;
        CGRect presentedViewFrame = [self frameOfPresentedViewInContainerView];
        self.presentedView.frame = presentedViewFrame;
        self.trackingView.frame = presentedViewFrame;
      }
                      completion:NULL];
}

/**
 If the container's preferred content size has changed and we are able to accommidate the new size,
 update the frame of the presented view and the shadowing view.
 */
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];

  CGSize existingSize = self.presentedView.bounds.size;
  CGSize newSize = [self sizeForChildContentContainer:container
                              withParentContainerSize:self.containerView.bounds.size];

  if (!CGSizeEqualToSize(existingSize, newSize)) {
    CGRect presentedViewFrame = [self frameOfPresentedViewInContainerView];
    self.presentedView.frame = presentedViewFrame;
    self.trackingView.frame = presentedViewFrame;
  }
}

#pragma mark - Internal

- (void)dismiss:(UIGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateRecognized) {
    [self.presentingViewController
        dismissViewControllerAnimated:YES
                           completion:^{
                             if ([self.dialogPresentationControllerDelegate
                                     respondsToSelector:@selector
                                     (dialogPresentationControllerDidDismiss:)]) {
                               [self.dialogPresentationControllerDelegate
                                   dialogPresentationControllerDidDismiss:self];
                             }
                           }];
  }
}

#pragma mark - Keyboard handling

- (void)registerKeyboardNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWatcherHandler:)
                                               name:MDCKeyboardWatcherKeyboardWillShowNotification
                                             object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWatcherHandler:)
                                               name:MDCKeyboardWatcherKeyboardWillHideNotification
                                             object:nil];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(keyboardWatcherHandler:)
             name:MDCKeyboardWatcherKeyboardWillChangeFrameNotification
           object:nil];
}

- (void)unregisterKeyboardNotifications {
  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:MDCKeyboardWatcherKeyboardWillShowNotification
              object:nil];

  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:MDCKeyboardWatcherKeyboardWillHideNotification
              object:nil];

  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:MDCKeyboardWatcherKeyboardWillChangeFrameNotification
              object:nil];
}

#pragma mark - KeyboardWatcher Notifications

- (void)keyboardWatcherHandler:(NSNotification *)aNotification {
  NSTimeInterval animationDuration =
      [MDCKeyboardWatcher animationDurationFromKeyboardNotification:aNotification];

  UIViewAnimationOptions animationCurveOption =
      [MDCKeyboardWatcher animationCurveOptionFromKeyboardNotification:aNotification];

  [UIView animateWithDuration:animationDuration
                        delay:0
                      options:animationCurveOption | UIViewAnimationOptionTransitionNone
                   animations:^{
                     CGRect presentedViewFrame = [self frameOfPresentedViewInContainerView];
                     self.presentedView.frame = presentedViewFrame;
                     self.trackingView.frame = presentedViewFrame;
                   }
                   completion:NULL];
}

@end
