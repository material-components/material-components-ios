/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCardView.h"
#import "private/MDCCardView+Private.h"

@implementation MDCCardView {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCCardViewInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCardViewInit];
  }
  return self;
}

- (void)commonMDCCardViewInit {
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _inkView.usesLegacyInkRipple = NO;
  _inkView.layer.zPosition = MAXFLOAT;
  [self addSubview:self.inkView];

  self.cornerRadius = 4.f;

  _state = MDCCardViewStateNormal;

  _shadowElevations = [[NSMutableDictionary alloc] init];
  _shadowElevations[@(MDCCardViewStateNormal)] = @(1.f);
  _shadowElevations[@(MDCCardViewStateHighlighted)] = @(8.f);
  [self updateShadowElevation];

  _shadowColors = [[NSMutableDictionary alloc] init];
  _shadowColors[@(MDCCardViewStateNormal)] = [UIColor blackColor];
  _shadowColors[@(MDCCardViewStateHighlighted)] = [UIColor blackColor];
  [self updateShadowColor];

  _borderColors = [[NSMutableDictionary alloc] init];
  _borderColors[@(MDCCardViewStateNormal)] = [UIColor clearColor];
  _borderColors[@(MDCCardViewStateHighlighted)] = [UIColor clearColor];
  [self updateBorderColor];

  _borderWidths = [[NSMutableDictionary alloc] init];
  _borderWidths[@(MDCCardViewStateNormal)] = @(1.f);
  _borderWidths[@(MDCCardViewStateHighlighted)] = @(0.f);
  [self updateBorderWidth];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [self boundingPath].CGPath;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setStyleForState:(MDCCardViewState)state
         withLocation:(CGPoint)location {
  _state = state;
  switch (state) {
    case MDCCardViewStateNormal: {
      [self.inkView startTouchEndedAnimationAtPoint:location completion:nil];
      break;
    }
    case MDCCardViewStateHighlighted: {
      [self.inkView startTouchBeganAnimationAtPoint:location completion:nil];
      break;
    }
    default:
      break;
  }
  [self updateShadowElevation];
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

- (CGFloat)shadowElevationForState:(MDCCardViewState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (elevation == nil) {
    elevation = _shadowElevations[@(MDCCardViewStateNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setShadowElevation:(CGFloat)shadowElevation forState:(MDCCardViewState)state {
  _shadowElevations[@(state)] = @(shadowElevation);

  [self updateShadowElevation];
}

- (void)updateShadowElevation {
  CGFloat elevation = [self shadowElevationForState:self.state];
  if (((MDCShadowLayer *)self.layer).elevation != elevation) {
    self.layer.shadowPath = [self boundingPath].CGPath;
    [(MDCShadowLayer *)self.layer setElevation:elevation];
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardViewState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  CGFloat borderWidth = [self borderWidthForState:self.state];
  self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidthForState:(MDCCardViewState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (borderWidth == nil) {
    borderWidth = _borderWidths[@(MDCCardViewStateNormal)];
  }
  if (borderWidth != nil) {
    return (CGFloat)[borderWidth doubleValue];
  }
  return 0;
}

- (void)setBorderColor:(UIColor *)borderColor forState:(MDCCardViewState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

- (void)updateBorderColor {
  CGColorRef borderColorRef = [self borderColorForState:self.state].CGColor;
  self.layer.borderColor = borderColorRef;
}

- (UIColor *)borderColorForState:(MDCCardViewState)state {
  UIColor *borderColor = _borderColors[@(state)];
  if (borderColor == nil) {
    borderColor = _borderColors[@(MDCCardViewStateNormal)];
  }
  if (borderColor != nil) {
    return borderColor;
  }
  return [UIColor clearColor];
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(MDCCardViewState)state {
  _shadowColors[@(state)] = shadowColor;

  [self updateShadowColor];
}

- (void)updateShadowColor {
  CGColorRef shadowColor = [self shadowColorForState:self.state].CGColor;
  self.layer.shadowColor = shadowColor;
}

- (UIColor *)shadowColorForState:(MDCCardViewState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (shadowColor == nil) {
    shadowColor = _shadowColors[@(MDCCardViewStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor clearColor];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self setStyleForState:MDCCardViewStateHighlighted withLocation:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self setStyleForState:MDCCardViewStateNormal withLocation:location];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  [self setStyleForState:MDCCardViewStateNormal withLocation:location];
}

@end
