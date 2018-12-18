// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

@protocol MDCInkLayerDelegate;

/**
 A Core Animation layer that draws and animates the ink effect.

 Quick summary of how the ink ripple works:

 1. On touch down, ink spreads from the touch point.
 2. On touch down hold, ink continues to spread, but will gravitate to the center point
    of the view.
 3. On touch up, the ink ripple opacity will start to decrease.
 */
@interface MDCInkLayer : CAShapeLayer

/**
 Ink layer animation delegate. Clients set this delegate to receive updates when ink layer
 animations start and end.
 */
@property(nonatomic, weak, nullable) id<MDCInkLayerDelegate> animationDelegate;

/**
 The start ink ripple spread animation has started and is active.
 */
@property(nonatomic, assign, readonly, getter=isStartAnimationActive) BOOL startAnimationActive;

/**
 Delay time in milliseconds before the end ink ripple spread animation begins.
 */
@property(nonatomic, assign) CGFloat endAnimationDelay;

/**
 The radius the ink ripple grows to when ink ripple ends.

 Default value is half the diagonal of the containing frame plus 10pt.
 */
@property(nonatomic, assign) CGFloat finalRadius;

/**
 The radius the ink ripple starts to grow from when the ink ripple begins.

 Default value is half the diagonal of the containing frame multiplied by 0.6.
 */
@property(nonatomic, assign) CGFloat initialRadius;

/**
 Maximum radius of the ink. If this is not set then the final radius value is used.
 */
@property(nonatomic, assign) CGFloat maxRippleRadius;

/**
 The color of the ink ripple.
 */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

/**
 Starts the ink ripple animation at a specified point.
 */
- (void)startAnimationAtPoint:(CGPoint)point;


/**
 Starts the ink ripple

 @param point the point where to start the ink ripple
 @param animated if to animate the ripple or not
 */
- (void)startInkAtPoint:(CGPoint)point animated:(BOOL)animated;

/**
 Changes the opacity of the ink ripple depending on if touch point is contained within or
 outside of the ink layer.
 */
- (void)changeAnimationAtPoint:(CGPoint)point;

/**
 Ends the ink ripple animation.
 */
- (void)endAnimationAtPoint:(CGPoint)point;


/**
 Ends the ink ripple

 @param point the point where to end the ink ripple
 @param animated if to animate the ripple or not
 */
- (void)endInkAtPoint:(CGPoint)point animated:(BOOL)animated;

@end

/**
 Delegate protocol for the MDCInkLayer. Clients may implement this protocol to receive updates when
 ink layer animations start and end.
 */
@protocol MDCInkLayerDelegate <CALayerDelegate>

@optional

/**
 Called when the ink ripple animation begins.

 @param inkLayer The MDCInkLayer that starts animating.
 */
- (void)inkLayerAnimationDidStart:(nonnull MDCInkLayer *)inkLayer;

/**
 Called when the ink ripple animation ends.

 @param inkLayer The MDCInkLayer that ends animating.
 */
- (void)inkLayerAnimationDidEnd:(nonnull MDCInkLayer *)inkLayer;

@end
