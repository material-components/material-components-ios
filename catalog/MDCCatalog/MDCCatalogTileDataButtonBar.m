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

#import "MDCCatalogTileDataButtonBar.h"

@implementation MDCCatalogTileDataButtonBar

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
  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  CGRect buttonBar = CGRectMake(CGRectGetMinX(frame) - 10, CGRectGetMinY(frame) + 24,
                                floor((CGRectGetWidth(frame) + 10) * 0.87626 - 10) + 10.5,
                                floor((CGRectGetHeight(frame) - 24) * 0.42786 + 0.5));

  {
    UIBezierPath* rectanglePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(buttonBar) +
                                          floor(CGRectGetWidth(buttonBar) * 0.00000 + 0.5),
                                      CGRectGetMinY(buttonBar) +
                                          floor(CGRectGetHeight(buttonBar) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(buttonBar) * 1.00000) -
                                          floor(CGRectGetWidth(buttonBar) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(buttonBar) * 1.00000 + 0.45) -
                                          floor(CGRectGetHeight(buttonBar) * 0.00000 + 0.5) +
                                          0.05)];
    [fillColor setFill];
    [rectanglePath fill];

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.66280 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.58242 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.63925 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.55274 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55593 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50098 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.56484 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37859 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.54709 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37270 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.57487 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.58450 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.34986 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.61672 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.59706 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.34986 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.60669 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.63447 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37859 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59914 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.63943 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50098 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.62882 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55593 * CGRectGetHeight(buttonBar))];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.66280 * CGRectGetHeight(buttonBar))];
    [bezierPath closePath];
    [fillColor2 setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.66280 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.58242 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.63925 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.55274 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55593 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50098 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.56484 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.53314 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37859 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.54709 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37270 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.57487 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.58450 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.34986 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.61672 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.59706 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.34986 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.60669 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.63447 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37859 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.59914 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.63943 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.64842 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50098 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.62882 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55593 * CGRectGetHeight(buttonBar))];
    [bezier2Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.59078 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.66280 * CGRectGetHeight(buttonBar))];
    [bezier2Path closePath];
    [fillColor2 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.81020 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.53042 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.46155 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.81020 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83245 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.46155 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53042 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83245 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier3Path closePath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86438 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50776 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50205 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.47850 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.48992 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86438 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.48421 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.87631 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.44906 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.87700 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43764 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.87741 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44639 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.87770 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.44157 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86548 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37591 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86196 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86479 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86323 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37056 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.84761 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.38983 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83787 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37234 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84461 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38269 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84138 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37680 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83568 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.32507 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83285 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83551 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.32078 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83430 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80980 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80698 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.32507 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80715 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.32078 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80479 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37234 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.79504 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38983 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80127 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37680 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.79804 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.38287 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.78069 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77718 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37591 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77937 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37038 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77787 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.76565 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.43764 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.76634 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44906 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.76490 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44157 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.76525 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.44639 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.77850 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.47850 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77827 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.48421 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.49010 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77850 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50187 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77827 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50776 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.76634 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.54291 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.76565 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55432 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.76525 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.54558 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.76496 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55040 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.77718 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61606 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.78069 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77787 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77942 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.62141 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.79504 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.60214 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80479 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61962 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.79804 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.60928 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80127 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.61516 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80698 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.66690 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80980 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80715 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67118 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80836 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83285 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83568 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.66690 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83430 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83551 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.67118 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83787 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61962 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.84761 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.60214 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84138 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61516 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84461 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.60910 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86196 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86548 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61606 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.62159 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86479 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.87700 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.55432 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.87631 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.54291 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.87770 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55040 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.87741 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.54558 * CGRectGetHeight(buttonBar))];
    [bezier3Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))];
    [bezier3Path closePath];
    [fillColor2 setFill];
    [bezier3Path fill];

    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.81020 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.53042 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80115 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.46155 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.81020 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83245 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43354 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.46155 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.82133 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84150 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53042 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83245 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier4Path closePath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86438 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50776 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50205 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.47850 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86455 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.48992 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86438 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.48421 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.87631 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.44906 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.87700 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.43764 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.87741 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44639 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.87770 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.44157 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86548 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37591 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86196 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86479 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86323 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37056 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.84761 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.38983 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83787 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37234 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84461 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38269 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84138 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37680 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83568 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.32507 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83285 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83551 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.32078 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83430 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80980 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80698 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.32507 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.31757 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80715 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.32078 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80479 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37234 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.79504 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38983 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80127 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37680 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.79804 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.38287 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.78069 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77718 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37591 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77937 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37038 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77787 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37199 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.76565 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.43764 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.76634 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44906 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.76490 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.44157 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.76525 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.44639 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.77850 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.47850 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49598 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77827 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.48421 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.49010 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.77850 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77810 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50187 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77827 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.50776 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.76634 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.54291 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.76565 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55432 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.76525 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.54558 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.76496 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55040 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.77718 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61606 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.78069 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.77787 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.77942 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.62141 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.79504 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.60214 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80479 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61962 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.79804 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.60928 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80127 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.61516 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.80698 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.66690 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.80980 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.80715 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67118 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.80836 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83285 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.83568 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.66690 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.83430 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.67440 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.83551 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.67118 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.83787 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61962 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.84761 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.60214 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.84138 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61516 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.84461 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.60910 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86196 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.86548 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.61606 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.86329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.62159 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.86479 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.61998 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.87700 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.55432 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.87631 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.54291 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.87770 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.55040 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.87741 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.54558 * CGRectGetHeight(buttonBar))];
    [bezier4Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.86415 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.51347 * CGRectGetHeight(buttonBar))];
    [bezier4Path closePath];
    [fillColor2 setFill];
    [bezier4Path fill];

    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.33147 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.49581 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.40696 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.33147 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.36017 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.40696 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49581 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36017 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier5Path closePath];
    [bezier5Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.38040 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37585 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37424 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.52685 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.37989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50651 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.48011 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38733 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36651 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.32513 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.38733 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.51543 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.32513 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.37020 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53934 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.35510 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36363 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55682 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.54433 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.40058 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.64746 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.40917 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.62087 * CGRectGetHeight(buttonBar))];
    [bezier5Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.38040 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier5Path closePath];
    [fillColor2 setFill];
    [bezier5Path fill];

    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.33147 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.49581 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.31989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.40696 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.33147 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.36017 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.37110 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.40696 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.49581 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36017 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier6Path closePath];
    [bezier6Path
        moveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.38040 * CGRectGetWidth(buttonBar),
                                CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37585 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37424 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.52685 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.37989 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.50651 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.48011 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.38329 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.38733 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36651 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.45138 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.32513 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.33541 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.38733 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.34582 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.30836 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.51543 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.32513 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(buttonBar) + 0.37020 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.53934 * CGRectGetHeight(buttonBar))
          controlPoint1:CGPointMake(CGRectGetMinX(buttonBar) + 0.35510 * CGRectGetWidth(buttonBar),
                                    CGRectGetMinY(buttonBar) + 0.56735 * CGRectGetHeight(buttonBar))
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBar) + 0.36363 * CGRectGetWidth(buttonBar),
                            CGRectGetMinY(buttonBar) + 0.55682 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.54433 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.37176 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.55843 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.40058 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.64746 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.40917 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.62087 * CGRectGetHeight(buttonBar))];
    [bezier6Path
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBar) + 0.38040 * CGRectGetWidth(buttonBar),
                           CGRectGetMinY(buttonBar) + 0.53167 * CGRectGetHeight(buttonBar))];
    [bezier6Path closePath];
    [fillColor2 setFill];
    [bezier6Path fill];
  }
}
#pragma clang diagnostic pop

@end
