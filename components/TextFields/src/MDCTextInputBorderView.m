// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextInputBorderView.h"

static inline NSString *_Nullable MDCNSStringFromCGLineCap(CGLineCap lineCap) {
  NSString *lineCapString;
  switch (lineCap) {
    case kCGLineCapButt:
      lineCapString = kCALineCapButt;
      break;
    case kCGLineCapRound:
      lineCapString = kCALineCapRound;
      break;
    case kCGLineCapSquare:
      lineCapString = kCALineCapSquare;
      break;
  }
  return lineCapString;
}

static inline NSString *_Nullable MDCNSStringFromCGLineJoin(CGLineJoin lineJoin) {
  NSString *lineJoinString;
  switch (lineJoin) {
    case kCGLineJoinBevel:
      lineJoinString = kCALineJoinBevel;
      break;
    case kCGLineJoinMiter:
      lineJoinString = kCALineJoinMiter;
      break;
    case kCGLineJoinRound:
      lineJoinString = kCALineJoinRound;
      break;
  }
  return lineJoinString;
}

@interface MDCTextInputBorderView ()

@property(nonatomic, strong, readonly) CAShapeLayer *borderLayer;

@end

@implementation MDCTextInputBorderView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTextInputBorderViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCTextInputBorderViewInit];
  }
  return self;
}

- (nonnull id)copyWithZone:(nullable __unused NSZone *)zone {
  MDCTextInputBorderView *copy = [[[self class] alloc] initWithFrame:self.frame];
  copy.borderFillColor = self.borderFillColor;
  copy.borderPath = [self.borderPath copy];
  copy.borderStrokeColor = self.borderStrokeColor;

  return copy;
}

- (void)commonMDCTextInputBorderViewInit {
  _borderFillColor = _borderFillColor ? _borderFillColor : [UIColor clearColor];
  _borderStrokeColor = _borderStrokeColor ? _borderStrokeColor : [UIColor clearColor];

  self.userInteractionEnabled = NO;
  self.opaque = NO;

  self.borderLayer.backgroundColor = [UIColor clearColor].CGColor;
  self.borderLayer.contentsScale = UIScreen.mainScreen.scale;
  self.borderLayer.opaque = NO;
  self.borderLayer.rasterizationScale = self.borderLayer.contentsScale;
  self.borderLayer.shouldRasterize = YES;
  self.borderLayer.zPosition = -1;
}

- (void)updateBorder {
  self.borderLayer.fillColor = self.borderFillColor.CGColor;
  self.borderLayer.lineWidth = self.borderPath.lineWidth;
  self.borderLayer.lineCap = MDCNSStringFromCGLineCap(self.borderPath.lineCapStyle);
  self.borderLayer.lineJoin = MDCNSStringFromCGLineJoin(self.borderPath.lineJoinStyle);
  self.borderLayer.miterLimit = self.borderPath.miterLimit;
  self.borderLayer.path = self.borderPath.CGPath;
  self.borderLayer.strokeColor = self.borderStrokeColor.CGColor;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updateBorder];
}

#pragma mark - Properties

- (void)setBorderFillColor:(UIColor *)borderFillColor {
  if (![_borderFillColor isEqual:borderFillColor]) {
    _borderFillColor = borderFillColor;
    [self updateBorder];
  }
}

- (CAShapeLayer *)borderLayer {
  return (CAShapeLayer *)self.layer;
}

- (void)setBorderPath:(UIBezierPath *)borderPath {
  if (![_borderPath isEqual:borderPath]) {
    _borderPath = borderPath;
    [self updateBorder];
  }
}

- (void)setBorderStrokeColor:(UIColor *)borderStrokeColor {
  if (![_borderStrokeColor isEqual:borderStrokeColor]) {
    _borderStrokeColor = borderStrokeColor;
    [self updateBorder];
  }
}

#pragma mark - UIView Methods

+ (Class)layerClass {
  return [CAShapeLayer class];
}

@end
