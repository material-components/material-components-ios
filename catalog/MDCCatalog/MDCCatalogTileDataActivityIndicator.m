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

#import "MDCCatalogTileDataActivityIndicator.h"

@implementation MDCCatalogTileDataActivityIndicator

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
  UIColor* fillColor = [UIColor colorWithRed:0 green:0.655 blue:0.969 alpha:1];

  UIBezierPath* bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(95.83, 25.66)];
  [bezierPath addCurveToPoint:CGPointMake(94.83, 25.69)
                controlPoint1:CGPointMake(95.5, 25.66)
                controlPoint2:CGPointMake(95.17, 25.68)];
  [bezierPath addLineToPoint:CGPointMake(94.83, 33.22)];
  [bezierPath addCurveToPoint:CGPointMake(95.83, 33.2)
                controlPoint1:CGPointMake(95.17, 33.21)
                controlPoint2:CGPointMake(95.5, 33.2)];
  [bezierPath addCurveToPoint:CGPointMake(125.97, 63.33)
                controlPoint1:CGPointMake(112.45, 33.2)
                controlPoint2:CGPointMake(125.97, 46.72)];
  [bezierPath addCurveToPoint:CGPointMake(95.83, 93.47)
                controlPoint1:CGPointMake(125.97, 79.95)
                controlPoint2:CGPointMake(112.45, 93.47)];
  [bezierPath addCurveToPoint:CGPointMake(65.7, 63.33)
                controlPoint1:CGPointMake(79.22, 93.47)
                controlPoint2:CGPointMake(65.7, 79.95)];
  [bezierPath addCurveToPoint:CGPointMake(69.37, 48.93)
                controlPoint1:CGPointMake(65.7, 58.12)
                controlPoint2:CGPointMake(67.03, 53.21)];
  [bezierPath addLineToPoint:CGPointMake(62.44, 45.92)];
  [bezierPath addCurveToPoint:CGPointMake(58.16, 63.33)
                controlPoint1:CGPointMake(59.71, 51.13)
                controlPoint2:CGPointMake(58.16, 57.05)];
  [bezierPath addCurveToPoint:CGPointMake(95.83, 101)
                controlPoint1:CGPointMake(58.16, 84.13)
                controlPoint2:CGPointMake(75.04, 101)];
  [bezierPath addCurveToPoint:CGPointMake(133.5, 63.33)
                controlPoint1:CGPointMake(116.63, 101)
                controlPoint2:CGPointMake(133.5, 84.13)];
  [bezierPath addCurveToPoint:CGPointMake(95.83, 25.66)
                controlPoint1:CGPointMake(133.5, 42.54)
                controlPoint2:CGPointMake(116.63, 25.66)];
  [bezierPath closePath];
  [fillColor setFill];
  [bezierPath fill];
}
#pragma clang diagnostic pop

@end
