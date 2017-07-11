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

#import <Foundation/Foundation.h>

#import "MDCSnackbarOverlayView.h"

#import "MaterialSnackbar.h"
#import "MDCSnackbarMessageViewInternal.h"
#import "MaterialAnimationTiming.h"
#import "MaterialKeyboardWatcher.h"
#import "MaterialOverlay.h"
#import "MaterialApplication.h"

NSString *const MDCSnackbarOverlayIdentifier = @"MDCSnackbar";

// The time it takes to show or hide the snackbar.
NSTimeInterval const MDCSnackbarTransitionDuration = 0.5f;

// How far from the bottom of the screen should the snackbar be.
static const CGFloat MDCSnackbarBottomMargin_iPhone = 0;
static const CGFloat MDCSnackbarBottomMargin_iPad = 0;

// How far from the sides of the screen should the snackbar be.
static const CGFloat MDCSnackbarSideMargin_iPhone = 0;
static const CGFloat MDCSnackbarSideMargin_iPad = 24.0f;

// The maximum height of the snackbar.
static const CGFloat kMaximumHeight = 80.0f;

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCSnackbarOverlayView () <CAAnimationDelegate>
@end
#endif

@interface MDCSnackbarOverlayView ()

/**
 The snackbar view to show. Setting this property simply puts the snackbar view into the window
 hierarchy and installs constraints which will keep it pinned to the bottom of the screen.
 */
@property(nonatomic) MDCSnackbarMessageView *snackbarView;

/**
 The object which will notify us of changes in the keyboard position.
 */
@property(nonatomic) MDCKeyboardWatcher *watcher;

/**
 The layout constraint which determines the bottom of the containing view. Setting the constant
 to a negative value will cause snackbars to appear from a point above the bottom of the screen.
 */
@property(nonatomic) NSLayoutConstraint *bottomConstraint;

/**
 The view which actually houses the snackbar. This view is sized to be the same width and height as
 ourselves, except offset from the bottom, based on the keyboard height as well as any user-set
 content offsets.
 */
@property(nonatomic) UIView *containingView;

/**
 Whether or not we are triggering a layout change ourselves. This is to distinguish when our bounds
 are changing due to rotation rather than us adding/removing a snackbar.
 */
@property(nonatomic) BOOL manualLayoutChange;

/**
 If we received a rotation event, this is the duration that should be used.
 */
@property(nonatomic) NSTimeInterval rotationDuration;

/**
 The constraint used to pin the bottom of the snackbar to the bottom of the screen.
 */
@property(nonatomic) NSLayoutConstraint *snackbarOnscreenConstraint;

/**
 The constraint used to pin the top of the snackbar to the bottom of the screen.
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
    _containingView.clipsToBounds = YES;
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
       constraints installed in @c setsnackbarView: come and go with the current snackbar.
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

  return MAX(keyboardHeight, userHeight);
}

/**
 The bottom margin which is dependent on device type and cannot change.
 */
- (CGFloat)staticBottomMargin {
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? MDCSnackbarBottomMargin_iPad
                                                              : MDCSnackbarBottomMargin_iPhone;
}

- (CGFloat)sideMargin {
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? MDCSnackbarSideMargin_iPad
                                                              : MDCSnackbarSideMargin_iPhone;
}

- (void)setSnackbarView:(MDCSnackbarMessageView *)snackbarView {
  if (_snackbarView != snackbarView) {
    [_snackbarView removeFromSuperview];
    _snackbarView = snackbarView;

    CGFloat bottomMargin = [self staticBottomMargin];
    CGFloat sideMargin = [self sideMargin];

    BOOL fullWidth = UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad;

    UIView *container = self.containingView;

    if (snackbarView) {
      [container addSubview:snackbarView];

      // Pin the snackbar to the bottom of the screen.
      [snackbarView setTranslatesAutoresizingMaskIntoConstraints:NO];

      [container addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:container
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];

      if (fullWidth) {
        [container addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:container
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1.0
                                                               constant:-2 * sideMargin]];
      } else {
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
      }

      // Always pin the snackbar to the bottom of the container.
      _snackbarOnscreenConstraint = [NSLayoutConstraint constraintWithItem:snackbarView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:container
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-bottomMargin];
      _snackbarOnscreenConstraint.active = NO;  // snackbar starts off-screen.
      _snackbarOnscreenConstraint.priority = UILayoutPriorityDefaultHigh;
      [container addConstraint:_snackbarOnscreenConstraint];

      _snackbarOffscreenConstraint = [NSLayoutConstraint constraintWithItem:snackbarView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:container
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:-bottomMargin];
      _snackbarOffscreenConstraint.active = YES;
      [container addConstraint:_snackbarOffscreenConstraint];

      // Always limit the height of the snackbar.
      [container
          addConstraint:[NSLayoutConstraint constraintWithItem:snackbarView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:kMaximumHeight]];
    }
  }
}

// All we care about is whether or not we tapped on the snackbar view. Everything else should pass
// through to other windows. Only ask the snackbar view if the given point belongs, and ignore all
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

  UIScreen *screen = window.screen;
  if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
    return [self.snackbarView convertRect:self.snackbarView.bounds
                        toCoordinateSpace:screen.fixedCoordinateSpace];
  }

  CGRect snackbarWindowFrame =
      [window convertRect:self.snackbarView.bounds fromView:self.snackbarView];
  CGRect snackbarScreenFrame = [window convertRect:snackbarWindowFrame toWindow:nil];
  return snackbarScreenFrame;
}

