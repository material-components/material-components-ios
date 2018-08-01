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
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillShow:)
                          name:UIKeyboardWillShowNotification
                        object:nil];

    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillHide:)
                          name:UIKeyboardWillHideNotification
                        object:nil];

    [defaultCenter addObserver:self
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

- (void)updateKeyboardOffsetWithKeyboardUserInfo:(NSDictionary *)userInfo {
  // On iOS 8, the window orientation is corrected logically after transforms, so there is
  // no need to swap the width and height like we had to on iOS 7 and below..
  CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

  // iOS 8 doesn't notify us of a new keyboard rect when a keyboard dock or undocks to/from the
  // bottom of the screen. The more common case of no frame is a keyboard undocking and moving
  // around, so on iOS 8 we'll take a missing frame to indicate an undocked keyboard. Unfortunately
  // when the keyboard is re-docked, we won't know, and won't be able to re-update the offset.
  // This also means that our "failure" mode is at the bottom of the screen, so we shouldn't get
  // into a situation where the offset is too far up with no keyboard on screen.
  if (CGRectIsEmpty(keyboardRect)) {
    // Set the offset to zero, as if the keyboard was undocked.
    self.keyboardFrame = CGRectZero;
    return;
  }

  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  CGRect intersection = CGRectIntersection(screenBounds, keyboardRect);

  // If the extent of the keyboard is at or below the bottom of the screen it is docked.
  // This handles the case of an external keyboard on iOS8+ where the entire frame of the keyboard
  // view is used, but on the top, the input accessory section is show.
  BOOL dockedKeyboard = CGRectGetMaxY(screenBounds) <= CGRectGetMaxY(keyboardRect);

  // If the bottom of the keyboard isn't at the bottom of the screen, then it is undocked, and we
  // shouldn't try to account for it.
  if (dockedKeyboard && !CGRectIsEmpty(intersection)) {
    self.keyboardFrame = intersection;
  } else {
    self.keyboardFrame = CGRectZero;
  }
}

- (CGFloat)visibleKeyboardHeight {
  return CGRectGetHeight(self.keyboardFrame);
}

// TODO : keyboardOffset deprecated, delete.
- (CGFloat)keyboardOffset {
  return self.visibleKeyboardHeight;
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

- (void)keyboardWillShow:(NSNotification *)notification {
  [self updateKeyboardOffsetWithKeyboardUserInfo:notification.userInfo];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:MDCKeyboardWatcherKeyboardWillShowNotification
                    object:self
                  userInfo:notification.userInfo];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
  [self updateKeyboardOffsetWithKeyboardUserInfo:notification.userInfo];
  [[NSNotificationCenter defaultCenter]
      postNotificationName:MDCKeyboardWatcherKeyboardWillChangeFrameNotification
                    object:self
                  userInfo:notification.userInfo];
}

- (void)keyboardWillHide:(NSNotification *)notification {
  // If we are going to be hidden, it doesn't matter what the keyboard rects are, the keyboard
  // offset is 0. This applies in scenarios where a keyboard is showing on a view controller inside
  // of a navigation controller, and that controller is popped. Instead of the normal keyboard
  // vertical dismiss animation, the keyboard actually slides away with the view controller. In that
  // scenario, the keyboard dictionaries do not reflect the keyboard going to the bottom of the
  // screen. As such, we need to take into account the extra knowledge that the keyboard is being
  // hidden, and drive the keyboard offset that way.
  self.keyboardFrame = CGRectZero;
  [[NSNotificationCenter defaultCenter]
      postNotificationName:MDCKeyboardWatcherKeyboardWillHideNotification
                    object:self
                  userInfo:notification.userInfo];
}

@end
