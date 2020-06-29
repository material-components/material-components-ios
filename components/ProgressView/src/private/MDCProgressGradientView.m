// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCProgressGradientView.h"

#import <MDFInternationalization/MDFInternationalization.h>

@interface MDCProgressGradientView ()

@property(nonatomic, readonly) CAGradientLayer *gradientLayer;
@property(nonatomic, readwrite) CAShapeLayer *shapeLayer;

@end

@implementation MDCProgressGradientView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCProgressGradientViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCProgressGradientViewInit];
  }
  return self;
}

- (void)commonMDCProgressGradientViewInit {
  self.gradientLayer.startPoint = CGPointMake(0.0f, 0.5f);
  self.gradientLayer.endPoint = CGPointMake(1.0f, 0.5f);

  self.shapeLayer = [CAShapeLayer layer];
  self.gradientLayer.mask = self.shapeLayer;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIBezierPath *path = [UIBezierPath bezierPath];
  CGPoint leftPoint = CGPointMake(0, CGRectGetMidY(self.gradientLayer.bounds));
  CGPoint rightPoint = CGPointMake(CGRectGetWidth(self.gradientLayer.bounds),
                                   CGRectGetMidY(self.gradientLayer.bounds));
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    [path moveToPoint:rightPoint];
    [path addLineToPoint:leftPoint];
  } else {
    [path moveToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
  }
  self.shapeLayer.frame = self.gradientLayer.bounds;
  self.shapeLayer.strokeColor = UIColor.blackColor.CGColor;
  self.shapeLayer.lineWidth = CGRectGetHeight(self.gradientLayer.bounds);
  if (self.gradientLayer.cornerRadius > 0) {
    self.shapeLayer.lineCap = kCALineCapRound;
  }
  self.shapeLayer.path = path.CGPath;
}

- (void)setColors:(NSArray *)colors {
  self.gradientLayer.colors = colors;
}

- (NSArray *)colors {
  return self.gradientLayer.colors;
}

+ (Class)layerClass {
  return [CAGradientLayer class];
}

#pragma mark - Private Helpers

- (CAGradientLayer *)gradientLayer {
  return (CAGradientLayer *)self.layer;
}

@end
