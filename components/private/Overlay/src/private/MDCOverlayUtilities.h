#import <UIKit/UIKit.h>

/**
 Utility function which converts a rectangle in overlay coordinates into the local coordinate
 space of the given @c target
 */
OBJC_EXPORT CGRect MDCOverlayConvertRectToView(CGRect overlayFrame, UIView *targetView);
