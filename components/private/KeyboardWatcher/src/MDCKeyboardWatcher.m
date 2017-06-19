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

#import "MDCKeyboardWatcher.h"
#import "MaterialApplication.h"

NSString *const MDCKeyboardWatcherKeyboardWillShowNotification =
    @"MDCKeyboardWatcherKeyboardWillShowNotification";
NSString *const MDCKeyboardWatcherKeyboardWillHideNotification =
    @"MDCKeyboardWatcherKeyboardWillHideNotification";
NSString *const MDCKeyboardWatcherKeyboardWillChangeFrameNotification =
    @"MDCKeyboardWatcherKeyboardWillChangeFrameNotification";

static MDCKeyboardWatcher *_sKeyboardWatcher;

@interface MDCKeyboardWatcher ()

/** The keyboard's frame, in rotation-compensated screen coordinates. */
@property(nonatomic) CGRect keyboardFrame;

@end

@implementation MDCKeyboardWatcher

// Because at the time of writing, there is no public API for answering the question: "Is the
// keyboard currently showing?", we must watch the keyboard's show/hide notifications and maintain
// that state on our own. The only time early enough to start watching the keyboard is at +load, so
// we must create a watcher then.
+ (void)load {
  @autoreleasepool {
    _sKeyboardWatcher = [[MDCKeyboardWatcher alloc] init];
  }
}

+ (instancetype)sharedKeyboardWatcher {
  return _sKeyboardWatcher;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self
           selector:@selector(keyboardWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(keyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil];

    [nc addObserver:self
           selector:@selector(keyboardWillChangeFrame:)
               name:UIKeyboardWillChangeFrameNotification
             object:nil];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notifications

- (BOOL)deviceUsesCoordinateSpaces {
  static BOOL useCoordinateSpace = NO;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    UIScreen *screen = [UIScreen mainScreen];
    useCoordinateSpace = [screen respondsToSelector:@selector(fixedCoordinateSpace)];
  });

  return useCoordinateSpace;
}

- (void)updateKeyboardOffsetWithKeyboardUserInfo:(NSDictionary *)userInfo
                                     forceHidden:(BOOL)forceHidden {
  CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  UIScreen *screen = [UIScreen mainScreen];

  // If we are supposed to be hidden, it doesn't matter what the keyboard rects are, the keyboard
  // offset is 0. This applies in scenarios where a keyboard is showing on a view controller inside
  // of a navigation controller, and that controller is popped. Instead of the normal keyboard
  // vertical dismiss animation, the keyboard actually slides away with the view controller. In that
  // scenario, the keyboard dictionaries do not reflect the keyboard going to the bottom of the
  // screen. As such, we need to take into account the extra knowledge that the keyboard is being
  // hidden, and drive the keyboard offset that way.
  if (forceHidden) {
    self.keyboardFrame = CGRectZero;
    return;
  }

  // On iOS 8, the window orientation is corrected logically after transforms, so there is
  // no need to swap the width and height like we had to on iOS 7 and below..
  BOOL isiOS8Device = [self deviceUsesCoordinateSpaces];

  // iOS 8 doesn't notify us of a new keyboard rect when a keyboard dock or undocks to/from the
  // bottom of the screen. The more common case of no frame is a keyboard undocking and moving
  // around, so on iOS 8 we'll take a missing frame to indicate an undocked keyboard. Unfortunately
  // when the keyboard is re-docked, we won't know, and won't be able to re-update the offset.
  // This also means that our "failure" mode is at the bottom of the screen, so we shouldn't get
  // into a situation where the offset is too far up with no keyboard on screen.
  if (CGRectIsEmpty(keyboardRect)) {
    if (isiOS8Device) {
      // Set the offset to zero, as if the keyboard was undocked.
      self.keyboardFrame = CGRectZero;
    }
    return;
  }

  CGRect screenBounds = [screen bounds];
  CGRect intersection = CGRectIntersection(screenBounds, keyboardRect);

  UIInterfaceOrientation orientation =
      [[UIApplication mdc_safeSharedApplication] statusBarOrientation];

  BOOL isDockedKeyboard = YES;

  if (!isiOS8Device) {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
      CGFloat width = intersection.size.width;
      CGFloat x = intersection.origin.x;

      intersection.size.width = intersection.size.height;
      intersection.size.height = width;

      intersection.origin.x = intersection.origin.y;
      intersection.origin.y = x;
    }

    // These calculations all depend on the fixed screen coordinate space, so we use the keyboard
    // rectangle instead of @c intersection, which has already accounted for rotation.
    switch (orientation) {
      case UIInterfaceOrientationPortraitUpsideDown:
        isDockedKeyboard = CGRectGetMinY(keyboardRect) == CGRectGetMinY(screenBounds);
        break;
      case UIInterfaceOrientationLandscapeLeft:
        isDockedKeyboard = CGRectGetMaxX(keyboardRect) == CGRectGetMaxX(screenBounds);
        break;
      case UIInterfaceOrientationLandscapeRight:
        isDockedKeyboard = CGRectGetMinX(keyboardRect) == CGRectGetMinX(screenBounds);
        break;
      case UIInterfaceOrientationPortrait:
      case UIInterfaceOrientationUnknown:
        isDockedKeyboard = CGRectGetMaxY(keyboardRect) == CGRectGetMaxY(screenBounds);
        break;
    }
  } else {
    // On an iPad an input accessory view may be shown on the screen even if there is an external
    // keyboard attached. In that case, iOS will build a software keyboard with an accessory view
    // attached to the top. It then sets the frame of this keyboard to be below the bounds of the
    // screen so only the top accessory view is rendered.
    // We handle this by considering software keyboards with a MaxY >= screen.MaxY as being docked.
    isDockedKeyboard = CGRectGetMaxY(keyboardRect) >= CGRectGetMaxY(screenBounds);
  }

  // If the keyboard is docked and the intersection of the keyboard and the screen is
  // non-zero update our stored keyboard frame.
  // If the keyboard is undocked, split, or not visible set the keyboard frame to CGRectZero.
  if (isDockedKeyboard && !CGRectIsEmpty(intersection)) {
    self.keyboardFrame = intersection;
  } else {
    self.keyboardFrame = CGRectZero;
  }
}

