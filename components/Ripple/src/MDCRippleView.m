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
#import "private/MDCRippleLayer.h"

#import "MaterialMath.h"

@interface MDCRippleView () <CALayerDelegate, MDCRippleLayerDelegate>

@property(nonatomic, strong) MDCRippleLayer *activeRippleLayer;

@end

@implementation MDCRippleView {
  CGFloat _unboundedMaxRippleRadius;
  NSMutableDictionary<NSNumber *, UIColor *> *_rippleColors;
}

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

  if (_rippleColors == nil) {
    _rippleColors = [NSMutableDictionary dictionary];
    _rippleColors[@(MDCRippleStateNormal)] = [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.16];
  }

  _rippleStyle = MDCRippleStyleBounded;
  self.layer.masksToBounds = YES;

  [self updateRippleColor];
}

- (void)setRippleColor:(UIColor *)rippleColor forState:(MDCRippleState)state {
  _rippleColors[@(state)] = rippleColor;

  [self updateRippleColor];
}

- (void)updateRippleColor {
  UIColor *rippleColor = [self rippleColorForState:self.state];
  self.activeRippleLayer.fillColor = rippleColor.CGColor;
//  self.rippleLayer.rippleColor = rippleColor;
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

  // this is for layout changes like landscape etc. should be moved to separate method.
  /**
  CGRect inkBounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  self.layer.bounds = inkBounds;

  // When bounds change ensure all ink layer bounds are changed too.
  for (CALayer *layer in self.layer.sublayers) {
    if ([layer isKindOfClass:[MDCRippleLayer class]]) {
      MDCRippleLayer *inkLayer = (MDCRippleLayer *)layer;
      inkLayer.bounds = inkBounds;
    }
  }
  */
}

- (void)setRippleStyle:(MDCRippleStyle)rippleStyle {
  _rippleStyle = rippleStyle;
  self.layer.masksToBounds = (rippleStyle == MDCRippleStyleBounded);
}

- (void)cancelAllRipplesAnimated:(BOOL)animated {
  NSArray<CALayer *> *sublayers = [self.layer.sublayers copy];
  for (CALayer *layer in sublayers) {
    if ([layer isKindOfClass:[MDCRippleLayer class]]) {
      MDCRippleLayer *rippleLayer = (MDCRippleLayer *)layer;
      if (animated) {
        [rippleLayer endRippleAnimated:animated];
      } else {
        [rippleLayer removeFromSuperlayer];
      }
    }
  }
}

- (void)BeginRipplePressDownAtPoint:(CGPoint)point
                           animated:(BOOL)animated
                         completion:(nullable MDCRippleCompletionBlock)completionBlock {
  MDCRippleLayer *rippleLayer = [MDCRippleLayer layer];
  rippleLayer.rippleColors = _rippleColors;
  rippleLayer.unboundedMaxRippleRadius = self.unboundedMaxRippleRadius;
  rippleLayer.rippleLayerDelegate = self;
  rippleLayer.frame = self.bounds;
  [self.layer addSublayer:rippleLayer];
  [rippleLayer startRippleAtPoint:point animated:animated];
  self.activeRippleLayer = rippleLayer;
}

- (void)BeginRipplePressUpAnimated:(BOOL)animated
                        completion:(nullable MDCRippleCompletionBlock)completionBlock {
  [self.activeRippleLayer endRippleAnimated:animated];
}

//+ (MDCInkView *)injectedInkViewForView:(UIView *)view {
//  MDCInkView *foundInkView = nil;
//  for (MDCInkView *subview in view.subviews) {
//    if ([subview isKindOfClass:[MDCInkView class]]) {
//      foundInkView = subview;
//      break;
//    }
//  }
//  if (!foundInkView) {
//    foundInkView = [[MDCInkView alloc] initWithFrame:view.bounds];
//    foundInkView.autoresizingMask =
//        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [view addSubview:foundInkView];
//  }
//  return foundInkView;
//}

#pragma mark - MDCRippleViewDelegate

- (void)ripplePressDownAnimationDidBegin:(MDCRippleView *)rippleView {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressDownAnimationDidBegin:)]) {
    [self.rippleViewDelegate ripplePressDownAnimationDidBegin:self];
  }
}

- (void)ripplePressDownAnimationDidEnd:(MDCRippleView *)rippleView {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressDownAnimationDidEnd:)]) {
    [self.rippleViewDelegate ripplePressDownAnimationDidEnd:self];
  }
}

- (void)ripplePressUpAnimationDidBegin:(MDCRippleView *)rippleView {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressUpAnimationDidBegin:)]) {
    [self.rippleViewDelegate ripplePressUpAnimationDidBegin:self];
  }
}

- (void)ripplePressUpAnimationDidEnd:(MDCRippleView *)rippleView {
  if ([self.rippleViewDelegate respondsToSelector:@selector(ripplePressUpAnimationDidEnd:)]) {
    [self.rippleViewDelegate ripplePressUpAnimationDidEnd:self];
  }
}

//#pragma mark - CALayerDelegate
//
//- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
//  if ([event isEqualToString:@"path"] || [event isEqualToString:@"shadowPath"]) {
//
//    // We have to create a pending animation because if we are inside a UIKit animation block we
//    // won't know any properties of the animation block until it is commited.
//    MDCInkPendingAnimation *pendingAnim = [[MDCInkPendingAnimation alloc] init];
//    pendingAnim.animationSourceLayer = self.superview.layer;
//    pendingAnim.fromValue = [layer.presentationLayer valueForKey:event];
//    pendingAnim.toValue = nil;
//    pendingAnim.keyPath = event;
//
//    return pendingAnim;
//  }
//  return nil;
//}

@end
