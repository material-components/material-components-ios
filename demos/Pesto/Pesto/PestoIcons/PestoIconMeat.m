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

#import "PestoIconMeat.h"

@implementation PestoIconMeat

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// General Declarations
  CGContextRef context = UIGraphicsGetCurrentContext();

  //// Color Declarations
  UIColor* fillColor = [UIColor colorWithRed:0.04 green:0.041 blue:0.037 alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 18.75) * 0.48642 + 0.05) + 0.45,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 17.32) * 0.46182 - 0.4) + 0.9, 18.75,
      17.32);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71, CGRectGetMinY(group))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.52, CGRectGetMinY(group) + 0.1)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.32, CGRectGetMinY(group))
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.92, CGRectGetMinY(group) + 0.03)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.5, CGRectGetMinY(group) + 5.05)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.69, CGRectGetMinY(group) + 0.6)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.3, CGRectGetMinY(group) + 2.96)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.39, CGRectGetMinY(group) + 5.18)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.46, CGRectGetMinY(group) + 5.1)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.42, CGRectGetMinY(group) + 5.14)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.04, CGRectGetMinY(group) + 12.36)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.74, CGRectGetMinY(group) + 7.14)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.35, CGRectGetMinY(group) + 9.82)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.1, CGRectGetMinY(group) + 17.32)
          controlPoint1:CGPointMake(CGRectGetMinX(group) - 0.21, CGRectGetMinY(group) + 14.43)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.68, CGRectGetMinY(group) + 17.18)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.25, CGRectGetMinY(group) + 17.32)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.15, CGRectGetMinY(group) + 17.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.2, CGRectGetMinY(group) + 17.32)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7, CGRectGetMinY(group) + 15.45)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.68, CGRectGetMinY(group) + 17.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.79, CGRectGetMinY(group) + 16.07)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.43, CGRectGetMinY(group) + 12.21)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.97, CGRectGetMinY(group) + 13.93)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.86, CGRectGetMinY(group) + 14.53)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.94, CGRectGetMinY(group) + 2.31)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.31, CGRectGetMinY(group) + 9.62)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.54, CGRectGetMinY(group) + 5.19)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71, CGRectGetMinY(group))
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.61, CGRectGetMinY(group) + 0.83)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.68, CGRectGetMinY(group))];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71, CGRectGetMinY(group) + 1.33)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.95, CGRectGetMinY(group) + 3.21)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.33, CGRectGetMinY(group) + 1.33)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.88, CGRectGetMinY(group) + 2.02)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.54, CGRectGetMinY(group) + 11.22)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.05, CGRectGetMinY(group) + 5.53)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 17.86, CGRectGetMinY(group) + 9.13)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.82, CGRectGetMinY(group) + 12.98)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.33, CGRectGetMinY(group) + 12.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.62, CGRectGetMinY(group) + 12.64)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.39, CGRectGetMinY(group) + 14.27)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.34, CGRectGetMinY(group) + 13.25)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.81, CGRectGetMinY(group) + 13.54)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.08, CGRectGetMinY(group) + 15.09)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.92, CGRectGetMinY(group) + 14.51)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.49, CGRectGetMinY(group) + 14.8)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.25, CGRectGetMinY(group) + 15.99)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.42, CGRectGetMinY(group) + 15.55)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.8, CGRectGetMinY(group) + 15.99)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.18, CGRectGetMinY(group) + 15.99)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.23, CGRectGetMinY(group) + 15.99)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.2, CGRectGetMinY(group) + 15.99)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.05, CGRectGetMinY(group) + 15.41)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.72, CGRectGetMinY(group) + 15.96)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.36, CGRectGetMinY(group) + 15.78)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.36, CGRectGetMinY(group) + 12.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.51, CGRectGetMinY(group) + 14.76)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23, CGRectGetMinY(group) + 13.6)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.41, CGRectGetMinY(group) + 6.04)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.62, CGRectGetMinY(group) + 10.43)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.75, CGRectGetMinY(group) + 8.01)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 4.51, CGRectGetMinY(group) + 5.92)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.75, CGRectGetMinY(group) + 1.42)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.99, CGRectGetMinY(group) + 4.2)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.26, CGRectGetMinY(group) + 1.86)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71, CGRectGetMinY(group) + 1.33)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.07, CGRectGetMinY(group) + 1.36)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.39, CGRectGetMinY(group) + 1.33)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.1, CGRectGetMinY(group) + 7.97);
    CGContextRotateCTM(context, 44.9 * M_PI / 180);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.68, -0.68, 5.35, 1.35)
                                   cornerRadius:0.6];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 6.95, CGRectGetMinY(group) + 8.67);
    CGContextRotateCTM(context, -44.9 * M_PI / 180);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68, -1.68, 1.35, 3.35)
                                   cornerRadius:0.6];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 3.99)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.71, CGRectGetMinY(group) + 4.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.01, CGRectGetMinY(group) + 3.99)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.71, CGRectGetMinY(group) + 4.29)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 5.33)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.71, CGRectGetMinY(group) + 5.03)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.01, CGRectGetMinY(group) + 5.33)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 14.04, CGRectGetMinY(group) + 4.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.74, CGRectGetMinY(group) + 5.33)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.04, CGRectGetMinY(group) + 5.03)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 3.99)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.04, CGRectGetMinY(group) + 4.29)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.74, CGRectGetMinY(group) + 3.99)];
    [bezier2Path closePath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 6.66)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.37, CGRectGetMinY(group) + 4.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.27, CGRectGetMinY(group) + 6.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.37, CGRectGetMinY(group) + 5.76)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 2.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.37, CGRectGetMinY(group) + 3.56)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.27, CGRectGetMinY(group) + 2.66)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.37, CGRectGetMinY(group) + 4.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.48, CGRectGetMinY(group) + 2.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.37, CGRectGetMinY(group) + 3.56)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37, CGRectGetMinY(group) + 6.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.37, CGRectGetMinY(group) + 5.76)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.48, CGRectGetMinY(group) + 6.66)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];
  }
}

@end
