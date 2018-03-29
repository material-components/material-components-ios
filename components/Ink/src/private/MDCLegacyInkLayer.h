/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 A Core Animation layer that draws and animates the ink effect.

 Quick summary of how the ink ripple works:

 1. On touch down, blast initiates from the touch point.
 2. On touch down hold, it continues to spread, but will gravitate to the center point
    of the view.
 3. On touch up, the ink ripple will lose energy, opacity will start to decrease.
 */
@interface MDCLegacyInkLayer : CALayer

/** Clips the ripple to the bounds of the layer. */
@property(nonatomic, assign, getter=isBounded) BOOL bounded;

/** Maximum radius of the ink. No maximum if radius is 0 or less. This value is ignored if
 @c bounded is set to |YES|.*/
@property(nonatomic, assign) CGFloat maxRippleRadius;

/** Set the foreground color of the ink. */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

/** Spread duration. */
@property(nonatomic, readonly, assign) NSTimeInterval spreadDuration;

/** Evaporate duration */
@property(nonatomic, readonly, assign) NSTimeInterval evaporateDuration;

/**
 Set to YES if the ink layer should be using a custom center.
 */
@property(nonatomic, assign) BOOL useCustomInkCenter;

/**
 Center point which ink gravitates towards.

 Ignored if useCustomInkCenter is not set.
 */
@property(nonatomic, assign) CGPoint customInkCenter;

/**
 Whether linear expansion should be used for the ink, rather than a Quantum curve. Useful for
 ink which needs to fill the bounds of its view completely and leave those bounds at full speed.
 */
@property(nonatomic, assign) BOOL userLinearExpansion;

/**
 Reset any ink applied to the layer.

 @param animated Enables the ink ripple fade out animation.
 */
- (void)resetAllInk:(BOOL)animated;

/**
 Spreads the ink over the whole view.

 Can be called multiple times which will result in multiple ink ripples.

 @param completionBlock Block called after the completion of the animation.
 @param point Point at which the ink spreads from.
 */
- (void)spreadFromPoint:(CGPoint)point completion:(void (^_Nullable)(void))completionBlock;

/**
 Dissipate ink blast, should be called on touch up.

 If there are multiple ripples at once, the oldest ripple will be evaporated.

 @param completionBlock Block called after the completion of the evaporation.
 */
- (void)evaporateWithCompletion:(void (^_Nullable)(void))completionBlock;

/**
 Dissipates the ink blast, but condenses to a point. Used for touch exit or cancel.

 If there are mulitple ripples, the oldest ripple will be evaporated.

 @param point Evaporate the ink towards the point.
 @param completionBlock Block called after the completion of the evaporation.
 */
- (void)evaporateToPoint:(CGPoint)point completion:(void (^_Nullable)(void))completionBlock;

@end
