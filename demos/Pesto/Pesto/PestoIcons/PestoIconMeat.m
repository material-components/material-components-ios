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
  UIColor* fillColor = [UIColor colorWithRed:0.04f green:0.041f blue:0.037f alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 18.75f) * 0.48642f + 0.05f) + 0.45f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 17.32f) * 0.46182f - 0.4f) + 0.9f, 18.75f,
      17.32f);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71f, CGRectGetMinY(group))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.52f, CGRectGetMinY(group) + 0.1f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.32f, CGRectGetMinY(group))
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.92f, CGRectGetMinY(group) + 0.03f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.5f, CGRectGetMinY(group) + 5.05f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.69f, CGRectGetMinY(group) + 0.6f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.3f, CGRectGetMinY(group) + 2.96f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.39f, CGRectGetMinY(group) + 5.18f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.46f, CGRectGetMinY(group) + 5.1f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.42f, CGRectGetMinY(group) + 5.14f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.04f, CGRectGetMinY(group) + 12.36f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.74f, CGRectGetMinY(group) + 7.14f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.35f, CGRectGetMinY(group) + 9.82f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.1f, CGRectGetMinY(group) + 17.32f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) - 0.21f, CGRectGetMinY(group) + 14.43f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.68f, CGRectGetMinY(group) + 17.18f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.25f, CGRectGetMinY(group) + 17.32f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.15f, CGRectGetMinY(group) + 17.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.2f, CGRectGetMinY(group) + 17.32f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7, CGRectGetMinY(group) + 15.45f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.68f, CGRectGetMinY(group) + 17.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.79f, CGRectGetMinY(group) + 16.07f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.43f, CGRectGetMinY(group) + 12.21f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.97f, CGRectGetMinY(group) + 13.93f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.86f, CGRectGetMinY(group) + 14.53f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.94f, CGRectGetMinY(group) + 2.31f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.31f, CGRectGetMinY(group) + 9.62f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.54f, CGRectGetMinY(group) + 5.19f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71f, CGRectGetMinY(group))
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.61f, CGRectGetMinY(group) + 0.83f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.68f, CGRectGetMinY(group))];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71f, CGRectGetMinY(group) + 1.33f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.95f, CGRectGetMinY(group) + 3.21f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.33f, CGRectGetMinY(group) + 1.33f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.88f, CGRectGetMinY(group) + 2.02f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.54f, CGRectGetMinY(group) + 11.22f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.05f, CGRectGetMinY(group) + 5.53f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 17.86f, CGRectGetMinY(group) + 9.13f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.82f, CGRectGetMinY(group) + 12.98f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.33f, CGRectGetMinY(group) + 12.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.62f, CGRectGetMinY(group) + 12.64f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.39f, CGRectGetMinY(group) + 14.27f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.34f, CGRectGetMinY(group) + 13.25f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.81f, CGRectGetMinY(group) + 13.54f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.08f, CGRectGetMinY(group) + 15.09f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.92f, CGRectGetMinY(group) + 14.51f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.49f, CGRectGetMinY(group) + 14.8f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.25f, CGRectGetMinY(group) + 15.99f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.42f, CGRectGetMinY(group) + 15.55f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.8f, CGRectGetMinY(group) + 15.99f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.18f, CGRectGetMinY(group) + 15.99f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.23f, CGRectGetMinY(group) + 15.99f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.2f, CGRectGetMinY(group) + 15.99f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.05f, CGRectGetMinY(group) + 15.41f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.72f, CGRectGetMinY(group) + 15.96f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.36f, CGRectGetMinY(group) + 15.78f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.36f, CGRectGetMinY(group) + 12.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.51f, CGRectGetMinY(group) + 14.76f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.23f, CGRectGetMinY(group) + 13.6f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.41f, CGRectGetMinY(group) + 6.04f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.62f, CGRectGetMinY(group) + 10.43f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.75f, CGRectGetMinY(group) + 8.01f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 4.51f, CGRectGetMinY(group) + 5.92f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.75f, CGRectGetMinY(group) + 1.42f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.99f, CGRectGetMinY(group) + 4.2f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.26f, CGRectGetMinY(group) + 1.86f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.71f, CGRectGetMinY(group) + 1.33f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.07f, CGRectGetMinY(group) + 1.36f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.39f, CGRectGetMinY(group) + 1.33f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 9.1f, CGRectGetMinY(group) + 7.97f);
    CGContextRotateCTM(context, 44.9f * (CGFloat)M_PI / 180);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-2.68f, -0.68f, 5.35f, 1.35f)
                                   cornerRadius:0.6f];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(group) + 6.95f, CGRectGetMinY(group) + 8.67f);
    CGContextRotateCTM(context, -44.9f * (CGFloat)M_PI / 180);

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-0.68f, -1.68f, 1.35f, 3.35f)
                                   cornerRadius:0.6f];
    [fillColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 3.99f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.71f, CGRectGetMinY(group) + 4.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.01f, CGRectGetMinY(group) + 3.99f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.71f, CGRectGetMinY(group) + 4.29f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 5.33f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.71f, CGRectGetMinY(group) + 5.03f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.01f, CGRectGetMinY(group) + 5.33f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 14.04f, CGRectGetMinY(group) + 4.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 13.74f, CGRectGetMinY(group) + 5.33f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.04f, CGRectGetMinY(group) + 5.03f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 3.99f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.04f, CGRectGetMinY(group) + 4.29f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 13.74f, CGRectGetMinY(group) + 3.99f)];
    [bezier2Path closePath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 6.66f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.37f, CGRectGetMinY(group) + 4.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 12.27f, CGRectGetMinY(group) + 6.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.37f, CGRectGetMinY(group) + 5.76f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 2.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.37f, CGRectGetMinY(group) + 3.56f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.27f, CGRectGetMinY(group) + 2.66f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 15.37f, CGRectGetMinY(group) + 4.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.48f, CGRectGetMinY(group) + 2.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.37f, CGRectGetMinY(group) + 3.56f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.37f, CGRectGetMinY(group) + 6.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.37f, CGRectGetMinY(group) + 5.76f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.48f, CGRectGetMinY(group) + 6.66f)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];
  }
}

@end
