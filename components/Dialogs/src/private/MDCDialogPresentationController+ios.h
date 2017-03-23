#import "MDCDialogPresentationController.h"

#if TARGET_OS_IOS

/**
 Portion of MDCDialogPresentationController that is used on iOS only.
 
 For use internally by MDCDialogPresentationController only.
 */
@interface MDCDialogPresentationController (iOS)
- (void)registerKeyboardNotifications;

- (void)unregisterKeyboardNotifications;
@end

#endif // #if TARGET_OS_IOS
