/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0f (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0f

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
  UIColor* fillColor = [UIColor colorWithRed:0.04f green:0.041f blue:0.037f alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 14.08f) * 0.47855f - 0.08f) + 0.58f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 26.64f) * 0.58262f + 0.26f) + 0.24f, 14.08f,
      26.64f);

  //// Group
  {
    //// Rectangle Drawing
    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 6.12f,
                                                           CGRectGetMinY(group), 1.8f, 5.15f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectanglePath fill];

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 8.72f, CGRectGetMinY(group) + 3.33f);
    CGContextRotateCTM(context, 44.9f * (CGFloat)M_PI / 180);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.9f, -2.58f, 1.8f, 5.15f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Rectangle 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 5.32f, CGRectGetMinY(group) + 3.38f);
    CGContextRotateCTM(context, 44.9f * (CGFloat)M_PI / 180);

    UIBezierPath* rectangle3Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.58f, -0.9f, 5.15f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle3Path fill];

    CGContextRestoreGState(context);

    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 7.03f, CGRectGetMinY(group) + 6.8f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.46f, CGRectGetMinY(group) + 9.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.25f, CGRectGetMinY(group) + 6.8f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.41f, CGRectGetMinY(group) + 7.9f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.94f, CGRectGetMinY(group) + 10.76f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.22f, CGRectGetMinY(group) + 9.92f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.05f, CGRectGetMinY(group) + 10.33f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.2f, CGRectGetMinY(group) + 15.12f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.59f, CGRectGetMinY(group) + 12.18f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.87f, CGRectGetMinY(group) + 13.76f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.26f, CGRectGetMinY(group) + 21.13f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.7f, CGRectGetMinY(group) + 17.23f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.4f, CGRectGetMinY(group) + 19.25f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.27f, CGRectGetMinY(group) + 24.28f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.74f, CGRectGetMinY(group) + 22.17f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.36f, CGRectGetMinY(group) + 23.36f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.34f, CGRectGetMinY(group) + 24.85f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.68f, CGRectGetMinY(group) + 24.7f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.1f, CGRectGetMinY(group) + 24.91f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.97f, CGRectGetMinY(group) + 24.26f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.56f, CGRectGetMinY(group) + 24.79f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.81f, CGRectGetMinY(group) + 24.48f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.11f, CGRectGetMinY(group) + 20.22f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.83f, CGRectGetMinY(group) + 23.11f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.45f, CGRectGetMinY(group) + 21.81f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.05f, CGRectGetMinY(group) + 14.31f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.78f, CGRectGetMinY(group) + 18.62f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.61f, CGRectGetMinY(group) + 16.51f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.02f, CGRectGetMinY(group) + 10.27f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.39f, CGRectGetMinY(group) + 12.61f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.38f, CGRectGetMinY(group) + 11.33f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.89f, CGRectGetMinY(group) + 6.87f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.45f, CGRectGetMinY(group) + 8.63f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.84f, CGRectGetMinY(group) + 7.3f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.05f, CGRectGetMinY(group) + 6.8f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.63f, CGRectGetMinY(group) + 6.81f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.37f, CGRectGetMinY(group) + 6.8f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 7.03f, CGRectGetMinY(group) + 6.8f)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 7.25f, CGRectGetMinY(group) + 26.64f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01f, CGRectGetMinY(group) + 25.53f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.5f, CGRectGetMinY(group) + 26.64f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.73f, CGRectGetMinY(group) + 26.26f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.65f, CGRectGetMinY(group) + 21.87f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.89f, CGRectGetMinY(group) + 24.41f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.16f, CGRectGetMinY(group) + 22.99f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.47f, CGRectGetMinY(group) + 15.53f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.73f, CGRectGetMinY(group) + 19.89f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1, CGRectGetMinY(group) + 17.75f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.22f, CGRectGetMinY(group) + 10.32f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.09f, CGRectGetMinY(group) + 13.96f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) - 0.23f, CGRectGetMinY(group) + 12.12f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.92f, CGRectGetMinY(group) + 8.62f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.37f, CGRectGetMinY(group) + 9.73f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.61f, CGRectGetMinY(group) + 9.16f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.06f, CGRectGetMinY(group) + 5.1f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.01f, CGRectGetMinY(group) + 6.76f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 5.43f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.43f, CGRectGetMinY(group) + 5.02f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.17f, CGRectGetMinY(group) + 5.05f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.3f, CGRectGetMinY(group) + 5.02f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 7.66f, CGRectGetMinY(group) + 5.02f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.97f, CGRectGetMinY(group) + 5.08f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.77f, CGRectGetMinY(group) + 5.02f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.88f, CGRectGetMinY(group) + 5.04f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.28f, CGRectGetMinY(group) + 5.14f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.07f, CGRectGetMinY(group) + 5.1f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.17f, CGRectGetMinY(group) + 5.11f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.7f, CGRectGetMinY(group) + 9.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.85f, CGRectGetMinY(group) + 5.7f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.93f, CGRectGetMinY(group) + 7.45f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.79f, CGRectGetMinY(group) + 14.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.32f, CGRectGetMinY(group) + 11.49f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.05f, CGRectGetMinY(group) + 13.39f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.75f, CGRectGetMinY(group) + 20.91f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.32f, CGRectGetMinY(group) + 17.01f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.46f, CGRectGetMinY(group) + 19.23f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.4f, CGRectGetMinY(group) + 25.32f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.13f, CGRectGetMinY(group) + 22.39f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.42f, CGRectGetMinY(group) + 23.95f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.81f, CGRectGetMinY(group) + 26.56f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.05f, CGRectGetMinY(group) + 25.79f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.55f, CGRectGetMinY(group) + 26.36f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.25f, CGRectGetMinY(group) + 26.64f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.62f, CGRectGetMinY(group) + 26.61f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.44f, CGRectGetMinY(group) + 26.64f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle 4 Drawing
    UIBezierPath* rectangle4Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 1.2f,
                                                           CGRectGetMinY(group) + 10.27f, 5.85f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle4Path fill];

    //// Rectangle 5 Drawing
    UIBezierPath* rectangle5Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 7.05f,
                                                           CGRectGetMinY(group) + 12.82f, 5.85f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle5Path fill];

    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 1.12f,
                                                           CGRectGetMinY(group) + 15.37f, 4.2f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle6Path fill];

    //// Rectangle 7 Drawing
    UIBezierPath* rectangle7Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 3.6f,
                                                           CGRectGetMinY(group) + 20.52f, 2.85f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle7Path fill];

    //// Rectangle 8 Drawing
    UIBezierPath* rectangle8Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group) + 8.72f,
                                                           CGRectGetMinY(group) + 17.93f, 3.4f, 1.8f)
                                   cornerRadius:0.8f];
    [fillColor setFill];
    [rectangle8Path fill];
  }
}

@end
