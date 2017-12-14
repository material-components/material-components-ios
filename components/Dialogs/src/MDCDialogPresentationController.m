/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCDialogPresentationController.h"

#import "MDCDialogTransition.h"
#import "MaterialKeyboardWatcher.h"
#import "private/MDCDialogShadowedView.h"
#import "private/MDCDialogTransitionMotionSpec.h"
#import <MotionAnimator/MotionAnimator.h>
#import <MotionTransitioning/MotionTransitioning.h>

static CGFloat MDCDialogMinimumWidth = 280.0f;
// TODO: Spec indicates 40 side margins and 280 minimum width.
// That is incompatible with a 320 wide device.
// Side margins set to 20 until we have a resolution
static UIEdgeInsets MDCDialogEdgeInsets = {24, 20, 24, 20};

@interface MDCDialogPresentationController () <MDMTransition>

// View matching the container's bounds that dims the entire screen and catchs taps to dismiss.
@property(nonatomic) UIView *dimmingView;

// A settable version of the parent presentedView API.
@property(nonatomic) UIView *presentedView;

@end

@implementation MDCDialogPresentationController {
  UITapGestureRecognizer *_dismissGestureRecognizer;
}

// We've made presentedView writable, so we need to synthesize the setter.
@synthesize presentedView = _presentedView;

#pragma mark - UIPresentationController

// dismissOnBackgroundTap wraps the enable property of our gesture recognizer to
// avoid duplication.
- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _dismissGestureRecognizer.enabled = dismissOnBackgroundTap;
}

- (BOOL)dismissOnBackgroundTap {
  return _dismissGestureRecognizer.enabled;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(UIViewController *)presentingViewController {
  self = [super initWithPresentedViewController:presentedViewController
                       presentingViewController:presentingViewController];
  if (self) {
    _dimmingView = [[UIView alloc] initWithFrame:CGRectZero];
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    _dimmingView.alpha = 0.0f;
    _dismissGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [_dimmingView addGestureRecognizer:_dismissGestureRecognizer];

    self.presentedView = [[MDCDialogShadowedView alloc] init];

    [self registerKeyboardNotifications];
  }

  return self;
}

- (void)dealloc {
  [self unregisterKeyboardNotifications];
}

- (CGRect)frameOfPresentedViewInContainerView {
  CGRect containerBounds = CGRectStandardize(self.containerView.bounds);

  // For pre iOS 11 devices, we are assuming a safeAreaInset of UIEdgeInsetsZero
  UIEdgeInsets containerSafeAreaInsets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    containerSafeAreaInsets = self.containerView.safeAreaInsets;
  }
#endif

  // Take the larger of the Safe Area insets and the Material specified insets.
  containerSafeAreaInsets.top = MAX(containerSafeAreaInsets.top, MDCDialogEdgeInsets.top);
  containerSafeAreaInsets.left = MAX(containerSafeAreaInsets.left, MDCDialogEdgeInsets.left);
  containerSafeAreaInsets.right = MAX(containerSafeAreaInsets.right, MDCDialogEdgeInsets.right);
  containerSafeAreaInsets.bottom = MAX(containerSafeAreaInsets.bottom, MDCDialogEdgeInsets.bottom);

  // Take into account a visible keyboard
  CGFloat keyboardHeight = [MDCKeyboardWatcher sharedKeyboardWatcher].visibleKeyboardHeight;
  containerSafeAreaInsets.bottom = MAX(containerSafeAreaInsets.bottom, keyboardHeight);

  // Area that the presented dialog can utilize.
  CGRect standardPresentableBounds = UIEdgeInsetsInsetRect(containerBounds, containerSafeAreaInsets);

  CGRect presentedViewFrame = CGRectZero;
  presentedViewFrame.size = [self sizeForChildContentContainer:self.presentedViewController
                                       withParentContainerSize:standardPresentableBounds.size];

  presentedViewFrame.origin.x =
    containerSafeAreaInsets.left + (standardPresentableBounds.size.width - presentedViewFrame.size.width) * 0.5f;
  presentedViewFrame.origin.y =
    containerSafeAreaInsets.top + (standardPresentableBounds.size.height - presentedViewFrame.size.height) * 0.5f;

  presentedViewFrame.origin.x = (CGFloat)floor(presentedViewFrame.origin.x);
  presentedViewFrame.origin.y = (CGFloat)floor(presentedViewFrame.origin.y);

  return presentedViewFrame;
}

