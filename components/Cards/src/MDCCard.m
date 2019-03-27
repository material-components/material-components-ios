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

#import "MDCCard.h"

#import "MaterialMath.h"
#import "MaterialShapes.h"

static const CGFloat MDCCardShadowElevationNormal = 1;
static const CGFloat MDCCardShadowElevationHighlighted = 8;
static const CGFloat MDCCardCornerRadiusDefault = 4;
static const BOOL MDCCardIsInteractableDefault = YES;

@interface MDCCard ()
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;
@end

@implementation MDCCard {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  UIColor *_backgroundColor;
  CGPoint _lastTouch;
}

@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCCardInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCardInit];
  }
  return self;
}

- (void)commonMDCCardInit {
  self.layer.cornerRadius = MDCCardCornerRadiusDefault;
  _interactable = MDCCardIsInteractableDefault;

  if (_inkView == nil) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.layer.zPosition = FLT_MAX;
    [self addSubview:_inkView];
  }

  if (_shadowElevations == nil) {
    _shadowElevations = [NSMutableDictionary dictionary];
    _shadowElevations[@(UIControlStateNormal)] = @(MDCCardShadowElevationNormal);
    _shadowElevations[@(UIControlStateHighlighted)] = @(MDCCardShadowElevationHighlighted);
  }

  if (_shadowColors == nil) {
    _shadowColors = [NSMutableDictionary dictionary];
    _shadowColors[@(UIControlStateNormal)] = UIColor.blackColor;
  }

  if (_borderColors == nil) {
    _borderColors = [NSMutableDictionary dictionary];
  }

  if (_borderWidths == nil) {
    _borderWidths = [NSMutableDictionary dictionary];
  }

  if (_backgroundColor == nil) {
    _backgroundColor = UIColor.whiteColor;
  }

  [self updateShadowElevation];
  [self updateShadowColor];
  [self updateBorderWidth];
  [self updateBorderColor];
  [self updateBackgroundColor];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (!self.layer.shapeGenerator) {
    self.layer.shadowPath = [self boundingPath].CGPath;
  }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

- (MDCShadowElevation)shadowElevationForState:(UIControlState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (state != UIControlStateNormal && elevation == nil) {
    elevation = _shadowElevations[@(UIControlStateNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(UIControlState)state {
  _shadowElevations[@(state)] = @(shadowElevation);

  [self updateShadowElevation];
}

- (void)updateShadowElevation {
  CGFloat elevation = [self shadowElevationForState:self.state];
  if (!MDCCGFloatEqual(((MDCShadowLayer *)self.layer).elevation, elevation)) {
    if (!self.layer.shapeGenerator) {
      self.layer.shadowPath = [self boundingPath].CGPath;
    }
    [(MDCShadowLayer *)self.layer setElevation:elevation];
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  CGFloat borderWidth = [self borderWidthForState:self.state];
  self.layer.shapedBorderWidth = borderWidth;
}

- (CGFloat)borderWidthForState:(UIControlState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (state != UIControlStateNormal && borderWidth == nil) {
    borderWidth = _borderWidths[@(UIControlStateNormal)];
  }
  if (borderWidth != nil) {
    return (CGFloat)[borderWidth doubleValue];
  }
  return 0;
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

- (void)updateBorderColor {
  UIColor *borderColor = [self borderColorForState:self.state];
  self.layer.shapedBorderColor = borderColor;
}

- (UIColor *)borderColorForState:(UIControlState)state {
  UIColor *borderColor = _borderColors[@(state)];
  if (state != UIControlStateNormal && borderColor == nil) {
    borderColor = _borderColors[@(UIControlStateNormal)];
  }
  return borderColor;
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(UIControlState)state {
  _shadowColors[@(state)] = shadowColor;

  [self updateShadowColor];
}

- (void)updateShadowColor {
  CGColorRef shadowColor = [self shadowColorForState:self.state].CGColor;
  self.layer.shadowColor = shadowColor;
}

- (UIColor *)shadowColorForState:(UIControlState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (state != UIControlStateNormal && shadowColor == nil) {
    shadowColor = _shadowColors[@(UIControlStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor blackColor];
}

- (void)setHighlighted:(BOOL)highlighted {
  // Original logic for changing the state to highlighted.
  if (self.rippleView == nil) {
    if (highlighted && !self.highlighted) {
      [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
    } else if (!highlighted && self.highlighted) {
      [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
    }
  }
  [super setHighlighted:highlighted];
  // Updated logic using Ripple for changing the state to highlighted.
  if (self.rippleView) {
    self.rippleView.rippleHighlighted = highlighted;
  }

  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
  BOOL beginTracking = [super beginTrackingWithTouch:touch withEvent:event];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;
  return beginTracking;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  if (!_interactable && result == self) {
    return nil;
  }
  if (self.layer.shapeGenerator) {
    if (!CGPathContainsPoint(self.layer.shapeLayer.path, nil, point, true)) {
      return nil;
    }
  }
  return result;
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  if (shapeGenerator) {
    self.layer.shadowPath = nil;
  } else {
    self.layer.shadowPath = [self boundingPath].CGPath;
  }

  self.layer.shapeGenerator = shapeGenerator;
  self.layer.shadowMaskEnabled = NO;
  [self updateBackgroundColor];
  // Original logic for configuring Ink prior to the Ripple integration.
  if (self.rippleView == nil) {
    [self updateInkForShape];
  }
}

- (id<MDCShapeGenerating>)shapeGenerator {
  return self.layer.shapeGenerator;
}

- (void)updateInkForShape {
  CGRect boundingBox = CGPathGetBoundingBox(self.layer.shapeLayer.path);
  self.inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(CGRectGetHeight(boundingBox), CGRectGetWidth(boundingBox)) / 2 + 10);
  self.inkView.layer.masksToBounds = NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  _backgroundColor = backgroundColor;
  [self updateBackgroundColor];
}

- (UIColor *)backgroundColor {
  return _backgroundColor;
}

- (void)updateBackgroundColor {
  self.layer.shapedBackgroundColor = _backgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (self.rippleView) {
    [self.rippleView touchesBegan:touches withEvent:event];
  }
  [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // The ripple invocation must come before touchesMoved of the super, otherwise the setHighlighted
  // of the UIControl will be triggered before the ripple identifies that the highlighted was
  // trigerred from a long press entering the view and shouldn't invoke a ripple.
  if (self.rippleView) {
    [self.rippleView touchesMoved:touches withEvent:event];
  }
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (self.rippleView) {
    [self.rippleView touchesEnded:touches withEvent:event];
  }
  [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (self.rippleView) {
    [self.rippleView touchesCancelled:touches withEvent:event];
  }
  [super touchesCancelled:touches withEvent:event];
}

- (void)setEnableRippleBehavior:(BOOL)enableRippleBehavior {
  if (enableRippleBehavior == _enableRippleBehavior) {
    return;
  }
  _enableRippleBehavior = enableRippleBehavior;
  if (enableRippleBehavior) {
    if (_rippleView == nil) {
      _rippleView = [[MDCStatefulRippleView alloc] initWithFrame:self.bounds];
      _rippleView.layer.zPosition = FLT_MAX;
      [self addSubview:_rippleView];
    }
    if (_inkView) {
      [_inkView removeFromSuperview];
      _inkView = nil;
    }
  } else {
    if (_rippleView) {
      [_rippleView removeFromSuperview];
      _rippleView = nil;
    }
    [self addSubview:_inkView];
  }
}

@end
