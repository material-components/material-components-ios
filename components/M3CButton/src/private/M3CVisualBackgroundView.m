#import "M3CVisualBackgroundView.h"
#import "M3CAnimationActions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation M3CVisualBackgroundView

#pragma mark - CALayerDelegate

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
  if (layer == self.layer && M3CIsMDCShadowPathKey(key)) {
    // Provide a custom action for the view's layer's shadow path only.
    return M3CShadowPathActionForLayer(layer);
  }
  return [super actionForLayer:layer forKey:key];
}

@end

NS_ASSUME_NONNULL_END
