/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

/** Completion block signature for all ink animations. */
typedef void (^MDCInkCompletionBlock)();

/** A UIView that draws and animates the material design ink effect. */
@interface MDCInkView : UIView

/** The foreground color of the ink. Default is white with 25% opacity. */
@property(nonatomic, strong, null_resettable) UIColor *inkColor;

/**
 Maximum radius of the ink. If the radius <= 0 then the hypotenuse of self.bounds is used.
 The default is 150pt.
 */
@property(nonatomic, assign) CGFloat maxRippleRadius;

/**
 Should fill background on spreading.

 Set to YES if using the ink in borderless views. Default is YES.
 */
@property(nonatomic, assign) BOOL fillsBackgroundOnSpread;

/** Whether to clip ink ripple to bounds. Defaults to YES. */
@property(nonatomic, assign) BOOL clipsRippleToBounds;

/** Gravitate ink to the center of the view. Default is YES. */
@property(nonatomic, assign) BOOL gravitatesInk;

/**
 Use a custom center for the ink splash. If YES, then customInkCenter is used, otherwise the
 center of self.bounds is used. Default is NO.
 */
@property(nonatomic, assign) BOOL usesCustomInkCenter;

/**
 Custom center for the ink splash in the view’s coordinate system.

 Ignored if usesCustomInkCenter is not set.
 */
@property(nonatomic, assign) CGPoint customInkCenter;

/**
 Reset any ink applied to the view without animation. See evaporateWithCompletion: and
 evaporateToPoint:completion: for animated versions.
 */
- (void)reset;

/**
 Spreads the ink over the whole view.

 Can be called multiple times which will result in multiple ink splashes. Each splash will exist
 until one of the evaporate* methods are called.

 @param completionBlock Block called after the completion of the animation.
 @param point Point from which the ink spreads in the view’s coordinate system.
 */
- (void)spreadFromPoint:(CGPoint)point completion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Dissipate the last ink splash; should be called on touch up.

 If there are multiple ripples at once, the oldest ripple will be evaporated.

 @param completionBlock Block called after the completion of the evaporation.
 */
- (void)evaporateWithCompletion:(nullable MDCInkCompletionBlock)completionBlock;

/**
 Dissipates the last ink splash while condensing down to a point. Used for touch exit or cancel.

 If there are multiple ripples, the oldest ripple will be evaporated.

 @param point Evaporate the ink towards the point.
 @param completionBlock Block called after the completion of the evaporation.
 */
- (void)evaporateToPoint:(CGPoint)point completion:(nullable MDCInkCompletionBlock)completionBlock;

@end
