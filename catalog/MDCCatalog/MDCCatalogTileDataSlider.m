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

#import "MDCCatalogTileDataSlider.h"

@implementation MDCCatalogTileDataSlider

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^completionBlock)() = ^() {
    [self draw:CGRectMake(0, 0, frame.size.width, frame.size.height)];
  };
  return [self drawImageWithFrame:frame completionBlock:completionBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* gradientColor = [UIColor colorWithRed:0.102 green:0.09 blue:0.094 alpha:0];
  UIColor* fillColor2 = [UIColor colorWithRed:0.209 green:0.73 blue:0.965 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithRed:0.407 green:0.798 blue:0.974 alpha:1];
  UIColor* fillColor4 = [UIColor colorWithRed:0.605 green:0.865 blue:0.983 alpha:1];
  UIColor* gradientColor1 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

  CGFloat gradient50Locations[] = {0, 1};
  CGGradientRef gradient50 = CGGradientCreateWithColors(
      colorSpace, (__bridge CFArrayRef) @[ (id)gradientColor1.CGColor, (id)gradientColor.CGColor ],
      gradient50Locations);

  CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 55.5,
                             floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                             floor((CGRectGetHeight(frame) - 55.5) * 0.12060 + 0.5));

  {
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, NULL);

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectanglePath = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                        floor(CGRectGetWidth(group2) * 1.00000 + 0.5) -
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                            floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
      [fillColor setFill];
      [rectanglePath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle2Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.84514 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.95558 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.84514 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect:rectangle2Rect];
      CGContextSaveGState(context);
      [rectangle2Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle2Rect) + -5.59 * CGRectGetWidth(rectangle2Rect) / 15.35,
              CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle2Rect) + 3.52 * CGRectGetWidth(rectangle2Rect) / 15.35,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.85971) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor setFill];
    [rectangle3Path fill];

    UIBezierPath* ovalPath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.81655) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.90288) -
                                                floor(CGRectGetWidth(group2) * 0.81655),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor setFill];
    [ovalPath fill];

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle4Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.49982 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.61025 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.49982 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect:rectangle4Rect];
      CGContextSaveGState(context);
      [rectangle4Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle4Rect) + -5.59 * CGRectGetWidth(rectangle4Rect) / 15.35,
              CGRectGetMidY(rectangle4Rect) + 0 * CGRectGetHeight(rectangle4Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle4Rect) + 3.52 * CGRectGetWidth(rectangle4Rect) / 15.35,
                      CGRectGetMidY(rectangle4Rect) + 0 * CGRectGetHeight(rectangle4Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.45683) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor2 setFill];
    [rectangle5Path fill];

    UIBezierPath* oval2Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.45683) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.54317) -
                                                floor(CGRectGetWidth(group2) * 0.45683),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor2 setFill];
    [oval2Path fill];
    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle6Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.28399 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.39442 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.28399 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRect:rectangle6Rect];
      CGContextSaveGState(context);
      [rectangle6Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle6Rect) + -5.59 * CGRectGetWidth(rectangle6Rect) / 15.35,
              CGRectGetMidY(rectangle6Rect) + 0 * CGRectGetHeight(rectangle6Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle6Rect) + 3.52 * CGRectGetWidth(rectangle6Rect) / 15.35,
                      CGRectGetMidY(rectangle6Rect) + 0 * CGRectGetHeight(rectangle6Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle7Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.29137) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor3 setFill];
    [rectangle7Path fill];

    UIBezierPath* oval3Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.24101) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.32734) -
                                                floor(CGRectGetWidth(group2) * 0.24101),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor3 setFill];
    [oval3Path fill];

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle8Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.14011 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.22176 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.14011 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRect:rectangle8Rect];
      CGContextSaveGState(context);
      [rectangle8Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle8Rect) + -5.65 * CGRectGetWidth(rectangle8Rect) / 11.35,
              CGRectGetMidY(rectangle8Rect) + 0 * CGRectGetHeight(rectangle8Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle8Rect) + 5.68 * CGRectGetWidth(rectangle8Rect) / 11.35,
                      CGRectGetMidY(rectangle8Rect) + 0 * CGRectGetHeight(rectangle8Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle9Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.14029) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor4 setFill];
    [rectangle9Path fill];

    UIBezierPath* oval4Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.09712) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.18345) -
                                                floor(CGRectGetWidth(group2) * 0.09712),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor4 setFill];
    [oval4Path fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  //// Cleanup
  CGGradientRelease(gradient50);
  CGColorSpaceRelease(colorSpace);
}

@end
