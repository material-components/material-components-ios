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

#import "MDCCatalogTileDataShadowLayer.h"

@implementation MDCCatalogTileDataShadowLayer

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"
+ (void)draw:(CGRect)frame {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
  UIColor* shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[shadowColor
                             colorWithAlphaComponent:CGColorGetAlpha(shadowColor.CGColor) * 0]];
  [shadow setShadowOffset:CGSizeMake(0.1, 2.1)];
  [shadow setShadowBlurRadius:6];
  NSShadow* shadow2 = [[NSShadow alloc] init];
  [shadow2 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.13]];
  [shadow2 setShadowOffset:CGSizeMake(0.1, 7.6)];
  [shadow2 setShadowBlurRadius:7];
  NSShadow* shadow3 = [[NSShadow alloc] init];
  [shadow3 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.08]];
  [shadow3 setShadowOffset:CGSizeMake(0.1, -3.6)];
  [shadow3 setShadowBlurRadius:4];
  NSShadow* shadow4 = [[NSShadow alloc] init];
  [shadow4 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.16]];
  [shadow4 setShadowOffset:CGSizeMake(4.1, 3.1)];
  [shadow4 setShadowBlurRadius:4];
  NSShadow* shadow7 = [[NSShadow alloc] init];
  [shadow7 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.16]];
  [shadow7 setShadowOffset:CGSizeMake(-4.1, 1.1)];
  [shadow7 setShadowBlurRadius:5];

  CGRect shadowLayer = CGRectMake(CGRectGetMinX(frame) + 50.2, CGRectGetMinY(frame) + 20.6,
                                  floor((CGRectGetWidth(frame) - 50.2) * 0.66473 + 49.9) - 49.4,
                                  floor((CGRectGetHeight(frame) - 20.6) * 0.62054 + 20.7) - 20.2);
  {
    UIBezierPath* bluePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(shadowLayer) +
                                          floor(CGRectGetWidth(shadowLayer) * 0.00000 + 0.5),
                                      CGRectGetMinY(shadowLayer) +
                                          floor(CGRectGetHeight(shadowLayer) * 0.17266 + 0.5),
                                      floor(CGRectGetWidth(shadowLayer) * 0.82969 + 0.5) -
                                          floor(CGRectGetWidth(shadowLayer) * 0.00000 + 0.5),
                                      floor(CGRectGetHeight(shadowLayer) * 1.00000 + 0.5) -
                                          floor(CGRectGetHeight(shadowLayer) * 0.17266 + 0.5))];
    [fillColor setFill];
    [bluePath fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.9);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectangle6Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow7.shadowOffset, shadow7.shadowBlurRadius,
                                  [shadow7.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle6Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle2Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius,
                                  [shadow2.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle2Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle3Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(shadowLayer) +
                                            floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) +
                                            0.6,
                                        CGRectGetMinY(shadowLayer) +
                                            floor(CGRectGetHeight(shadowLayer) * 0.00480 + 0.5),
                                        floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                            floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                        floor(CGRectGetHeight(shadowLayer) * 0.83213 + 0.5) -
                                            floor(CGRectGetHeight(shadowLayer) * 0.00480 + 0.5))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius,
                                  [shadow3.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle3Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectanglePath = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                  [shadow.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectanglePath fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle4Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow4.shadowOffset, shadow4.shadowBlurRadius,
                                  [shadow4.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle4Path fill];
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }
  }
}
#pragma clang diagnostic pop

@end
