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

UIImage* MDCDrawImage(CGRect frame, MDCDrawFunc drawFunc) {
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);
  drawFunc(frame);
  UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

static UIColor *MDCPrimaryColor() {
  return [UIColor colorWithWhite:0.2f alpha:1];
}

static UIColor *MDCSecondaryColor() {
  return [UIColor colorWithWhite:0.7f alpha:1];
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
#pragma clang diagnostic ignored "-Wconversion"
void MDCCatalogDrawActivityIndicatorTile(CGRect frame) {
  UIColor* fillColor = MDCSecondaryColor();
  UIColor* fillColor2 = MDCPrimaryColor();

  CGRect activityIndicatorGroup =
  CGRectMake(CGRectGetMinX(frame) + 54, CGRectGetMinY(frame) + 24.1,
             floor((CGRectGetWidth(frame) - 54) * 0.59717 + 54.48) - 53.98,
             floor((CGRectGetHeight(frame) - 24.1) * 0.61055 + 23.7) - 23.2);

  {
    UIBezierPath* backgroundBezierPath = [UIBezierPath bezierPath];
    [backgroundBezierPath
     moveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                             0.48875 * CGRectGetWidth(activityIndicatorGroup),
                             CGRectGetMinY(activityIndicatorGroup) +
                             0.00013 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.00013 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.51064 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.21258 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.00514 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               -0.00612 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.23411 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.51125 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.99987 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.00638 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.78716 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.23507 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               1.00613 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.99987 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.48811 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.78742 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.99361 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               1.00612 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.76464 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.48875 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.00013 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.99362 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.21284 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.76493 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               -0.00613 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath closePath];
    [backgroundBezierPath
     moveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                             0.50875 * CGRectGetWidth(activityIndicatorGroup),
                             CGRectGetMinY(activityIndicatorGroup) +
                             0.91228 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.08761 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.50938 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.28131 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.91729 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.09261 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.73711 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.49125 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.08772 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.08261 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.28166 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.26381 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.09272 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.91239 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.49187 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.71869 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.08271 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.90739 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.26414 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.50875 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.91228 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.91739 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.71959 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.73619 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.90728 * CGRectGetHeight(activityIndicatorGroup))];
    [backgroundBezierPath closePath];
    backgroundBezierPath.miterLimit = 4;

    [fillColor setFill];
    [backgroundBezierPath fill];

    UIBezierPath* progressBezierPath = [UIBezierPath bezierPath];
    [progressBezierPath
     moveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                             0.48875 * CGRectGetWidth(activityIndicatorGroup),
                             CGRectGetMinY(activityIndicatorGroup) +
                             0.00013 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addLineToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                0.49125 * CGRectGetWidth(activityIndicatorGroup),
                                CGRectGetMinY(activityIndicatorGroup) +
                                0.08772 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.91239 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.49187 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.71869 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.08271 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.90739 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.26414 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.50875 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.91353 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.91739 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.71959 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.73619 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.90853 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.08761 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.50938 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.28131 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.91729 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.09261 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.73711 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.29880 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.14027 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.08386 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.35048 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.17009 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.21159 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addLineToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                0.25631 * CGRectGetWidth(activityIndicatorGroup),
                                CGRectGetMinY(activityIndicatorGroup) +
                                0.06394 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.00013 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.51064 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.10010 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.15153 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               -0.00362 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.31920 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.51125 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.99987 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.00638 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.78716 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.23507 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               1.00613 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.99987 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.48811 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.78742 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.99361 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               1.00612 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.76464 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath
     addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                 0.48875 * CGRectGetWidth(activityIndicatorGroup),
                                 CGRectGetMinY(activityIndicatorGroup) +
                                 0.00013 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.99362 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               0.21284 * CGRectGetHeight(activityIndicatorGroup))
     controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                               0.76493 * CGRectGetWidth(activityIndicatorGroup),
                               CGRectGetMinY(activityIndicatorGroup) +
                               -0.00613 * CGRectGetHeight(activityIndicatorGroup))];
    [progressBezierPath closePath];
    progressBezierPath.miterLimit = 4;

    [fillColor2 setFill];
    [progressBezierPath fill];
  }
}

void MDCCatalogDrawAnimationTimingTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* strokeColor = MDCSecondaryColor();
  UIColor* gradientColor = [UIColor colorWithWhite:0.649 alpha:1];
  UIColor* gradientColor2 = [UIColor colorWithWhite:0.149 alpha:1];
  UIColor* gradientColor3 = [UIColor colorWithWhite:0.033 alpha:1];
  UIColor* fillColor1 = [UIColor colorWithWhite:0.341 alpha:0.9];
  UIColor* fillColor2 = [UIColor colorWithWhite:0.467 alpha:0.9];
  UIColor* fillColor3 = [UIColor colorWithWhite:0.533 alpha:0.9];
  UIColor* fillColor4 = [UIColor colorWithWhite:0.608 alpha:0.9];
  UIColor* fillColor5 = [UIColor colorWithWhite:0.651 alpha:1];
  UIColor* fillColor6 = [UIColor colorWithWhite:0.765 alpha:0.9];
  UIColor* fillColor7 = [UIColor colorWithWhite:0.831 alpha:0.9];
  UIColor* fillColor8 = [UIColor colorWithWhite:0.902 alpha:0.9];
  UIColor* fillColor9 = [fillColor8 colorWithAlphaComponent:0.5];

  CGFloat gradientLocations[] = {0, 0, 0.52, 1};
  CGGradientRef gradient =
  CGGradientCreateWithColors(colorSpace,
                             (__bridge CFArrayRef) @[
                                                     (id)gradientColor.CGColor, (id)gradientColor.CGColor,
                                                     (id)gradientColor2.CGColor, (id)gradientColor3.CGColor
                                                     ],
                             gradientLocations);

  CGRect animationTimingGroup =
  CGRectMake(CGRectGetMinX(frame) + 25, CGRectGetMinY(frame) + 24.1,
             floor((CGRectGetWidth(frame) - 25) * 0.84479 + 24.8) - 24.3,
             floor((CGRectGetHeight(frame) - 24.1) * 0.61421 + 23.7) - 23.2);

  {
    {
      CGContextSaveGState(context);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* curveClipPath = [UIBezierPath bezierPath];
      [curveClipPath moveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                             0.44801 * CGRectGetWidth(animationTimingGroup),
                                             CGRectGetMinY(animationTimingGroup) +
                                             0.42305 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.39211 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.55362 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.00000 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.91045 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.29457 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.78039 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.15166 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.91045 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.00000 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.91045 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.00000 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.94776 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.40966 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.57571 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.15866 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.94776 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.30796 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.81216 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.40966 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.57571 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.46556 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.44514 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.85694 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.08954 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.56256 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.21915 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.70521 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.08954 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.85694 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.08954 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.85694 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.05224 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.44801 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.42305 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.69821 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.05224 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.54916 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.18738 * CGRectGetHeight(animationTimingGroup))];
      [curveClipPath closePath];
      [curveClipPath addClip];

      UIBezierPath* curveBezierPath = [UIBezierPath bezierPath];
      [curveBezierPath
       moveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                               0.44801 * CGRectGetWidth(animationTimingGroup),
                               CGRectGetMinY(animationTimingGroup) +
                               0.42305 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.39211 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.55362 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.00000 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.91045 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.29457 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.78039 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.15166 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.91045 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.00000 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.91045 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.00000 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.94776 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.40966 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.57571 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.15866 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.94776 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.30796 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.81216 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.40966 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.57571 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.46556 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.44514 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.85694 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.08954 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.56256 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.21915 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.70521 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.08954 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.85694 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.08954 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                  0.85694 * CGRectGetWidth(animationTimingGroup),
                                  CGRectGetMinY(animationTimingGroup) +
                                  0.05224 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath
       addCurveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                   0.44801 * CGRectGetWidth(animationTimingGroup),
                                   CGRectGetMinY(animationTimingGroup) +
                                   0.42305 * CGRectGetHeight(animationTimingGroup))
       controlPoint1:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.69821 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.05224 * CGRectGetHeight(animationTimingGroup))
       controlPoint2:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                 0.54916 * CGRectGetWidth(animationTimingGroup),
                                 CGRectGetMinY(animationTimingGroup) +
                                 0.18738 * CGRectGetHeight(animationTimingGroup))];
      [curveBezierPath closePath];
      CGContextSaveGState(context);
      [curveBezierPath addClip];
      CGRect curveBezierBounds = CGPathGetPathBoundingBox(curveBezierPath.CGPath);
      CGContextDrawLinearGradient(
                                  context, gradient,
                                  CGPointMake(
                                              CGRectGetMidX(curveBezierBounds) + -59 * CGRectGetWidth(curveBezierBounds) / 118,
                                              CGRectGetMidY(curveBezierBounds) + -0 * CGRectGetHeight(curveBezierBounds) / 72),
                                  CGPointMake(
                                              CGRectGetMidX(curveBezierBounds) + 59 * CGRectGetWidth(curveBezierBounds) / 118,
                                              CGRectGetMidY(curveBezierBounds) + -0 * CGRectGetHeight(curveBezierBounds) / 72),
                                  kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
      CGContextRestoreGState(context);

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* circle3Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.15920 + 0.5),
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.30348 - 0.1) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.15920 + 0.5) + 0.6)];
    [fillColor3 setFill];
    [circle3Path fill];

    UIBezierPath* circle2Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.06343 - 0.2) + 0.7,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.20771 + 0.2) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.06343 - 0.2) - 0.4)];
    [fillColor2 setFill];
    [circle2Path fill];

    {
      CGContextSaveGState(context);
      CGContextSetAlpha(context, 0.9);
      CGContextBeginTransparencyLayer(context, NULL);

      UIBezierPath* circle1Path = [UIBezierPath
                                   bezierPathWithOvalInRect:
                                   CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                              floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                              CGRectGetMinY(animationTimingGroup) +
                                              floor(CGRectGetHeight(animationTimingGroup) * 0.00249 - 0.1) + 0.6,
                                              floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                              floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                              floor(CGRectGetHeight(animationTimingGroup) * 0.14677 + 0.3) -
                                              floor(CGRectGetHeight(animationTimingGroup) * 0.00249 - 0.1) - 0.4)];
      [fillColor1 setFill];
      [circle1Path fill];

      CGContextEndTransparencyLayer(context);
      CGContextRestoreGState(context);
    }

    UIBezierPath* circle4Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.29353 + 0.3) + 0.2,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.43781 - 0.3) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.29353 + 0.3) + 0.6)];
    [fillColor4 setFill];
    [circle4Path fill];

    UIBezierPath* circle5Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.42910 + 0.2) + 0.3,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.57338 - 0.4) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.42910 + 0.2) + 0.6)];
    [fillColor5 setFill];
    [circle5Path fill];

    UIBezierPath* circle6Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.56468 + 0.1) + 0.4,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.70896 + 0.5) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.56468 + 0.1) - 0.4)];
    [fillColor6 setFill];
    [circle6Path fill];

    UIBezierPath* circle8Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.79478 - 0.4) + 0.9,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.93905) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.79478 - 0.4) - 0.4)];
    [fillColor8 setFill];
    [circle8Path fill];

    UIBezierPath* circle9Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.85572 + 0.5),
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 1.00000 - 0.1) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.85572 + 0.5) + 0.6)];
    [fillColor9 setFill];
    [circle9Path fill];

    UIBezierPath* circle7Path = [UIBezierPath
                                 bezierPathWithOvalInRect:
                                 CGRectMake(CGRectGetMinX(animationTimingGroup) +
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.1,
                                            CGRectGetMinY(animationTimingGroup) +
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.70025) + 0.5,
                                            floor(CGRectGetWidth(animationTimingGroup) * 1.00000 - 0.2) -
                                            floor(CGRectGetWidth(animationTimingGroup) * 0.91576 + 0.4) + 0.6,
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.84453 + 0.4) -
                                            floor(CGRectGetHeight(animationTimingGroup) * 0.70025) - 0.4)];
    [fillColor7 setFill];
    [circle7Path fill];

    UIBezierPath* axesBezierPath = [UIBezierPath bezierPath];
    [axesBezierPath moveToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                            0.85694 * CGRectGetWidth(animationTimingGroup),
                                            CGRectGetMinY(animationTimingGroup) +
                                            0.99378 * CGRectGetHeight(animationTimingGroup))];
    [axesBezierPath
     addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                0.00000 * CGRectGetWidth(animationTimingGroup),
                                CGRectGetMinY(animationTimingGroup) +
                                0.99378 * CGRectGetHeight(animationTimingGroup))];
    [axesBezierPath
     addLineToPoint:CGPointMake(CGRectGetMinX(animationTimingGroup) +
                                0.00000 * CGRectGetWidth(animationTimingGroup),
                                CGRectGetMinY(animationTimingGroup) +
                                0.00000 * CGRectGetHeight(animationTimingGroup))];
    [strokeColor setStroke];
    axesBezierPath.lineWidth = 3;
    [axesBezierPath stroke];
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawAppBarTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = MDCSecondaryColor();

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

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = MDCSecondaryColor();

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

  UIColor* fillColor = MDCPrimaryColor();

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

void MDCCatalogDrawCollectionCellsTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = [UIColor colorWithWhite:0.0 alpha:0];
  UIColor* fillColor2 = [UIColor colorWithWhite:0.6 alpha:0.3];

  UIColor* color = MDCPrimaryColor();
  UIColor* gradientColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];

  // This gradient was adjusted by hand to not use macOS API
  CGFloat gradientLocations[] = {0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
                                                      colorSpace, (__bridge CFArrayRef) @[ (id)fillColor2.CGColor, (id)gradientColor.CGColor ],
                                                      gradientLocations);

  CGRect collectionCellsGroup = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                                           floor((CGRectGetWidth(frame) - 24.5) * 0.84404 + 0.5),
                                           floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));

  {
    UIBezierPath* stripeLowPath = [UIBezierPath bezierPath];
    [stripeLowPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                           0.00000 * CGRectGetWidth(collectionCellsGroup),
                                           CGRectGetMinY(collectionCellsGroup) +
                                           0.75626 * CGRectGetHeight(collectionCellsGroup))];
    [stripeLowPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              1.00000 * CGRectGetWidth(collectionCellsGroup),
                                              CGRectGetMinY(collectionCellsGroup) +
                                              0.75626 * CGRectGetHeight(collectionCellsGroup))];
    stripeLowPath.miterLimit = 4;

    [fillColor setFill];
    [stripeLowPath fill];
    [color setStroke];
    stripeLowPath.lineWidth = 1;
    [stripeLowPath stroke];

    UIBezierPath* stripeMiddlePath = [UIBezierPath bezierPath];
    [stripeMiddlePath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              0.00000 * CGRectGetWidth(collectionCellsGroup),
                                              CGRectGetMinY(collectionCellsGroup) +
                                              0.50376 * CGRectGetHeight(collectionCellsGroup))];
    [stripeMiddlePath
     addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                1.00000 * CGRectGetWidth(collectionCellsGroup),
                                CGRectGetMinY(collectionCellsGroup) +
                                0.50376 * CGRectGetHeight(collectionCellsGroup))];
    stripeMiddlePath.miterLimit = 4;

    [fillColor setFill];
    [stripeMiddlePath fill];
    [color setStroke];
    stripeMiddlePath.lineWidth = 1;
    [stripeMiddlePath stroke];

    UIBezierPath* stripeHighPath = [UIBezierPath bezierPath];
    [stripeHighPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                            0.00000 * CGRectGetWidth(collectionCellsGroup),
                                            CGRectGetMinY(collectionCellsGroup) +
                                            0.25126 * CGRectGetHeight(collectionCellsGroup))];
    [stripeHighPath
     addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                1.00000 * CGRectGetWidth(collectionCellsGroup),
                                CGRectGetMinY(collectionCellsGroup) +
                                0.25126 * CGRectGetHeight(collectionCellsGroup))];
    stripeHighPath.miterLimit = 4;

    [fillColor setFill];
    [stripeHighPath fill];
    [color setStroke];
    stripeHighPath.lineWidth = 1;
    [stripeHighPath stroke];

    CGRect gradientRectangleRect =
    CGRectMake(CGRectGetMinX(collectionCellsGroup) +
               floor(CGRectGetWidth(collectionCellsGroup) * 0.00000 + 0.5),
               CGRectGetMinY(collectionCellsGroup) +
               floor(CGRectGetHeight(collectionCellsGroup) * 0.76250 + 0.5),
               floor(CGRectGetWidth(collectionCellsGroup) * 1.00000 + 0.5) -
               floor(CGRectGetWidth(collectionCellsGroup) * 0.00000 + 0.5),
               floor(CGRectGetHeight(collectionCellsGroup) * 1.00000 + 0.5) -
               floor(CGRectGetHeight(collectionCellsGroup) * 0.76250 + 0.5));
    UIBezierPath* gradientRectanglePath = [UIBezierPath bezierPathWithRect:gradientRectangleRect];
    CGContextSaveGState(context);
    [gradientRectanglePath addClip];
    CGContextDrawLinearGradient(
                                context, gradient,
                                CGPointMake(CGRectGetMidX(gradientRectangleRect), CGRectGetMinY(gradientRectangleRect)),
                                CGPointMake(CGRectGetMidX(gradientRectangleRect), CGRectGetMaxY(gradientRectangleRect)), 0);
    CGContextRestoreGState(context);

    UIBezierPath* solidRectanglePath = [UIBezierPath
                                        bezierPathWithRect:CGRectMake(
                                                                      CGRectGetMinX(collectionCellsGroup) +
                                                                      floor(CGRectGetWidth(collectionCellsGroup) * 0.00000 + 0.5),
                                                                      CGRectGetMinY(collectionCellsGroup) +
                                                                      floor(CGRectGetHeight(collectionCellsGroup) * 0.00000 + 0.5),
                                                                      floor(CGRectGetWidth(collectionCellsGroup) * 1.00000 + 0.5) -
                                                                      floor(CGRectGetWidth(collectionCellsGroup) * 0.00000 + 0.5),
                                                                      floor(CGRectGetHeight(collectionCellsGroup) * 0.76250 + 0.5) -
                                                                      floor(CGRectGetHeight(collectionCellsGroup) * 0.00000 + 0.5))];
    [fillColor2 setFill];
    [solidRectanglePath fill];
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawCollectionsTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* white40 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
  UIColor* blue60 = fillColor;
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
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = MDCSecondaryColor();

  // This gradient was adjusted by hand to not use macOS API
  CGFloat gradientLocations[] = {0.13, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
                                                      colorSpace,
                                                      (__bridge CFArrayRef) @[ (id)gradientColor.CGColor, (id)UIColor.clearColor.CGColor ],
                                                      gradientLocations);

  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[UIColor.blackColor colorWithAlphaComponent:0.3]];
  [shadow setShadowOffset:CGSizeMake(0.1, 2.1)];
  [shadow setShadowBlurRadius:5];

  CGRect dialogsGroup = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24.1,
                                   floor((CGRectGetWidth(frame) - 24.5) * 0.84404 + 0.5),
                                   floor((CGRectGetHeight(frame) - 24.1) * 0.64095 + 23.7) - 23.2);

  {
    CGRect rectangleRect = CGRectMake(
                                      CGRectGetMinX(dialogsGroup) + floor(CGRectGetWidth(dialogsGroup) * 0.00000 + 0.5),
                                      CGRectGetMinY(dialogsGroup) + floor(CGRectGetHeight(dialogsGroup) * 0.00000 - 0.4) + 0.9,
                                      floor(CGRectGetWidth(dialogsGroup) * 1.00000 + 0.5) -
                                      floor(CGRectGetWidth(dialogsGroup) * 0.00000 + 0.5),
                                      floor(CGRectGetHeight(dialogsGroup) * 0.95352 - 0.4) -
                                      floor(CGRectGetHeight(dialogsGroup) * 0.00000 - 0.4));
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(
                                context, gradient, CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMinY(rectangleRect)),
                                CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMaxY(rectangleRect)), 0);
    CGContextRestoreGState(context);

    UIBezierPath* rectangle2Path = [UIBezierPath
                                    bezierPathWithRect:CGRectMake(CGRectGetMinX(dialogsGroup) +
                                                                  floor(CGRectGetWidth(dialogsGroup) * 0.14130) + 0.5,
                                                                  CGRectGetMinY(dialogsGroup) +
                                                                  floor(CGRectGetHeight(dialogsGroup) * 0.16567 + 0.5),
                                                                  floor(CGRectGetWidth(dialogsGroup) * 0.86594) -
                                                                  floor(CGRectGetWidth(dialogsGroup) * 0.14130),
                                                                  floor(CGRectGetHeight(dialogsGroup) * 1.00000 + 0.5) -
                                                                  floor(CGRectGetHeight(dialogsGroup) * 0.16567 + 0.5))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                                [shadow.shadowColor CGColor]);
    [UIColor.whiteColor setFill];
    [rectangle2Path fill];
    CGContextRestoreGState(context);
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawFeatureHighlightTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = MDCSecondaryColor();
  UIColor* white = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];

  CGRect featureHighlightGroup = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                                            floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                                            floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));

  {
    CGContextSaveGState(context);
    CGContextBeginTransparencyLayer(context, NULL);

    UIBezierPath* clippingRectPath = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(featureHighlightGroup) +
                                                                    floor(CGRectGetWidth(featureHighlightGroup) * 0.00000 + 0.5),
                                                                    CGRectGetMinY(featureHighlightGroup) +
                                                                    floor(CGRectGetHeight(featureHighlightGroup) * 0.00000 + 0.5),
                                                                    floor(CGRectGetWidth(featureHighlightGroup) * 1.00000 + 0.5) -
                                                                    floor(CGRectGetWidth(featureHighlightGroup) * 0.00000 + 0.5),
                                                                    floor(CGRectGetHeight(featureHighlightGroup) * 1.00000 + 0.5) -
                                                                    floor(CGRectGetHeight(featureHighlightGroup) * 0.00000 + 0.5))];
    [clippingRectPath addClip];

    UIBezierPath* rectanglePath = [UIBezierPath
                                   bezierPathWithRect:CGRectMake(
                                                                 CGRectGetMinX(featureHighlightGroup) +
                                                                 floor(CGRectGetWidth(featureHighlightGroup) * -0.00000 - 0.5) +
                                                                 1,
                                                                 CGRectGetMinY(featureHighlightGroup) +
                                                                 floor(CGRectGetHeight(featureHighlightGroup) * 0.00000 + 0.5),
                                                                 floor(CGRectGetWidth(featureHighlightGroup) * 1.00000 - 0.5) -
                                                                 floor(CGRectGetWidth(featureHighlightGroup) * -0.00000 - 0.5),
                                                                 floor(CGRectGetHeight(featureHighlightGroup) * 1.00000 + 0.5) -
                                                                 floor(CGRectGetHeight(featureHighlightGroup) * 0.00000 + 0.5))];
    [fillColor setFill];
    [rectanglePath fill];

    {
      UIBezierPath* circlePath = [UIBezierPath
                                  bezierPathWithOvalInRect:
                                  CGRectMake(CGRectGetMinX(featureHighlightGroup) +
                                             floor(CGRectGetWidth(featureHighlightGroup) * -0.06619 - 0.3) + 0.8,
                                             CGRectGetMinY(featureHighlightGroup) +
                                             floor(CGRectGetHeight(featureHighlightGroup) * -0.13625 + 0.4) + 0.1,
                                             floor(CGRectGetWidth(featureHighlightGroup) * 0.36403 - 0.1) -
                                             floor(CGRectGetWidth(featureHighlightGroup) * -0.06619 - 0.3) - 0.2,
                                             floor(CGRectGetHeight(featureHighlightGroup) * 0.61125 - 0.4) -
                                             floor(CGRectGetHeight(featureHighlightGroup) * -0.13625 + 0.4) + 0.8)];
      [fillColor2 setFill];
      [circlePath fill];

      UIBezierPath* hamburgerLowPath = [UIBezierPath
                                        bezierPathWithRect:CGRectMake(
                                                                      CGRectGetMinX(featureHighlightGroup) +
                                                                      floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                      0.3,
                                                                      CGRectGetMinY(featureHighlightGroup) +
                                                                      floor(CGRectGetHeight(featureHighlightGroup) * 0.27500) + 0.5,
                                                                      floor(CGRectGetWidth(featureHighlightGroup) * 0.20000 - 0.3) -
                                                                      floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                      0.5,
                                                                      floor(CGRectGetHeight(featureHighlightGroup) * 0.29375 + 0.5) -
                                                                      floor(CGRectGetHeight(featureHighlightGroup) * 0.27500) -
                                                                      0.5)];
      [white setFill];
      [hamburgerLowPath fill];

      UIBezierPath* hamburgerMiddlePath = [UIBezierPath
                                           bezierPathWithRect:CGRectMake(
                                                                         CGRectGetMinX(featureHighlightGroup) +
                                                                         floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                         0.3,
                                                                         CGRectGetMinY(featureHighlightGroup) +
                                                                         floor(CGRectGetHeight(featureHighlightGroup) * 0.22750 + 0.2) +
                                                                         0.3,
                                                                         floor(CGRectGetWidth(featureHighlightGroup) * 0.20000 - 0.3) -
                                                                         floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                         0.5,
                                                                         floor(CGRectGetHeight(featureHighlightGroup) * 0.24625 - 0.3) -
                                                                         floor(CGRectGetHeight(featureHighlightGroup) * 0.22750 + 0.2) +
                                                                         0.5)];
      [white setFill];
      [hamburgerMiddlePath fill];

      UIBezierPath* hamburgerHighPath = [UIBezierPath
                                         bezierPathWithRect:CGRectMake(
                                                                       CGRectGetMinX(featureHighlightGroup) +
                                                                       floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                       0.3,
                                                                       CGRectGetMinY(featureHighlightGroup) +
                                                                       floor(CGRectGetHeight(featureHighlightGroup) * 0.18125 + 0.5),
                                                                       floor(CGRectGetWidth(featureHighlightGroup) * 0.20000 - 0.3) -
                                                                       floor(CGRectGetWidth(featureHighlightGroup) * 0.10288 + 0.2) +
                                                                       0.5,
                                                                       floor(CGRectGetHeight(featureHighlightGroup) * 0.20000) -
                                                                       floor(CGRectGetHeight(featureHighlightGroup) * 0.18125 + 0.5) +
                                                                       0.5)];
      [white setFill];
      [hamburgerHighPath fill];
    }

    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
  }
}

void MDCCatalogDrawFlexibleHeaderTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();

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

  UIColor* gradientColor = MDCPrimaryColor();
  UIColor* fillColor = MDCSecondaryColor();

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
  UIColor* blue80 = MDCPrimaryColor();

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

  UIColor* fillColor = MDCPrimaryColor();
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

  UIColor* fillColor = MDCPrimaryColor();
  CGFloat fillColorRGBA[4];
  [fillColor getRed:&fillColorRGBA[0]
              green:&fillColorRGBA[1]
               blue:&fillColorRGBA[2]
              alpha:&fillColorRGBA[3]];

  UIColor* color2 = [UIColor colorWithRed:(fillColorRGBA[0] * 0.7)
                                    green:(fillColorRGBA[1] * 0.7)
                                     blue:(fillColorRGBA[2] * 0.7)
                                    alpha:(fillColorRGBA[3] * 0.7 + 0.3)];
  UIColor* fillColor2 = [UIColor colorWithWhite:0.831 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithWhite:0.714 alpha:1];
  UIColor* fillColor4 = [UIColor colorWithWhite:0.608 alpha:1];
  UIColor* fillColor5 = [UIColor colorWithWhite:0.467 alpha:1];

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
  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = MDCSecondaryColor();
  UIColor* textForeground = [fillColor colorWithAlphaComponent:0.2];
  UIColor* gradientColor2 = MDCPrimaryColor();

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

