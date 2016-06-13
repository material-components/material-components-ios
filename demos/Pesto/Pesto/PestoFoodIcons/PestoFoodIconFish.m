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

#import "PestoFoodIconFish.h"

@implementation PestoFoodIconFish

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
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 18.67) * 0.53822 + 0.33) + 0.17,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 18.67) * 0.59583 + 0.11) + 0.39, 18.67,
      18.67);

  //// Group
  {
    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.88, CGRectGetMinY(group) + 8.91);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68, -4.67, 1.35, 9.35)
                                   cornerRadius:0.4];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 4.23, CGRectGetMinY(group) + 8.91);
    CGContextRotateCTM(context, 44.9 * M_PI / 180);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68, -2, 1.35, 4) cornerRadius:0.4];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 5.88, CGRectGetMinY(group) + 11.06);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.33, -0.68, 4.65, 1.35)
                                   cornerRadius:0.4];
    [fillColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 7.98, CGRectGetMinY(group) + 12.71);
    CGContextRotateCTM(context, 44.9 * M_PI / 180);

    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68, -2, 1.35, 4) cornerRadius:0.4];
    [fillColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 10.33, CGRectGetMinY(group) + 14.11);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68, -1.33, 1.35, 2.65)
                                   cornerRadius:0.4];
    [fillColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 6 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.83, CGRectGetMinY(group) + 3.31);
    CGContextRotateCTM(context, -44.9 * M_PI / 180);

    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2, -0.68, 4, 1.35) cornerRadius:0.4];
    [fillColor setFill];
    [rectangle6Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 7 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 11.93, CGRectGetMinY(group) + 4.96);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle7Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.33, -0.68, 4.65, 1.35)
                                   cornerRadius:0.4];
    [fillColor setFill];
    [rectangle7Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 8 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 13.58, CGRectGetMinY(group) + 7.11);
    CGContextRotateCTM(context, -44.9 * M_PI / 180);

    UIBezierPath* rectangle8Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2, -0.68, 4, 1.35) cornerRadius:0.4];
    [fillColor setFill];
    [rectangle8Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 9 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 14.98, CGRectGetMinY(group) + 9.46);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle9Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-1.33, -0.68, 2.65, 1.35)
                                   cornerRadius:0.4];
    [fillColor setFill];
    [rectangle9Path fill];

    CGContextRestoreGState(context);

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 14.3, CGRectGetMinY(group) + 14.3)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.3, CGRectGetMinY(group) + 16.39)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 16.39, CGRectGetMinY(group) + 14.3)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.3, CGRectGetMinY(group) + 14.3)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.16, CGRectGetMinY(group) + 18.47)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.97, CGRectGetMinY(group) + 18)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.04, CGRectGetMinY(group) + 18.35)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.97, CGRectGetMinY(group) + 18.18)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 12.97, CGRectGetMinY(group) + 13.63)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.63, CGRectGetMinY(group) + 12.97)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.97, CGRectGetMinY(group) + 13.27)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.27, CGRectGetMinY(group) + 12.97)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 18, CGRectGetMinY(group) + 12.97)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.62, CGRectGetMinY(group) + 13.38)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.27, CGRectGetMinY(group) + 12.97)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.52, CGRectGetMinY(group) + 13.13)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.47, CGRectGetMinY(group) + 14.11)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.72, CGRectGetMinY(group) + 13.63)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.66, CGRectGetMinY(group) + 13.91)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.11, CGRectGetMinY(group) + 18.47)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.38, CGRectGetMinY(group) + 18.62)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.91, CGRectGetMinY(group) + 18.66)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.63, CGRectGetMinY(group) + 18.72)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.16, CGRectGetMinY(group) + 18.47)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.3, CGRectGetMinY(group) + 18.58)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.22, CGRectGetMinY(group) + 18.54)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 1.65, CGRectGetMinY(group) + 1.65)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.53, CGRectGetMinY(group) + 5.89)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.27, CGRectGetMinY(group) + 3.04)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23, CGRectGetMinY(group) + 4.49)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.22, CGRectGetMinY(group) + 3.22)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.88, CGRectGetMinY(group) + 4.9)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.45, CGRectGetMinY(group) + 3.99)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.89, CGRectGetMinY(group) + 1.53)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.99, CGRectGetMinY(group) + 2.45)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.9, CGRectGetMinY(group) + 1.88)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.65, CGRectGetMinY(group) + 1.65)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.49, CGRectGetMinY(group) + 1.23)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.04, CGRectGetMinY(group) + 1.27)];
    [bezier2Path closePath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 1.32, CGRectGetMinY(group) + 8.98)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.2, CGRectGetMinY(group) + 8.83)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.27, CGRectGetMinY(group) + 8.94)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23, CGRectGetMinY(group) + 8.88)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.48, CGRectGetMinY(group) + 0.91)
          controlPoint1:CGPointMake(CGRectGetMinX(group) - 0.09, CGRectGetMinY(group) + 6.41)
          controlPoint2:CGPointMake(CGRectGetMinX(group) - 0.35, CGRectGetMinY(group) + 3.52)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.91, CGRectGetMinY(group) + 0.48)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.55, CGRectGetMinY(group) + 0.71)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.71, CGRectGetMinY(group) + 0.55)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.83, CGRectGetMinY(group) + 1.2)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.52, CGRectGetMinY(group) - 0.35)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.41, CGRectGetMinY(group) - 0.09)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.15, CGRectGetMinY(group) + 1.96)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.1, CGRectGetMinY(group) + 1.35)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.23, CGRectGetMinY(group) + 1.66)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.49, CGRectGetMinY(group) + 2.45)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.07, CGRectGetMinY(group) + 2.26)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.8, CGRectGetMinY(group) + 2.46)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.17, CGRectGetMinY(group) + 4.17)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.86, CGRectGetMinY(group) + 2.4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.32, CGRectGetMinY(group) + 3.01)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.45, CGRectGetMinY(group) + 8.49)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.01, CGRectGetMinY(group) + 5.32)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.4, CGRectGetMinY(group) + 6.86)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.96, CGRectGetMinY(group) + 9.15)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.46, CGRectGetMinY(group) + 8.8)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.26, CGRectGetMinY(group) + 9.07)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.32, CGRectGetMinY(group) + 8.98)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.73, CGRectGetMinY(group) + 9.22)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.48, CGRectGetMinY(group) + 9.15)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];
  }
}

@end
