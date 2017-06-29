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

#import "PestoIconSpicy.h"

@implementation PestoIconSpicy

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
      CGRectGetMinX(frame) + (CGFloat)floor((CGRectGetWidth(frame) - 20.19f) * 0.50018f - 0.41f) + 0.91f,
      CGRectGetMinY(frame) + (CGFloat)floor((CGRectGetHeight(frame) - 16.36f) * 0.46418f + 0.12f) + 0.38f, 20.19f,
      16.36f);

  //// Group
  {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29f, CGRectGetMinY(group) + 2.06f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.75f, CGRectGetMinY(group) + 2.12f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.11f, CGRectGetMinY(group) + 2.06f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.93f, CGRectGetMinY(group) + 2.08f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.58f, CGRectGetMinY(group) + 2.97f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.98f, CGRectGetMinY(group) + 2.31f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.26f, CGRectGetMinY(group) + 2.52f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.6f, CGRectGetMinY(group) + 6.51f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.54f, CGRectGetMinY(group) + 3.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.36f, CGRectGetMinY(group) + 5.18f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 1.61f, CGRectGetMinY(group) + 6.55f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.6f, CGRectGetMinY(group) + 6.52f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.6f, CGRectGetMinY(group) + 6.53f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.58f, CGRectGetMinY(group) + 8.52f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 1.74f, CGRectGetMinY(group) + 7.2f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.24f, CGRectGetMinY(group) + 7.94f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.94f, CGRectGetMinY(group) + 12.63f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.48f, CGRectGetMinY(group) + 10.05f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.61f, CGRectGetMinY(group) + 11.45f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 12.96f, CGRectGetMinY(group) + 16.05f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.92f, CGRectGetMinY(group) + 14.39f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 10.37f, CGRectGetMinY(group) + 15.54f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.26f, CGRectGetMinY(group) + 16.36f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 14.05f, CGRectGetMinY(group) + 16.26f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 15.15f, CGRectGetMinY(group) + 16.36f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.93f, CGRectGetMinY(group) + 16.34f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.48f, CGRectGetMinY(group) + 16.36f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.71f, CGRectGetMinY(group) + 16.35f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 19, CGRectGetMinY(group) + 16.16f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.62f, CGRectGetMinY(group) + 16.32f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.32f, CGRectGetMinY(group) + 16.26f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 20.17f, CGRectGetMinY(group) + 15.47f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.48f, CGRectGetMinY(group) + 16.09f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 20.34f, CGRectGetMinY(group) + 16.09f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 18.06f, CGRectGetMinY(group) + 14)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 19.98f, CGRectGetMinY(group) + 14.81f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 18.57f, CGRectGetMinY(group) + 14.25f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 10.82f, CGRectGetMinY(group) + 8.61f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.41f, CGRectGetMinY(group) + 12.67f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 12.4f, CGRectGetMinY(group) + 11.24f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 7.54f, CGRectGetMinY(group) + 2.42f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 9.63f, CGRectGetMinY(group) + 6.65f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.7f, CGRectGetMinY(group) + 3.77f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29f, CGRectGetMinY(group) + 2.06f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.15f, CGRectGetMinY(group) + 2.19f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.73f, CGRectGetMinY(group) + 2.06f)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29f, CGRectGetMinY(group) + 3.39f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.83f, CGRectGetMinY(group) + 3.56f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.47f, CGRectGetMinY(group) + 3.39f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.66f, CGRectGetMinY(group) + 3.45f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 8.59f, CGRectGetMinY(group) + 6.64f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 7.79f, CGRectGetMinY(group) + 4.15f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.16f, CGRectGetMinY(group) + 5.31f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 9.68f, CGRectGetMinY(group) + 9.3f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 8.87f, CGRectGetMinY(group) + 7.53f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 9.16f, CGRectGetMinY(group) + 8.46f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 17.09f, CGRectGetMinY(group) + 15)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 11.39f, CGRectGetMinY(group) + 12.14f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.41f, CGRectGetMinY(group) + 13.67f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.88f, CGRectGetMinY(group) + 15.01f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 17.02f, CGRectGetMinY(group) + 15.01f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.95f, CGRectGetMinY(group) + 15.01f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 16.26f, CGRectGetMinY(group) + 15.02f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 16.68f, CGRectGetMinY(group) + 15.02f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 16.47f, CGRectGetMinY(group) + 15.02f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 13.21f, CGRectGetMinY(group) + 14.74f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 15.21f, CGRectGetMinY(group) + 15.02f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 14.19f, CGRectGetMinY(group) + 14.93f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.82f, CGRectGetMinY(group) + 11.63f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 10.8f, CGRectGetMinY(group) + 14.27f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 8.59f, CGRectGetMinY(group) + 13.2f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.73f, CGRectGetMinY(group) + 7.84f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.62f, CGRectGetMinY(group) + 10.57f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.58f, CGRectGetMinY(group) + 9.29f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.54f, CGRectGetMinY(group) + 7.53f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.67f, CGRectGetMinY(group) + 7.74f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.6f, CGRectGetMinY(group) + 7.64f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.91f, CGRectGetMinY(group) + 6.28f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.3f, CGRectGetMinY(group) + 7.14f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.98f, CGRectGetMinY(group) + 6.6f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.32f, CGRectGetMinY(group) + 4.08f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.81f, CGRectGetMinY(group) + 5.7f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.49f, CGRectGetMinY(group) + 4.63f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.06f, CGRectGetMinY(group) + 3.42f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.8f, CGRectGetMinY(group) + 3.76f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.34f, CGRectGetMinY(group) + 3.59f)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.29f, CGRectGetMinY(group) + 3.39f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.14f, CGRectGetMinY(group) + 3.4f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.21f, CGRectGetMinY(group) + 3.39f)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5f, CGRectGetMinY(group) + 6.69f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.83f, CGRectGetMinY(group) + 6.02f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.13f, CGRectGetMinY(group) + 6.69f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.83f, CGRectGetMinY(group) + 6.39f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5f, CGRectGetMinY(group) + 5.36f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 3.83f, CGRectGetMinY(group) + 5.66f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 4.13f, CGRectGetMinY(group) + 5.36f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.19f, CGRectGetMinY(group) + 4.67f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 4.88f, CGRectGetMinY(group) + 5.36f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.19f, CGRectGetMinY(group) + 5.05f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 5.86f, CGRectGetMinY(group) + 4)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 5.19f, CGRectGetMinY(group) + 4.3f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.49f, CGRectGetMinY(group) + 4)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 6.52f, CGRectGetMinY(group) + 4.67f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.22f, CGRectGetMinY(group) + 4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 6.52f, CGRectGetMinY(group) + 4.3f)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4.5f, CGRectGetMinY(group) + 6.69f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 6.52f, CGRectGetMinY(group) + 5.78f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 5.61f, CGRectGetMinY(group) + 6.69f)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(group) + 3.33f, CGRectGetMinY(group) + 4)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 2.67f, CGRectGetMinY(group) + 3.33f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.96f, CGRectGetMinY(group) + 4)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 2.67f, CGRectGetMinY(group) + 3.7f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.67f, CGRectGetMinY(group) + 1.33f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.67f, CGRectGetMinY(group) + 2.23f)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 1.77f, CGRectGetMinY(group) + 1.33f)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 0.67f)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 0.3f, CGRectGetMinY(group) + 1.33f)
          controlPoint2:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 1.04f)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 0.67f, CGRectGetMinY(group))
                   controlPoint1:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 0.3f)
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 0.3f, CGRectGetMinY(group))];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 3.33f)
                   controlPoint1:CGPointMake(CGRectGetMinX(group) + 2.5f, CGRectGetMinY(group))
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 1.5f)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 3.33f, CGRectGetMinY(group) + 4)
                   controlPoint1:CGPointMake(CGRectGetMinX(group) + 4, CGRectGetMinY(group) + 3.7f)
                   controlPoint2:CGPointMake(CGRectGetMinX(group) + 3.7f, CGRectGetMinY(group) + 4)];
    [bezier3Path closePath];
    [fillColor setFill];
    [bezier3Path fill];
  }
}

@end
