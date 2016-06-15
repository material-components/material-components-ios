/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "PestoIconSpicy.h"

@implementation PestoIconSpicy

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// Color Declarations
  UIColor* fillColor = [UIColor colorWithRed:0.04 green:0.041 blue:0.037 alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 20.19) * 0.50018 - 0.41) + 0.91,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 16.36) * 0.46418 + 0.12) + 0.38, 20.19,
      16.36);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29, CGRectGetMinY(group) + 2.06)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.75, CGRectGetMinY(group) + 2.12)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.11, CGRectGetMinY(group) + 2.06)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.93, CGRectGetMinY(group) + 2.08)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.58, CGRectGetMinY(group) + 2.97)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.98, CGRectGetMinY(group) + 2.31)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.26, CGRectGetMinY(group) + 2.52)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.6, CGRectGetMinY(group) + 6.51)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.54, CGRectGetMinY(group) + 3.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.36, CGRectGetMinY(group) + 5.18)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.61, CGRectGetMinY(group) + 6.55)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.6, CGRectGetMinY(group) + 6.52)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.6, CGRectGetMinY(group) + 6.53)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.58, CGRectGetMinY(group) + 8.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.74, CGRectGetMinY(group) + 7.2)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.24, CGRectGetMinY(group) + 7.94)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.94, CGRectGetMinY(group) + 12.63)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.48, CGRectGetMinY(group) + 10.05)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.61, CGRectGetMinY(group) + 11.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.96, CGRectGetMinY(group) + 16.05)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.92, CGRectGetMinY(group) + 14.39)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.37, CGRectGetMinY(group) + 15.54)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.26, CGRectGetMinY(group) + 16.36)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.05, CGRectGetMinY(group) + 16.26)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.15, CGRectGetMinY(group) + 16.36)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.93, CGRectGetMinY(group) + 16.34)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.48, CGRectGetMinY(group) + 16.36)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.71, CGRectGetMinY(group) + 16.35)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19, CGRectGetMinY(group) + 16.16)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.62, CGRectGetMinY(group) + 16.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.32, CGRectGetMinY(group) + 16.26)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 20.17, CGRectGetMinY(group) + 15.47)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.48, CGRectGetMinY(group) + 16.09)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 20.34, CGRectGetMinY(group) + 16.09)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.06, CGRectGetMinY(group) + 14)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.98, CGRectGetMinY(group) + 14.81)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.57, CGRectGetMinY(group) + 14.25)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.82, CGRectGetMinY(group) + 8.61)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.41, CGRectGetMinY(group) + 12.67)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.4, CGRectGetMinY(group) + 11.24)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.54, CGRectGetMinY(group) + 2.42)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.63, CGRectGetMinY(group) + 6.65)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.7, CGRectGetMinY(group) + 3.77)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29, CGRectGetMinY(group) + 2.06)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.15, CGRectGetMinY(group) + 2.19)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.73, CGRectGetMinY(group) + 2.06)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29, CGRectGetMinY(group) + 3.39)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.83, CGRectGetMinY(group) + 3.56)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.47, CGRectGetMinY(group) + 3.39)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.66, CGRectGetMinY(group) + 3.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.59, CGRectGetMinY(group) + 6.64)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.79, CGRectGetMinY(group) + 4.15)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.16, CGRectGetMinY(group) + 5.31)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.68, CGRectGetMinY(group) + 9.3)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.87, CGRectGetMinY(group) + 7.53)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.16, CGRectGetMinY(group) + 8.46)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.09, CGRectGetMinY(group) + 15)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.39, CGRectGetMinY(group) + 12.14)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.41, CGRectGetMinY(group) + 13.67)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.88, CGRectGetMinY(group) + 15.01)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.02, CGRectGetMinY(group) + 15.01)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.95, CGRectGetMinY(group) + 15.01)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.26, CGRectGetMinY(group) + 15.02)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.68, CGRectGetMinY(group) + 15.02)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.47, CGRectGetMinY(group) + 15.02)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.21, CGRectGetMinY(group) + 14.74)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.21, CGRectGetMinY(group) + 15.02)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.19, CGRectGetMinY(group) + 14.93)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.82, CGRectGetMinY(group) + 11.63)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.8, CGRectGetMinY(group) + 14.27)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.59, CGRectGetMinY(group) + 13.2)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.73, CGRectGetMinY(group) + 7.84)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.62, CGRectGetMinY(group) + 10.57)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.58, CGRectGetMinY(group) + 9.29)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.54, CGRectGetMinY(group) + 7.53)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.67, CGRectGetMinY(group) + 7.74)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.6, CGRectGetMinY(group) + 7.64)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.91, CGRectGetMinY(group) + 6.28)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.3, CGRectGetMinY(group) + 7.14)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.98, CGRectGetMinY(group) + 6.6)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.32, CGRectGetMinY(group) + 4.08)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.81, CGRectGetMinY(group) + 5.7)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.49, CGRectGetMinY(group) + 4.63)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.06, CGRectGetMinY(group) + 3.42)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.8, CGRectGetMinY(group) + 3.76)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.34, CGRectGetMinY(group) + 3.59)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29, CGRectGetMinY(group) + 3.39)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.14, CGRectGetMinY(group) + 3.4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.21, CGRectGetMinY(group) + 3.39)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5, CGRectGetMinY(group) + 6.69)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.83, CGRectGetMinY(group) + 6.02)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.13, CGRectGetMinY(group) + 6.69)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.83, CGRectGetMinY(group) + 6.39)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5, CGRectGetMinY(group) + 5.36)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.83, CGRectGetMinY(group) + 5.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.13, CGRectGetMinY(group) + 5.36)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.19, CGRectGetMinY(group) + 4.67)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.88, CGRectGetMinY(group) + 5.36)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.19, CGRectGetMinY(group) + 5.05)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.86, CGRectGetMinY(group) + 4)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.19, CGRectGetMinY(group) + 4.3)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.49, CGRectGetMinY(group) + 4)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.52, CGRectGetMinY(group) + 4.67)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.22, CGRectGetMinY(group) + 4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.52, CGRectGetMinY(group) + 4.3)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5, CGRectGetMinY(group) + 6.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.52, CGRectGetMinY(group) + 5.78)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.61, CGRectGetMinY(group) + 6.69)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 3.33, CGRectGetMinY(group) + 4)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.67, CGRectGetMinY(group) + 3.33)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.96, CGRectGetMinY(group) + 4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.67, CGRectGetMinY(group) + 3.7)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.67, CGRectGetMinY(group) + 1.33)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.67, CGRectGetMinY(group) + 2.23)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.77, CGRectGetMinY(group) + 1.33)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 0.67)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.3, CGRectGetMinY(group) + 1.33)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 1.04)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.67, CGRectGetMinY(group))
                   controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 0.3)
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.3, CGRectGetMinY(group))];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 3.33)
                   controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.5, CGRectGetMinY(group))
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 1.5)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.33, CGRectGetMinY(group) + 4)
                   controlPoint1:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 3.7)
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.7, CGRectGetMinY(group) + 4)];
    [bezier3Path closePath];
    [fillColor setFill];
    [bezier3Path fill];
  }
}

@end
