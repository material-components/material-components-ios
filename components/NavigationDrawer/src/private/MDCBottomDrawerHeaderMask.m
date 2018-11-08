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

#import "MDCBottomDrawerHeaderMask.h"

@implementation MDCBottomDrawerHeaderMask

- (instancetype)initWithMaximumCornerRadius:(CGFloat)maximumCornerRadius
                        minimumCornerRadius:(CGFloat)minimumCornerRadius {
  self = [super init];
  if (self) {
    _maximumCornerRadius = maximumCornerRadius;
    _minimumCornerRadius = minimumCornerRadius;
  }
  return self;
}

- (CAShapeLayer *)layerForCornerRadius:(CGFloat)cornerRadius inView:(UIView *)view {
  CAShapeLayer *headerLayer = [[CAShapeLayer alloc] init];
  CGRect safeBounds = CGRectStandardize(view.bounds);
  CGFloat halfViewHeight = safeBounds.size.height / 2;
  CGFloat halfViewWidth = safeBounds.size.width / 2;
  CGFloat safeCornerRadius = MIN(cornerRadius, MIN(halfViewWidth, halfViewHeight));
  CGFloat newCornerRadius = [self calcuateCornerRadiusFromMaximumCornerRadius:safeCornerRadius
                                                        toMinimumCornerRadius:0
                                                               withPercentage:1];
  UIBezierPath *path = [self createPathWithCornerRadius:newCornerRadius
                                                  width:safeBounds.size.width
                                                 height:safeBounds.size.height];
  headerLayer.path = path.CGPath;
  return headerLayer;
}

- (CGFloat)calcuateCornerRadiusFromMaximumCornerRadius:(CGFloat)maximumCornerRadius
                                 toMinimumCornerRadius:(CGFloat)minimumCornerRadius
                                        withPercentage:(CGFloat)percentage {
  if (percentage < 0) {
    return maximumCornerRadius;
  } else if (percentage > 1) {
    return minimumCornerRadius;
  }
  return ((maximumCornerRadius - minimumCornerRadius) * percentage) + minimumCornerRadius;
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
              startAngle:(CGFloat)(3 * M_PI_2)
                endAngle:0
               clockwise:YES];
  [path addLineToPoint:CGPointMake(width, 2 * height)];
  [path addLineToPoint:CGPointMake(0, 2 * height)];
  [path addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                  radius:cornerRadius
              startAngle:(CGFloat)M_PI
                endAngle:(CGFloat)(3 * M_PI_2)
               clockwise:YES];
  [path closePath];
  return path;
}

- (void)applyMask {
  if (self.view) {
    CAShapeLayer *maskLayer = [self layerForCornerRadius:self.maximumCornerRadius inView:self.view];
    self.view.layer.mask = maskLayer;
  }
}

- (void)animateWithPercentage:(CGFloat)percentage {
  if (self.view) {
    [CATransaction begin];
    CGFloat cornerRadius =
        [self calcuateCornerRadiusFromMaximumCornerRadius:self.maximumCornerRadius
                                    toMinimumCornerRadius:self.minimumCornerRadius
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
