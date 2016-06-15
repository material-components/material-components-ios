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

#import "MDCCatalogTileDataAppBar.h"

@implementation MDCCatalogTileDataAppBar

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
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                             floor((CGRectGetWidth(frame) - 24.5) * 1.02783 + 24.45) - 23.95,
                             floor((CGRectGetHeight(frame) - 24) * 0.42786 + 0.5));

  {
    UIBezierPath* rectanglePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.05,
                                      floor(CGRectGetHeight(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.5) + 0.05)];
    [fillColor setFill];
    [rectanglePath fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.2);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* bezierPath = [UIBezierPath bezierPath];
      [bezierPath
          moveToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                  CGRectGetMinY(group2) + 0.42819 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.42819 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.39251 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.39251 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.42819 * CGRectGetHeight(group2))];
      [bezierPath closePath];
      [bezierPath
          moveToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                  CGRectGetMinY(group2) + 0.51740 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.51740 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.48171 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.48171 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.51740 * CGRectGetHeight(group2))];
      [bezierPath closePath];
      [bezierPath
          moveToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                  CGRectGetMinY(group2) + 0.60660 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.60660 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.22445 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.57092 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.57092 * CGRectGetHeight(group2))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(group2) + 0.11734 * CGRectGetWidth(group2),
                                     CGRectGetMinY(group2) + 0.60660 * CGRectGetHeight(group2))];
      [bezierPath closePath];
      [fillColor2 setFill];
      [bezierPath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }
  }
}

@end
