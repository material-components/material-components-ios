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

#import "MDCRippleView.h"
#import "private/MDCRippleLayer.h"

#import "MaterialMath.h"

@interface MDCRippleView () <CALayerDelegate, MDCRippleLayerDelegate>

@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;
@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end

@interface MDCRipplePendingAnimation : NSObject <CAAction>

@property(nonatomic, weak) CALayer *animationSourceLayer;
@property(nonatomic, strong) NSString *keyPath;
@property(nonatomic, strong) id fromValue;
@property(nonatomic, strong) id toValue;

@end

static const CGFloat kRippleDefaultAlpha = (CGFloat)0.16;
static const CGFloat kRippleFadeOutDelay = (CGFloat)0.15;

@implementation MDCRippleView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCRippleViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCRippleViewInit];
  }
  return self;
}

- (void)commonMDCRippleViewInit {
  self.userInteractionEnabled = NO;
  self.backgroundColor = [UIColor clearColor];
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

  _rippleColor = [[UIColor alloc] initWithWhite:0 alpha:kRippleDefaultAlpha];

  _rippleStyle = MDCRippleStyleBounded;
  self.layer.masksToBounds = YES;

  // Use mask layer when the superview has a shadowPath.
  _maskLayer = [CAShapeLayer layer];
  _maskLayer.delegate = self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updateRippleStyle];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
  [super layoutSublayersOfLayer:layer];
  for (CALayer *sublayer in self.layer.sublayers) {
    sublayer.frame = CGRectStandardize(self.bounds);
    [sublayer setNeedsLayout];
  }
}

- (void)setRippleStyle:(MDCRippleStyle)rippleStyle {
  _rippleStyle = rippleStyle;
  [self updateRippleStyle];
}

- (void)updateRippleStyle {
  self.layer.masksToBounds = (self.rippleStyle == MDCRippleStyleBounded);
  if (self.rippleStyle == MDCRippleStyleBounded) {
    if (self.superview.layer.shadowPath) {
      self.maskLayer.path = self.superview.layer.shadowPath;
      self.layer.mask = _maskLayer;
    }
  } else {
    self.layer.mask = nil;
  }
}

- (void)cancelAllRipplesAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  NSArray<CALayer *> *sublayers = [self.layer.sublayers copy];
  if (animated) {
    CFTimeInterval latestBeginTouchDownRippleTime = DBL_MIN;
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        latestBeginTouchDownRippleTime =
            MAX(latestBeginTouchDownRippleTime, rippleLayer.rippleTouchDownStartTime);
      }
    }
    dispatch_group_t group = dispatch_group_create();
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        if (!rippleLayer.isStartAnimationActive) {
          rippleLayer.rippleTouchDownStartTime =
              latestBeginTouchDownRippleTime + kRippleFadeOutDelay;
        }
        dispatch_group_enter(group);
        [rippleLayer endRippleAnimated:animated
                            completion:^{
                              dispatch_group_leave(group);
                            }];
      }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
      if (completion) {
        completion();
      }
    });
  } else {
    for (CALayer *layer in sublayers) {
      if ([layer isKindOfClass:[MDCRippleLayer class]]) {
        MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
        [rippleLayer removeFromSuperlayer];
      }
    }
  }
}

- (MDCRippleLayer *)activeRippleLayer {
  if (self.layer.sublayers.count < 1) {
    return nil;
  }
  return _activeRippleLayer;
}

- (void)beginRippleTouchDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completion {
  MDCRippleLayer *rippleLayer = [MDCRippleLayer layer];
  rippleLayer.rippleLayerDelegate = self;
  rippleLayer.fillColor = self.rippleColor.CGColor;
  rippleLayer.frame = self.bounds;
  if (self.rippleStyle == MDCRippleStyleUnbounded) {
    rippleLayer.maximumRadius = self.maximumRadius;
  }
  [self.layer addSublayer:rippleLayer];
  [rippleLayer startRippleAtPoint:point animated:animated completion:completion];
  self.activeRippleLayer = rippleLayer;
}

- (void)beginRippleTouchUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer endRippleAnimated:animated completion:completion];
}

- (void)fadeInRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer fadeInRippleAnimated:animated completion:completion];
}

- (void)fadeOutRippleAnimated:(BOOL)animated completion:(MDCRippleCompletionBlock)completion {
  [self.activeRippleLayer fadeOutRippleAnimated:animated completion:completion];
}

- (void)setActiveRippleColor:(UIColor *)rippleColor {
  if (rippleColor == nil) {
    return;
  }
  self.activeRippleLayer.fillColor = rippleColor.CGColor;
}

#pragma mark - MDCRippleLayerDelegate

- (void)rippleLayerTouchDownAnimationDidBegin:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(rippleTouchDownAnimationDidBegin:)]) {
    [self.rippleViewDelegate rippleTouchDownAnimationDidBegin:self];
  }
}

- (void)rippleLayerTouchDownAnimationDidEnd:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(rippleTouchDownAnimationDidEnd:)]) {
    [self.rippleViewDelegate rippleTouchDownAnimationDidEnd:self];
  }
}

- (void)rippleLayerTouchUpAnimationDidBegin:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(rippleTouchUpAnimationDidBegin:)]) {
    [self.rippleViewDelegate rippleTouchUpAnimationDidBegin:self];
  }
}

- (void)rippleLayerTouchUpAnimationDidEnd:(MDCRippleLayer *)rippleLayer {
  if ([self.rippleViewDelegate respondsToSelector:@selector(rippleTouchUpAnimationDidEnd:)]) {
    [self.rippleViewDelegate rippleTouchUpAnimationDidEnd:self];
  }
}

#pragma mark - CALayerDelegate

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
  if ([event isEqualToString:@"path"] || [event isEqualToString:@"shadowPath"]) {
    // We have to create a pending animation because if we are inside a UIKit animation block we
    // won't know any properties of the animation block until it is commited.
    MDCRipplePendingAnimation *pendingAnim = [[MDCRipplePendingAnimation alloc] init];
    pendingAnim.animationSourceLayer = self.superview.layer;
    pendingAnim.fromValue = [layer.presentationLayer valueForKey:event];
    pendingAnim.toValue = nil;
    pendingAnim.keyPath = event;

    return pendingAnim;
  }
  return nil;
}

@end

@implementation MDCRipplePendingAnimation

- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict {
  if (![anObject isKindOfClass:[CAShapeLayer class]]) {
    return;
  }

  // In order to synchronize our animation with UIKit animations we have to fetch the resizing
  // animation created by UIKit and copy the configuration to our custom animation.
  CAShapeLayer *layer = (CAShapeLayer *)anObject;
  CAAnimation *boundsAction = [self.animationSourceLayer animationForKey:@"bounds.size"];
  BOOL isBasicAnimation = [boundsAction isKindOfClass:[CABasicAnimation class]];
  if (!isBasicAnimation) {
    NSAssert(isBasicAnimation || !boundsAction,
             @"This animation synchronization does not support a bounds size change that "
             @"isn't of a CABasicAnimation type.");
    return;
  }
  CABasicAnimation *animation = (CABasicAnimation *)[boundsAction copy];
  animation.keyPath = self.keyPath;
  animation.fromValue = self.fromValue;
  animation.toValue = self.toValue;

  [layer addAnimation:animation forKey:event];
}
@end