void MDCCatalogDrawOverlayWindow(CGRect frame) {
  UIColor* fillColor = MDCSecondaryColor();
  UIColor* fillColor2 = MDCPrimaryColor();
  UIColor* fillColor3 = [UIColor colorWithWhite:0.5 alpha:1.0];

  CGRect overlayWindowGroup = CGRectMake(CGRectGetMinX(frame) + 54, CGRectGetMinY(frame) + 38,
                                         floor((CGRectGetWidth(frame) - 54) * 0.59701 + 0.5),
                                         floor((CGRectGetHeight(frame) - 38) * 0.68376 + 0.5));

  UIBezierPath* rightCornerPath = [UIBezierPath bezierPath];
  [rightCornerPath moveToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                           1.00000 * CGRectGetWidth(overlayWindowGroup),
                                           CGRectGetMinY(overlayWindowGroup) +
                                           0.00000 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              0.12500 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.00000 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              0.12500 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.12500 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              0.87500 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.12500 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              0.87500 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              1.00000 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                              1.00000 * CGRectGetWidth(overlayWindowGroup),
                                              CGRectGetMinY(overlayWindowGroup) +
                                              0.00000 * CGRectGetHeight(overlayWindowGroup))];
  [rightCornerPath closePath];
  rightCornerPath.miterLimit = 4;

  [fillColor setFill];
  [rightCornerPath fill];

  UIBezierPath* leftCornerPath = [UIBezierPath bezierPath];
  [leftCornerPath moveToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                          0.12500 * CGRectGetWidth(overlayWindowGroup),
                                          CGRectGetMinY(overlayWindowGroup) +
                                          0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.12500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.15150 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.12500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.14588 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.12500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.12500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.00000 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.12500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.00000 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.27088 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.00000 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.27650 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.00000 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             1.00000 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.65000 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             1.00000 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.87500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             1.00000 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.87500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.77500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath addLineToPoint:CGPointMake(CGRectGetMinX(overlayWindowGroup) +
                                             0.12500 * CGRectGetWidth(overlayWindowGroup),
                                             CGRectGetMinY(overlayWindowGroup) +
                                             0.87500 * CGRectGetHeight(overlayWindowGroup))];
  [leftCornerPath closePath];
  leftCornerPath.miterLimit = 4;

  [fillColor2 setFill];
  [leftCornerPath fill];

  UIBezierPath* overlapRectanglePath = [UIBezierPath
                                        bezierPathWithRect:CGRectMake(
                                                                      CGRectGetMinX(overlayWindowGroup) +
                                                                      floor(CGRectGetWidth(overlayWindowGroup) * 0.12500 + 0.5),
                                                                      CGRectGetMinY(overlayWindowGroup) +
                                                                      floor(CGRectGetHeight(overlayWindowGroup) * 0.12500 + 0.5),
                                                                      floor(CGRectGetWidth(overlayWindowGroup) * 0.87500 + 0.5) -
                                                                      floor(CGRectGetWidth(overlayWindowGroup) * 0.12500 + 0.5),
                                                                      floor(CGRectGetHeight(overlayWindowGroup) * 0.87500 + 0.5) -
                                                                      floor(CGRectGetHeight(overlayWindowGroup) * 0.12500 + 0.5))];
  [fillColor3 setFill];
  [overlapRectanglePath fill];
}

void MDCCatalogDrawPageControlTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor10 = MDCSecondaryColor();
  UIColor* gradientColor2 = MDCPrimaryColor();
  UIColor* fillColor7 = [gradientColor2 colorWithAlphaComponent:0.5];
  UIColor* fillColor8 = [gradientColor2 colorWithAlphaComponent:0.8];
  UIColor* color2 = [gradientColor2 colorWithAlphaComponent:0.3];

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

static NSString* const PalettesFontName = @"RobotoMono-Regular";

