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

#import <UIKit/UIKit.h>

#import "MDCCatalogTiles.h"

UIImage *MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc) {
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);
  drawFunc(frame);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
#pragma clang diagnostic ignored "-Wconversion"
void MDCCatalogDrawActivityIndicatorTile(CGRect frame) {
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

void MDCCatalogDrawAppBarTile(CGRect frame) {
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

void MDCCatalogDrawButtonBarTile(CGRect frame) {
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

void MDCCatalogDrawButtonsTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 77.75) * 0.22200 + 0.02) + 0.48,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 24.25) * 0.30382 + 0.47) + 0.03, 77.75,
      24.25);
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.95);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group), 77.75, 24.25)
                                   cornerRadius:3.4];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  UIBezierPath* ovalPath = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(
                                   CGRectGetMinX(frame) +
                                       floor((CGRectGetWidth(frame) - 49.8) * 0.82308 - 0.25) +
                                       0.75,
                                   CGRectGetMinY(frame) +
                                       floor((CGRectGetHeight(frame) - 49.7) * 0.25641 + 0.2) + 0.3,
                                   49.8, 49.7)];
  [fillColor setFill];
  [ovalPath fill];
}

void MDCCatalogDrawCollectionsTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* white40 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
  UIColor* blue60 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.6];
  UIColor* white60 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
  UIColor* white80 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
  UIColor* white30 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];

  CGRect group2 =
      CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.13021 + 0.02) + 0.48,
                 CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.15484 - 0.38) + 0.88,
                 floor(CGRectGetWidth(frame) * 0.86984 - 0.03) -
                     floor(CGRectGetWidth(frame) * 0.13021 + 0.02) + 0.05,
                 floor(CGRectGetHeight(frame) * 0.67177 + 0.5) -
                     floor(CGRectGetHeight(frame) * 0.15484 - 0.38) - 0.88);

  {
    UIBezierPath* collectionsPath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00018 + 0.48) + 0.02,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.02,
                                      floor(CGRectGetWidth(group2) * 0.99982 + 0.47) -
                                          floor(CGRectGetWidth(group2) * 0.00018 + 0.48),
                                      floor(CGRectGetHeight(group2) * 0.99969 + 0.38) -
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.1)];
    [fillColor setFill];
    [collectionsPath fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.6);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectangle2Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00036 + 0.45) + 0.05,
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.02,
                                        floor(CGRectGetWidth(group2) * 0.66667 - 0.2) -
                                            floor(CGRectGetWidth(group2) * 0.00036 + 0.45) + 0.65,
                                        floor(CGRectGetHeight(group2) * 0.99969 + 0.38) -
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.48) + 0.1)];
      [white60 setFill];
      [rectangle2Path fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 0.33333 + 0.15) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.35,
                                      floor(CGRectGetHeight(group2) * 0.50016 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05)];
    [white80 setFill];
    [rectangle3Path fill];

    UIBezierPath* rectangle4Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.33333 + 0.15) + 0.35,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.50016 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.66667 - 0.2) -
                                          floor(CGRectGetWidth(group2) * 0.33333 + 0.15) + 0.35,
                                      floor(CGRectGetHeight(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetHeight(group2) * 0.50016 + 0.5) + 0.05)];
    [blue60 setFill];
    [rectangle4Path fill];

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.66667 - 0.2) + 0.7,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 1.00000 + 0.45) -
                                          floor(CGRectGetWidth(group2) * 0.66667 - 0.2) - 0.65,
                                      floor(CGRectGetHeight(group2) * 0.50016 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.00031 + 0.45) + 0.05)];
    [white30 setFill];
    [rectangle5Path fill];

    UIBezierPath* rectangle6Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.16667 + 0.32) + 0.18,
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.24992 + 0.45) + 0.05,
                                      floor(CGRectGetWidth(group2) * 0.85203 + 0.02) -
                                          floor(CGRectGetWidth(group2) * 0.16667 + 0.32) + 0.3,
                                      floor(CGRectGetHeight(group2) * 0.74977 + 0.4) -
                                          floor(CGRectGetHeight(group2) * 0.24992 + 0.45) + 0.05)];
    [white40 setFill];
    [rectangle6Path fill];
  }
}

void MDCCatalogDrawDialogsTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 77.75) * 0.22200 + 0.02) + 0.48,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 24.25) * 0.30382 + 0.47) + 0.03, 77.75,
      24.25);
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.95);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectanglePath =
        [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(group),
                                                           CGRectGetMinY(group), 77.75, 24.25)
                                   cornerRadius:3.4];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  UIBezierPath* ovalPath = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(
                                   CGRectGetMinX(frame) +
                                       floor((CGRectGetWidth(frame) - 49.8) * 0.82308 - 0.25) +
                                       0.75,
                                   CGRectGetMinY(frame) +
                                       floor((CGRectGetHeight(frame) - 49.7) * 0.25641 + 0.2) + 0.3,
                                   49.8, 49.7)];
  [fillColor setFill];
  [ovalPath fill];
}

