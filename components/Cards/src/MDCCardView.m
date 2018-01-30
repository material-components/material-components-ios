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

  _shadowElevations = [[NSMutableDictionary alloc] init];
  _shadowElevations[@(MDCCardViewStateNormal)] = @(1.f);
  _shadowElevations[@(MDCCardViewStateHighlighted)] = @(8.f);
  _state = MDCCardViewStateNormal;
  [self updateShadowElevation];
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
    if (elevation < 0) {
      self.layer.borderWidth = 1.f;
      self.layer.borderColor =
        [UIColor colorWithRed:218/255.0 green:220/255.0 blue:224/255.0 alpha:1].CGColor;
    } else {
      self.layer.borderWidth = 0.f;
    }
    CGFloat elevationNormalized = elevation < 0 ? 0 : elevation;
    self.layer.shadowPath = [self boundingPath].CGPath;
    [(MDCShadowLayer *)self.layer setElevation:elevationNormalized];
  }
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