void MDCCatalogDrawPalettesTile(CGRect frame) {
  CGFloat PalettesFontPointSize = [UIScreen mainScreen].bounds.size.width / 320 * 7;

  UIColor* textDark = MDCPrimaryColor();
  UIColor* textLight = MDCSecondaryColor();
  UIColor* fill200 = [UIColor colorWithWhite:0.831 alpha:1];
  UIColor* fill300 = [UIColor colorWithWhite:0.765 alpha:1];
  UIColor* fill400 = [UIColor colorWithWhite:0.714 alpha:1];
  UIColor* fill500 = [UIColor colorWithWhite:0.663 alpha:1];
  UIColor* fill600 = [UIColor colorWithWhite:0.608 alpha:1];
  UIColor* fill700 = [UIColor colorWithWhite:0.533 alpha:1];
  UIColor* fill800 = [UIColor colorWithWhite:0.467 alpha:1];

  CGRect palettesGroup = CGRectMake(CGRectGetMinX(frame) + 25, CGRectGetMinY(frame) + 24.1,
                                    floor((CGRectGetWidth(frame) - 25) * 0.84663 + 0.5),
                                    floor((CGRectGetHeight(frame) - 24.1) * 0.60733 + 23.7) - 23.2);

  {
    UIBezierPath* rectangle100Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) + 0.9,
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) - 0.4)];
    [textLight setFill];
    [rectangle100Path fill];

    UIBezierPath* rectangle200Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) + 0.9,
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) - 0.4)];
    [fill200 setFill];
    [rectangle200Path fill];

    UIBezierPath* rectangle300Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) + 0.9,
                                                                    floor(CGRectGetWidth(palettesGroup) * 1.00000 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.00000 - 0.4) - 0.4)];
    [fill300 setFill];
    [rectangle300Path fill];

    UIBezierPath* rectangle400Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.3,
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66918 - 0.4) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.6)];
    [fill400 setFill];
    [rectangle400Path fill];

    UIBezierPath* rectangle500Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.3,
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66918 - 0.4) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.6)];
    [fill500 setFill];
    [rectangle500Path fill];

    UIBezierPath* rectangle600Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(
                                                                    CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.3,
                                                                    floor(CGRectGetWidth(palettesGroup) * 1.00000 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66918 - 0.4) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.33459 + 0.2) + 0.6)];
    [fill600 setFill];
    [rectangle600Path fill];

    UIBezierPath* rectangle700Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5),
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.00000 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 1.00000 - 0.1) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5) +
                                                                    0.6)];
    [fill700 setFill];
    [rectangle700Path fill];

    UIBezierPath* rectangle800Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5),
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.33333 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 1.00000 - 0.1) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5) +
                                                                    0.6)];
    [fill800 setFill];
    [rectangle800Path fill];

    UIBezierPath* rectangle900Path = [UIBezierPath
                                      bezierPathWithRect:CGRectMake(CGRectGetMinX(palettesGroup) +
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    CGRectGetMinY(palettesGroup) +
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5),
                                                                    floor(CGRectGetWidth(palettesGroup) * 1.00000 + 0.5) -
                                                                    floor(CGRectGetWidth(palettesGroup) * 0.66667 + 0.5),
                                                                    floor(CGRectGetHeight(palettesGroup) * 1.00000 - 0.1) -
                                                                    floor(CGRectGetHeight(palettesGroup) * 0.66541 + 0.5) +
                                                                    0.6)];
    [textDark setFill];
    [rectangle900Path fill];

    CGRect label100Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.17769 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.31321 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1));
    NSMutableParagraphStyle* label100Style = [NSMutableParagraphStyle new];
    label100Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label100FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textDark,
                                             NSParagraphStyleAttributeName : label100Style
                                             };

    [@"100" drawInRect:label100Rect withAttributes:label100FontAttributes];

    CGRect label200Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5),
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.50740 + 0.48) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.31321 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1));
    NSMutableParagraphStyle* label200Style = [NSMutableParagraphStyle new];
    label200Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label200FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textDark,
                                             NSParagraphStyleAttributeName : label200Style
                                             };

    [@"200" drawInRect:label200Rect withAttributes:label200FontAttributes];

    CGRect label300Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.83711 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.31321 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.12453 - 0.1));
    NSMutableParagraphStyle* label300Style = [NSMutableParagraphStyle new];
    label300Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label300FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textDark,
                                             NSParagraphStyleAttributeName : label300Style
                                             };

    [@"300" drawInRect:label300Rect withAttributes:label300FontAttributes];

    CGRect label400Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.17769 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.65283 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1));
    NSMutableParagraphStyle* label400Style = [NSMutableParagraphStyle new];
    label400Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label400FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textDark,
                                             NSParagraphStyleAttributeName : label400Style
                                             };

    [@"400" drawInRect:label400Rect withAttributes:label400FontAttributes];

    CGRect label500Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5),
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.50740 + 0.48) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.65283 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1));
    NSMutableParagraphStyle* label500Style = [NSMutableParagraphStyle new];
    label500Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label500FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textLight,
                                             NSParagraphStyleAttributeName : label500Style
                                             };

    [@"500" drawInRect:label500Rect withAttributes:label500FontAttributes];

    CGRect label600Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1) + 0.6,
                                     floor(CGRectGetWidth(palettesGroup) * 0.83711 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.65283 - 0.1) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.46415 - 0.1));
    NSMutableParagraphStyle* label600Style = [NSMutableParagraphStyle new];
    label600Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label600FontAttributes = @{
      NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
      NSForegroundColorAttributeName : textDark,
      NSParagraphStyleAttributeName : label600Style
    };

    [@"600" drawInRect:label600Rect withAttributes:label600FontAttributes];

    CGRect label700Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4) + 0.1,
                                     floor(CGRectGetWidth(palettesGroup) * 0.17769 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.03261) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.98616 + 0.4) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4));
    NSMutableParagraphStyle* label700Style = [NSMutableParagraphStyle new];
    label700Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label700FontAttributes = @{
      NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
      NSForegroundColorAttributeName : textDark,
      NSParagraphStyleAttributeName : label700Style
    };

    [@"700" drawInRect:label700Rect withAttributes:label700FontAttributes];

    CGRect label800Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5),
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4) + 0.1,
                                     floor(CGRectGetWidth(palettesGroup) * 0.50740 + 0.48) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.36232 + 0.5) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.98616 + 0.4) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4));
    NSMutableParagraphStyle* label800Style = [NSMutableParagraphStyle new];
    label800Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label800FontAttributes = @{
      NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
      NSForegroundColorAttributeName : textDark,
      NSParagraphStyleAttributeName : label800Style
    };

    [@"800" drawInRect:label800Rect withAttributes:label800FontAttributes];

    CGRect label900Rect = CGRectMake(
                                     CGRectGetMinX(palettesGroup) + floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.5,
                                     CGRectGetMinY(palettesGroup) + floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4) + 0.1,
                                     floor(CGRectGetWidth(palettesGroup) * 0.83711 - 0.02) -
                                     floor(CGRectGetWidth(palettesGroup) * 0.69203) + 0.02,
                                     floor(CGRectGetHeight(palettesGroup) * 0.98616 + 0.4) -
                                     floor(CGRectGetHeight(palettesGroup) * 0.79749 + 0.4));
    NSMutableParagraphStyle* label900Style = [NSMutableParagraphStyle new];
    label900Style.alignment = NSTextAlignmentLeft;

    NSDictionary* label900FontAttributes = @{
                                             NSFontAttributeName : [UIFont fontWithName:PalettesFontName size:PalettesFontPointSize],
                                             NSForegroundColorAttributeName : textLight,
                                             NSParagraphStyleAttributeName : label900Style
                                             };

    [@"900" drawInRect:label900Rect withAttributes:label900FontAttributes];
  }
}

void MDCCatalogDrawProgressViewTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = [UIColor colorWithWhite:0.1 alpha:1];
  UIColor* gradientColor = MDCSecondaryColor();

  CGFloat gradientLocations[] = {0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
                                                      colorSpace,
                                                      (__bridge CFArrayRef) @[ (id)gradientColor.CGColor, (id)UIColor.clearColor.CGColor ],
                                                      gradientLocations);

  CGRect progressViewGroup = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                                        floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                                        floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));

  {
    CGRect gradientRectangleRect = CGRectMake(
        CGRectGetMinX(progressViewGroup) + floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
        CGRectGetMinY(progressViewGroup) +
            floor(CGRectGetHeight(progressViewGroup) * 0.30500),
        floor(CGRectGetWidth(progressViewGroup) * 1.00000 + 0.5) -
            floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
        floor(CGRectGetHeight(progressViewGroup) * 1.00000 - 0.1) -
            floor(CGRectGetHeight(progressViewGroup) * 0.30500 + 0.5) + 0.6);
    UIBezierPath* gradientRectanglePath = [UIBezierPath bezierPathWithRect:gradientRectangleRect];
    CGContextSaveGState(context);
    [gradientRectanglePath addClip];
    CGContextDrawLinearGradient(
                                context, gradient,
                                CGPointMake(CGRectGetMidX(gradientRectangleRect), CGRectGetMinY(gradientRectangleRect)),
                                CGPointMake(CGRectGetMidX(gradientRectangleRect), CGRectGetMaxY(gradientRectangleRect)), 0);
    CGContextRestoreGState(context);

    UIBezierPath* whiteProgressBackgroundRectanglePath = [UIBezierPath
                                                          bezierPathWithRect:CGRectMake(CGRectGetMinX(progressViewGroup) +
                                                                                        floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
                                                                                        CGRectGetMinY(progressViewGroup) +
                                                                                        floor(CGRectGetHeight(progressViewGroup) * 0.36250) + 0.5,
                                                                                        floor(CGRectGetWidth(progressViewGroup) * 1.00000 + 0.5) -
                                                                                        floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
                                                                                        floor(CGRectGetHeight(progressViewGroup) * 0.41875 + 0.5) -
                                                                                        floor(CGRectGetHeight(progressViewGroup) * 0.36250) -
                                                                                        0.5)];
    [UIColor.whiteColor setFill];
    [whiteProgressBackgroundRectanglePath fill];

    UIBezierPath* headerRectanglePath = [UIBezierPath
                                         bezierPathWithRect:CGRectMake(
                                                                       CGRectGetMinX(progressViewGroup) +
                                                                       floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
                                                                       CGRectGetMinY(progressViewGroup) +
                                                                       floor(CGRectGetHeight(progressViewGroup) * 0.00000 + 0.5),
                                                                       floor(CGRectGetWidth(progressViewGroup) * 1.00000 + 0.5) -
                                                                       floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
                                                                       floor(CGRectGetHeight(progressViewGroup) * 0.36250 + 0.5) -
                                                                       floor(CGRectGetHeight(progressViewGroup) * 0.00000 + 0.5))];
    [fillColor2 setFill];
    [headerRectanglePath fill];

    UIBezierPath* progressRectanglePath = [UIBezierPath
                                           bezierPathWithRect:CGRectMake(
                                                                         CGRectGetMinX(progressViewGroup) +
                                                                         floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
                                                                         CGRectGetMinY(progressViewGroup) +
                                                                         floor(CGRectGetHeight(progressViewGroup) * 0.35625 + 0.5),
                                                                         floor(CGRectGetWidth(progressViewGroup) * 0.79209 + 0.4) -
                                                                         floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5) + 0.1,
                                                                         floor(CGRectGetHeight(progressViewGroup) * 0.41250) -
                                                                         floor(CGRectGetHeight(progressViewGroup) * 0.35625 + 0.5) +
                                                                         0.5)];
    [fillColor setFill];
    [progressRectanglePath fill];
  }

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawShadowLayerTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCPrimaryColor();
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

  UIColor* fillColor = MDCPrimaryColor();
  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor2 = [UIColor colorWithWhite:0.209 alpha:1];
  UIColor* fillColor3 = [UIColor colorWithWhite:0.407 alpha:1];
  UIColor* fillColor4 = MDCSecondaryColor();
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

  CGGradientRelease(gradient50);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawSnackbarTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = MDCSecondaryColor();
  UIColor* fillColor = MDCPrimaryColor();

  CGFloat gradientLocations[] = {0, 0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
                                                      colorSpace,
                                                      (__bridge CFArrayRef)
                                                      @[ (id)gradientColor.CGColor, (id)gradientColor.CGColor, (id)gradientColor.CGColor ],
                                                      gradientLocations);

  CGRect group = CGRectMake(
                            CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
                            CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 55.6) * 0.21076 + 0.05) + 0.45, 139,
                            55.6);

  {
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 0.1);
    CGContextBeginTransparencyLayer(context, NULL);

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

  UIBezierPath* rectangle2Path = [UIBezierPath
                                  bezierPathWithRect:CGRectMake(CGRectGetMinX(frame) +
                                                                floor((CGRectGetWidth(frame) - 139) * 0.50000) + 0.5,
                                                                CGRectGetMinY(frame) +
                                                                floor((CGRectGetHeight(frame) - 29) * 0.57103 + 0.45) +
                                                                0.05,
                                                                139, 29)];
  [fillColor setFill];
  [rectangle2Path fill];

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

void MDCCatalogDrawSwitchTile(CGRect frame) {
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = MDCSecondaryColor();
  UIColor* fillColor2 = MDCPrimaryColor();

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

void MDCCatalogDrawTabsTile(CGRect frame) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = MDCSecondaryColor();
  UIColor* fillColor = MDCPrimaryColor();
  UIColor* fillColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
  
  CGFloat gradientLocations[] = {0, 0.86, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
                                                      colorSpace,
                                                      (__bridge CFArrayRef)
                                                      @[ (id)fillColor.CGColor, (id)gradientColor.CGColor, (id)gradientColor.CGColor ],
                                                      gradientLocations);
  
  NSShadow* shadow = [[NSShadow alloc] init];
  [shadow
   setShadowColor:[fillColor colorWithAlphaComponent:CGColorGetAlpha(fillColor.CGColor) * 0.44]];
  [shadow setShadowOffset:CGSizeMake(1.1, -0.1)];
  [shadow setShadowBlurRadius:5];
  
  CGRect tabsGroup = CGRectMake(CGRectGetMinX(frame) + 24, CGRectGetMinY(frame) + 24.1,
                                floor((CGRectGetWidth(frame) - 24) * 0.85366 + 0.5),
                                floor((CGRectGetHeight(frame) - 24.1) * 0.67227 + 23.7) - 23.2);
  
  CGContextSaveGState(context);
  CGContextBeginTransparencyLayer(context, NULL);
  
  UIBezierPath* clip2Path = [UIBezierPath
                             bezierPathWithRect:CGRectMake(CGRectGetMinX(tabsGroup) +
                                                           floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                           CGRectGetMinY(tabsGroup) +
                                                           floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5),
                                                           floor(CGRectGetWidth(tabsGroup) * 1.00000 + 0.5) -
                                                           floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                           floor(CGRectGetHeight(tabsGroup) * 1.00000 + 0.5) -
                                                           floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5))];
  [clip2Path addClip];
  
  CGContextSaveGState(context);
  CGContextSetAlpha(context, 0.1);
  CGContextBeginTransparencyLayer(context, NULL);
  
  UIBezierPath* clipPath = [UIBezierPath
                            bezierPathWithRect:CGRectMake(CGRectGetMinX(tabsGroup) +
                                                          floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                          CGRectGetMinY(tabsGroup) +
                                                          floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5),
                                                          floor(CGRectGetWidth(tabsGroup) * 1.00000 + 0.5) -
                                                          floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                          floor(CGRectGetHeight(tabsGroup) * 1.00000 + 0.5) -
                                                          floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5))];
  [clipPath addClip];
  
  CGRect rectangleRect =
  CGRectMake(CGRectGetMinX(tabsGroup) + floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
             CGRectGetMinY(tabsGroup) + floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5),
             floor(CGRectGetWidth(tabsGroup) * 1.00000 + 0.5) -
             floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
             floor(CGRectGetHeight(tabsGroup) * 1.00000 + 0.5) -
             floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5));
  UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rectangleRect];
  CGContextSaveGState(context);
  [rectanglePath addClip];
  CGContextDrawLinearGradient(
                              context, gradient,
                              CGPointMake(CGRectGetMidX(rectangleRect) + 0 * CGRectGetWidth(rectangleRect) / 140,
                                          CGRectGetMidY(rectangleRect) + 18.17 * CGRectGetHeight(rectangleRect) / 88),
                              CGPointMake(CGRectGetMidX(rectangleRect) + 0 * CGRectGetWidth(rectangleRect) / 140,
                                          CGRectGetMidY(rectangleRect) + 41.79 * CGRectGetHeight(rectangleRect) / 88),
                              kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
  CGContextRestoreGState(context);
  
  CGContextEndTransparencyLayer(context);
  CGContextRestoreGState(context);
  UIBezierPath* tabBarBackgroundRectanglePath = [UIBezierPath
                                                 bezierPathWithRect:CGRectMake(CGRectGetMinX(tabsGroup) +
                                                                               floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                                               CGRectGetMinY(tabsGroup) +
                                                                               floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5),
                                                                               floor(CGRectGetWidth(tabsGroup) * 1.00000 + 0.5) -
                                                                               floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                                               floor(CGRectGetHeight(tabsGroup) * 0.68182 + 0.5) -
                                                                               floor(CGRectGetHeight(tabsGroup) * 0.00000 + 0.5))];
  [fillColor setFill];
  [tabBarBackgroundRectanglePath fill];
  
  UIBezierPath* selectedRectanglePath = [UIBezierPath
                                         bezierPathWithRect:CGRectMake(CGRectGetMinX(tabsGroup) +
                                                                       floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5),
                                                                       CGRectGetMinY(tabsGroup) +
                                                                       floor(CGRectGetHeight(tabsGroup) * 0.63636 + 0.5),
                                                                       floor(CGRectGetWidth(tabsGroup) * 0.33857 + 0.1) -
                                                                       floor(CGRectGetWidth(tabsGroup) * 0.00000 + 0.5) + 0.4,
                                                                       floor(CGRectGetHeight(tabsGroup) * 0.68182 + 0.5) -
                                                                       floor(CGRectGetHeight(tabsGroup) * 0.63636 + 0.5))];
  CGContextSaveGState(context);
  CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius,
                              [shadow.shadowColor CGColor]);
  [fillColor2 setFill];
  [selectedRectanglePath fill];
  CGContextRestoreGState(context);
  
  UIBezierPath* hamburgerBezierPath = [UIBezierPath bezierPath];
  [hamburgerBezierPath
   moveToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                           CGRectGetMinY(tabsGroup) + 0.13384 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.13384 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.12122 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.12122 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.13384 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath closePath];
  [hamburgerBezierPath
   moveToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                           CGRectGetMinY(tabsGroup) + 0.16541 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.16541 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.15278 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.15278 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.16541 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath closePath];
  [hamburgerBezierPath
   moveToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                           CGRectGetMinY(tabsGroup) + 0.19697 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.19697 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.14286 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.18434 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.18434 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath
   addLineToPoint:CGPointMake(CGRectGetMinX(tabsGroup) + 0.07143 * CGRectGetWidth(tabsGroup),
                              CGRectGetMinY(tabsGroup) + 0.19697 * CGRectGetHeight(tabsGroup))];
  [hamburgerBezierPath closePath];
  [fillColor2 setFill];
  [hamburgerBezierPath fill];
  
  CGContextEndTransparencyLayer(context);
  CGContextRestoreGState(context);
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