- (BOOL)isDrivenByMaterialMotion {
  return self.presentedViewController.mdm_transitionController.activeTransition != nil;
}

- (void)presentationTransitionWillBegin {
  [super presentationTransitionWillBegin];

  // Set the dimming view to the container's bounds and fully transparent.
  self.dimmingView.frame = self.containerView.bounds;
  self.dimmingView.alpha = 0.0f;
  [self.containerView addSubview:self.dimmingView];

  // Set the shadowing view to the same frame as the presented view.
  CGRect presentedFrame = [self frameOfPresentedViewInContainerView];
  self.presentedView.frame = presentedFrame;
  [self.containerView addSubview:self.presentedView];

  self.presentedViewController.view.frame = self.presentedView.bounds;
  self.presentedViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                                        | UIViewAutoresizingFlexibleHeight);
  [self.presentedView addSubview:self.presentedViewController.view];

  // Compatibility fall-back for when clients are using this presentation controller with
  // MDCDialogTransitionController.
  if (![self isDrivenByMaterialMotion]) {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator =
          [self.presentedViewController transitionCoordinator];
    if (transitionCoordinator) {
      [transitionCoordinator animateAlongsideTransition:
       ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
         [self animateWithDirection:MDMTransitionDirectionForward];
       } completion:nil];
    } else {
      [self animateWithDirection:MDMTransitionDirectionForward];
    }
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
    [self.presentedView removeFromSuperview];
  }

  [super presentationTransitionDidEnd:completed];
}

- (void)dismissalTransitionWillBegin {
  [super dismissalTransitionWillBegin];

  if (![self isDrivenByMaterialMotion]) {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator =
          [self.presentedViewController transitionCoordinator];
    if (transitionCoordinator) {
      [transitionCoordinator animateAlongsideTransition:
       ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
         [self animateWithDirection:MDMTransitionDirectionBackward];
       } completion:nil];
    } else {
      [self animateWithDirection:MDMTransitionDirectionBackward];
    }
  }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.dimmingView removeFromSuperview];
    [self.presentedView removeFromSuperview];

    // Re-enable accessibilityElements on the presenting view controller.
    self.presentingViewController.view.accessibilityElementsHidden = NO;
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
    if (0.0f < targetSize.width && targetSize.width < MDCDialogMinimumWidth) {
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

  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.frame = self.containerView.bounds;
        CGRect presentedViewFrame = [self frameOfPresentedViewInContainerView];
        self.presentedView.frame = presentedViewFrame;
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
  }
}

#pragma mark - Internal

- (void)dismiss:(UIGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateRecognized) {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
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
                        delay:0.0f
                      options:animationCurveOption | UIViewAnimationOptionTransitionNone
                   animations:^{
                     CGRect presentedViewFrame = [self frameOfPresentedViewInContainerView];
                     self.presentedView.frame = presentedViewFrame;
                   }
                   completion:NULL];
}

#pragma mark - MDMTransition

- (void)startWithContext:(id<MDMTransitionContext>)context {
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [context transitionDidEnd];
  }];

  [self animateWithDirection:context.direction];

  [CATransaction commit];
}

- (void)animateWithDirection:(MDMTransitionDirection)direction {
  MDMMotionAnimator *animator = [[MDMMotionAnimator alloc] init];
  animator.shouldReverseValues = direction == MDMTransitionDirectionBackward;

  MDMMotionTiming scrimOpacity;
  if (direction == MDMTransitionDirectionForward) {
    scrimOpacity = MDCDialogTransitionMotionSpec.appearance.scrimOpacity;

    // Only scale in when appearing.
    [animator animateWithTiming:MDCDialogTransitionMotionSpec.appearance.contentScale
                        toLayer:self.presentedView.layer
                     withValues:@[@(MDCDialogTransitionMotionSpec.appearance.contentScaleFromValue),
                                  @1]
                        keyPath:MDMKeyPathScale];

  } else {
    scrimOpacity = MDCDialogTransitionMotionSpec.disappearance.scrimOpacity;
  }

  [animator animateWithTiming:scrimOpacity
                      toLayer:self.dimmingView.layer
                   withValues:@[@0, @1]
                      keyPath:MDMKeyPathOpacity];
}

@end
