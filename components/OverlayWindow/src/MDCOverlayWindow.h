#import <UIKit/UIKit.h>

/**
 Subclasses UIWindow to allow overlays to cover all content.

 Overlays will be the full size of the screen, or when multitasking use all available screen space,
 and will be rotated as appropriate based on device orientation. For performance, owners of overlay
 views should set the @c hidden property to YES when the overlay is not in use.
 */
@interface MDCOverlayWindow : UIWindow

/**
 Notifies the window that the given overlay view should be shown.

 Overlay owners must call this method to ensure that the overlay is actually displayed over the
 window's primary content.

 @param overlay The overlay being displayed.
 @param level The UIWindowLevel to display the overlay on.
 */
- (void)activateOverlay:(UIView *)overlay withLevel:(UIWindowLevel)level;

/**
 Notifies the window that the given overlay is no longer active.

 Overlay owners should still hide their overlay before calling this method.

 @param overlay The overlay being displayed.
 */
- (void)deactivateOverlay:(UIView *)overlay;

@end