static NSString* const TextFieldFontName = @"RobotoMono-Medium";

void MDCCatalogDrawTextFieldTile(CGRect frame) {
  UIColor* fillColor = [UIColor colorWithRed: 0.012 green: 0.663 blue: 0.957 alpha: 1];
  UIColor* textForeground = [UIColor colorWithRed: 0.008 green: 0.467 blue: 0.741 alpha: 1];
  
  
  CGRect textFieldGroup = CGRectMake(CGRectGetMinX(frame) + 24, CGRectGetMinY(frame) + 60, floor((frame.size.width - 24) * 0.85366 + 0.5), floor((frame.size.height - 60) * 0.38947 + 0.5));
  
  UIBezierPath* underlineRectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(textFieldGroup) + floor(textFieldGroup.size.width * 0.00000 + 0.5), CGRectGetMinY(textFieldGroup) + floor(textFieldGroup.size.height * 0.89189 + 0.5), floor(textFieldGroup.size.width * 1.00000 + 0.5) - floor(textFieldGroup.size.width * 0.00000 + 0.5), floor(textFieldGroup.size.height * 1.00000 + 0.5) - floor(textFieldGroup.size.height * 0.89189 + 0.5))];
  [fillColor setFill];
  [underlineRectanglePath fill];
  
  
  CGRect textLabelRect = CGRectMake(CGRectGetMinX(textFieldGroup) + floor(textFieldGroup.size.width * 0.00000 + 0.5), CGRectGetMinY(textFieldGroup) + floor(textFieldGroup.size.height * 0.00000 + 0.5), floor(textFieldGroup.size.width * 0.27433 + 0.09) - floor(textFieldGroup.size.width * 0.00000 + 0.5) + 0.41, floor(textFieldGroup.size.height * 0.70270 + 0.5) - floor(textFieldGroup.size.height * 0.00000 + 0.5));
  NSMutableParagraphStyle* textLabelStyle = [[NSMutableParagraphStyle alloc] init];
  textLabelStyle.alignment = NSTextAlignmentLeft;
  NSDictionary* textLabelFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: TextFieldFontName size: 16], NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: textLabelStyle};
  
  [@"Text" drawInRect: textLabelRect withAttributes: textLabelFontAttributes];
  
  
  CGRect fieldLabelRect = CGRectMake(CGRectGetMinX(textFieldGroup) + floor(textFieldGroup.size.width * 0.32579 - 0.11) + 0.61, CGRectGetMinY(textFieldGroup) + floor(textFieldGroup.size.height * 0.00000 + 0.5), floor(textFieldGroup.size.width * 0.66870 - 0.12) - floor(textFieldGroup.size.width * 0.32579 - 0.11) + 0.01, floor(textFieldGroup.size.height * 0.70270 + 0.5) - floor(textFieldGroup.size.height * 0.00000 + 0.5));
  NSMutableParagraphStyle* fieldLabelStyle = [[NSMutableParagraphStyle alloc] init];
  fieldLabelStyle.alignment = NSTextAlignmentLeft;
  NSDictionary* fieldLabelFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: TextFieldFontName size: 16], NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: fieldLabelStyle};
  
  [@"field" drawInRect: fieldLabelRect withAttributes: fieldLabelFontAttributes];
  
  
  UIBezierPath* cursorRectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(textFieldGroup) + floor(textFieldGroup.size.width * 0.66429 + 0.5), CGRectGetMinY(textFieldGroup) + floor(textFieldGroup.size.height * 0.08109 + 0.5), floor(textFieldGroup.size.width * 0.67857 + 0.5) - floor(textFieldGroup.size.width * 0.66429 + 0.5), floor(textFieldGroup.size.height * 0.67568 + 0.5) - floor(textFieldGroup.size.height * 0.08109 + 0.5))];
  [fillColor setFill];
  [cursorRectanglePath fill];
  
}

void MDCCatalogDrawTypographyTile(CGRect frame) {
  UIColor* fillColor = MDCPrimaryColor();

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
