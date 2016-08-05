/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "PestoIconMain.h"

@implementation PestoIconMain

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
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 19.83) * 0.52934 + 0.06) + 0.44,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 17.25) * 0.47003 - 0.32) + 0.82, 19.83,
      17.25);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 12.13)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 2.56, CGRectGetMinY(group) + 12.13)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 14.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.15, CGRectGetMinY(group) + 12.13)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 13.28)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.56, CGRectGetMinY(group) + 17.25)
          controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 16.1)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.15, CGRectGetMinY(group) + 17.25)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 17.25)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 14.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.68, CGRectGetMinY(group) + 17.25)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 16.1)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 12.13)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 13.28)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.68, CGRectGetMinY(group) + 12.13)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 13.47)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 14.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.95, CGRectGetMinY(group) + 13.47)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 14.02)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 15.92)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 15.37)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 17.95, CGRectGetMinY(group) + 15.92)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 2.56, CGRectGetMinY(group) + 15.92)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 14.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.88, CGRectGetMinY(group) + 15.92)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 15.37)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.56, CGRectGetMinY(group) + 13.47)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 14.02)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.88, CGRectGetMinY(group) + 13.47)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 17.27, CGRectGetMinY(group) + 13.47)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.23, CGRectGetMinY(group) + 1.87)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.76, CGRectGetMinY(group) + 1.68)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.06, CGRectGetMinY(group) + 1.87)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.89, CGRectGetMinY(group) + 1.81)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.1, CGRectGetMinY(group) + 1.68)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.3, CGRectGetMinY(group) + 1.22)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.56, CGRectGetMinY(group) + 1.22)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.16, CGRectGetMinY(group) + 1.68)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.84, CGRectGetMinY(group) + 1.94)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.42, CGRectGetMinY(group) + 1.94)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.16, CGRectGetMinY(group) + 0.73)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.9, CGRectGetMinY(group) + 1.41)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.9, CGRectGetMinY(group) + 0.99)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.7, CGRectGetMinY(group) + 0.73)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.13, CGRectGetMinY(group) - 0.24)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.72, CGRectGetMinY(group) - 0.25)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.7, CGRectGetMinY(group) + 1.68)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.96, CGRectGetMinY(group) + 0.99)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.96, CGRectGetMinY(group) + 1.41)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.23, CGRectGetMinY(group) + 1.87)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.57, CGRectGetMinY(group) + 1.81)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.4, CGRectGetMinY(group) + 1.87)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92, CGRectGetMinY(group) + 2.32)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 12.24)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.45, CGRectGetMinY(group) + 2.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 6.77)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 13.57)
          controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 12.98)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.6, CGRectGetMinY(group) + 13.57)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 13.57)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 12.24)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.24, CGRectGetMinY(group) + 13.57)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 12.98)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92, CGRectGetMinY(group) + 2.32)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.83, CGRectGetMinY(group) + 6.77)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.38, CGRectGetMinY(group) + 2.32)];
    [bezier3Path closePath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92, CGRectGetMinY(group) + 3.66)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 12.24)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.66, CGRectGetMinY(group) + 3.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.5, CGRectGetMinY(group) + 7.5)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 12.24)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92, CGRectGetMinY(group) + 3.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.33, CGRectGetMinY(group) + 7.5)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.18, CGRectGetMinY(group) + 3.66)];
    [bezier3Path closePath];
    [fillColor setFill];
    [bezier3Path fill];

    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01, CGRectGetMinY(group) + 10.45)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.34, CGRectGetMinY(group) + 9.79)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.64, CGRectGetMinY(group) + 10.45)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.34, CGRectGetMinY(group) + 10.15)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.69, CGRectGetMinY(group) + 5.44)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.34, CGRectGetMinY(group) + 7.39)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.29, CGRectGetMinY(group) + 5.44)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.36, CGRectGetMinY(group) + 6.11)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.06, CGRectGetMinY(group) + 5.44)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.36, CGRectGetMinY(group) + 5.74)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.69, CGRectGetMinY(group) + 6.78)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.36, CGRectGetMinY(group) + 6.48)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.06, CGRectGetMinY(group) + 6.78)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.68, CGRectGetMinY(group) + 9.79)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.03, CGRectGetMinY(group) + 6.78)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.68, CGRectGetMinY(group) + 8.13)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01, CGRectGetMinY(group) + 10.45)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.68, CGRectGetMinY(group) + 10.15)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.38, CGRectGetMinY(group) + 10.45)];
    [bezier4Path closePath];
    [fillColor setFill];
    [bezier4Path fill];
  }
}

@end
