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

#import "MDCCatalogTileDataSpritedAnimationView.h"

@implementation MDCCatalogTileDataSpritedAnimationView

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^completionBlock)() = ^() {
    [self draw:CGRectMake(0, 0, frame.size.width, frame.size.height)];
  };
  return [self drawImageWithFrame:frame completionBlock:completionBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* blue60 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.6];
  UIColor* blue40 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.4];
  UIColor* blue20 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];

  CGRect spritedButtonAnimation =
      CGRectMake(CGRectGetMinX(frame) + 56.33, CGRectGetMinY(frame) + 14.3,
                 floor((CGRectGetWidth(frame) - 56.33) * 0.57217 + 56.16) - 55.66,
                 floor((CGRectGetHeight(frame) - 14.3) * 0.53546 + 14.1) - 13.6);

  {
    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.2);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* bezierPath = [UIBezierPath bezierPath];
      [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                              0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                          CGRectGetMinY(spritedButtonAnimation) +
                                              0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.64143 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.28787 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.42929 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.35858 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.28787 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.28786 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.42929 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.50001 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.28786 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.64142 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.35858 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.71213 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.57071 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.64143 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.71213 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.64142 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.57071 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.50001 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath closePath];
      [blue20 setFill];
      [bezierPath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.66830 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.30849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.58169 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.48170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.43170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.30850 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.33170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.25850 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.41831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.43170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.51831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.33170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.69151 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.41830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74151 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.51830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.56831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.69150 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.66830 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.74151 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.58170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.56830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.48170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.66830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.30849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path closePath];
    [blue40 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.61300 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.27146 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.51641 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.24558 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.46464 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.43876 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.27146 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.38701 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24558 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.48360 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.43876 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.53536 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.38699 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.72854 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.48359 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.75442 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.53535 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.56123 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.72855 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.61300 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75443 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.51641 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.56124 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.46464 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.61300 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.27146 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path closePath];
    [blue60 setFill];
    [bezier3Path fill];

    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24999 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24999 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74999 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74999 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75001 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75001 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path closePath];
    [fillColor setFill];
    [bezier4Path fill];

    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.90000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.27950 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.72050 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.27950 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.27950 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.72050 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.27950 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.72050 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.72050 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.22399 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.22400 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.77600 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.22399 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.77600 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.77600 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.22400 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.77600 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path closePath];
    [fillColor setFill];
    [bezier5Path fill];
  }
}

@end
