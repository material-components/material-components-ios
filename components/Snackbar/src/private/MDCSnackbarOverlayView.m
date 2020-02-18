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

#import "MDCSnackbarOverlayView.h"

#import <Foundation/Foundation.h>

#import <MDFInternationalization/MDFInternationalization.h>

#import "../MDCSnackbarMessage.h"
#import "MDCSnackbarMessageViewInternal.h"
#import "MaterialAnimationTiming.h"
#import "MaterialApplication.h"
#import "MaterialAvailability.h"
#import "MaterialKeyboardWatcher.h"
#import "MaterialOverlay.h"

NSString *const MDCSnackbarOverlayIdentifier = @"MDCSnackbar";

// The time it takes to show or hide the Snackbar.
NSTimeInterval const MDCSnackbarEnterTransitionDuration = 0.15;
NSTimeInterval const MDCSnackbarExitTransitionDuration = 0.125;
NSTimeInterval const MDCSnackbarLegacyTransitionDuration = 0.5;

// The scaling starting point for presenting the new Snackbar.
static const CGFloat MDCSnackbarEnterStartingScale = (CGFloat)0.8;

// How far from the bottom of the screen should the Snackbar be.
static const CGFloat MDCSnackbarBottomMargin_iPhone = 8;
static const CGFloat MDCSnackbarBottomMargin_iPad = 24;
static const CGFloat MDCSnackbarLegacyBottomMargin_iPhone = 0;
static const CGFloat MDCSnackbarLegacyBottomMargin_iPad = 0;

// How far from the sides of the screen should the Snackbar be.
static const CGFloat MDCSnackbarSideMargin_CompactWidth = 8;
static const CGFloat MDCSnackbarLegacySideMargin_CompactWidth = 0;
static const CGFloat MDCSnackbarSideMargin_RegularWidth = 24;

// The maximum height of the Snackbar.
static const CGFloat kMaximumHeight = 80;

#if MDC_AVAILABLE_SDK_IOS(10_0)
@interface MDCSnackbarOverlayView () <CAAnimationDelegate>
@end
#endif  // MDC_AVAILABLE_SDK_IOS(10_0)

@interface MDCSnackbarOverlayView ()

/**
 The Snackbar view to show. Setting this property simply puts the Snackbar view into the window
 hierarchy and installs constraints which will keep it pinned to the bottom of the screen.
 */
@property(nonatomic) MDCSnackbarMessageView *snackbarView;

/**
 The layout constraint which determines how far the Snackbar is from the leading edge of the screen.
 It is active when the alignment of the parent overlay view is MDCSnackbarAlignmentLeading.
 */
@property(nonatomic) NSLayoutConstraint *snackbarViewLeadingConstraint;

/**
 The layout constraint used to center the Snackbar.
 It is active when the alignment of the parent overlay view is MDCSnackbarAlignmentCenter.
 */
@property(nonatomic) NSLayoutConstraint *snackbarViewCenterConstraint;

/**
 The object which will notify us of changes in the keyboard position.
 */
@property(nonatomic) MDCKeyboardWatcher *watcher;

/**
 The layout constraint which determines the bottom of the containing view. Setting the constant
 to a negative value will cause Snackbars to appear from a point above the bottom of the screen.
 */
@property(nonatomic) NSLayoutConstraint *bottomConstraint;

/**
 The layout constraint which determines the maximum height of the Snackbar .
 */
@property(nonatomic) NSLayoutConstraint *maximumHeightConstraint;

/**
 The view which actually houses the Snackbar. This view is sized to be the same width and height as
 ourselves, except offset from the bottom, based on the keyboard height as well as any user-set
 content offsets.
 */
@property(nonatomic) UIView *containingView;

/**
 Whether or not we are triggering a layout change ourselves. This is to distinguish when our bounds
 are changing due to rotation rather than us adding/removing a Snackbar.
 */
@property(nonatomic) BOOL manualLayoutChange;

/**
 If we received a rotation event, this is the duration that should be used.
 */
@property(nonatomic) NSTimeInterval rotationDuration;

/**
 The constraint used to pin the bottom of the Snackbar to the bottom of the screen.
 */
@property(nonatomic) NSLayoutConstraint *snackbarOnscreenConstraint;

