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

#import "MDCBottomDrawerHeaderLayer.h"

@implementation MDCBottomDrawerHeaderLayer {
  CGFloat _maximumCornerRadius;
  CGFloat _minimumCornerRadius;
}

- (instancetype)initWithMaxCornerRadius:(CGFloat)max minimumCornerRadius:(CGFloat)min {
  self = [super init];
  if (self) {
    _maximumCornerRadius = max;
    _minimumCornerRadius = min;
  }
  return self;
}

- (CAShapeLayer *)layerForCornerRadius:(CGFloat)cornerRadius inView:(UIView *)view {
  CAShapeLayer *headerLayer = [[CAShapeLayer alloc] init];
  CGRect safeBounds = CGRectStandardize(view.bounds);
  CGFloat halfViewHeight = safeBounds.size.height / 2;
  CGFloat halfViewWidth = safeBounds.size.width / 2;
  CGFloat safeCornerRadius = MIN(cornerRadius, MIN(halfViewWidth, halfViewHeight));
  CGFloat newCornerRadius = [self calcuateCornerRadiusFromOriginalCornerRadius:safeCornerRadius
                                                           toFinalCornerRadius:0
                                                                withPercentage:1.f];
  UIBezierPath *path = [self createPathWithCornerRadius:newCornerRadius
                                                  width:safeBounds.size.width
                                                 height:safeBounds.size.height];
  headerLayer.path = path.CGPath;
  return headerLayer;
}

- (CGFloat)calcuateCornerRadiusFromOriginalCornerRadius:(CGFloat)originalCornerRadius
                                    toFinalCornerRadius:(CGFloat)finalCornerRadius
                                         withPercentage:(CGFloat)percentage {
  return ((originalCornerRadius - finalCornerRadius) * percentage) + finalCornerRadius;
}

- (UIBezierPath *)createPathWithCornerRadius:(CGFloat)cornerRadius
                                       width:(CGFloat)width
                                      height:(CGFloat)height {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGPoint origin = CGPointMake(cornerRadius, 0);
  [path moveToPoint:origin];
  [path addLineToPoint:CGPointMake(width - cornerRadius, 0)];
  [path addArcWithCenter:CGPointMake(width - cornerRadius, cornerRadius)
                  radius:cornerRadius
              startAngle:-(CGFloat)M_PI
                endAngle:0
               clockwise:YES];
  [path addLineToPoint:CGPointMake(width, height)];
  [path addLineToPoint:CGPointMake(0, height)];
  [path addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                  radius:cornerRadius
              startAngle:-(CGFloat)M_PI
                endAngle:0
               clockwise:YES];
  [path closePath];
  return path;
}

- (void)mask {
  if (self.view) {
    CAShapeLayer *maskLayer = [self layerForCornerRadius:_maximumCornerRadius inView:self.view];
    self.view.layer.mask = maskLayer;
  }
}

- (void)animateWithPercentage:(CGFloat)percentage {
  if (self.view) {
    [CATransaction begin];
    CGFloat cornerRadius = [self calcuateCornerRadiusFromOriginalCornerRadius:_maximumCornerRadius
                                                          toFinalCornerRadius:_minimumCornerRadius
                                                               withPercentage:percentage];
    UIBezierPath *newPath = [self createPathWithCornerRadius:cornerRadius
                                                       width:CGRectGetWidth(self.view.frame)
                                                      height:CGRectGetHeight(self.view.frame)];
    CAShapeLayer *maskLayer = (CAShapeLayer *)self.view.layer.mask;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(maskLayer.path);
    pathAnimation.toValue = (__bridge id _Nullable)(newPath.CGPath);
    [maskLayer addAnimation:pathAnimation forKey:@"path"];
    [CATransaction setCompletionBlock:^{
      maskLayer.path = newPath.CGPath;
    }];
    [CATransaction commit];
  }
}

@end
