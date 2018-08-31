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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// These notifications mirror their UIKeyboard* counterparts. They are posted after the keyboard
// watcher has updated its own internal state, so listeners are safe to query the keyboard watcher
// for its values.
OBJC_EXTERN NSString *const MDCKeyboardWatcherKeyboardWillShowNotification;
OBJC_EXTERN NSString *const MDCKeyboardWatcherKeyboardWillHideNotification;
OBJC_EXTERN NSString *const MDCKeyboardWatcherKeyboardWillChangeFrameNotification;

/**
 An object which will watch the state of the keyboard.

 The keyboard watcher calculates an offset representing the distance from the top of the keyboard to
 the bottom of the screen.
 */
@interface MDCKeyboardWatcher : NSObject

/**
 Shared singleton instance of MDCKeyboardWatcher.
 */
+ (instancetype)sharedKeyboardWatcher;

/** Extract the animation duration from the keyboard notification */
+ (NSTimeInterval)animationDurationFromKeyboardNotification:(NSNotification *)notification;

/** Extract the animation curve option from the keyboard notification */
+ (UIViewAnimationOptions)animationCurveOptionFromKeyboardNotification:
        (NSNotification *)notification;

/**
 The height of the visible keyboard view.

 Zero if the keyboard is not currently showing or is not docked.
 */
@property(nonatomic, readonly) CGFloat visibleKeyboardHeight;

#pragma mark deprecated

/**
 The distance from the top of the keyboard to the bottom of the screen.

 Zero if the keyboard is not currently showing or is not docked.
 */
@property(nonatomic, readonly) CGFloat keyboardOffset __deprecated_msg("Use visibleKeyboardHeight instead of keyboardOffset")
;

@end