/**
 The constraint used to pin the top of the Snackbar to the bottom of the screen.
 */
@property(nonatomic) NSLayoutConstraint *snackbarOffscreenConstraint;

@end

@implementation MDCSnackbarOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  MDCKeyboardWatcher *watcher = [MDCKeyboardWatcher sharedKeyboardWatcher];

  if (self) {
    _watcher = watcher;
    _containingView = [[UIView alloc] initWithFrame:frame];
    _containingView.translatesAutoresizingMaskIntoConstraints = NO;
    if (MDCSnackbarMessage.usesLegacySnackbar) {
      _containingView.clipsToBounds = YES;
    }
    [self addSubview:_containingView];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self
           selector:@selector(keyboardWillShow:)
               name:MDCKeyboardWatcherKeyboardWillShowNotification
             object:watcher];

    [nc addObserver:self
           selector:@selector(keyboardWillBeHidden:)
               name:MDCKeyboardWatcherKeyboardWillHideNotification
             object:watcher];

    [nc addObserver:self
           selector:@selector(keyboardWillChangeFrame:)
               name:MDCKeyboardWatcherKeyboardWillChangeFrameNotification
             object:watcher];

    [nc addObserver:self
           selector:@selector(willRotate:)
               name:UIApplicationWillChangeStatusBarOrientationNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(didRotate:)
               name:UIApplicationDidChangeStatusBarOrientationNotification
             object:nil];

    [self setupContainerConstraints];
  }

  return self;
}

/**
 Installs constraints for the ever-present container view.

 @note These constraints remain installed for the life of the overlay view, whereas the
       constraints installed in @c setSnackbarView: come and go with the current Snackbar.
 */
- (void)setupContainerConstraints {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:_containingView
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeLeading
                                                  multiplier:1.0
                                                    constant:0]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:_containingView
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeTrailing
                                                  multiplier:1.0
                                                    constant:0]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:_containingView
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                    constant:0]];

  self.bottomConstraint = [NSLayoutConstraint constraintWithItem:_containingView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:-[self dynamicBottomMargin]];
  [self addConstraint:self.bottomConstraint];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 The bottom margin which is dependent on the keyboard and application-wide settings, and may
 change at any time during runtime.
 */
- (CGFloat)dynamicBottomMargin {
  CGFloat keyboardHeight = self.watcher.visibleKeyboardHeight;
  CGFloat userHeight = self.bottomOffset;
  if (!MDCSnackbarMessage.usesLegacySnackbar) {
    if (@available(iOS 11.0, *)) {
      userHeight = MAX(userHeight, self.safeAreaInsets.bottom);
    }
  }

  return MAX(keyboardHeight, userHeight);
}

/**
 The bottom margin which is dependent on device type and cannot change.
 */
- (CGFloat)staticBottomMargin {
  if (MDCSnackbarMessage.usesLegacySnackbar) {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
               ? MDCSnackbarLegacyBottomMargin_iPad
               : MDCSnackbarLegacyBottomMargin_iPhone;
  }
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? MDCSnackbarBottomMargin_iPad
                                                              : MDCSnackbarBottomMargin_iPhone;
}

- (CGFloat)sideMargin {
  if (MDCSnackbarMessage.usesLegacySnackbar) {
    return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular
               ? MDCSnackbarSideMargin_RegularWidth
               : MDCSnackbarLegacySideMargin_CompactWidth;
  }
  return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular
             ? MDCSnackbarSideMargin_RegularWidth
             : MDCSnackbarSideMargin_CompactWidth;
}

