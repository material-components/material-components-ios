#import "MDCOverlayUtilities.h"

CGRect MDCOverlayConvertRectToView(CGRect screenRect, UIView *target) {
  if (target != nil && !CGRectIsNull(screenRect)) {
    // Overlay rectangles are in screen fixed coordinates in iOS 8. If available, we'll use that
    // API to do the conversion.
    UIScreen *screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
      return [target convertRect:screenRect fromCoordinateSpace:screen.fixedCoordinateSpace];
    }

    // If we can't use coordinate spaces (iOS 8 only), then convert the rectangle from screen
    // coordinates to our own view. On iOS 7 and below, the window is the same size as the screen's
    // bounds, so we can safely convert from window coordinates here and get the same outcome.
    return [target convertRect:screenRect fromView:nil];
  }
  return CGRectNull;
}
