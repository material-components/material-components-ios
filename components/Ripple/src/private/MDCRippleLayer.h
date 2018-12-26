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
#import "MDCRippleState.h"

typedef void (^MDCRippleCompletionBlock)(void);

@protocol MDCRippleLayerDelegate;

@interface MDCRippleLayer : CAShapeLayer

@property(nonatomic, weak, nullable) id<MDCRippleLayerDelegate> rippleLayerDelegate;

@property(nonatomic, assign, readonly, getter=isStartAnimationActive) BOOL startAnimationActive;

@property(nonatomic, assign) CGFloat finalRadius;

@property(nonatomic, assign) CGFloat unboundedMaxRippleRadius;

@property (nonatomic, readonly) MDCRippleState state;

@property(nonatomic, strong, nonnull) NSDictionary<NSNumber *, UIColor *> *rippleColors;

@property (nonatomic) BOOL allowsSelection;


- (void)startRippleAtPoint:(CGPoint)point
                  animated:(BOOL)animated
                completion:(nullable MDCRippleCompletionBlock)completion;
- (void)endRippleAnimated:(BOOL)animated completion:(nullable MDCRippleCompletionBlock)completion;

@end

@protocol MDCRippleLayerDelegate <CALayerDelegate>
- (void)rippleLayerPressDownAnimationDidBegin:(nonnull MDCRippleLayer *)rippleLayer;
- (void)rippleLayerPressDownAnimationDidEnd:(nonnull MDCRippleLayer *)rippleLayer;
- (void)rippleLayerPressUpAnimationDidBegin:(nonnull MDCRippleLayer *)rippleLayer;
- (void)rippleLayerPressUpAnimationDidEnd:(nonnull MDCRippleLayer *)rippleLayer;


@end
