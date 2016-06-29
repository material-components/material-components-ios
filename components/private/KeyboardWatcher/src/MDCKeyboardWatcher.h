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

/**
 The distance from the top of the keyboard to the bottom of the screen.

 Zero if the keyboard is not currently showing or is not docked.
 */
@property(nonatomic, readonly) CGFloat keyboardOffset;

@end
