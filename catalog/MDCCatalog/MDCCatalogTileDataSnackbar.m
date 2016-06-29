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

#import "MDCCatalogTileDataSnackbar.h"

@implementation MDCCatalogTileDataSnackbar

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// General Declarations
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  //// Color Declarations
  UIColor* gradientColor = [UIColor colorWithRed:0.076 green:0.59 blue:0.945 alpha:1];
  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  //// Gradient Declarations
  CGFloat gradientLocations[] = {0, 0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef)
          @[ (id)gradientColor.CGColor, (id)gradientColor.CGColor, (id)gradientColor.CGColor ],
      gradientLocations);

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 55.6) * 0.21076 + 0.05) + 0.45, 139,
      55.6);

  //// Group
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.1);
    CGContextBeginTransparencyLayer(context, NULL);

    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(CGRectGetMinX(group), CGRectGetMinY(group), 139, 55.6);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(
        context, gradient,
        CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
                    CGRectGetMidY(rectangleRect) + 16.12 * CGRectGetHeight(rectangleRect) / 55.6),
        CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
                    CGRectGetMidY(rectangleRect) + -25.22 * CGRectGetHeight(rectangleRect) / 55.6),
        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  //// Rectangle 2 Drawing
  UIBezierPath* rectangle2Path = [UIBezierPath
      bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) +
                                        floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
                                    CGRectGetMinY(frame) +
                                        floor((CGRectGetHeight(frame) - 29) * 0.57103 + 0.45) +
                                        0.05,
                                    139, 29)];
  [fillColor setFill];
  [rectangle2Path fill];

  //// Cleanup
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

@end
