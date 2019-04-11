// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCContainerStylerPathDrawingUtils.h"

#import "MaterialMath.h"

@implementation MDCContainerStylerPathDrawingUtils

+ (void)addTopRightCornerToPath:(UIBezierPath *)path
                      fromPoint:(CGPoint)point1
                        toPoint:(CGPoint)point2
                     withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)(M_PI / 2);
  CGFloat endAngle = 0;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addBottomRightCornerToPath:(UIBezierPath *)path
                         fromPoint:(CGPoint)point1
                           toPoint:(CGPoint)point2
                        withRadius:(CGFloat)radius {
  CGFloat startAngle = 0;
  CGFloat endAngle = -(CGFloat)((M_PI * 3) / 2);
  CGPoint center = CGPointMake(point2.x, point1.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addBottomLeftCornerToPath:(UIBezierPath *)path
                        fromPoint:(CGPoint)point1
                          toPoint:(CGPoint)point2
                       withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)((M_PI * 3) / 2);
  CGFloat endAngle = -(CGFloat)M_PI;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (void)addTopLeftCornerToPath:(UIBezierPath *)path
                     fromPoint:(CGPoint)point1
                       toPoint:(CGPoint)point2
                    withRadius:(CGFloat)radius {
  CGFloat startAngle = -(CGFloat)M_PI;
  CGFloat endAngle = -(CGFloat)(M_PI / 2);
  CGPoint center = CGPointMake(point1.x + radius, point2.y + radius);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

+ (UIBezierPath *)pathForClearButtonImageWithFrame:(CGRect)frame {
  CGRect innerBounds =
      CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
                 MDCFloor((frame.size.width - 2) * (CGFloat)0.90909 + (CGFloat)0.5),
                 MDCFloor((frame.size.height - 2) * (CGFloat)0.90909 + (CGFloat)0.5));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) +
                                             (CGFloat)0.50000 * innerBounds.size.width,
                                         CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
        controlPoint1:CGPointMake(
                          CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)
        controlPoint2:CGPointMake(
                          CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                          CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
      moveToPoint:CGPointMake(
                      CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                      CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.45367 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.45367 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.54800 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.54800 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(
                         CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                         CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

@end
