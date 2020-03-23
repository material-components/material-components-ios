// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCRippleLayerDelegate.h"

/**
 Convenience naming for the completion blocks the ripple animation provides.
 */
typedef void (^MDCRippleCompletionBlock)(void);

@protocol MDCRippleLayerDelegate;

/**
 The Ripple Layer presents and animates the ripple. There can be multiple Ripple Layers
 as sublayers for MDCRippleView. The Ripple Layer subclasses CAShapeLayer to leverage the path
 property so we can conveniently draw the ripple circle.
 */
@interface MDCRippleLayer : CAShapeLayer

/**
 The ripple layer delegate.
 */
@property(nonatomic, weak, nullable) id<MDCRippleLayerDelegate> rippleLayerDelegate;

/**
 A bool indicating if the start animation is currently active for this ripple layer.
 */
@property(nonatomic, assign, readonly, getter=isStartAnimationActive) BOOL startAnimationActive;

/**
 The ripple's touch down animation start time. It is measured in seconds
 as the current absolute time when the animation begins.
 */
@property(nonatomic, assign) CFTimeInterval rippleTouchDownStartTime;

/**
 The radius the ripple expands to when activated.

 @note This only impacts new ripples, if a ripple is already being animated this property will have
 no impact.
 */
@property(nonatomic, assign) CGFloat maximumRadius;

/**
 Starts the ripple at the given point.

 @param point The point to start the ripple animation.
 @param animated Whether or not the ripple should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)startRippleAtPoint:(CGPoint)point
                  animated:(BOOL)animated
                completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Ends the ripple.

 @param animated Whether or not the ripple should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)endRippleAnimated:(BOOL)animated completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Fades the ripple in by changing the layer's opacity.

 @param animated Whether or not the fade in should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)fadeInRippleAnimated:(BOOL)animated
                  completion:(nullable MDCRippleCompletionBlock)completion;

/**
 Fades the ripple out by changing the layer's opacity.

 @param animated Whether or not the fade out should be animated or not.
 @param completion A completion block called after the completion of the animation.
 */
- (void)fadeOutRippleAnimated:(BOOL)animated
                   completion:(nullable MDCRippleCompletionBlock)completion;
@end