- (CGFloat)keyboardOffset {
  return CGRectGetHeight(self.keyboardFrame);
}

+ (NSTimeInterval)animationDurationFromKeyboardNotification:(NSNotification *)notification {
  if (![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillShowNotification] &&
      ![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillHideNotification] &&
      ![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillChangeFrameNotification]) {
    NSAssert(NO, @"Cannot extract the animation duration from a non-keyboard notification.");

    return 0.0;
  }

  NSNumber *animationDurationNumber = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration = (NSTimeInterval)[animationDurationNumber doubleValue];

  return animationDuration;
}

/** Convert UIViewAnimationCurve to UIViewAnimationOptions */
static UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve animationCurve) {
  switch (animationCurve) {
    case UIViewAnimationCurveEaseInOut:
      return UIViewAnimationOptionCurveEaseInOut;
    case UIViewAnimationCurveEaseIn:
      return UIViewAnimationOptionCurveEaseIn;
    case UIViewAnimationCurveEaseOut:
      return UIViewAnimationOptionCurveEaseOut;
    case UIViewAnimationCurveLinear:
      return UIViewAnimationOptionCurveLinear;
  }

  // UIKit unpredictably returns values that aren't declared in UIViewAnimationCurve, so we can't
  // assert here.
  // UIKeyboardWillChangeFrameNotification can post with a curve of 7.
  // Based on how UIViewAnimationOptions are defined in UIView.h, (animationCurve << 16) may an
  // be acceptable return value for unrecognized curves.
  return UIViewAnimationOptionCurveEaseInOut;
}

+ (UIViewAnimationOptions)animationCurveOptionFromKeyboardNotification:
        (NSNotification *)notification {
  if (![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillShowNotification] &&
      ![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillHideNotification] &&
      ![notification.name isEqualToString:MDCKeyboardWatcherKeyboardWillChangeFrameNotification]) {
    NSAssert(NO, @"Cannot extract the animation curve option from a non-keyboard notification.");

    return UIViewAnimationOptionCurveEaseInOut;
  }

  NSNumber *animationCurveNumber = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
  UIViewAnimationCurve animationCurve = (UIViewAnimationCurve)[animationCurveNumber integerValue];
  UIViewAnimationOptions animationCurveOption = animationOptionsWithCurve(animationCurve);

  return animationCurveOption;
}

#pragma mark - Notifications

- (void)updateOffsetWithUserInfo:(NSDictionary *)userInfo
                     forceHidden:(BOOL)forceHidden
              notificationToPost:(NSString *)notificationToPost {
  [self updateKeyboardOffsetWithKeyboardUserInfo:userInfo forceHidden:forceHidden];
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationToPost
                                                      object:self
                                                    userInfo:userInfo];
}

- (void)keyboardWillShow:(NSNotification *)notification {
  [self updateOffsetWithUserInfo:notification.userInfo
                     forceHidden:NO
              notificationToPost:MDCKeyboardWatcherKeyboardWillShowNotification];
}

- (void)keyboardWillHide:(NSNotification *)notification {
  [self updateOffsetWithUserInfo:notification.userInfo
                     forceHidden:YES
              notificationToPost:MDCKeyboardWatcherKeyboardWillHideNotification];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
  [self updateOffsetWithUserInfo:notification.userInfo
                     forceHidden:NO
              notificationToPost:MDCKeyboardWatcherKeyboardWillChangeFrameNotification];
}

@end
