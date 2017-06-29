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
  UIColor* fillColor = [UIColor colorWithRed:0.04f green:0.041f blue:0.037f alpha:1];

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 19.83f) * 0.52934f + 0.06f) + 0.44f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 17.25f) * 0.47003f - 0.32f) + 0.82f, 19.83f,
      17.25f);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 12.13f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 2.56f, CGRectGetMinY(group) + 12.13f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 14.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.15f, CGRectGetMinY(group) + 12.13f)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 13.28f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.56f, CGRectGetMinY(group) + 17.25f)
          controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 16.1f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.15f, CGRectGetMinY(group) + 17.25f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 17.25f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 14.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.68f, CGRectGetMinY(group) + 17.25f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 16.1f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 12.13f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 13.28f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.68f, CGRectGetMinY(group) + 12.13f)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 13.47f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 14.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.95f, CGRectGetMinY(group) + 13.47f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 14.02f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 15.92f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 15.37f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 17.95f, CGRectGetMinY(group) + 15.92f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 2.56f, CGRectGetMinY(group) + 15.92f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 14.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.88f, CGRectGetMinY(group) + 15.92f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 15.37f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.56f, CGRectGetMinY(group) + 13.47f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 14.02f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.88f, CGRectGetMinY(group) + 13.47f)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 17.27f, CGRectGetMinY(group) + 13.47f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 11.23f, CGRectGetMinY(group) + 1.87f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.76f, CGRectGetMinY(group) + 1.68f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.06f, CGRectGetMinY(group) + 1.87f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.89f, CGRectGetMinY(group) + 1.81f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.1f, CGRectGetMinY(group) + 1.68f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.3f, CGRectGetMinY(group) + 1.22f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.56f, CGRectGetMinY(group) + 1.22f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.16f, CGRectGetMinY(group) + 1.68f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.84f, CGRectGetMinY(group) + 1.94f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.42f, CGRectGetMinY(group) + 1.94f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.16f, CGRectGetMinY(group) + 0.73f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.9f, CGRectGetMinY(group) + 1.41f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 7.9f, CGRectGetMinY(group) + 0.99f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.7f, CGRectGetMinY(group) + 0.73f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.13f, CGRectGetMinY(group) - 0.24f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.72f, CGRectGetMinY(group) - 0.25f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.7f, CGRectGetMinY(group) + 1.68f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.96f, CGRectGetMinY(group) + 0.99f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.96f, CGRectGetMinY(group) + 1.41f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 11.23f, CGRectGetMinY(group) + 1.87f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.57f, CGRectGetMinY(group) + 1.81f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 11.4f, CGRectGetMinY(group) + 1.87f)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92f, CGRectGetMinY(group) + 2.32f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 12.24f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.45f, CGRectGetMinY(group) + 2.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 6.77f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 13.57f)
          controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 12.98f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.6f, CGRectGetMinY(group) + 13.57f)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 13.57f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 12.24f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.24f, CGRectGetMinY(group) + 13.57f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 12.98f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92f, CGRectGetMinY(group) + 2.32f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.83f, CGRectGetMinY(group) + 6.77f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.38f, CGRectGetMinY(group) + 2.32f)];
    [bezier3Path closePath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92f, CGRectGetMinY(group) + 3.66f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 12.24f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.66f, CGRectGetMinY(group) + 3.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.5f, CGRectGetMinY(group) + 7.5f)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 12.24f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.92f, CGRectGetMinY(group) + 3.66f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.33f, CGRectGetMinY(group) + 7.5f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.18f, CGRectGetMinY(group) + 3.66f)];
    [bezier3Path closePath];
    [fillColor setFill];
    [bezier3Path fill];

    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01f, CGRectGetMinY(group) + 10.45f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.34f, CGRectGetMinY(group) + 9.79f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.64f, CGRectGetMinY(group) + 10.45f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.34f, CGRectGetMinY(group) + 10.15f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.69f, CGRectGetMinY(group) + 5.44f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.34f, CGRectGetMinY(group) + 7.39f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.29f, CGRectGetMinY(group) + 5.44f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.36f, CGRectGetMinY(group) + 6.11f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.06f, CGRectGetMinY(group) + 5.44f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.36f, CGRectGetMinY(group) + 5.74f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.69f, CGRectGetMinY(group) + 6.78f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.36f, CGRectGetMinY(group) + 6.48f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.06f, CGRectGetMinY(group) + 6.78f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.68f, CGRectGetMinY(group) + 9.79f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.03f, CGRectGetMinY(group) + 6.78f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.68f, CGRectGetMinY(group) + 8.13f)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.01f, CGRectGetMinY(group) + 10.45f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.68f, CGRectGetMinY(group) + 10.15f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.38f, CGRectGetMinY(group) + 10.45f)];
    [bezier4Path closePath];
    [fillColor setFill];
    [bezier4Path fill];
  }
}

@end
