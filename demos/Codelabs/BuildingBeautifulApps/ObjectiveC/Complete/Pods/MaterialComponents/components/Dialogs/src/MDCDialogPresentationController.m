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

#import "MaterialKeyboardWatcher.h"
#import "private/MDCDialogShadowedView.h"

static CGFloat MDCDialogMinimumWidth = 280.0f;
// TODO: Spec indicates 40 side margins and 280 minimum width.
// That is incompatible with a 320 wide device.
// Side margins set to 20 until we have a resolution
static UIEdgeInsets MDCDialogEdgeInsets = {24, 20, 24, 20};

@interface MDCDialogPresentationController ()

// View matching the container's bounds that dims the entire screen and catchs taps to dismiss.
@property(nonatomic) UIView *dimmingView;

// Tracking view that adds a shadow under the presented view. This view's frame should always match
// the presented view's.
@property(nonatomic) UIView *trackingView;

@end

@implementation MDCDialogPresentationController {
  UITapGestureRecognizer *_dismissGestureRecognizer;
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

    _trackingView = [[MDCDialogShadowedView alloc] init];

    [self registerKeyboardNotifications];
  }

  return self;
}

- (void)dealloc {
  [self unregisterKeyboardNotifications];
}

- (CGRect)frameOfPresentedViewInContainerView {
  CGRect presentedViewFrame = CGRectZero;

  CGRect containerBounds = self.containerView.bounds;
  containerBounds.size.height -= [MDCKeyboardWatcher sharedKeyboardWatcher].keyboardOffset;

  presentedViewFrame.size = [self sizeForChildContentContainer:self.presentedViewController
                                       withParentContainerSize:containerBounds.size];

  presentedViewFrame.origin.x = (containerBounds.size.width - presentedViewFrame.size.width) * 0.5f;
  presentedViewFrame.origin.y =
      (containerBounds.size.height - presentedViewFrame.size.height) * 0.5f;

  presentedViewFrame.origin.x = (CGFloat)floor(presentedViewFrame.origin.x);
  presentedViewFrame.origin.y = (CGFloat)floor(presentedViewFrame.origin.y);

  return presentedViewFrame;
}

- (void)presentationTransitionWillBegin {
  // TODO: Follow the Material spec description of Autonomous surface creation for both
  // presentation and dismissal of the dialog.
  // https://spec.googleplex.com/quantum/motion/choreography.html#choreography-creation

  // Set the dimming view to the container's bounds and fully transparent.
  self.dimmingView.frame = self.containerView.bounds;
  self.dimmingView.alpha = 0.0f;
  [self.containerView addSubview:self.dimmingView];

  // Set the shadowing view to the same frame as the presented view.
  CGRect presentedFrame = [self frameOfPresentedViewInContainerView];
  self.trackingView.frame = presentedFrame;
  self.trackingView.alpha = 0.0f;
  [self.containerView addSubview:self.trackingView];

  // Fade-in chrome views to be fully visible.
  id<UIViewControllerTransitionCoordinator> transitionCoordinator =
      [self.presentedViewController transitionCoordinator];
  if (transitionCoordinator) {
    [transitionCoordinator
        animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
          self.dimmingView.alpha = 1.0f;
          self.trackingView.alpha = 1.0f;
        }
                        completion:NULL];
  } else {
    self.dimmingView.alpha = 1.0f;
    self.trackingView.alpha = 1.0f;
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
        animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
          self.dimmingView.alpha = 0.0f;
          self.trackingView.alpha = 0.0f;
        }
                        completion:NULL];
  } else {
    self.dimmingView.alpha = 0.0f;
    self.trackingView.alpha = 0.0f;
  }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
  if (completed) {
    [self.dimmingView removeFromSuperview];
    [self.trackingView removeFromSuperview];

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

  CGSize maxChildSize;
  maxChildSize.width = parentSize.width - MDCDialogEdgeInsets.left - MDCDialogEdgeInsets.right;
  maxChildSize.height = parentSize.height - MDCDialogEdgeInsets.top - MDCDialogEdgeInsets.bottom;

  CGSize targetSize = maxChildSize;

  const CGSize preferredContentSize = container.preferredContentSize;
  if (!CGSizeEqualToSize(preferredContentSize, CGSizeZero)) {
    targetSize = preferredContentSize;

    // If the targetSize.width is greater than 0.0 it must be at least MDCDialogMinimumWidth.
    if (0.0f < targetSize.width && targetSize.width < MDCDialogMinimumWidth) {
      targetSize.width = MDCDialogMinimumWidth;
    }
    // targetSize cannot exceed maxChildSize.
    targetSize.width = MIN(targetSize.width, maxChildSize.width);
    targetSize.height = MIN(targetSize.height, maxChildSize.height);
  }

  targetSize.width = (CGFloat)ceil(targetSize.width);
  targetSize.height = (CGFloat)ceil(targetSize.height);

  return targetSize;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator
      animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
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
                     self.trackingView.frame = presentedViewFrame;
                   }
                   completion:NULL];
}

@end
