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

#import "MDCCatalogTileDataFlexibleHeader.h"

@implementation MDCCatalogTileDataFlexibleHeader

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
  UIColor* blue10 = [fillColor colorWithAlphaComponent:0.1];
  UIColor* blue5 = [fillColor colorWithAlphaComponent:0.05];

  CGRect flexibleHeaderView = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                                         floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                                         floor((CGRectGetHeight(frame) - 24) * 0.61145 + 0.5));
  {
    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.05);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectanglePath = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(flexibleHeaderView) +
                                     floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                                 CGRectGetMinY(flexibleHeaderView) +
                                     floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.5),
                                 floor(CGRectGetWidth(flexibleHeaderView) * 1.00000 + 0.5) -
                                     floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                                 floor(CGRectGetHeight(flexibleHeaderView) * 1.00000 + 0.4) -
                                     floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.5) +
                                     0.1)];
      [blue5 setFill];
      [rectanglePath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle2Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(flexibleHeaderView) +
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               CGRectGetMinY(flexibleHeaderView) +
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00031 - 0.33) +
                                   0.83,
                               floor(CGRectGetWidth(flexibleHeaderView) * 1.00000 + 0.5) -
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               floor(CGRectGetHeight(flexibleHeaderView) * 0.83989 + 0.42) -
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00031 - 0.33) -
                                   0.75)];
    [blue10 setFill];
    [rectangle2Path fill];

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(flexibleHeaderView) +
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               CGRectGetMinY(flexibleHeaderView) +
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 - 0.3) + 0.8,
                               floor(CGRectGetWidth(flexibleHeaderView) * 1.00000 + 0.5) -
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               floor(CGRectGetHeight(flexibleHeaderView) * 0.64045 + 0.4) -
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 - 0.3) -
                                   0.7)];
    [blue10 setFill];
    [rectangle3Path fill];

    UIBezierPath* rectangle4Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(flexibleHeaderView) +
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               CGRectGetMinY(flexibleHeaderView) +
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.4) + 0.1,
                               floor(CGRectGetWidth(flexibleHeaderView) * 1.00000 + 0.5) -
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               floor(CGRectGetHeight(flexibleHeaderView) * 0.47441 + 0.4) -
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.4))];
    [blue10 setFill];
    [rectangle4Path fill];

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(flexibleHeaderView) +
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               CGRectGetMinY(flexibleHeaderView) +
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.4) + 0.1,
                               floor(CGRectGetWidth(flexibleHeaderView) * 1.00000 + 0.5) -
                                   floor(CGRectGetWidth(flexibleHeaderView) * 0.00000 + 0.5),
                               floor(CGRectGetHeight(flexibleHeaderView) * 0.36205 + 0.4) -
                                   floor(CGRectGetHeight(flexibleHeaderView) * 0.00000 + 0.4))];
    [fillColor setFill];
    [rectangle5Path fill];
  }
}
#pragma clang diagnostic pop

@end
