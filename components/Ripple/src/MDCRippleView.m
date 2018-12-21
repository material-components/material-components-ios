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

#import "MDCRippleView.h"

#import "MaterialMath.h"
//#import "private/MDCRippleLayer.h"

@interface MDCRippleView () <CALayerDelegate, MDCRippleLayerDelegate>

@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;

@end

@implementation MDCRippleView {
  CGFloat _unboundedMaxRippleRadius;
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
}

//+ (Class)layerClass {
//  return [MDCLegacyInkLayer class];
//}

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
  self.layer.delegate = self;

  if (_rippleColors == nil) {
    _rippleColors = [NSMutableDictionary dictionary];
    _rippleColors[@(MDCRippleStateNormal)] = [UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.14];
  }

  [self updateRippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

- (void)updateRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  self.rippleLayer.rippleColor = rippleColor;
}

- (UIColor *)rippleColorForState:(MDCRippleState)state {
  UIColor *rippleColor = _rippleColors[@(state)];
  if (state != MDCRippleStateNormal && rippleColor == nil) {
    rippleColor = _rippleColors[@(MDCRippleStateNormal)];
  }
  return rippleColor;
}

- (void)layoutSubviews {
  [super layoutSubviews];

//  CGRect inkBounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
//  self.layer.bounds = inkBounds;
//
//  // When bounds change ensure all ink layer bounds are changed too.
//  for (CALayer *layer in self.layer.sublayers) {
//    if ([layer isKindOfClass:[MDCInkLayer class]]) {
//      MDCInkLayer *inkLayer = (MDCInkLayer *)layer;
//      inkLayer.bounds = inkBounds;
//    }
//  }
}

- (void)setRippleStyle:(MDCRippleStyle)rippleStyle {
  _rippleStyle = rippleStyle;
  switch(inkStyle) {
    case MDCRippleStyleBounded:
//      self.inkLayer.maxRippleRadius = 0;
      break;
    case MDCRippleStyleUnbounded:
//      self.inkLayer.maxRippleRadius = _maxRippleRadius;
      break;
  }
}

- (CGFloat)unboundedMaxRippleRadius {
//  return self.inkLayer.maxRippleRadius;
}

- (void)setUnboundedMaxRippleRadius:(CGFloat)unboundedMaxRippleRadius {
  _maxRippleRadius = unboundedMaxRippleRadius;
//  if (MDCCGFloatEqual(self.inkLayer.maxRippleRadius, radius)) {
//    return;
//  }

  switch(self.inkStyle) {
    case MDCRippleStyleUnbounded:
//      self.inkLayer.maxRippleRadius = radius;
      break;
    case MDCRippleStyleBounded:
      // No-op
      break;
  }
}

- (void)cancelAllRipplesAnimated:(BOOL)animated {
  NSArray<CALayer *> *sublayers = [self.layer.sublayers copy];
  for (CALayer *layer in sublayers) {
    if ([layer isKindOfClass:[MDCInkLayer class]]) {
      MDCInkLayer *inkLayer = (MDCInkLayer *)layer;
      if (animated) {
        [inkLayer endAnimationAtPoint:CGPointZero];
      } else {
        [inkLayer removeFromSuperlayer];
      }
    }
  }
}

- (void)BeginRipplePressDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completionBlock {
  self.startInkRippleCompletionBlock = completionBlock;
  MDCInkLayer *inkLayer = [MDCInkLayer layer];
  inkLayer.inkColor = self.inkColor;
  inkLayer.maxRippleRadius = self.maxRippleRadius;
  inkLayer.animationDelegate = self;
  inkLayer.opacity = 0;
  inkLayer.frame = self.bounds;
  [self.layer addSublayer:inkLayer];
  [inkLayer startInkAtPoint:point animated:animated];
  self.activeInkLayer = inkLayer;
}

- (void)BeginRipplePressUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completionBlock {
  self.endInkRippleCompletionBlock = completionBlock;
  [self.activeInkLayer endInkAtPoint:point animated:animated];
}

+ (MDCInkView *)injectedInkViewForView:(UIView *)view {
  MDCInkView *foundInkView = nil;
  for (MDCInkView *subview in view.subviews) {
    if ([subview isKindOfClass:[MDCInkView class]]) {
      foundInkView = subview;
      break;
    }
  }
  if (!foundInkView) {
    foundInkView = [[MDCInkView alloc] initWithFrame:view.bounds];
    foundInkView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:foundInkView];
  }
  return foundInkView;
}

#pragma mark - MDCInkLayerDelegate

- (void)inkLayerAnimationDidStart:(MDCInkLayer *)inkLayer {
  if (self.activeInkLayer == inkLayer && self.startInkRippleCompletionBlock) {
    self.startInkRippleCompletionBlock();
  }
  if ([self.animationDelegate respondsToSelector:@selector(inkAnimationDidStart:)]) {
    [self.animationDelegate inkAnimationDidStart:self];
  }
}

- (void)inkLayerAnimationDidEnd:(MDCInkLayer *)inkLayer {
  if (self.activeInkLayer == inkLayer && self.endInkRippleCompletionBlock) {
    self.endInkRippleCompletionBlock();
  }
  if ([self.animationDelegate respondsToSelector:@selector(inkAnimationDidEnd:)]) {
    [self.animationDelegate inkAnimationDidEnd:self];
  }
}

#pragma mark - CALayerDelegate

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
  if ([event isEqualToString:@"path"] || [event isEqualToString:@"shadowPath"]) {

    // We have to create a pending animation because if we are inside a UIKit animation block we
    // won't know any properties of the animation block until it is commited.
    MDCInkPendingAnimation *pendingAnim = [[MDCInkPendingAnimation alloc] init];
    pendingAnim.animationSourceLayer = self.superview.layer;
    pendingAnim.fromValue = [layer.presentationLayer valueForKey:event];
    pendingAnim.toValue = nil;
    pendingAnim.keyPath = event;

    return pendingAnim;
  }
  return nil;
}

@end
