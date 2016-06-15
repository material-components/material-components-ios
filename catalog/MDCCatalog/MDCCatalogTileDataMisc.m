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

#import "MDCCatalogTileDataMisc.h"

@implementation MDCCatalogTileDataMisc

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  CGFloat fillColorRGBA[4];
  [fillColor getRed:&fillColorRGBA[0]
              green:&fillColorRGBA[1]
               blue:&fillColorRGBA[2]
              alpha:&fillColorRGBA[3]];

  UIColor* color2 = [UIColor colorWithRed:(fillColorRGBA[0] * 0.7)
                                    green:(fillColorRGBA[1] * 0.7)
                                     blue:(fillColorRGBA[2] * 0.7)
                                    alpha:(fillColorRGBA[3] * 0.7 + 0.3)];
  UIColor* fillColor2 = [UIColor colorWithRed:0.605 green:0.865 blue:0.983 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithRed:0.308 green:0.764 blue:0.97 alpha:1];
  UIColor* fillColor4 = [UIColor colorWithRed:0.407 green:0.798 blue:0.974 alpha:1];
  UIColor* fillColor5 = [UIColor colorWithRed:0.506 green:0.831 blue:0.978 alpha:1];

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[color2 colorWithAlphaComponent:CGColorGetAlpha(color2.CGColor) * 0.19]];
  [shadow setShadowOffset:CGSizeMake(0.1, 1.1)];
  [shadow setShadowBlurRadius:1.1];

  {
    CGContextSaveGState(context);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* clippingRectPath =
        [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24.5,
                                                    CGRectGetMinY(frame) + 24, 139, 80)];
    [clippingRectPath addClip];

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 82.7, CGRectGetMinY(frame) + 105.76)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 114.64, CGRectGetMinY(frame) + 135.99)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.48, CGRectGetMinY(frame) + 124.73)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.8, CGRectGetMinY(frame) + 155.05)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 185.18, CGRectGetMinY(frame) + 124.67)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.8, CGRectGetMinY(frame) + 94.3)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.75, CGRectGetMinY(frame) + 94.35)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.43, CGRectGetMinY(frame) + 64.03)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 82.7, CGRectGetMinY(frame) + 105.76)];
    [bezierPath closePath];
    [fillColor2 setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 124.07, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 93.7, CGRectGetMinY(frame) + 33.35)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 184.82, CGRectGetMinY(frame) + 124.36)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 191.92, CGRectGetMinY(frame) + 55.92)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 184.82, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.45, CGRectGetMinY(frame) - 27.4)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.07, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path closePath];
    [fillColor3 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 113.47, CGRectGetMinY(frame) + 53.5)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 116.13, CGRectGetMinY(frame) + 50.84)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 116.13, CGRectGetMinY(frame) + 41.97)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 118.58, CGRectGetMinY(frame) + 48.39)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 118.58, CGRectGetMinY(frame) + 44.42)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 107.26, CGRectGetMinY(frame) + 41.97)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 113.68, CGRectGetMinY(frame) + 39.52)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 109.71, CGRectGetMinY(frame) + 39.52)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 104.6, CGRectGetMinY(frame) + 44.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 113.47, CGRectGetMinY(frame) + 53.5)];
    [bezier3Path closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [bezier3Path fill];
    CGContextRestoreGState(context);

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(frame) + 62.9, CGRectGetMinY(frame) + 63.83);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 43.4, 43.7)];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 83.48, CGRectGetMinY(frame) + 83.64)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 86.03, CGRectGetMinY(frame) + 81.08)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 86.03, CGRectGetMinY(frame) + 72.21)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 88.48, CGRectGetMinY(frame) + 78.64)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 88.48, CGRectGetMinY(frame) + 74.66)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 77.16, CGRectGetMinY(frame) + 72.21)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 83.58, CGRectGetMinY(frame) + 69.76)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 79.61, CGRectGetMinY(frame) + 69.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 74.6, CGRectGetMinY(frame) + 74.77)];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3.37)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 5.94, CGRectGetMinY(frame) + 86.16)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 7.25, CGRectGetMinY(frame) + 102.63)];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 107.88)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 3.1, CGRectGetMinY(frame) + 124.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 33.48, CGRectGetMinY(frame) + 155.14)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 63.85, CGRectGetMinY(frame) + 124.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 94.23, CGRectGetMinY(frame) + 94.39)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 83.48, CGRectGetMinY(frame) + 83.64)];
    [bezier4Path closePath];
    [fillColor4 setFill];
    [bezier4Path fill];

    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 82.47, CGRectGetMinY(frame) + 44.5)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 95.29, CGRectGetMinY(frame) + 31.68)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 117.34, CGRectGetMinY(frame) + 9.63)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 85.2, CGRectGetMinY(frame) - 19.83)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) - 27)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 2.1, CGRectGetMinY(frame) + 3.37)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) + 33.75)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 43.23, CGRectGetMinY(frame) + 23)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) + 33.75)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 62.85, CGRectGetMinY(frame) + 64.12)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 73.6, CGRectGetMinY(frame) + 53.37)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 76.26, CGRectGetMinY(frame) + 56.03)];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 85.13, CGRectGetMinY(frame) + 56.03)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 78.71, CGRectGetMinY(frame) + 58.48)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 82.68, CGRectGetMinY(frame) + 58.48)];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 85.13, CGRectGetMinY(frame) + 47.16)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 87.58, CGRectGetMinY(frame) + 53.58)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 87.58, CGRectGetMinY(frame) + 49.61)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 82.47, CGRectGetMinY(frame) + 44.5)];
    [bezier5Path closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor5 setFill];
    [bezier5Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 104.2, CGRectGetMinY(frame) + 83.75)];
    [bezier6Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 106.86, CGRectGetMinY(frame) + 86.41)];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 115.73, CGRectGetMinY(frame) + 86.41)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 109.31, CGRectGetMinY(frame) + 88.86)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 113.28, CGRectGetMinY(frame) + 88.86)];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 115.73, CGRectGetMinY(frame) + 77.54)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 118.18, CGRectGetMinY(frame) + 83.96)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 118.18, CGRectGetMinY(frame) + 79.98)];
    [bezier6Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 113.07, CGRectGetMinY(frame) + 74.87)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [bezier6Path fill];
    CGContextRestoreGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }
}

@end
