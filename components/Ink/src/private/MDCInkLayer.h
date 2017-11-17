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

@protocol MDCInkLayerDelegate;

@interface MDCInkLayer : CAShapeLayer

/**
 Ink layer animation delegate.
 */
@property(nonatomic, weak) id<MDCInkLayerDelegate> animationDelegate;

/**
 The start ink ripple spread animation has started and is active.
 */
@property(nonatomic, assign) BOOL startAnimationActive;

/**
 Delay time in milliseconds before the end ink ripple spread animation begins.
 */
@property(nonatomic, assign) CGFloat endAnimationDelay;

/**
 The radius the ink ripple grows to when ink ripple ends.
 */
@property(nonatomic, assign) CGFloat finalRadius;

/**
 The radius the ink ripple starts to grow from when the ink ripple begins.
 */
@property(nonatomic, assign) CGFloat initialRadius;

/**
 The color of the ink ripple.
 */
@property(nonatomic, strong) UIColor *inkColor;

/**
 Starts the ink ripple animation at a specified point.
 */
- (void)startAnimationAtPoint:(CGPoint)point;

/**
 Changes the opacity of the ink ripple depending on if touch point is contained within or
 outside of the ink layer.
 */
- (void)changeAnimationAtPoint:(CGPoint)point;

/**
 Ends the ink ripple animation.
 */
- (void)endAnimationAtPoint:(CGPoint)point;

@end

/**
 Delegate protocol for the MDCInkLayer.
 */
@protocol MDCInkLayerDelegate <CALayerDelegate>

@optional

/**
 Called when the ink ripple animation begins.
 
 @param inkLayer The MDCInkLayer that starts animating.
 */
- (void)inkLayerAnimationDidStart:(MDCInkLayer *)inkLayer;

/**
 Called when the ink ripple animation ends.
 
 @param inkLayer The MDCInkLayer that ends animating.
 */
- (void)inkLayerAnimationDidEnd:(MDCInkLayer *)inkLayer;

@end

