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
#if TARGET_OS_IOS

#import "MDCDialogPresentationController+ios.h"

#import "MaterialKeyboardWatcher.h"

@interface MDCDialogPresentationController (private)

// Access to the trackingView used by MDCDialogTransitionController(iOS)
@property(nonatomic) UIView *trackingView;

@end

@implementation MDCDialogPresentationController (iOS)

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

#endif //#if TARGET_OS_IOS
