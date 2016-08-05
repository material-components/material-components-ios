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

#import "PestoIconSettings.h"

@implementation PestoIconSettings

+ (UIImage*)drawTileImage:(CGRect)frame {
  void (^drawBlock)(CGRect) = ^(CGRect drawBlockFrame) {
    [self draw:CGRectMake(0, 0, drawBlockFrame.size.width, drawBlockFrame.size.height)];
  };
  return [self drawImageWithFrame:frame drawBlock:drawBlock];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
+ (void)draw:(CGRect)frame {
  //// Color Declarations
  UIColor* fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  //// Bezier Drawing
  UIBezierPath* bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.64583 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.35417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.41958 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64583 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.35417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.58042 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.35417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.41958 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.41958 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.64583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.58042 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.35417 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.64583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.41958 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64583 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.64583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.58042 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.58042 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.64583 * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.80958 * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.54083 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.81250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.81125 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.52750 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.81250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51417 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.80958 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.45917 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.81250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.48583 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.81125 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.47250 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.89750 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.39042 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.90250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.36375 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.90542 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.38417 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.90750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.37292 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.81917 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.21958 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.79375 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21042 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.81417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21042 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.80292 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.20708 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.69000 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.25208 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.61958 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21125 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.66833 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.23542 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.64500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22167 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.60375 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.10083 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.58333 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.08333 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.60250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.09083 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.59375 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.08333 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41667 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.08333 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.39625 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.10083 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.40625 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.08333 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.39750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.09083 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.38042 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.21125 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31000 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.25208 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.35500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.22167 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.33167 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.23583 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.20625 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.21042 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.18083 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21958 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.19667 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.20667 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.18583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.21042 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.09750 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.36375 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.10250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.39042 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.09208 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.37292 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.09458 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.38417 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.19042 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.45917 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.18750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.18875 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.47250 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.18750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.48625 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.19042 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.54083 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.18750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.51375 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.18875 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.52750 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.10250 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.60958 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.09750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.63625 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.09458 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.61583 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.09250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.62708 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.18083 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.78042 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.20625 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.78958 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.18583 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.78958 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.19708 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.79292 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.31000 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.74792 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.38042 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.78875 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.33167 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.76458 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.35500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.77833 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.39625 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.89917 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41667 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.91667 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.39750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.90917 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.40625 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.91667 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.58333 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.91667 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.60375 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.89917 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.59375 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.91667 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.60250 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.90917 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.61958 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.78875 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.69000 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.74792 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.64500 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.77833 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.66833 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.76417 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.79375 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.78958 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.81917 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.78042 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.80333 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.79333 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.81417 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.78958 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.90250 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.63625 * CGRectGetHeight(frame))];
  [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.89750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.60958 * CGRectGetHeight(frame))
                controlPoint1:CGPointMake(CGRectGetMinX(frame) + 0.90750 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.62708 * CGRectGetHeight(frame))
                controlPoint2:CGPointMake(CGRectGetMinX(frame) + 0.90542 * CGRectGetWidth(frame),
                                          CGRectGetMinY(frame) + 0.61583 * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.80958 * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.54083 * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}

@end
