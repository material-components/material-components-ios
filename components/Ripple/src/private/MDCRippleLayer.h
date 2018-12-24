// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

typedef NS_ENUM(NSInteger, MDCRippleState) {
  MDCRippleStateNormal = 0, // No Ripple
  MDCRippleStateHighlighted, // Ripple has been triggered
  MDCRippleStateSelected, // Ripple has spread and is staying
};

@protocol MDCRippleLayerDelegate;

@interface MDCRippleLayer : CAShapeLayer

@property(nonatomic, weak, nullable) id<MDCRippleLayerDelegate> rippleLayerDelegate;

@property(nonatomic, assign, readonly, getter=isStartAnimationActive) BOOL startAnimationActive;

@property(nonatomic, assign) CGFloat endAnimationDelay;

@property(nonatomic, assign) CGFloat finalRadius;

@property(nonatomic, assign) CGFloat initialRadius;

@property(nonatomic, assign) CGFloat maxRippleRadius;

@property(nonatomic, strong, nonnull) NSDictionary<NSNumber *, UIColor *> *rippleColors;

/**
 Starts the ink ripple animation at a specified point.
 */
- (void)startAnimationAtPoint:(CGPoint)point;

/**
 Starts the ink ripple

 @param point the point where to start the ink ripple
 @param animated if to animate the ripple or not
 */
- (void)startRippleAtPoint:(CGPoint)point animated:(BOOL)animated;

/**
 Ends the ink ripple animation.
 */
- (void)endAnimation;


/**
 Ends the ink ripple

 */
- (void)endRippleAnimated:(BOOL)animated;

@end

/**
 Delegate protocol for the MDCInkLayer. Clients may implement this protocol to receive updates when
 ink layer animations start and end.
 */
@protocol MDCRippleLayerDelegate <CALayerDelegate>

@optional

/**
 Called when the ink ripple animation begins.

 */
- (void)rippleLayerAnimationDidStart:(nonnull MDCRippleLayer *)rippleLayer;

/**
 Called when the ink ripple animation ends.

 */
- (void)rippleLayerAnimationDidEnd:(nonnull MDCRippleLayer *)rippleLayer;

@end
