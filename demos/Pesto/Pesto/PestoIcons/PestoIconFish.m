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

#import "PestoIconFish.h"

@implementation PestoIconFish

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
  UIColor* fillColor = [UIColor colorWithRed:0.04f green:0.041f blue:0.037f alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 18.67f) * 0.53822f + 0.33f) + 0.17f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 18.67f) * 0.59583f + 0.11f) + 0.39f, 18.67f,
      18.67f);

  //// Group
  {
    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.88f, CGRectGetMinY(group) + 8.91f);
    CGContextRotateCTM(context, -45 * (CGFloat)M_PI / 180);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68f, -4.67f, 1.35f, 9.35f)
                                   cornerRadius:0.4f];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 4.23f, CGRectGetMinY(group) + 8.91f);
    CGContextRotateCTM(context, 44.9f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68f, -2, 1.35f, 4) cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 5.88f, CGRectGetMinY(group) + 11.06f);
    CGContextRotateCTM(context, -45.f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.33f, -0.68f, 4.65f, 1.35f)
                                   cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 4 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 7.98f, CGRectGetMinY(group) + 12.71f);
    CGContextRotateCTM(context, 44.9f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68f, -2.f, 1.35f, 4.f) cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle4Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 5 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 10.33f, CGRectGetMinY(group) + 14.11f);
    CGContextRotateCTM(context, 45.f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68f, -1.33f, 1.35f, 2.65f)
                                   cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle5Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 6 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.83f, CGRectGetMinY(group) + 3.31f);
    CGContextRotateCTM(context, -44.9f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.f, -0.68f, 4.f, 1.35f) cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle6Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 7 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 11.93f, CGRectGetMinY(group) + 4.96f);
    CGContextRotateCTM(context, -45.f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle7Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.33f, -0.68f, 4.65f, 1.35f)
                                   cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle7Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 8 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 13.58f, CGRectGetMinY(group) + 7.11f);
    CGContextRotateCTM(context, -44.9f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle8Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.f, -0.68f, 4.f, 1.35f) cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle8Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 9 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 14.98f, CGRectGetMinY(group) + 9.46f);
    CGContextRotateCTM(context, -45.f * (CGFloat)M_PI / 180.f);

    UIBezierPath* rectangle9Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-1.33f, -0.68f, 2.65f, 1.35f)
                                   cornerRadius:0.4f];
    [fillColor setFill];
    [rectangle9Path fill];

    CGContextRestoreGState(context);

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 14.3f, CGRectGetMinY(group) + 14.3f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.3f, CGRectGetMinY(group) + 16.39f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 16.39f, CGRectGetMinY(group) + 14.3f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.3f, CGRectGetMinY(group) + 14.3f)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.16f, CGRectGetMinY(group) + 18.47f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.97f, CGRectGetMinY(group) + 18.f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.04f, CGRectGetMinY(group) + 18.35f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.97f, CGRectGetMinY(group) + 18.18f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 12.97f, CGRectGetMinY(group) + 13.63f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.63f, CGRectGetMinY(group) + 12.97f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.97f, CGRectGetMinY(group) + 13.27f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.27f, CGRectGetMinY(group) + 12.97f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 18.f, CGRectGetMinY(group) + 12.97f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.62f, CGRectGetMinY(group) + 13.38f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.27f, CGRectGetMinY(group) + 12.97f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.52f, CGRectGetMinY(group) + 13.13f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.47f, CGRectGetMinY(group) + 14.11f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.72f, CGRectGetMinY(group) + 13.63f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.66f, CGRectGetMinY(group) + 13.91f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 14.11f, CGRectGetMinY(group) + 18.47f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.38f, CGRectGetMinY(group) + 18.62f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.91f, CGRectGetMinY(group) + 18.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.63f, CGRectGetMinY(group) + 18.72f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.16f, CGRectGetMinY(group) + 18.47f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.3f, CGRectGetMinY(group) + 18.58f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.22f, CGRectGetMinY(group) + 18.54f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 1.65f, CGRectGetMinY(group) + 1.65f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.53f, CGRectGetMinY(group) + 5.89f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.27f, CGRectGetMinY(group) + 3.04f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23f, CGRectGetMinY(group) + 4.49f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.22f, CGRectGetMinY(group) + 3.22f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.88f, CGRectGetMinY(group) + 4.9f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.45f, CGRectGetMinY(group) + 3.99f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.89f, CGRectGetMinY(group) + 1.53f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.99f, CGRectGetMinY(group) + 2.45f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.9f, CGRectGetMinY(group) + 1.88f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.65f, CGRectGetMinY(group) + 1.65f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.49f, CGRectGetMinY(group) + 1.23f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.04f, CGRectGetMinY(group) + 1.27f)];
    [bezier2Path closePath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 1.32f, CGRectGetMinY(group) + 8.98f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.2f, CGRectGetMinY(group) + 8.83f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.27f, CGRectGetMinY(group) + 8.94f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23f, CGRectGetMinY(group) + 8.88f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.48f, CGRectGetMinY(group) + 0.91f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) - 0.09f, CGRectGetMinY(group) + 6.41f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) - 0.35f, CGRectGetMinY(group) + 3.52f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.91f, CGRectGetMinY(group) + 0.48f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.55f, CGRectGetMinY(group) + 0.71f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.71f, CGRectGetMinY(group) + 0.55f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.83f, CGRectGetMinY(group) + 1.2f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.52f, CGRectGetMinY(group) - 0.35f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.41f, CGRectGetMinY(group) - 0.09f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.15f, CGRectGetMinY(group) + 1.96f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.1f, CGRectGetMinY(group) + 1.35f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.23f, CGRectGetMinY(group) + 1.66f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.49f, CGRectGetMinY(group) + 2.45f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.07f, CGRectGetMinY(group) + 2.26f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.8f, CGRectGetMinY(group) + 2.46f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.17f, CGRectGetMinY(group) + 4.17f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.86f, CGRectGetMinY(group) + 2.4f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.32f, CGRectGetMinY(group) + 3.01f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.45f, CGRectGetMinY(group) + 8.49f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.01f, CGRectGetMinY(group) + 5.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.4f, CGRectGetMinY(group) + 6.86f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.96f, CGRectGetMinY(group) + 9.15f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.46f, CGRectGetMinY(group) + 8.8f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.26f, CGRectGetMinY(group) + 9.07f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.32f, CGRectGetMinY(group) + 8.98f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.73f, CGRectGetMinY(group) + 9.22f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.48f, CGRectGetMinY(group) + 9.15f)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];
  }
}

@end
