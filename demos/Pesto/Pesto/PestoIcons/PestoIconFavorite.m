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

#import "PestoIconFavorite.h"

@implementation PestoIconFavorite

+ (UIImage *)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// Color Declarations
  UIColor *fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];

  //// Bezier Drawing
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.88958 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.43958 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83458 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.08333 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.22500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64000 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.08333 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51167 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.08333 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22583 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.18417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21208 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.38500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.45458 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.15875 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.68750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.54542 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.15875 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.61500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.91667 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.81583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.91667 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22583 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.56042 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.83500 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.91667 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51167 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.77500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.88958 * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}

@end
