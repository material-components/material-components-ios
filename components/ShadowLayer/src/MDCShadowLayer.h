/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>
#import "MaterialShadowElevations.h"

/**
 Metrics of the Material shadow effect.

 These can be used if you require your own shadow implementation but want to match the material
 spec.
 */
@interface MDCShadowMetrics : NSObject
@property(nonatomic, readonly) CGFloat topShadowRadius;
@property(nonatomic, readonly) CGSize topShadowOffset;
@property(nonatomic, readonly) float topShadowOpacity;
@property(nonatomic, readonly) CGFloat bottomShadowRadius;
@property(nonatomic, readonly) CGSize bottomShadowOffset;
@property(nonatomic, readonly) float bottomShadowOpacity;

/**
 The shadow metrics for manually creating shadows given an elevation.

 @param elevation The shadow's elevation in points.
 @return The shadow metrics.
 */
+ (nonnull MDCShadowMetrics *)metricsWithElevation:(CGFloat)elevation;
@end

/**
 The Material shadow effect.

 @see
 https://material.io/guidelines/what-is-material/elevation-shadows.html#elevation-shadows-shadows

 Consider rasterizing your MDCShadowLayer if your view will not generally be animating or
 changing size. If you need to animate a rasterized MDCShadowLayer, disable rasterization first.

 For example, if self's layerClass is MDCShadowLayer, you might introduce the following code:

     self.layer.shouldRasterize = YES;
     self.layer.rasterizationScale = [UIScreen mainScreen].scale;
 */
@interface MDCShadowLayer : CALayer

/**
 The elevation of the layer in points.

 The higher the elevation, the more spread out the shadow is. This is distinct from the layer's
 zPosition which can be used to order overlapping layers, but will have no affect on the size of
 the shadow.

 Negative values act as if zero were specified.

 The default value is 0.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 Whether to apply the "cutout" shadow layer mask.

 If enabled, then a mask is created to ensure the interior, non-shadow part of the layer is visible.

 Default is YES. Not animatable.
 */
@property(nonatomic, getter=isShadowMaskEnabled, assign) BOOL shadowMaskEnabled;

@end

/**
 Subclasses can depend on MDCShadowLayer implementing CALayerDelegate actionForLayer:forKey: in
 order to implicitly animate 'path' or 'shadowPath' on sublayers.
 */
@interface MDCShadowLayer (Subclassing) <CALayerDelegate>
@end
