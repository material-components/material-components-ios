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

#import "PestoIconVeggie.h"

@implementation PestoIconVeggie

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
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 14.08) * 0.47855 - 0.08) + 0.58,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 26.64) * 0.58262 + 0.26) + 0.24, 14.08,
      26.64);

  //// Group
  {
    //// Rectangle Drawing
    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 6.12,
                                                           CGRectGetMinY(group), 1.8, 5.15)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectanglePath fill];

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 8.72, CGRectGetMinY(group) + 3.33);
    CGContextRotateCTM(context, 44.9 * M_PI / 180);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9, -2.58, 1.8, 5.15)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 5.32, CGRectGetMinY(group) + 3.38);
    CGContextRotateCTM(context, 44.9 * M_PI / 180);

    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.58, -0.9, 5.15, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 7.03, CGRectGetMinY(group) + 6.8)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.46, CGRectGetMinY(group) + 9.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.25, CGRectGetMinY(group) + 6.8)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.41, CGRectGetMinY(group) + 7.9)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.94, CGRectGetMinY(group) + 10.76)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.22, CGRectGetMinY(group) + 9.92)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.05, CGRectGetMinY(group) + 10.33)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.2, CGRectGetMinY(group) + 15.12)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.59, CGRectGetMinY(group) + 12.18)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.87, CGRectGetMinY(group) + 13.76)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.26, CGRectGetMinY(group) + 21.13)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.7, CGRectGetMinY(group) + 17.23)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.4, CGRectGetMinY(group) + 19.25)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.27, CGRectGetMinY(group) + 24.28)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.74, CGRectGetMinY(group) + 22.17)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.36, CGRectGetMinY(group) + 23.36)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.34, CGRectGetMinY(group) + 24.85)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.68, CGRectGetMinY(group) + 24.7)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.1, CGRectGetMinY(group) + 24.91)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.97, CGRectGetMinY(group) + 24.26)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.56, CGRectGetMinY(group) + 24.79)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.81, CGRectGetMinY(group) + 24.48)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.11, CGRectGetMinY(group) + 20.22)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.83, CGRectGetMinY(group) + 23.11)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.45, CGRectGetMinY(group) + 21.81)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.05, CGRectGetMinY(group) + 14.31)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.78, CGRectGetMinY(group) + 18.62)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.61, CGRectGetMinY(group) + 16.51)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.02, CGRectGetMinY(group) + 10.27)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.39, CGRectGetMinY(group) + 12.61)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.38, CGRectGetMinY(group) + 11.33)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.89, CGRectGetMinY(group) + 6.87)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.45, CGRectGetMinY(group) + 8.63)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.84, CGRectGetMinY(group) + 7.3)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.05, CGRectGetMinY(group) + 6.8)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.63, CGRectGetMinY(group) + 6.81)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.37, CGRectGetMinY(group) + 6.8)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 7.03, CGRectGetMinY(group) + 6.8)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 7.25, CGRectGetMinY(group) + 26.64)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01, CGRectGetMinY(group) + 25.53)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.5, CGRectGetMinY(group) + 26.64)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.73, CGRectGetMinY(group) + 26.26)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.65, CGRectGetMinY(group) + 21.87)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.89, CGRectGetMinY(group) + 24.41)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.16, CGRectGetMinY(group) + 22.99)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.47, CGRectGetMinY(group) + 15.53)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.73, CGRectGetMinY(group) + 19.89)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1, CGRectGetMinY(group) + 17.75)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.22, CGRectGetMinY(group) + 10.32)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.09, CGRectGetMinY(group) + 13.96)
          controlPoint2:CGPointMake(CGRectGetMinX(group) - 0.23, CGRectGetMinY(group) + 12.12)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.92, CGRectGetMinY(group) + 8.62)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.37, CGRectGetMinY(group) + 9.73)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.61, CGRectGetMinY(group) + 9.16)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.06, CGRectGetMinY(group) + 5.1)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.01, CGRectGetMinY(group) + 6.76)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 5.43)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.43, CGRectGetMinY(group) + 5.02)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.17, CGRectGetMinY(group) + 5.05)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.3, CGRectGetMinY(group) + 5.02)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 7.66, CGRectGetMinY(group) + 5.02)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.97, CGRectGetMinY(group) + 5.08)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.77, CGRectGetMinY(group) + 5.02)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.88, CGRectGetMinY(group) + 5.04)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.28, CGRectGetMinY(group) + 5.14)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.07, CGRectGetMinY(group) + 5.1)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.17, CGRectGetMinY(group) + 5.11)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.7, CGRectGetMinY(group) + 9.69)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.85, CGRectGetMinY(group) + 5.7)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.93, CGRectGetMinY(group) + 7.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.79, CGRectGetMinY(group) + 14.66)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.32, CGRectGetMinY(group) + 11.49)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.05, CGRectGetMinY(group) + 13.39)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.75, CGRectGetMinY(group) + 20.91)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.32, CGRectGetMinY(group) + 17.01)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.46, CGRectGetMinY(group) + 19.23)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.4, CGRectGetMinY(group) + 25.32)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.13, CGRectGetMinY(group) + 22.39)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.42, CGRectGetMinY(group) + 23.95)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.81, CGRectGetMinY(group) + 26.56)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.05, CGRectGetMinY(group) + 25.79)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.55, CGRectGetMinY(group) + 26.36)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.25, CGRectGetMinY(group) + 26.64)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.62, CGRectGetMinY(group) + 26.61)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.44, CGRectGetMinY(group) + 26.64)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle 4 Drawing
    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 1.2,
                                                           CGRectGetMinY(group) + 10.27, 5.85, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle4Path fill];

    //// Rectangle 5 Drawing
    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 7.05,
                                                           CGRectGetMinY(group) + 12.82, 5.85, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle5Path fill];

    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 1.12,
                                                           CGRectGetMinY(group) + 15.37, 4.2, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle6Path fill];

    //// Rectangle 7 Drawing
    UIBezierPath* rectangle7Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.6,
                                                           CGRectGetMinY(group) + 20.52, 2.85, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle7Path fill];

    //// Rectangle 8 Drawing
    UIBezierPath* rectangle8Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 8.72,
                                                           CGRectGetMinY(group) + 17.93, 3.4, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle8Path fill];
  }
}

@end