void MDCCatalogDrawFlexibleHeaderTile(CGRect frame) {
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

void MDCCatalogDrawHeaderStackViewTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0.076 green:0.59 blue:0.945 alpha:1];
  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  CGFloat fillColorRGBA[4];
  [fillColor getRed:&fillColorRGBA[0]
              green:&fillColorRGBA[1]
               blue:&fillColorRGBA[2]
              alpha:&fillColorRGBA[3]];

  UIColor* color = [UIColor colorWithRed:(fillColorRGBA[0] * 0.6)
                                   green:(fillColorRGBA[1] * 0.6)
                                    blue:(fillColorRGBA[2] * 0.6)
                                   alpha:(fillColorRGBA[3] * 0.6 + 0.4)];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
  UIColor* blue80 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.56];

  CGFloat gradientLocations[] = {0.14, 0.51, 1};

  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor.CGColor, (id)[gradientColor colorWithAlphaComponent:0.5].CGColor,
        (id)UIColor.clearColor.CGColor
      ],
      gradientLocations);

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[color colorWithAlphaComponent:CGColorGetAlpha(color.CGColor) * 0.4]];
  [shadow setShadowOffset:CGSizeMake(0.1, 1.1)];
  [shadow setShadowBlurRadius:1.1];

  CGRect headerStackView = CGRectMake(CGRectGetMinX(frame) + 26, CGRectGetMinY(frame) + 24,
                                      floor((CGRectGetWidth(frame) - 26) * 0.85185 + 0.5),
                                      floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));
  {
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(headerStackView) +
                                          floor(CGRectGetWidth(headerStackView) * 0.00000 + 0.5),
                                      CGRectGetMinY(headerStackView) +
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(headerStackView) * 1.00000 + 0.5) -
                                          floor(CGRectGetWidth(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetHeight(headerStackView) * 1.00000 + 0.5) -
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5))];
    [rectangle5Path addClip];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangleRect = CGRectMake(
          CGRectGetMinX(headerStackView) + floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
          CGRectGetMinY(headerStackView) +
              floor(CGRectGetHeight(headerStackView) * 0.30469 - 0.48) + 0.98,
          floor(CGRectGetWidth(headerStackView) * 1.00362) -
              floor(CGRectGetWidth(headerStackView) * -0.01087),
          floor(CGRectGetHeight(headerStackView) * 1.00031 - 0.13) -
              floor(CGRectGetHeight(headerStackView) * 0.30469 - 0.48) - 0.35);
      UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
      CGContextSaveGState(context);
      [rectanglePath addClip];
      CGContextDrawLinearGradient(
          context, gradient,
          CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 140,
                      CGRectGetMidY(rectangleRect) + 3.99 * CGRectGetHeight(rectangleRect) / 55.65),
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 140,
              CGRectGetMidY(rectangleRect) + 26.77 * CGRectGetHeight(rectangleRect) / 55.65),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle2Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(headerStackView) +
                                   floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
                               CGRectGetMinY(headerStackView) +
                                   floor(CGRectGetHeight(headerStackView) * 0.21687 - 0.15) + 0.65,
                               floor(CGRectGetWidth(headerStackView) * 1.00362) -
                                   floor(CGRectGetWidth(headerStackView) * -0.01087),
                               floor(CGRectGetHeight(headerStackView) * 0.57937 - 0.15) -
                                   floor(CGRectGetHeight(headerStackView) * 0.21687 - 0.15))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [blue80 setFill];
    [rectangle2Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(headerStackView) +
                                          floor(CGRectGetWidth(headerStackView) * -0.01087) + 0.5,
                                      CGRectGetMinY(headerStackView) +
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5),
                                      floor(CGRectGetWidth(headerStackView) * 1.00362) -
                                          floor(CGRectGetWidth(headerStackView) * -0.01087),
                                      floor(CGRectGetHeight(headerStackView) * 0.36250 + 0.5) -
                                          floor(CGRectGetHeight(headerStackView) * 0.00000 + 0.5))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [rectangle3Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* rectangle4Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(headerStackView) +
                                   floor(CGRectGetWidth(headerStackView) * 0.03569 - 0.43) + 0.93,
                               CGRectGetMinY(headerStackView) +
                                   floor(CGRectGetHeight(headerStackView) * 0.54500 - 0.1) + 0.6,
                               floor(CGRectGetWidth(headerStackView) * 0.37518 - 0.28) -
                                   floor(CGRectGetWidth(headerStackView) * 0.03569 - 0.43) - 0.15,
                               floor(CGRectGetHeight(headerStackView) * 0.58000 + 0.1) -
                                   floor(CGRectGetHeight(headerStackView) * 0.54500 - 0.1) - 0.2)];
    [fillColor2 setFill];
    [rectangle4Path fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawInkTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 139.5) * 0.49485 + 0.5),
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 80.1) * 0.32043 - 0.4) + 0.9, 139.5,
      80.1);

  UIBezierPath* rectanglePath =
      [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24,
                                                  CGRectGetMinY(frame) + 24, 139.5, 80.1)];
  [fillColor setFill];
  [rectanglePath fill];
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.5);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* clipPath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group), CGRectGetMinY(group), 139.5, 80.1)];
    [clipPath addClip];

    UIBezierPath* ovalPath =
        [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group) + 53.65,
                                                          CGRectGetMinY(group) - 5.05, 90.2, 90.2)];
    [fillColor2 setFill];
    [ovalPath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }
}

void MDCCatalogDrawMiscTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  CGFloat fillColorRGBA[4];
  [fillColor getRed:&fillColorRGBA[0]
              green:&fillColorRGBA[1]
               blue:&fillColorRGBA[2]
              alpha:&fillColorRGBA[3]];

  UIColor* color2 = [UIColor colorWithRed:(fillColorRGBA[0] * 0.7)
                                    green:(fillColorRGBA[1] * 0.7)
                                     blue:(fillColorRGBA[2] * 0.7)
                                    alpha:(fillColorRGBA[3] * 0.7 + 0.3)];
  UIColor* fillColor2 = [UIColor colorWithRed:0.605 green:0.865 blue:0.983 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithRed:0.308 green:0.764 blue:0.97 alpha:1];
  UIColor* fillColor4 = [UIColor colorWithRed:0.407 green:0.798 blue:0.974 alpha:1];
  UIColor* fillColor5 = [UIColor colorWithRed:0.506 green:0.831 blue:0.978 alpha:1];

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[color2 colorWithAlphaComponent:CGColorGetAlpha(color2.CGColor) * 0.19]];
  [shadow setShadowOffset:CGSizeMake(0.1, 1.1)];
  [shadow setShadowBlurRadius:1.1];

  {
    CGContextSaveGState(context);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* clippingRectPath =
        [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24.5,
                                                    CGRectGetMinY(frame) + 24, 139, 80)];
    [clippingRectPath addClip];

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 82.7, CGRectGetMinY(frame) + 105.76)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 114.64, CGRectGetMinY(frame) + 135.99)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.48, CGRectGetMinY(frame) + 124.73)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.8, CGRectGetMinY(frame) + 155.05)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 185.18, CGRectGetMinY(frame) + 124.67)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.8, CGRectGetMinY(frame) + 94.3)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.75, CGRectGetMinY(frame) + 94.35)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.43, CGRectGetMinY(frame) + 64.03)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 82.7, CGRectGetMinY(frame) + 105.76)];
    [bezierPath closePath];
    [fillColor2 setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 124.07, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 93.7, CGRectGetMinY(frame) + 33.35)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 184.82, CGRectGetMinY(frame) + 124.36)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 191.92, CGRectGetMinY(frame) + 55.92)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 184.82, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 154.45, CGRectGetMinY(frame) - 27.4)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 124.07, CGRectGetMinY(frame) + 2.97)];
    [bezier2Path closePath];
    [fillColor3 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 113.47, CGRectGetMinY(frame) + 53.5)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 116.13, CGRectGetMinY(frame) + 50.84)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 116.13, CGRectGetMinY(frame) + 41.97)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 118.58, CGRectGetMinY(frame) + 48.39)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 118.58, CGRectGetMinY(frame) + 44.42)];
    [bezier3Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 107.26, CGRectGetMinY(frame) + 41.97)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 113.68, CGRectGetMinY(frame) + 39.52)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 109.71, CGRectGetMinY(frame) + 39.52)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 104.6, CGRectGetMinY(frame) + 44.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 113.47, CGRectGetMinY(frame) + 53.5)];
    [bezier3Path closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [bezier3Path fill];
    CGContextRestoreGState(context);

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(frame) + 62.9, CGRectGetMinY(frame) + 63.83);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 43.4, 43.7)];
    [fillColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);

    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 83.48, CGRectGetMinY(frame) + 83.64)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 86.03, CGRectGetMinY(frame) + 81.08)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 86.03, CGRectGetMinY(frame) + 72.21)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 88.48, CGRectGetMinY(frame) + 78.64)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 88.48, CGRectGetMinY(frame) + 74.66)];
    [bezier4Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 77.16, CGRectGetMinY(frame) + 72.21)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 83.58, CGRectGetMinY(frame) + 69.76)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 79.61, CGRectGetMinY(frame) + 69.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 74.6, CGRectGetMinY(frame) + 74.77)];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3.37)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 5.94, CGRectGetMinY(frame) + 86.16)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 7.25, CGRectGetMinY(frame) + 102.63)];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 107.88)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 3.1, CGRectGetMinY(frame) + 124.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 33.48, CGRectGetMinY(frame) + 155.14)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 63.85, CGRectGetMinY(frame) + 124.76)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 94.23, CGRectGetMinY(frame) + 94.39)];
    [bezier4Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 83.48, CGRectGetMinY(frame) + 83.64)];
    [bezier4Path closePath];
    [fillColor4 setFill];
    [bezier4Path fill];

    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 82.47, CGRectGetMinY(frame) + 44.5)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 95.29, CGRectGetMinY(frame) + 31.68)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 117.34, CGRectGetMinY(frame) + 9.63)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 85.2, CGRectGetMinY(frame) - 19.83)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) - 27)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 2.1, CGRectGetMinY(frame) + 3.37)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) + 33.75)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 43.23, CGRectGetMinY(frame) + 23)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 32.47, CGRectGetMinY(frame) + 33.75)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 62.85, CGRectGetMinY(frame) + 64.12)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 73.6, CGRectGetMinY(frame) + 53.37)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 76.26, CGRectGetMinY(frame) + 56.03)];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 85.13, CGRectGetMinY(frame) + 56.03)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 78.71, CGRectGetMinY(frame) + 58.48)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 82.68, CGRectGetMinY(frame) + 58.48)];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 85.13, CGRectGetMinY(frame) + 47.16)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 87.58, CGRectGetMinY(frame) + 53.58)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 87.58, CGRectGetMinY(frame) + 49.61)];
    [bezier5Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 82.47, CGRectGetMinY(frame) + 44.5)];
    [bezier5Path closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor5 setFill];
    [bezier5Path fill];
    CGContextRestoreGState(context);

    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 104.2, CGRectGetMinY(frame) + 83.75)];
    [bezier6Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 106.86, CGRectGetMinY(frame) + 86.41)];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 115.73, CGRectGetMinY(frame) + 86.41)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 109.31, CGRectGetMinY(frame) + 88.86)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 113.28, CGRectGetMinY(frame) + 88.86)];
    [bezier6Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 115.73, CGRectGetMinY(frame) + 77.54)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 118.18, CGRectGetMinY(frame) + 83.96)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 118.18, CGRectGetMinY(frame) + 79.98)];
    [bezier6Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 113.07, CGRectGetMinY(frame) + 74.87)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [fillColor setFill];
    [bezier6Path fill];
    CGContextRestoreGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }
}

void MDCCatalogDrawNavigationBarTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor = [UIColor colorWithRed:0.184 green:0.571 blue:0.828 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:0.994 green:0.994 blue:0.994 alpha:1];
  UIColor* textForeground = [UIColor colorWithRed:0.996 green:0.996 blue:0.996 alpha:0.2];
  UIColor* gradientColor2 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];

  CGFloat gradientLocations[] = {0.14, 0.5, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor2.CGColor, (id)[gradientColor2 colorWithAlphaComponent:0.5].CGColor,
        (id)gradientColor.CGColor
      ],
      gradientLocations);
  {
    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangleRect =
          CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 48.38, 139, 55.65);
      UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
      CGContextSaveGState(context);
      [rectanglePath addClip];
      CGContextDrawLinearGradient(
          context, gradient,
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
              CGRectGetMidY(rectangleRect) + -16.12 * CGRectGetHeight(rectangleRect) / 55.65),
          CGPointMake(
              CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
              CGRectGetMidY(rectangleRect) + 25.22 * CGRectGetHeight(rectangleRect) / 55.65),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle2Path =
        [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) + 24.5,
                                                    CGRectGetMinY(frame) + 24, 139, 29)];
    [fillColor setFill];
    [rectangle2Path fill];

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 147.88, CGRectGetMinY(frame) + 42.73)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 145.07, CGRectGetMinY(frame) + 40.19)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 38.51)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 146.21, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 34.77)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 144.54, CGRectGetMinY(frame) + 33.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 34.59)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 147.16, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 148.07, CGRectGetMinY(frame) + 33.89)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 151.12, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 149.26, CGRectGetMinY(frame) + 33.89)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 150.17, CGRectGetMinY(frame) + 33.45)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 152.8, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 34.77)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 149.46, CGRectGetMinY(frame) + 42.74)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 38.51)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 152.26, CGRectGetMinY(frame) + 40.19)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezierPath closePath];
    [fillColor2 setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 147.88, CGRectGetMinY(frame) + 42.73)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 145.07, CGRectGetMinY(frame) + 40.19)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 38.51)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 146.21, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 143.22, CGRectGetMinY(frame) + 34.77)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 144.54, CGRectGetMinY(frame) + 33.45)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 34.59)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 147.16, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 148.07, CGRectGetMinY(frame) + 33.89)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 151.12, CGRectGetMinY(frame) + 33.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 149.26, CGRectGetMinY(frame) + 33.89)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 150.17, CGRectGetMinY(frame) + 33.45)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 36.45)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 152.8, CGRectGetMinY(frame) + 33.45)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 34.77)];
    [bezier2Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(frame) + 149.46, CGRectGetMinY(frame) + 42.74)
          controlPoint1:CGPointMake(CGRectGetMinX(frame) + 154.12, CGRectGetMinY(frame) + 38.51)
          controlPoint2:CGPointMake(CGRectGetMinX(frame) + 152.26, CGRectGetMinY(frame) + 40.19)];
    [bezier2Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 148.67, CGRectGetMinY(frame) + 43.45)];
    [bezier2Path closePath];
    [fillColor2 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 35.18)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 35.18)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 36.27)];
    [bezier3Path closePath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 39)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 39)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 37.91)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 37.91)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 39)];
    [bezier3Path closePath];
    [bezier3Path
        moveToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 45.16, CGRectGetMinY(frame) + 40.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 40.63)];
    [bezier3Path
        addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 35.35, CGRectGetMinY(frame) + 41.72)];
    [bezier3Path closePath];
    [fillColor2 setFill];
    [bezier3Path fill];

    CGRect labelRect =
        CGRectMake(CGRectGetMinX(frame) + 57, CGRectGetMinY(frame) + 29.86, 36.21, 17);
    {
      NSString* textContent = @"AppBar";
      NSMutableParagraphStyle* labelStyle = [NSMutableParagraphStyle new];
      labelStyle.alignment = NSTextAlignmentCenter;

      NSDictionary* labelFontAttributes = @{
        NSFontAttributeName : [UIFont fontWithName:@"Roboto-Medium" size:11],
        NSForegroundColorAttributeName : textForeground,
        NSParagraphStyleAttributeName : labelStyle
      };

      CGFloat labelTextHeight =
          [textContent boundingRectWithSize:CGSizeMake(labelRect.size.width, INFINITY)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:labelFontAttributes
                                    context:nil]
              .size.height;
      CGContextSaveGState(context);
      CGContextClipToRect(context, labelRect);
      [textContent drawInRect:CGRectMake(CGRectGetMinX(labelRect),
                                         CGRectGetMinY(labelRect) +
                                             (CGRectGetHeight(labelRect) - labelTextHeight) / 2,
                                         CGRectGetWidth(labelRect), labelTextHeight)
               withAttributes:labelFontAttributes];
      CGContextRestoreGState(context);
    }
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawPageControlTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor10 = [UIColor colorWithRed:0.506 green:0.831 blue:0.976 alpha:1];
  UIColor* gradientColor2 = [UIColor colorWithRed:0.075 green:0.592 blue:0.945 alpha:0.3];
  UIColor* fillColor7 = [UIColor colorWithRed:0.902 green:0.965 blue:0.996 alpha:0.5];
  UIColor* fillColor8 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
  UIColor* color2 = [UIColor colorWithRed:0.902 green:0.965 blue:0.996 alpha:0.3];

  CGFloat gradient2Locations[] = {0.28, 0.68, 0.98};
  CGGradientRef gradient2 = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor2.CGColor, (id)[gradientColor2 colorWithAlphaComponent:0.5].CGColor,
        (id)gradientColor.CGColor
      ],
      gradient2Locations);

  CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 30.75, CGRectGetMinY(frame) + 51,
                             floor((CGRectGetWidth(frame) - 30.75) * 0.81399 + 0.5),
                             floor((CGRectGetHeight(frame) - 51) * 0.22127 + 0.5));
  {
    UIBezierPath* ovalPath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.82031 + 0.5),
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.49) +
                                                0.01,
                                            floor(CGRectGetWidth(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetWidth(group2) * 0.82031 + 0.5),
                                            floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [fillColor10 setFill];
    [ovalPath fill];

    UIBezierPath* rectanglePath = [UIBezierPath
        bezierPathWithRoundedRect:CGRectMake(
                                      CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                      floor(CGRectGetWidth(group2) * 0.58984) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                          floor(CGRectGetHeight(group2) * 0.00000 + 0.49))
                     cornerRadius:11.4];
    [fillColor10 setFill];
    [rectanglePath fill];

    {
      CGContextSaveGState(context);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* clipPath = [UIBezierPath
          bezierPathWithRoundedRect:CGRectMake(
                                        CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                        floor(CGRectGetWidth(group2) * 0.39922 + 0.4) -
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.1,
                                        floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                            floor(CGRectGetHeight(group2) * 0.00000 + 0.49))
                       cornerRadius:11.4];
      [clipPath addClip];

      CGRect rectangle2Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                     floor(CGRectGetWidth(group2) * 0.39922 + 0.4) -
                         floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.1,
                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49));
      UIBezierPath* rectangle2Path =
          [UIBezierPath bezierPathWithRoundedRect:rectangle2Rect cornerRadius:11.4];
      CGContextSaveGState(context);
      [rectangle2Path addClip];
      CGContextDrawLinearGradient(
          context, gradient2,
          CGPointMake(CGRectGetMidX(rectangle2Rect) + -23.3 * CGRectGetWidth(rectangle2Rect) / 51.1,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 23),
          CGPointMake(CGRectGetMidX(rectangle2Rect) + 15.87 * CGRectGetWidth(rectangle2Rect) / 51.1,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 23),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* oval2Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(
                                     CGRectGetMinX(group2) +
                                         floor(CGRectGetWidth(group2) * 0.10977 + 0.45) + 0.05,
                                     CGRectGetMinY(group2) +
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                     floor(CGRectGetWidth(group2) * 0.28945 + 0.45) -
                                         floor(CGRectGetWidth(group2) * 0.10977 + 0.45),
                                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [color2 setFill];
    [oval2Path fill];

    UIBezierPath* oval3Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.21836 - 0.45) +
                                                0.95,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00053 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.39805 - 0.45) -
                                                floor(CGRectGetWidth(group2) * 0.21836 - 0.45),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00053 + 0.5))];
    [fillColor7 setFill];
    [oval3Path fill];

    UIBezierPath* oval4Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(
                                     CGRectGetMinX(group2) +
                                         floor(CGRectGetWidth(group2) * 0.32930 + 0.35) + 0.15,
                                     CGRectGetMinY(group2) +
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49) + 0.01,
                                     floor(CGRectGetWidth(group2) * 0.50898 + 0.35) -
                                         floor(CGRectGetWidth(group2) * 0.32930 + 0.35),
                                     floor(CGRectGetHeight(group2) * 0.99947 + 0.49) -
                                         floor(CGRectGetHeight(group2) * 0.00000 + 0.49))];
    [fillColor8 setFill];
    [oval4Path fill];
  }

  CGGradientRelease(gradient2);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawShadowLayerTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
  UIColor* shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[shadowColor
                             colorWithAlphaComponent:CGColorGetAlpha(shadowColor.CGColor) * 0]];
  [shadow setShadowOffset:CGSizeMake(0.1, 2.1)];
  [shadow setShadowBlurRadius:6];
  NSShadow* shadow2 = [[NSShadow alloc] init];
  [shadow2 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.13]];
  [shadow2 setShadowOffset:CGSizeMake(0.1, 7.6)];
  [shadow2 setShadowBlurRadius:7];
  NSShadow* shadow3 = [[NSShadow alloc] init];
  [shadow3 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.08]];
  [shadow3 setShadowOffset:CGSizeMake(0.1, -3.6)];
  [shadow3 setShadowBlurRadius:4];
  NSShadow* shadow4 = [[NSShadow alloc] init];
  [shadow4 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.16]];
  [shadow4 setShadowOffset:CGSizeMake(4.1, 3.1)];
  [shadow4 setShadowBlurRadius:4];
  NSShadow* shadow7 = [[NSShadow alloc] init];
  [shadow7 setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.16]];
  [shadow7 setShadowOffset:CGSizeMake(-4.1, 1.1)];
  [shadow7 setShadowBlurRadius:5];

  CGRect shadowLayer = CGRectMake(CGRectGetMinX(frame) + 50.2, CGRectGetMinY(frame) + 20.6,
                                  floor((CGRectGetWidth(frame) - 50.2) * 0.66473 + 49.9) - 49.4,
                                  floor((CGRectGetHeight(frame) - 20.6) * 0.62054 + 20.7) - 20.2);
  {
    UIBezierPath* bluePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(shadowLayer) +
                                          floor(CGRectGetWidth(shadowLayer) * 0.00000 + 0.5),
                                      CGRectGetMinY(shadowLayer) +
                                          floor(CGRectGetHeight(shadowLayer) * 0.17266 + 0.5),
                                      floor(CGRectGetWidth(shadowLayer) * 0.82969 + 0.5) -
                                          floor(CGRectGetWidth(shadowLayer) * 0.00000 + 0.5),
                                      floor(CGRectGetHeight(shadowLayer) * 1.00000 + 0.5) -
                                          floor(CGRectGetHeight(shadowLayer) * 0.17266 + 0.5))];
    [fillColor setFill];
    [bluePath fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.9);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectangle6Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow7.shadowOffset, shadow7.shadowBlurRadius,
                                  [shadow7.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle6Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle2Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius,
                                  [shadow2.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle2Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle3Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(shadowLayer) +
                                            floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) +
                                            0.6,
                                        CGRectGetMinY(shadowLayer) +
                                            floor(CGRectGetHeight(shadowLayer) * 0.00480 + 0.5),
                                        floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                            floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                        floor(CGRectGetHeight(shadowLayer) * 0.83213 + 0.5) -
                                            floor(CGRectGetHeight(shadowLayer) * 0.00480 + 0.5))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius,
                                  [shadow3.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle3Path fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectanglePath = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                  [shadow.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectanglePath fill];
      CGContextRestoreGState(context);

      UIBezierPath* rectangle4Path = [UIBezierPath
          bezierPathWithRect:CGRectMake(
                                 CGRectGetMinX(shadowLayer) +
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1) + 0.6,
                                 CGRectGetMinY(shadowLayer) +
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1) + 0.4,
                                 floor(CGRectGetWidth(shadowLayer) * 1.00000 - 0.1) -
                                     floor(CGRectGetWidth(shadowLayer) * 0.17031 - 0.1),
                                 floor(CGRectGetHeight(shadowLayer) * 0.82734 + 0.1) -
                                     floor(CGRectGetHeight(shadowLayer) * 0.00000 + 0.1))];
      CGContextSaveGState(context);
      CGContextSetShadowWithColor(context, shadow4.shadowOffset, shadow4.shadowBlurRadius,
                                  [shadow4.shadowColor CGColor]);
      [fillColor2 setFill];
      [rectangle4Path fill];
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }
  }
}

void MDCCatalogDrawSliderTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* gradientColor = [UIColor colorWithRed:0.102 green:0.09 blue:0.094 alpha:0];
  UIColor* fillColor2 = [UIColor colorWithRed:0.209 green:0.73 blue:0.965 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithRed:0.407 green:0.798 blue:0.974 alpha:1];
  UIColor* fillColor4 = [UIColor colorWithRed:0.605 green:0.865 blue:0.983 alpha:1];
  UIColor* gradientColor1 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

  CGFloat gradient50Locations[] = {0, 1};
  CGGradientRef gradient50 = CGGradientCreateWithColors(
      colorSpace, (__bridge CFArrayRef) @[ (id)gradientColor1.CGColor, (id)gradientColor.CGColor ],
      gradient50Locations);

  CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 55.5,
                             floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                             floor((CGRectGetHeight(frame) - 55.5) * 0.12060 + 0.5));

  {
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, NULL);

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.1);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* rectanglePath = [UIBezierPath
          bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        CGRectGetMinY(group2) +
                                            floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                        floor(CGRectGetWidth(group2) * 1.00000 + 0.5) -
                                            floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                        floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                            floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
      [fillColor setFill];
      [rectanglePath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle2Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.84514 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.95558 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.84514 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect:rectangle2Rect];
      CGContextSaveGState(context);
      [rectangle2Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle2Rect) + -5.59 * CGRectGetWidth(rectangle2Rect) / 15.35,
              CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle2Rect) + 3.52 * CGRectGetWidth(rectangle2Rect) / 15.35,
                      CGRectGetMidY(rectangle2Rect) + 0 * CGRectGetHeight(rectangle2Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle3Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.85971) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor setFill];
    [rectangle3Path fill];

    UIBezierPath* ovalPath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.81655) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.90288) -
                                                floor(CGRectGetWidth(group2) * 0.81655),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor setFill];
    [ovalPath fill];

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle4Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.49982 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.61025 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.49982 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect:rectangle4Rect];
      CGContextSaveGState(context);
      [rectangle4Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle4Rect) + -5.59 * CGRectGetWidth(rectangle4Rect) / 15.35,
              CGRectGetMidY(rectangle4Rect) + 0 * CGRectGetHeight(rectangle4Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle4Rect) + 3.52 * CGRectGetWidth(rectangle4Rect) / 15.35,
                      CGRectGetMidY(rectangle4Rect) + 0 * CGRectGetHeight(rectangle4Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle5Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.45683) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor2 setFill];
    [rectangle5Path fill];

    UIBezierPath* oval2Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.45683) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.54317) -
                                                floor(CGRectGetWidth(group2) * 0.45683),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor2 setFill];
    [oval2Path fill];
    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle6Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.28399 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.39442 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.28399 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRect:rectangle6Rect];
      CGContextSaveGState(context);
      [rectangle6Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle6Rect) + -5.59 * CGRectGetWidth(rectangle6Rect) / 15.35,
              CGRectGetMidY(rectangle6Rect) + 0 * CGRectGetHeight(rectangle6Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle6Rect) + 3.52 * CGRectGetWidth(rectangle6Rect) / 15.35,
                      CGRectGetMidY(rectangle6Rect) + 0 * CGRectGetHeight(rectangle6Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle7Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.29137) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor3 setFill];
    [rectangle7Path fill];

    UIBezierPath* oval3Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.24101) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.32734) -
                                                floor(CGRectGetWidth(group2) * 0.24101),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor3 setFill];
    [oval3Path fill];

    {
      CGContextSaveGState(context);
      CGContextSetBlendMode(context, kCGBlendModeMultiply);
      CGContextBeginTransparencyLayer(context, NULL);

      CGRect rectangle8Rect =
          CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.14011 + 0.02) + 0.48,
                     CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                     floor(CGRectGetWidth(group2) * 0.22176 - 0.33) -
                         floor(CGRectGetWidth(group2) * 0.14011 + 0.02) + 0.35,
                     floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                         floor(CGRectGetHeight(group2) * 0.41667 + 0.5));
      UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRect:rectangle8Rect];
      CGContextSaveGState(context);
      [rectangle8Path addClip];
      CGContextDrawLinearGradient(
          context, gradient50,
          CGPointMake(
              CGRectGetMidX(rectangle8Rect) + -5.65 * CGRectGetWidth(rectangle8Rect) / 11.35,
              CGRectGetMidY(rectangle8Rect) + 0 * CGRectGetHeight(rectangle8Rect) / 2),
          CGPointMake(CGRectGetMidX(rectangle8Rect) + 5.68 * CGRectGetWidth(rectangle8Rect) / 11.35,
                      CGRectGetMidY(rectangle8Rect) + 0 * CGRectGetHeight(rectangle8Rect) / 2),
          kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* rectangle9Path = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(group2) +
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5),
                                      CGRectGetMinY(group2) +
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5),
                                      floor(CGRectGetWidth(group2) * 0.14029) -
                                          floor(CGRectGetWidth(group2) * 0.00000 + 0.5) + 0.5,
                                      floor(CGRectGetHeight(group2) * 0.58333 + 0.5) -
                                          floor(CGRectGetHeight(group2) * 0.41667 + 0.5))];
    [fillColor4 setFill];
    [rectangle9Path fill];

    UIBezierPath* oval4Path = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(group2) +
                                                floor(CGRectGetWidth(group2) * 0.09712) + 0.5,
                                            CGRectGetMinY(group2) +
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(group2) * 0.18345) -
                                                floor(CGRectGetWidth(group2) * 0.09712),
                                            floor(CGRectGetHeight(group2) * 1.00000 + 0.5) -
                                                floor(CGRectGetHeight(group2) * 0.00000 + 0.5))];
    [fillColor4 setFill];
    [oval4Path fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  //// Cleanup
  CGGradientRelease(gradient50);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawSnackbarTile(CGRect frame) {
  //// General Declarations
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  //// Color Declarations
  UIColor* gradientColor = [UIColor colorWithRed:0.076 green:0.59 blue:0.945 alpha:1];
  UIColor* fillColor = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  //// Gradient Declarations
  CGFloat gradientLocations[] = {0, 0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef)
          @[ (id)gradientColor.CGColor, (id)gradientColor.CGColor, (id)gradientColor.CGColor ],
      gradientLocations);

  //// Subframes
  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 55.6) * 0.21076 + 0.05) + 0.45, 139,
      55.6);

  //// Group
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.1);
    CGContextBeginTransparencyLayer(context, NULL);

    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(CGRectGetMinX(group), CGRectGetMinY(group), 139, 55.6);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(
        context, gradient,
        CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
                    CGRectGetMidY(rectangleRect) + 16.12 * CGRectGetHeight(rectangleRect) / 55.6),
        CGPointMake(CGRectGetMidX(rectangleRect) + -0 * CGRectGetWidth(rectangleRect) / 139,
                    CGRectGetMidY(rectangleRect) + -25.22 * CGRectGetHeight(rectangleRect) / 55.6),
        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  //// Rectangle 2 Drawing
  UIBezierPath* rectangle2Path = [UIBezierPath
      bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) +
                                        floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
                                    CGRectGetMinY(frame) +
                                        floor((CGRectGetHeight(frame) - 29) * 0.57103 + 0.45) +
                                        0.05,
                                    139, 29)];
  [fillColor setFill];
  [rectangle2Path fill];

  //// Cleanup
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawSpritedAnimationViewTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  UIColor* blue60 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.6];
  UIColor* blue40 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.4];
  UIColor* blue20 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];

  CGRect spritedButtonAnimation =
      CGRectMake(CGRectGetMinX(frame) + 56.33, CGRectGetMinY(frame) + 14.3,
                 floor((CGRectGetWidth(frame) - 56.33) * 0.57217 + 56.16) - 55.66,
                 floor((CGRectGetHeight(frame) - 14.3) * 0.53546 + 14.1) - 13.6);

  {
    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.2);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* bezierPath = [UIBezierPath bezierPath];
      [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                              0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                          CGRectGetMinY(spritedButtonAnimation) +
                                              0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.64143 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.28787 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.42929 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.35858 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.28787 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.28786 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.42929 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.50001 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.28786 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.64142 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.35858 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.71213 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.57071 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.64143 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.71213 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.64142 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.57071 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.50001 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath
          addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                         0.71213 * CGRectGetWidth(spritedButtonAnimation),
                                     CGRectGetMinY(spritedButtonAnimation) +
                                         0.35858 * CGRectGetHeight(spritedButtonAnimation))];
      [bezierPath closePath];
      [blue20 setFill];
      [bezierPath fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.66830 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.30849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.58169 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.48170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.43170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.30850 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.33170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.25850 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.41831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.43170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.51831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.33170 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.69151 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.41830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74151 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.51830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.56831 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.69150 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.66830 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.74151 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.58170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.56830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.48170 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.66830 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.30849 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier2Path closePath];
    [blue40 setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.61300 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.27146 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.51641 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.24558 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.46464 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.43876 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.27146 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.38701 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24558 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.48360 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.43876 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.53536 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.38699 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.72854 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.48359 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.75442 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.53535 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.56123 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.72855 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.61300 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75443 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.51641 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.56124 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.46464 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.61300 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.27146 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier3Path closePath];
    [blue60 setFill];
    [bezier3Path fill];

    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24999 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.24999 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.45000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74999 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.74999 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75001 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.55000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.75001 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.45000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path addLineToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                                0.55000 * CGRectGetWidth(spritedButtonAnimation),
                                            CGRectGetMinY(spritedButtonAnimation) +
                                                0.25000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier4Path closePath];
    [fillColor setFill];
    [bezier4Path fill];

    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.90000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.27950 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.72050 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.09999 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.27950 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.27950 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.72050 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.10000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.27950 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.90000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.72050 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.72050 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.90000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path closePath];
    [bezier5Path moveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                             0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                         CGRectGetMinY(spritedButtonAnimation) +
                                             0.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.22399 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.22400 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.77600 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.22399 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.49999 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.77600 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        1.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.77600 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path
        addCurveToPoint:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.50000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint1:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        1.00000 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.22400 * CGRectGetHeight(spritedButtonAnimation))
          controlPoint2:CGPointMake(CGRectGetMinX(spritedButtonAnimation) +
                                        0.77600 * CGRectGetWidth(spritedButtonAnimation),
                                    CGRectGetMinY(spritedButtonAnimation) +
                                        0.00000 * CGRectGetHeight(spritedButtonAnimation))];
    [bezier5Path closePath];
    [fillColor setFill];
    [bezier5Path fill];
  }
}

void MDCCatalogDrawSwitchTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithRed:0.119 green:0.63 blue:0.95 alpha:1];
  UIColor* fillColor2 = [UIColor colorWithRed:0.077 green:0.591 blue:0.945 alpha:1];

  CGRect group = CGRectMake(
      CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 56.43) * 0.59180 - 0.37) + 0.87,
      CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 31.91) * 0.38869 + 0.25) + 0.25, 56.43,
      31.91);
  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.3);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group) + 31.91)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 15.96)
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 49.28, CGRectGetMinY(group) + 31.91)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 24.77)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group))
          controlPoint1:CGPointMake(CGRectGetMinX(group) + 56.43, CGRectGetMinY(group) + 7.14)
          controlPoint2:CGPointMake(CGRectGetMinX(group) + 49.28, CGRectGetMinY(group))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(group), CGRectGetMinY(group) + 31.91)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(group) + 40.47, CGRectGetMinY(group) + 31.91)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }

  UIBezierPath* ovalPath = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(
                                   CGRectGetMinX(frame) +
                                       floor((CGRectGetWidth(frame) - 43.3) * 0.37111 - 0.2) + 0.7,
                                   CGRectGetMinY(frame) +
                                       floor((CGRectGetHeight(frame) - 43.3) * 0.37735 - 0.05) +
                                       0.55,
                                   43.3, 43.3)];
  [fillColor2 setFill];
  [ovalPath fill];
}

void MDCCatalogDrawTypographyTile(CGRect frame) {
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
