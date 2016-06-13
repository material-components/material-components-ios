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

#import "MDCCatalogTileDataPageControl.h"

@implementation MDCCatalogTileDataPageControl

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor10 = [UIColor colorWithRed:0.506 green:0.831 blue:0.976 alpha:1];
  UIColor* gradientColor2 = [UIColor colorWithRed:0.075 green:0.592 blue:0.945 alpha:0.3];
  UIColor* fillColor7 = [UIColor colorWithRed:0.902 green:0.965 blue:0.996 alpha:0.5];
  UIColor* fillColor8 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
  UIColor* color2 = [UIColor colorWithRed:0.902 green:0.965 blue:0.996 alpha:0.3];

  CGFloat gradient2Locations[] = {0.28, 0.68, 0.98};
  CGGradientRef gradient2 = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor2.CGColor, (id)[gradientColor2 colorWithAlphaComponent:0.5].CGColor,
        (id)gradientColor.CGColor
      ],
      gradient2Locations);

  CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 30.75, CGRectGetMinY(frame) + 51,
                             floor((CGRectGetWidth(frame) - 30.75) * 0.81399 + 0.5),
                             floor((CGRectGetHeight(frame) - 51) * 0.22127 + 0.5));
  {
    UIBezierPath* ovalPath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.82031 + 0.5),
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.49) +
                                                0.01,
                                            floor(CGRectGetWidth(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetWidth(group2) * 0.82031 + 0.5),
                                            floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [fillColor10 setFill];
    [ovalPath fill];

    UIBezierPath* rectanglePath = [UIBezierPath
        bezierPathWithRoundedRect:CGRectMake(
                                      CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                      floor(CGRectGetWidth(group2) * 0.58984) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.49))
                     cornerRadius:11.4];
    [fillColor10 setFill];
    [rectanglePath fill];

    {
      CGContextSaveGState(context);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* clipPath = [UIBezierPath
          bezierPathWithRoundedRect:CGRectMake(
                                        CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                        floor(CGRectGetWidth(group2) * 0.39922 + 0.4) -
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.1,
                                        floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.49))
                       cornerRadius:11.4];
      [clipPath addClip];

      CGRect rectangle2Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                     floor(CGRectGetWidth(group2) * 0.39922 + 0.4) -
                         floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.1,
                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49));
      UIBezierPath* rectangle2Path =
          [UIBezierPath bezierPathWithRoundedRect:rectangle2Rect cornerRadius:11.4];
      CGContextSaveGState(context);
      [rectangle2Path addClip];
      CGContextDrawLinearGradient(
          context, gradient2,
          CGPointMake(CGRectGetMidX(rectangle2Rect) + -23.3 * CGRectGetWidth(rectangle2Rect) / 51.1,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 23),
          CGPointMake(CGRectGetMidX(rectangle2Rect) + 15.87 * CGRectGetWidth(rectangle2Rect) / 51.1,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 23),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* oval2Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(
                                     CGRectGetMinX(group2) +
                                         floor(CGRectGetWidth(group2) * 0.10977 + 0.45) + 0.05,
                                     CGRectGetMinY(group2) +
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                     floor(CGRectGetWidth(group2) * 0.28945 + 0.45) -
                                         floor(CGRectGetWidth(group2) * 0.10977 + 0.45),
                                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [color2 setFill];
    [oval2Path fill];

    UIBezierPath* oval3Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.21836 - 0.45) +
                                                0.95,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00053 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.39805 - 0.45) -
                                                floor(CGRectGetWidth(group2) * 0.21836 - 0.45),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00053 + 0.5))];
    [fillColor7 setFill];
    [oval3Path fill];

    UIBezierPath* oval4Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(
                                     CGRectGetMinX(group2) +
                                         floor(CGRectGetWidth(group2) * 0.32930 + 0.35) + 0.15,
                                     CGRectGetMinY(group2) +
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                     floor(CGRectGetWidth(group2) * 0.50898 + 0.35) -
                                         floor(CGRectGetWidth(group2) * 0.32930 + 0.35),
                                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [fillColor8 setFill];
    [oval4Path fill];
  }

  CGGradientRelease(gradient2);
  CGColorSpaceRelease(colorSpace);
}

@end
