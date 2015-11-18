@import UIKit;

/**
 Metrics of the material shadow effect.

 These can be used if you require your own shadow implementation but want to match the material
 spec.
 */
@interface MDCShadowMetrics : NSObject
@property(nonatomic, readonly) CGFloat topShadowRadius;
@property(nonatomic, readonly) CGSize topShadowOffset;
@property(nonatomic, readonly) CGFloat topShadowOpacity;
@property(nonatomic, readonly) CGFloat bottomShadowRadius;
@property(nonatomic, readonly) CGSize bottomShadowOffset;
@property(nonatomic, readonly) CGFloat bottomShadowOpacity;

/**
 The shadow metrics for manually creating shadows given an elevation.

 @param elevation The shadow's elevation in points.
 @return The shadow metrics.
 */
// TODO(iangordon): Determine why Swift works even without the nonnull annotation below
+ (nonnull MDCShadowMetrics *)metricsWithElevation:(CGFloat)elevation;
@end

/**
 The material shadow effect.

 @see https://www.google.com/design/spec/what-is-material/elevation-shadows.html#elevation-shadows-shadows

 Consider rasterizing your MDCShadowLayer if your view will not generally be animating or
 changing size. If you need to animate a rasterized MDCShadowLayer, disable rasterization first.

 For example, if self's layerClass is MDCShadowLayer, you might introduce the following code:

     self.layer.shouldRasterize = YES;
     self.layer.rasterizationScale = [UIScreen mainScreen].scale;
 */
@interface MDCShadowLayer : CALayer

/**
 The elevation of the layer in points.

 The higher the elevation, the more spread out the shadow is.

 Negative values act as if zero were specified.
 */
@property(nonatomic, assign) CGFloat elevation;

/**
 Whether to apply the "cutout" shadow layer mask.

 If enabled, then a mask is created to ensure the interior, non-shadow part of the layer is visible.

 Default is YES. Not animatable.
 */
@property(nonatomic, assign) BOOL shadowMaskEnabled;

@end
