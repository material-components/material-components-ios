#import "MDCOverlayObserverOverlay.h"

#import "MDCOverlayUtilities.h"

@implementation MDCOverlayObserverOverlay

- (CGRect)overlayFrameInView:(UIView *)targetView {
  return MDCOverlayConvertRectToView(self.frame, targetView);
}

@end