#pragma mark - Presentation/Dismissal

- (void)showSnackbarView:(MDCSnackbarMessageView *)snackbarView
                animated:(BOOL)animated
              completion:(void (^)(void))completion {
  self.snackbarView = snackbarView;  // Install the snackbar.

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
                     self.snackbarView = nil;  // Uninstall the snackbar

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

#pragma mark - Fade Animation

- (void)fadeInsnackbarView:(MDCSnackbarMessageView *)snackbarView
                completion:(void (^)(void))completion {
  snackbarView.alpha = 0;

  // Make sure that the snackbar has been properly sized before fading in.
  [self triggerSnackbarLayoutChange];

  void (^animations)(void) = ^{
    self.snackbarView.alpha = 1.0;
  };
  void (^realCompletion)(BOOL) = ^(BOOL finished) {
    if (completion) {
      completion();
    }
  };

  UIViewAnimationCurve curve = UIViewAnimationCurveEaseInOut;
  CAMediaTimingFunction *function = nil;

  MDCAnimationTimingFunction materialCurve = MDCAnimationTimingFunctionEaseOut;
  function = [CAMediaTimingFunction mdc_functionWithType:materialCurve];

  [MDCSnackbarOverlayView animateWithDuration:MDCSnackbarTransitionDuration
                                        curve:materialCurve
                                   animations:animations
                                   completion:realCompletion];

  // Notify the overlay system.
  [self notifyOverlayChangeWithFrame:[self snackbarRectInScreenCoordinates]
                            duration:MDCSnackbarTransitionDuration
                               curve:curve
                      timingFunction:function];
}

#pragma mark - Slide Animation

- (void)slideMessageView:(MDCSnackbarMessageView *)snackbarView
                onscreen:(BOOL)onscreen
      fromContentOpacity:(CGFloat)fromContentOpacity
        toContentOpacity:(CGFloat)toContentOpacity
              completion:(void (^)(void))completion {
  // Prepare to move the snackbar.
  _snackbarOnscreenConstraint.active = onscreen;
  _snackbarOffscreenConstraint.active = !onscreen;
  [_containingView setNeedsUpdateConstraints];

  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  [CATransaction begin];
  [CATransaction setAnimationTimingFunction:timingFunction];

  // We use UIView animation inside a CATransaction in order to use the custom animation curve.
  [UIView animateWithDuration:MDCSnackbarTransitionDuration
      delay:0
      options:UIViewAnimationOptionCurveEaseInOut
      animations:^{
        // Trigger snackbar animation.
        [_containingView layoutIfNeeded];
      }
      completion:^(BOOL finished) {
        if (completion) {
          completion();
        }
      }];

  [snackbarView animateContentOpacityFrom:fromContentOpacity
                                       to:toContentOpacity
                                 duration:MDCSnackbarTransitionDuration
                           timingFunction:timingFunction];
  [CATransaction commit];

  // Notify the overlay system.
  [self notifyOverlayChangeWithFrame:[self snackbarRectInScreenCoordinates]
                            duration:MDCSnackbarTransitionDuration
                               curve:0
                      timingFunction:timingFunction];
}

- (void)slideInMessageView:(MDCSnackbarMessageView *)snackbarView
                completion:(void (^)(void))completion {
  // Make sure that the snackbar has been properly sized to calculate the translation value.
  [self triggerSnackbarLayoutChange];

  [self slideMessageView:snackbarView
                onscreen:YES
      fromContentOpacity:0
        toContentOpacity:1
              completion:completion];
}

- (void)slideOutMessageView:(MDCSnackbarMessageView *)snackbarView
                 completion:(void (^)(void))completion {
  // Make sure that the snackbar has been properly sized to calculate the translation value.
  [self triggerSnackbarLayoutChange];

  [self slideMessageView:snackbarView
                onscreen:NO
      fromContentOpacity:1
        toContentOpacity:0
              completion:completion];
}

#pragma mark - Keyboard Notifications

- (void)updatesnackbarPositionWithKeyboardUserInfo:(NSDictionary *)userInfo {
  // Always set the bottom constraint, even if there isn't a snackbar currently displayed.
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

#pragma mark - Bottom Offset

- (void)setBottomOffset:(CGFloat)bottomOffset {
  if (_bottomOffset != bottomOffset) {
    _bottomOffset = bottomOffset;

    self.bottomConstraint.constant = -[self dynamicBottomMargin];
    [self triggerSnackbarLayoutChange];
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

  // On iOS 7, the layout of this overlay view will have already occurred by the time the will
  // rotation notification is posted. In that event, we need to report rotation here. Opting to
  // check for version using the UIDevice string methods because we need to perform this check even
  // if the app was compiled on an iOS 7 SDK and is running on an iOS 8 device.
  NSString *version = [[UIDevice currentDevice] systemVersion];
  if ([version compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending) {
    [self handleRotation];
  }
}

- (void)didRotate:(NSNotification *)notification {
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
