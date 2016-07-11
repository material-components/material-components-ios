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

#import "MDCCatalogTileDataTypography.h"

@implementation MDCCatalogTileDataTypography

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
  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  UIBezierPath* bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.48184 * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.26476 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41639 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.26476 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41639 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.48366 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.38021 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.48366 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.38021 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.26476 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31535 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.26476 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31535 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.22910 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.48184 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.22910 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.48184 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.26476 * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];

  UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
  [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                       CGRectGetMinY(frame) + 0.24850 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.29448 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.57741 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.29448 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.57741 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.32595 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.32595 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.43155 * CGRectGetHeight(frame))];
  [bezier2Path
      addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.55341 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.44720 * CGRectGetHeight(frame))
        controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.43878 * CGRectGetHeight(frame))
        controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.55105 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.44400 * CGRectGetHeight(frame))];
  [bezier2Path
      addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.56602 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45201 * CGRectGetHeight(frame))
        controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.55576 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45041 * CGRectGetHeight(frame))
        controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.55996 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45201 * CGRectGetHeight(frame))];
  [bezier2Path
      addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.57827 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45026 * CGRectGetHeight(frame))
        controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.57005 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45201 * CGRectGetHeight(frame))
        controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.57414 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.45143 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.57827 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.48313 * CGRectGetHeight(frame))];
  [bezier2Path
      addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.55520 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.48715 * CGRectGetHeight(frame))
        controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.57029 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.48581 * CGRectGetHeight(frame))
        controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.56261 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.48715 * CGRectGetHeight(frame))];
  [bezier2Path
      addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.51485 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.43313 * CGRectGetHeight(frame))
        controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.52830 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.48715 * CGRectGetHeight(frame))
        controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.51485 * CGRectGetWidth(frame),
                                  CGRectGetMinY(frame) + 0.46915 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.51485 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.32595 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.48919 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.32595 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.48919 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.29448 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.51485 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.29448 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.51485 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.24850 * CGRectGetHeight(frame))];
  [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.54987 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.24850 * CGRectGetHeight(frame))];
  [bezier2Path closePath];
  [fillColor setFill];
  [bezier2Path fill];
}
#pragma clang diagnostic pop

@end
