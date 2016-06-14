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

#import "PestoIconTimer.h"

@implementation PestoIconTimer

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
  UIColor* fillColor = [UIColor colorWithRed:0.041 green:0.043 blue:0.038 alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 29.19) * 0.40011 + 0.38) + 0.12,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 19.97) * 0.55597 + 0.16) + 0.34, 29.19,
      19.97);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 1.06)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.35, CGRectGetMinY(group) + 10.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.58, CGRectGetMinY(group) + 1.06)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.35, CGRectGetMinY(group) + 5.3)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 19.97)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.35, CGRectGetMinY(group) + 15.74)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.58, CGRectGetMinY(group) + 19.97)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 28.26, CGRectGetMinY(group) + 10.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 24.02, CGRectGetMinY(group) + 19.97)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 28.26, CGRectGetMinY(group) + 15.74)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 1.06)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 28.26, CGRectGetMinY(group) + 5.3)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 24.02, CGRectGetMinY(group) + 1.06)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 2.84)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 26.48, CGRectGetMinY(group) + 10.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 23.03, CGRectGetMinY(group) + 2.84)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 26.48, CGRectGetMinY(group) + 6.29)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 18.19)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 26.48, CGRectGetMinY(group) + 14.75)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 23.03, CGRectGetMinY(group) + 18.19)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.12, CGRectGetMinY(group) + 10.52)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.57, CGRectGetMinY(group) + 18.19)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.12, CGRectGetMinY(group) + 14.75)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8, CGRectGetMinY(group) + 2.84)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.12, CGRectGetMinY(group) + 6.29)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.57, CGRectGetMinY(group) + 2.84)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle Drawing
    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.18,
                                                           CGRectGetMinY(group) + 14.31, 4.7, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectanglePath fill];

    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group) + 11.16, 7.05, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle2Path fill];

    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.18,
                                                           CGRectGetMinY(group) + 4.91, 4.7, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle3Path fill];

    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 10.88, CGRectGetMinY(group) + 2.56);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9, -2.73, 1.8, 5.45)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 26.62, CGRectGetMinY(group) + 2.66);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9, -2.73, 1.8, 5.45)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.14, CGRectGetMinY(group) + 10.96)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 15.87, CGRectGetMinY(group) + 8.7)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.87, CGRectGetMinY(group) + 7.64)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.58, CGRectGetMinY(group) + 8.41)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.58, CGRectGetMinY(group) + 7.93)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 15.92, CGRectGetMinY(group) + 7.59)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.98, CGRectGetMinY(group) + 7.59)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.21, CGRectGetMinY(group) + 7.3)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.69, CGRectGetMinY(group) + 7.3)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 19.24, CGRectGetMinY(group) + 9.85)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.24, CGRectGetMinY(group) + 10.91)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.53, CGRectGetMinY(group) + 10.15)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.53, CGRectGetMinY(group) + 10.62)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 19.19, CGRectGetMinY(group) + 10.96)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.14, CGRectGetMinY(group) + 10.96)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.9, CGRectGetMinY(group) + 11.25)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.43, CGRectGetMinY(group) + 11.25)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group) + 8.06, 7.05, 1.8)
                                   cornerRadius:0.8];
    [fillColor setFill];
    [rectangle6Path fill];
  }
}

@end