- (void)setSnackbarView:(MDCSnackbarMessageView *)snackbarView {
  if (_snackbarView != snackbarView) {
    [_snackbarView removeFromSuperview];
    _snackbarView = snackbarView;

    CGFloat bottomMargin = [self staticBottomMargin];
    CGFloat sideMargin = [self sideMargin];
    CGFloat leftMargin = sideMargin;
    CGFloat rightMargin = sideMargin;

    UIView *container = self.containingView;

    if (snackbarView) {
      [container addSubview:snackbarView];

      // Pin the Snackbar to the bottom of the screen.
      [snackbarView setTranslatesAutoresizingMaskIntoConstraints:NO];

      BOOL isRegularWidth =
          self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular;
      BOOL isRegularHeight =
          self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular;
      if (isRegularWidth && isRegularHeight) {
        self.snackbarViewCenterConstraint =
            [NSLayoutConstraint constraintWithItem:snackbarView
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:container
                                         attribute:NSLayoutAttributeCenterX
                                        multiplier:1.0
                                          constant:0];
        self.snackbarViewCenterConstraint.active = self.alignment == MDCSnackbarAlignmentCenter;

        self.snackbarViewLeadingConstraint =
            [NSLayoutConstraint constraintWithItem:snackbarView
                                         attribute:NSLayoutAttributeLeading
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:container
                                         attribute:NSLayoutAttributeLeading
                                        multiplier:1.0
                                          constant:sideMargin];
        self.snackbarViewLeadingConstraint.active = self.alignment == MDCSnackbarAlignmentLeading;

        // If not full width, ensure that it doesn't get any larger than our own width.
        [container
            addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                          toItem:container
                                                       attribute:NSLayoutAttributeWidth
                                                      multiplier:1.0
                                                        constant:-2 * sideMargin]];

        // Also ensure that it doesn't get any smaller than its own minimum width.
        [container
            addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:[snackbarView minimumWidth]]];

        // Also ensure that it doesn't get any larger than its own maximum width.
        [container
            addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:[snackbarView maximumWidth]]];
      } else {
        if (@available(iOS 11.0, *)) {
          if (self.mdf_effectiveUserInterfaceLayoutDirection ==
              UIUserInterfaceLayoutDirectionLeftToRight) {
            leftMargin += self.mdc_safeAreaInsets.left;
            rightMargin += self.mdc_safeAreaInsets.right;
          } else {
            leftMargin += self.mdc_safeAreaInsets.right;
            rightMargin += self.mdc_safeAreaInsets.left;
          }
        }

        [container addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:container
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                               constant:leftMargin]];

        [container addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:container
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:-1 * rightMargin]];
      }

      _snackbarOnscreenConstraint = [NSLayoutConstraint constraintWithItem:snackbarView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:container
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-bottomMargin];
      _snackbarOnscreenConstraint.active = !MDCSnackbarMessage.usesLegacySnackbar;
      if (MDCSnackbarMessage.usesLegacySnackbar) {
        _snackbarOnscreenConstraint.priority = UILayoutPriorityDefaultHigh;
      }
      [container addConstraint:_snackbarOnscreenConstraint];

      _snackbarOffscreenConstraint = [NSLayoutConstraint constraintWithItem:snackbarView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:container
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:-bottomMargin];
      _snackbarOffscreenConstraint.active = MDCSnackbarMessage.usesLegacySnackbar;
      if (!MDCSnackbarMessage.usesLegacySnackbar) {
        _snackbarOffscreenConstraint.priority = UILayoutPriorityDefaultLow;
      }
      [container addConstraint:_snackbarOffscreenConstraint];

      // Always limit the height of the Snackbar.
      self.maximumHeightConstraint =
          [NSLayoutConstraint constraintWithItem:snackbarView
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                          toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1.0
                                        constant:self.maximumHeight];

      [container addConstraint:self.maximumHeightConstraint];
    }
  }
}

// All we care about is whether or not we tapped on the Snackbar view. Everything else should pass
// through to other windows. Only ask the Snackbar view if the given point belongs, and ignore all
// other touches.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  BOOL result = NO;

  if (self.snackbarView) {
    CGPoint snackbarPoint = [self convertPoint:point toView:self.snackbarView];
    result = [self.snackbarView pointInside:snackbarPoint withEvent:event];
  }

  return result;
}

- (void)triggerSnackbarLayoutChange {
  self.manualLayoutChange = YES;
  self.snackbarView.anchoredToScreenBottom = self.anchoredToScreenBottom;
  [self layoutIfNeeded];
  self.manualLayoutChange = NO;
}

- (CGRect)snackbarRectInScreenCoordinates {
  if (self.snackbarView == nil) {
    return CGRectNull;
  }

  UIWindow *window = self.snackbarView.window;
  if (window == nil) {
    return CGRectNull;
  }

  return [self.snackbarView convertRect:self.snackbarView.bounds
                      toCoordinateSpace:window.screen.coordinateSpace];
}

