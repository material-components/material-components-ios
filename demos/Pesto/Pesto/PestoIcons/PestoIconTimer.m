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
  UIColor* fillColor = [UIColor colorWithRed:0.041f green:0.043f blue:0.038f alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 29.19f) * 0.40011f + 0.38f) + 0.12f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 19.97f) * 0.55597f + 0.16f) + 0.34f, 29.19f,
      19.97f);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 1.06f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.35f, CGRectGetMinY(group) + 10.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.58f, CGRectGetMinY(group) + 1.06f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.35f, CGRectGetMinY(group) + 5.3f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 19.97f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.35f, CGRectGetMinY(group) + 15.74f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.58f, CGRectGetMinY(group) + 19.97f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 28.26f, CGRectGetMinY(group) + 10.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 24.02f, CGRectGetMinY(group) + 19.97f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 28.26f, CGRectGetMinY(group) + 15.74f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 1.06f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 28.26f, CGRectGetMinY(group) + 5.3f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 24.02f, CGRectGetMinY(group) + 1.06f)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 2.84f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 26.48f, CGRectGetMinY(group) + 10.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 23.03f, CGRectGetMinY(group) + 2.84f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 26.48f, CGRectGetMinY(group) + 6.29f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 18.19f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 26.48f, CGRectGetMinY(group) + 14.75f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 23.03f, CGRectGetMinY(group) + 18.19f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.12f, CGRectGetMinY(group) + 10.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.57f, CGRectGetMinY(group) + 18.19f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.12f, CGRectGetMinY(group) + 14.75f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.8f, CGRectGetMinY(group) + 2.84f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.12f, CGRectGetMinY(group) + 6.29f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.57f, CGRectGetMinY(group) + 2.84f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle Drawing
    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.18f,
                                                           CGRectGetMinY(group) + 14.31f, 4.7f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectanglePath fill];

    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group) + 11.16f, 7.05f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle2Path fill];

    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.18f,
                                                           CGRectGetMinY(group) + 4.91f, 4.7f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle3Path fill];

    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 10.88f, CGRectGetMinY(group) + 2.56f);
    CGContextRotateCTM(context, 45 * (CGFloat)M_PI / 180);

    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9f, -2.73f, 1.8f, 5.45f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 26.62f, CGRectGetMinY(group) + 2.66f);
    CGContextRotateCTM(context, -45 *(CGFloat) M_PI / 180);

    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9f, -2.73f, 1.8f, 5.45f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 18.14f, CGRectGetMinY(group) + 10.96f)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 15.87f, CGRectGetMinY(group) + 8.7f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.87f, CGRectGetMinY(group) + 7.64f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.58f, CGRectGetMinY(group) + 8.41f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.58f, CGRectGetMinY(group) + 7.93f)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 15.92f, CGRectGetMinY(group) + 7.59f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.98f, CGRectGetMinY(group) + 7.59f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.21f, CGRectGetMinY(group) + 7.3f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.69f, CGRectGetMinY(group) + 7.3f)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 19.24f, CGRectGetMinY(group) + 9.85f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.24f, CGRectGetMinY(group) + 10.91f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.53f, CGRectGetMinY(group) + 10.15f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.53f, CGRectGetMinY(group) + 10.62f)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 19.19f, CGRectGetMinY(group) + 10.96f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.14f, CGRectGetMinY(group) + 10.96f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.9f, CGRectGetMinY(group) + 11.25f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.43f, CGRectGetMinY(group) + 11.25f)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group) + 8.06f, 7.05f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle6Path fill];
  }
}

@end
