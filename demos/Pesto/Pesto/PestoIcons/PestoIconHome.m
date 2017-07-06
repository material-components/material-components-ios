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

#import "PestoIconHome.h"

@implementation PestoIconHome

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
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41667f * CGRectGetWidth(frame),
                                      CGRectGetMinY(frame) + 0.83333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41667f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.58333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.58333f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.58333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.58333f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.79167f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.79167f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.91667f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.12500f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.08333f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.20833f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.20833f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83333f * CGRectGetHeight(frame))];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 0.41667f * CGRectGetWidth(frame),
                                         CGRectGetMinY(frame) + 0.83333f * CGRectGetHeight(frame))];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}

@end