- (CGFloat)maximumHeight {
  // Maximum height must be extended to include the bottom content safe area.
  CGFloat maximumHeight = kMaximumHeight;
  if (self.anchoredToScreenBottom && MDCSnackbarMessage.usesLegacySnackbar) {
    if (@available(iOS 11.0, *)) {
      maximumHeight += self.safeAreaInsets.bottom;
    }
  }
  return maximumHeight;
}

- (BOOL)anchoredToScreenBottom {
  return [self dynamicBottomMargin] == 0;
}

#pragma mark - Safe Area Insets

- (void)safeAreaInsetsDidChange {
  self.maximumHeightConstraint.constant = self.maximumHeight;
  [self triggerSnackbarLayoutChange];
}

- (UIEdgeInsets)mdc_safeAreaInsets {
  UIEdgeInsets insets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    insets = self.safeAreaInsets;
  }
  return insets;
}

#pragma mark - Presentation/Dismissal

- (void)showSnackbarView:(MDCSnackbarMessageView *)snackbarView
                animated:(BOOL)animated
              completion:(void (^)(void))completion {
  self.snackbarView = snackbarView;  // Install the Snackbar.
  self.bottomConstraint.constant = -self.dynamicBottomMargin;

  if (animated) {
    [self slideInMessageView:snackbarView completion:completion];
  } else {
    if (completion) {
      completion();
    }
  }
}

- (void)dismissSnackbarViewAnimated:(BOOL)animated completion:(void (^)(void))completion {
  if (animated) {
    [self slideOutMessageView:self.snackbarView
                   completion:^{
                     self.snackbarView = nil;  // Uninstall the Snackbar

                     if (completion) {
                       completion();
                     }
                   }];
  } else {
    self.snackbarView = nil;
    if (completion) {
      completion();
    }
  }
}

#pragma mark - Slide Animation

- (void)slideMessageView:(MDCSnackbarMessageView *)snackbarView
                onscreen:(BOOL)onscreen
      fromContentOpacity:(CGFloat)fromContentOpacity
        toContentOpacity:(CGFloat)toContentOpacity
              completion:(void (^)(void))completion {
  // Prepare to move the Snackbar.
  NSTimeInterval duration = MDCSnackbarLegacyTransitionDuration;
  if (!MDCSnackbarMessage.usesLegacySnackbar) {
    duration = onscreen ? MDCSnackbarEnterTransitionDuration : MDCSnackbarExitTransitionDuration;
  }
  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:timingFunction];
  [CATransaction setCompletionBlock:completion];
  [CATransaction setAnimationDuration:duration];
  CAAnimationGroup *animationsGroup = [CAAnimationGroup animation];
  animationsGroup.fillMode = kCAFillModeForwards;
  animationsGroup.removedOnCompletion = NO;

  if (MDCSnackbarMessage.usesLegacySnackbar) {
    _snackbarOnscreenConstraint.active = onscreen;
    _snackbarOffscreenConstraint.active = !onscreen;
    [_containingView setNeedsUpdateConstraints];
    // We use UIView animation inside a CATransaction in order to use the custom animation curve.
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                       // Trigger Snackbar animation.
                       [self->_containingView layoutIfNeeded];
                     }
                     completion:nil];
    [snackbarView animateContentOpacityFrom:fromContentOpacity
                                         to:toContentOpacity
                                   duration:duration
                             timingFunction:timingFunction];
  } else {
    NSMutableArray *animations =
        [NSMutableArray arrayWithObject:[snackbarView animateSnackbarOpacityFrom:fromContentOpacity
                                                                              to:toContentOpacity]];
    if (onscreen) {
      [animations addObject:[snackbarView animateSnackbarScaleFrom:MDCSnackbarEnterStartingScale
                                                           toScale:1]];
    }
    animationsGroup.animations = animations;
    [snackbarView.layer addAnimation:animationsGroup forKey:@"snackbarAnimation"];
  }

  [CATransaction commit];

  // To support the MDCOverlayObserver seeing frame changes, we need to update the frame of the
  // new Snackbar for the observer, as now it doesn't change frame but rather change opacity.
  // In future we should add support for opacity to our MDCOverlayObserver and not only frame.
  CGRect snackbarRect = [self snackbarRectInScreenCoordinates];
  if (!MDCSnackbarMessage.usesLegacySnackbar && !onscreen) {
    snackbarRect.origin.y = self.bounds.size.height - [self dynamicBottomMargin];
  }

  // Notify the overlay system.
  [self notifyOverlayChangeWithFrame:snackbarRect
                            duration:duration
                               curve:0
                      timingFunction:timingFunction];
}

