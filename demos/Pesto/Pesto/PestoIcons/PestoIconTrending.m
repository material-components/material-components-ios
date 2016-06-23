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

#import "PestoIconTrending.h"

@implementation PestoIconTrending

+ (UIImage *)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width,
                          drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// Color Declarations
  UIColor *fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];

  //// Bezier Drawing
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  [bezierPath
      moveToPoint:CGPointMake(
                      CGRectGetMinX(frame) + 0.66667 * CGRectGetWidth(frame),
                      CGRectGetMinY(frame) + 0.25000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.76208 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.34542 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.55875 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.54875 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.39208 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.38208 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.08333 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.69125 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.14208 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.75000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.39208 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.50000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.55875 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.66667 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.82125 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.40458 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.91667 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.50000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.91667 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.25000 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) +
                                             0.66667 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) +
                                             0.25000 * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}

@end
