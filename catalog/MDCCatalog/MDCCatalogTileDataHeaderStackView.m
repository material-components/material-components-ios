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

#import "MDCCatalogTileDataHeaderStackView.h"

@implementation MDCCatalogTileDataHeaderStackView

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
#pragma clang diagnostic ignored "-Wassign-enum"
+ (void)draw:(CGRect)frame {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0.076 green:0.59 blue:0.945 alpha:1];
  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  CGFloat fillColorRGBA[4];
  [fillColor getRed:&fillColorRGBA[0]
              green:&fillColorRGBA[1]
               blue:&fillColorRGBA[2]
              alpha:&fillColorRGBA[3]];

  UIColor* color = [UIColor colorWithRed:(fillColorRGBA[0] * 0.6)
                                   green:(fillColorRGBA[1] * 0.6)
                                    blue:(fillColorRGBA[2] * 0.6)
                                   alpha:(fillColorRGBA[3] * 0.6 + 0.4)];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
  UIColor* blue80 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.56];

  CGFloat gradientLocations[] = {0.14, 0.51, 1};

  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor.CGColor, (id)[gradientColor colorWithAlphaComponent:0.5].CGColor,
        (id)UIColor.clearColor.CGColor
      ],
      gradientLocations);

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[color colorWithAlphaComponent:CGColorGetAlpha(color.CGColor) * 0.4]];
  [shadow setShadowOffset:CGSizeMake(0.1, 1.1)];
  [shadow setShadowBlurRadius:1.1];

  CGRect headerStackView = CGRectMake(CGRectGetMinX(frame) + 26, CGRectGetMinY(frame) + 24,
                                      floor((CGRectGetWidth(frame) - 26) * 0.85185 + 0.5),
                                      floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));
  {
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(headerStackView) +
                                          floor(CGRectGetWidth(headerStackView) * 0.00000 + 0.5),
                                      CGRectGetMinY(headerStackView) +
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(headerStackView) * 1.00000 + 0.5) -
                                          floor(CGRectGetWidth(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetHeight(headerStackView) * 1.00000 + 0.5) -
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5))];
    [rectangle5Path addClip];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangleRect = CGRectMake(
          CGRectGetMinX(headerStackView) + floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
          CGRectGetMinY(headerStackView) +
              floor(CGRectGetHeight(headerStackView) * 0.30469 - 0.48) + 0.98,
          floor(CGRectGetWidth(headerStackView) * 1.00362) -
              floor(CGRectGetWidth(headerStackView) * -0.01087),
          floor(CGRectGetHeight(headerStackView) * 1.00031 - 0.13) -
              floor(CGRectGetHeight(headerStackView) * 0.30469 - 0.48) - 0.35);
      UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
      CGContextSaveGState(context);
      [rectanglePath addClip];
      CGContextDrawLinearGradient(
          context, gradient,
          CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 140,
                      CGRectGetMidY(rectangleRect) + 3.99 * CGRectGetHeight(rectangleRect) / 55.65),
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 140,
              CGRectGetMidY(rectangleRect) + 26.77 * CGRectGetHeight(rectangleRect) / 55.65),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle2Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(headerStackView) +
                                   floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
                               CGRectGetMinY(headerStackView) +
                                   floor(CGRectGetHeight(headerStackView) * 0.21687 - 0.15) + 0.65,
                               floor(CGRectGetWidth(headerStackView) * 1.00362) -
                                   floor(CGRectGetWidth(headerStackView) * -0.01087),
                               floor(CGRectGetHeight(headerStackView) * 0.57937 - 0.15) -
                                   floor(CGRectGetHeight(headerStackView) * 0.21687 - 0.15))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [blue80 setFill];
    [rectangle2Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(headerStackView) +
                                          floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
                                      CGRectGetMinY(headerStackView) +
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(headerStackView) * 1.00362) -
                                          floor(CGRectGetWidth(headerStackView) * -0.01087),
                                      floor(CGRectGetHeight(headerStackView) * 0.36250 + 0.5) -
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [rectangle3Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* rectangle4Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(headerStackView) +
                                   floor(CGRectGetWidth(headerStackView) * 0.03569 - 0.43) + 0.93,
                               CGRectGetMinY(headerStackView) +
                                   floor(CGRectGetHeight(headerStackView) * 0.54500 - 0.1) + 0.6,
                               floor(CGRectGetWidth(headerStackView) * 0.37518 - 0.28) -
                                   floor(CGRectGetWidth(headerStackView) * 0.03569 - 0.43) - 0.15,
                               floor(CGRectGetHeight(headerStackView) * 0.58000 + 0.1) -
                                   floor(CGRectGetHeight(headerStackView) * 0.54500 - 0.1) - 0.2)];
    [fillColor2 setFill];
    [rectangle4Path fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}
#pragma clang diagnostic pop

@end