- (void)slideInMessageView:(MDCSnackbarMessageView *)snackbarView
                completion:(void (^)(void))completion {
  // Make sure that the Snackbar has been properly sized to calculate the translation value.
  [self triggerSnackbarLayoutChange];

  [self slideMessageView:snackbarView
                onscreen:YES
      fromContentOpacity:0
        toContentOpacity:1
              completion:completion];
}

- (void)slideOutMessageView:(MDCSnackbarMessageView *)snackbarView
                 completion:(void (^)(void))completion {
  // Make sure that the Snackbar has been properly sized to calculate the translation value.
  [self triggerSnackbarLayoutChange];

  [self slideMessageView:snackbarView
                onscreen:NO
      fromContentOpacity:1
        toContentOpacity:0
              completion:completion];
}

#pragma mark - Keyboard Notifications

- (void)updatesnackbarPositionWithKeyboardUserInfo:(NSDictionary *)userInfo {
  // Always set the bottom constraint, even if there isn't a Snackbar currently displayed.
  void (^updateBlock)(void) = ^{
    self.bottomConstraint.constant = -[self dynamicBottomMargin];
    [self triggerSnackbarLayoutChange];
  };

  if (self.snackbarView) {
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve =
        [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | curve << 16;

    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:updateBlock
                     completion:nil];

    // Notify the overlay system that a change is happening.
    [self notifyOverlayChangeWithFrame:[self snackbarRectInScreenCoordinates]
                              duration:duration
                                 curve:curve
                        timingFunction:nil];
  } else {
    updateBlock();
  }
}

- (void)keyboardWillShow:(NSNotification *)notification {
  [self updatesnackbarPositionWithKeyboardUserInfo:[notification userInfo]];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
  [self updatesnackbarPositionWithKeyboardUserInfo:[notification userInfo]];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
  [self updatesnackbarPositionWithKeyboardUserInfo:[notification userInfo]];
}

#pragma mark - Bottom And Side Margins

- (void)setBottomOffset:(CGFloat)bottomOffset {
  if (_bottomOffset != bottomOffset) {
    _bottomOffset = bottomOffset;

    self.maximumHeightConstraint.constant = self.maximumHeight;
    self.bottomConstraint.constant = -self.dynamicBottomMargin;
    [self triggerSnackbarLayoutChange];

    // If there is no Snackbar the following method returns CGRectNull, but we still need to notify
    // observers of bottom offset changes.
    CGRect frame = [self snackbarRectInScreenCoordinates];
    if (CGRectIsNull(frame)) {
      frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.bottomOffset,
                         CGRectGetWidth(self.frame), self.bottomOffset);
    }
    [self notifyOverlayChangeWithFrame:frame
                              duration:[CATransaction animationDuration]
                                 curve:UIViewAnimationCurveEaseInOut
                        timingFunction:nil];
  }
}

- (void)setAlignment:(MDCSnackbarAlignment)alignment {
  if (_alignment != alignment) {
    _alignment = alignment;

    [self activateSnackbarViewConstraintsForAlignment:alignment];

    [self triggerSnackbarLayoutChange];

    // If there is no Snackbar the following method returns CGRectNull, but we still need to notify
    // observers of bottom offset changes.
    CGRect frame = [self snackbarRectInScreenCoordinates];
    if (CGRectIsNull(frame)) {
      frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.bottomOffset,
                         CGRectGetWidth(self.frame), self.bottomOffset);
    }
    [self notifyOverlayChangeWithFrame:frame
                              duration:[CATransaction animationDuration]
                                 curve:UIViewAnimationCurveEaseInOut
                        timingFunction:nil];
  }
}

