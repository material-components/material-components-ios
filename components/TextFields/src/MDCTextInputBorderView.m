/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInputBorderView.h"

static NSString *const MDCTextInputBorderViewBorderFillColorKey =
    @"MDCTextInputBorderViewBorderFillColorKey";
static NSString *const MDCTextInputBorderViewBorderPathKey =
    @"MDCTextInputBorderViewBorderPathKey";
static NSString *const MDCTextInputBorderViewBorderStrokeColorKey =
    @"MDCTextInputBorderViewBorderStrokeColorKey";

static inline NSString * _Nullable MDCNSStringFromCGLineCap(CGLineCap lineCap) {
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
    default:
      break;
  }
  return lineCapString;
}

static inline  NSString *_Nullable MDCNSStringFromCGLineJoin(CGLineJoin lineJoin) {
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
    default:
      break;
  }
  return lineJoinString;
}

@interface MDCTextInputBorderView()

@property(nonatomic, strong) CAShapeLayer *borderLayer;
@property(nonatomic, strong) CAShapeLayer *borderMask;

@end

@implementation MDCTextInputBorderView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTextInputBorderViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    _borderFillColor = [coder decodeObjectForKey:MDCTextInputBorderViewBorderFillColorKey];
    _borderPath = [coder decodeObjectForKey:MDCTextInputBorderViewBorderPathKey];
    _borderStrokeColor = [coder decodeObjectForKey:MDCTextInputBorderViewBorderStrokeColorKey];
    [self commonMDCTextInputBorderViewInit];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.borderFillColor forKey:MDCTextInputBorderViewBorderFillColorKey];
  [aCoder encodeObject:self.borderPath forKey:MDCTextInputBorderViewBorderPathKey];
  [aCoder encodeObject:self.borderStrokeColor forKey:MDCTextInputBorderViewBorderStrokeColorKey];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
  MDCTextInputBorderView *copy = [[[self class] alloc] initWithFrame:self.frame];
  copy.borderFillColor = self.borderFillColor;
  copy.borderPath = self.borderPath.copy;
  copy.borderStrokeColor = self.borderStrokeColor;

  return copy;
}

- (void)commonMDCTextInputBorderViewInit {
  _borderFillColor = _borderFillColor ? _borderFillColor : [UIColor clearColor];
  _borderStrokeColor = _borderStrokeColor ? _borderStrokeColor : [UIColor clearColor];
  self.layer.mask = self.borderMask;

  self.userInteractionEnabled = NO;
  self.opaque = NO;

  _borderLayer.backgroundColor = [UIColor clearColor].CGColor;
  _borderLayer.contentsScale = UIScreen.mainScreen.scale;
  _borderLayer.opaque = NO;
  _borderLayer.rasterizationScale = _borderLayer.contentsScale;
  _borderLayer.shouldRasterize = YES;
  _borderLayer.zPosition = -1.f;
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

#pragma mark - UIView Methods

+ (Class)layerClass {
  return [CAShapeLayer class];
}

#pragma mark - Mask Implementation

- (CAShapeLayer *)borderMask {
  if (!_borderMask) {
    _borderMask = [CAShapeLayer layer];
  }

  return _borderMask;
}

@end
