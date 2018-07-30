/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCInkView.h"

#import "MaterialMath.h"
#import "private/MDCInkLayer.h"
#import "private/MDCLegacyInkLayer.h"

@interface MDCInkPendingAnimation : NSObject <CAAction>

@property(nonatomic, weak) CALayer *animationSourceLayer;
@property(nonatomic, strong) NSString *keyPath;
@property(nonatomic, strong) id fromValue;
@property(nonatomic, strong) id toValue;

@end

@interface MDCInkView () <CALayerDelegate, MDCInkLayerDelegate>

@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, copy) MDCInkCompletionBlock startInkRippleCompletionBlock;
@property(nonatomic, copy) MDCInkCompletionBlock endInkRippleCompletionBlock;
@property(nonatomic, strong) MDCInkLayer *activeInkLayer;

// Legacy ink ripple
@property(nonatomic, readonly) MDCLegacyInkLayer *inkLayer;

@end

@implementation MDCInkView {
  CGFloat _maxRippleRadius;
}

+ (Class)layerClass {
  return [MDCLegacyInkLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCInkViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCInkViewInit];
  }
  return self;
}

- (void)commonMDCInkViewInit {
  self.userInteractionEnabled = NO;
  self.backgroundColor = [UIColor clearColor];
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  self.layer.delegate = self;
  self.inkColor = self.defaultInkColor;
  _usesLegacyInkRipple = YES;

  // Use mask layer when the superview has a shadowPath.
  _maskLayer = [CAShapeLayer layer];
  _maskLayer.delegate = self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // If the superview has a shadowPath make sure ink does not spread outside of the shadowPath.
  if (self.superview.layer.shadowPath) {
    self.maskLayer.path = self.superview.layer.shadowPath;
    self.layer.mask = _maskLayer;
  }

  CGRect inkBounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  self.layer.bounds = inkBounds;

  // When bounds change ensure all ink layer bounds are changed too.
  for (CALayer *layer in self.layer.sublayers) {
    if ([layer isKindOfClass:[MDCInkLayer class]]) {
      MDCInkLayer *inkLayer = (MDCInkLayer *)layer;
      inkLayer.bounds = inkBounds;
    }
  }
}

- (void)setInkStyle:(MDCInkStyle)inkStyle {
  _inkStyle = inkStyle;
  if (self.usesLegacyInkRipple) {
    switch (inkStyle) {
      case MDCInkStyleBounded:
        self.inkLayer.masksToBounds = YES;
        self.inkLayer.bounded = YES;
        break;
      case MDCInkStyleUnbounded:
        self.inkLayer.masksToBounds = NO;
        self.inkLayer.bounded = NO;
        break;
    }
  } else {
    switch(inkStyle) {
      case MDCInkStyleBounded:
        self.inkLayer.maxRippleRadius = 0;
        break;
      case MDCInkStyleUnbounded:
        self.inkLayer.maxRippleRadius = _maxRippleRadius;
        break;
    }
  }
}

- (void)setInkColor:(UIColor *)inkColor {
  if (inkColor == nil) {
    return;
  }
  self.inkLayer.inkColor = inkColor;
}

- (UIColor *)inkColor {
  return self.inkLayer.inkColor;
}

- (CGFloat)maxRippleRadius {
  return self.inkLayer.maxRippleRadius;
}

- (void)setMaxRippleRadius:(CGFloat)radius {
  // Keep track of the set value in case the caller will change inkStyle later
  _maxRippleRadius = radius;
  if (MDCCGFloatEqual(self.inkLayer.maxRippleRadius, radius)) {
    return;
  }

  // Legacy Ink updates inkLayer.maxRippleRadius regardless of inkStyle
  if (self.usesLegacyInkRipple) {
    self.inkLayer.maxRippleRadius = radius;
    // This is required for legacy Ink so that the Ink bounds will be adjusted correctly
    [self setNeedsLayout];
  } else {
    // New Ink Bounded style ignores maxRippleRadius
    switch(self.inkStyle) {
      case MDCInkStyleUnbounded:
        self.inkLayer.maxRippleRadius = radius;
        break;
      case MDCInkStyleBounded:
        // No-op
        break;
    }
  }
}

- (BOOL)usesCustomInkCenter {
  return self.inkLayer.useCustomInkCenter;
}

- (void)setUsesCustomInkCenter:(BOOL)usesCustomInkCenter {
  self.inkLayer.useCustomInkCenter = usesCustomInkCenter;
}

- (CGPoint)customInkCenter {
  return self.inkLayer.customInkCenter;
}

- (void)setCustomInkCenter:(CGPoint)customInkCenter {
  self.inkLayer.customInkCenter = customInkCenter;
}

- (MDCLegacyInkLayer *)inkLayer {
  return (MDCLegacyInkLayer *)self.layer;
}

- (void)startTouchBeganAnimationAtPoint:(CGPoint)point
                             completion:(MDCInkCompletionBlock)completionBlock {
  [self startTouchBeganAtPoint:point animated:YES withCompletion:completionBlock];
}

- (void)startTouchBeganAtPoint:(CGPoint)point animated:(BOOL)animated
                withCompletion:(nullable MDCInkCompletionBlock)completionBlock {
  if (self.usesLegacyInkRipple) {
    [self.inkLayer spreadFromPoint:point completion:completionBlock];
  } else {
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
}

- (void)startTouchEndAtPoint:(CGPoint)point animated:(BOOL)animated
              withCompletion:(nullable MDCInkCompletionBlock)completionBlock {
  if (self.usesLegacyInkRipple) {
    [self.inkLayer evaporateWithCompletion:completionBlock];
  } else {
    self.endInkRippleCompletionBlock = completionBlock;
    [self.activeInkLayer endInkAtPoint:point animated:animated];
  }
}

- (void)startTouchEndedAnimationAtPoint:(CGPoint)point
                             completion:(MDCInkCompletionBlock)completionBlock {
  [self startTouchEndAtPoint:point animated:YES withCompletion:completionBlock];
}

- (void)cancelAllAnimationsAnimated:(BOOL)animated {
  if (self.usesLegacyInkRipple) {
    [self.inkLayer resetAllInk:animated];
  } else {
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
}

- (UIColor *)defaultInkColor {
  return [[UIColor alloc] initWithWhite:0 alpha:0.14f];
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

@implementation MDCInkPendingAnimation

- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict {
  if ([anObject isKindOfClass:[CAShapeLayer class]]) {
    CAShapeLayer *layer = (CAShapeLayer *)anObject;

    // In order to synchronize our animation with UIKit animations we have to fetch the resizing
    // animation created by UIKit and copy the configuration to our custom animation.
    CAAnimation *boundsAction = [self.animationSourceLayer animationForKey:@"bounds.size"];
    if ([boundsAction isKindOfClass:[CABasicAnimation class]]) {
      CABasicAnimation *animation = (CABasicAnimation *)[boundsAction copy];
      animation.keyPath = self.keyPath;
      animation.fromValue = self.fromValue;
      animation.toValue = self.toValue;

      [layer addAnimation:animation forKey:event];
    }
  }
}

@end