- (void)activateSnackbarViewConstraintsForAlignment:(MDCSnackbarAlignment)alignment {
  switch (alignment) {
    case MDCSnackbarAlignmentCenter:
      self.snackbarViewLeadingConstraint.active = NO;
      self.snackbarViewCenterConstraint.active = YES;
      break;
    case MDCSnackbarAlignmentLeading:
      self.snackbarViewLeadingConstraint.active = YES;
      self.snackbarViewCenterConstraint.active = NO;
      break;
    default:
      self.snackbarViewLeadingConstraint.active = NO;
      self.snackbarViewCenterConstraint.active = YES;
      break;
  }
}

#pragma mark - Rotation

- (void)handleRotation {
  if (self.snackbarView != nil) {
    [self notifyOverlayChangeWithFrame:[self snackbarRectInScreenCoordinates]
                              duration:self.rotationDuration
                                 curve:UIViewAnimationCurveEaseInOut
                        timingFunction:nil];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (!self.manualLayoutChange && self.rotationDuration > 0) {
    [self.containingView layoutIfNeeded];
    [self handleRotation];
  }
}

- (void)willRotate:(NSNotification *)notification {
  UIApplication *application = [UIApplication mdc_safeSharedApplication];
  UIInterfaceOrientation currentOrientation = application.statusBarOrientation;
  UIInterfaceOrientation targetOrientation =
      [notification.userInfo[UIApplicationStatusBarOrientationUserInfoKey] integerValue];

  NSTimeInterval duration = application.statusBarOrientationAnimationDuration;

  // If this is a landscape->landscape or portrait->portrait rotation, then double the duration.
  BOOL currentIsLandscape = UIInterfaceOrientationIsLandscape(currentOrientation);
  BOOL targetIsLandscape = UIInterfaceOrientationIsLandscape(targetOrientation);
  if (currentIsLandscape == targetIsLandscape) {
    duration = 2 * duration;
  }

  self.rotationDuration = duration;
}

- (void)didRotate:(__unused NSNotification *)notification {
  // The UIApplicationDidChangeStatusBarOrientationNotification happens pretty much immediately
  // after the willRotate notification, before any layouts are changed. By delaying this until the
  // next runloop, any rotation-related layout changes will occur, and we can know that they were
  // due to rotation.
  dispatch_async(dispatch_get_main_queue(), ^{
    self.rotationDuration = -1;
  });
}

#pragma mark - Overlay Support

- (void)notifyOverlayChangeWithFrame:(CGRect)frame
                            duration:(NSTimeInterval)duration
                               curve:(UIViewAnimationCurve)curve
                      timingFunction:(CAMediaTimingFunction *)timingFunction {
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:@{
    MDCOverlayIdentifierKey : MDCSnackbarOverlayIdentifier,
    MDCOverlayFrameKey : [NSValue valueWithCGRect:frame],
    MDCOverlayTransitionDurationKey : @(duration),
  }];

  if (duration > 0) {
    if (timingFunction != nil) {
      userInfo[MDCOverlayTransitionTimingFunctionKey] = timingFunction;
    } else {
      userInfo[MDCOverlayTransitionCurveKey] = @(curve);
    }
  }

  // Notify the overlay system that a change is happening
  [[NSNotificationCenter defaultCenter] postNotificationName:MDCOverlayDidChangeNotification
                                                      object:nil
                                                    userInfo:userInfo];
}

#pragma mark - UIAccessibilityAction

- (BOOL)accessibilityPerformEscape {
  if (self.snackbarView) {
    [self.snackbarView dismissWithAction:nil userInitiated:YES];
    return YES;
  } else {
    return NO;
  }
}

#pragma mark - Timing functions

static void WrapWithTimingFunctionForCurve(MDCAnimationTimingFunction mediaTiming,
                                           void (^block)(void)) {
  [CATransaction begin];
  [CATransaction
      setAnimationTimingFunction:[CAMediaTimingFunction mdc_functionWithType:mediaTiming]];
  block();
  [CATransaction commit];
}

+ (void)animateWithDuration:(NSTimeInterval)duration
                      curve:(MDCAnimationTimingFunction)curve
                 animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion {
  WrapWithTimingFunctionForCurve(curve, ^{
    [UIView animateWithDuration:duration animations:animations completion:completion];
  });
}

@end
