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
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.88958f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.43958f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83458f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.08333f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.22500f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64000f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.08333f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51167f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31250f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.08333f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22583f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.18417f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21208f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.38500f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.45458f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.15875f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.68750f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.54542f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.15875f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.61500f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.91667f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.81583f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.91667f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22583f * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.56042f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.83500f * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.91667f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51167f * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.77500f * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64000f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.88958f * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}

@end
