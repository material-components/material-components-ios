// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <UIKit/UIKit.h>

#import "MDCCatalogTiles.h"
#import "MaterialColorScheme.h"

UIImage* _Nullable MDCDrawImage(CGRect frame,
                                MDCDrawFunc drawFunc,
                                id<MDCColorScheming> colorScheme) {
  if (CGRectIsEmpty(frame)) {
    return nil;
  }
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);
  drawFunc(frame, colorScheme);
  UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

/* Auto-generated code using PaintCode and formatted with clang-format. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
#pragma clang diagnostic ignored "-Wconversion"

void MDCCatalogDrawMDCLogoDark(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* green = [UIColor colorWithRed:0 green:0.902 blue:0.463 alpha:1];
  UIColor* lightGreen = [UIColor colorWithRed:0.698 green:1 blue:0.349 alpha:1];
  UIColor* fillColor = [UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1];

  CGRect logoDarkGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 1,
                                    floor((frame.size.width) * 1.00000 + 0.5),
                                    floor((frame.size.height - 1) * 1.00000 + 0.5));
  {
    UIBezierPath* squarePath = [UIBezierPath bezierPath];
    [squarePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(logoDarkGroup) + 0.00000 * logoDarkGroup.size.width,
                        CGRectGetMinY(logoDarkGroup) + 0.66667 * logoDarkGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.33333 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.66667 * logoDarkGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.33333 * logoDarkGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.00000 * logoDarkGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.00000 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.00000 * logoDarkGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.00000 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.66667 * logoDarkGroup.size.height)];
    [squarePath closePath];
    [fillColor setFill];
    [squarePath fill];

    UIBezierPath* circlePath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(logoDarkGroup) +
                                                floor(logoDarkGroup.size.width * 0.33333 + 0.5),
                                            CGRectGetMinY(logoDarkGroup) +
                                                floor(logoDarkGroup.size.height * 0.33333 + 0.5),
                                            floor(logoDarkGroup.size.width * 1.00000 + 0.5) -
                                                floor(logoDarkGroup.size.width * 0.33333 + 0.5),
                                            floor(logoDarkGroup.size.height * 1.00000 + 0.5) -
                                                floor(logoDarkGroup.size.height * 0.33333 + 0.5))];
    [lightGreen setFill];
    [circlePath fill];

    UIBezierPath* intersectionPath = [UIBezierPath bezierPath];
    [intersectionPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                        CGRectGetMinY(logoDarkGroup) + 0.33333 * logoDarkGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.33333 * logoDarkGroup.size.height)];
    [intersectionPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(logoDarkGroup) + 0.33333 * logoDarkGroup.size.width,
                            CGRectGetMinY(logoDarkGroup) + 0.66667 * logoDarkGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(logoDarkGroup) + 0.48257 * logoDarkGroup.size.width,
                            CGRectGetMinY(logoDarkGroup) + 0.33333 * logoDarkGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(logoDarkGroup) + 0.33333 * logoDarkGroup.size.width,
                            CGRectGetMinY(logoDarkGroup) + 0.48257 * logoDarkGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.66667 * logoDarkGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoDarkGroup) + 0.66667 * logoDarkGroup.size.width,
                           CGRectGetMinY(logoDarkGroup) + 0.33333 * logoDarkGroup.size.height)];
    [intersectionPath closePath];
    [green setFill];
    [intersectionPath fill];
  }
}

void MDCCatalogDrawMDCLogoLight(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* white = [UIColor whiteColor];
  UIColor* green = [UIColor colorWithRed:0 green:0.902 blue:0.463 alpha:1];
  UIColor* lightGreen = [UIColor colorWithRed:0.698 green:1 blue:0.349 alpha:1];

  CGRect logoLightGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame),
                                     floor((frame.size.width) * 1.00000 + 0.5),
                                     floor((frame.size.height) * 1.00000 + 0.5));
  {
    UIBezierPath* squarePath = [UIBezierPath bezierPath];
    [squarePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(logoLightGroup) + 0.00000 * logoLightGroup.size.width,
                        CGRectGetMinY(logoLightGroup) + 0.66667 * logoLightGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.33333 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.66667 * logoLightGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.33333 * logoLightGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.00000 * logoLightGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.00000 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.00000 * logoLightGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.00000 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.66667 * logoLightGroup.size.height)];
    [squarePath closePath];
    [white setFill];
    [squarePath fill];

    UIBezierPath* circlePath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(CGRectGetMinX(logoLightGroup) +
                                                floor(logoLightGroup.size.width * 0.33333 + 0.5),
                                            CGRectGetMinY(logoLightGroup) +
                                                floor(logoLightGroup.size.height * 0.33333 + 0.5),
                                            floor(logoLightGroup.size.width * 1.00000 + 0.5) -
                                                floor(logoLightGroup.size.width * 0.33333 + 0.5),
                                            floor(logoLightGroup.size.height * 1.00000 + 0.5) -
                                                floor(logoLightGroup.size.height * 0.33333 + 0.5))];
    [green setFill];
    [circlePath fill];

    UIBezierPath* intersectionPath = [UIBezierPath bezierPath];
    [intersectionPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                        CGRectGetMinY(logoLightGroup) + 0.33333 * logoLightGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.33333 * logoLightGroup.size.height)];
    [intersectionPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(logoLightGroup) + 0.33333 * logoLightGroup.size.width,
                            CGRectGetMinY(logoLightGroup) + 0.66667 * logoLightGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(logoLightGroup) + 0.48257 * logoLightGroup.size.width,
                            CGRectGetMinY(logoLightGroup) + 0.33333 * logoLightGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(logoLightGroup) + 0.33333 * logoLightGroup.size.width,
                            CGRectGetMinY(logoLightGroup) + 0.48257 * logoLightGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.66667 * logoLightGroup.size.height)];
    [intersectionPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(logoLightGroup) + 0.66667 * logoLightGroup.size.width,
                           CGRectGetMinY(logoLightGroup) + 0.33333 * logoLightGroup.size.height)];
    [intersectionPath closePath];
    [lightGreen setFill];
    [intersectionPath fill];
  }
}

void MDCCatalogDrawActivityIndicatorTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect activityIndicatorGroup =
      CGRectMake(CGRectGetMinX(frame) + 7.67, CGRectGetMinY(frame) + 7.67,
                 floor((frame.size.width - 7.67) * 0.89686 + 7.83) - 7.33,
                 floor((frame.size.height - 7.67) * 0.89686 + 7.83) - 7.33);
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                            0.95000 * activityIndicatorGroup.size.width,
                                        CGRectGetMinY(activityIndicatorGroup) +
                                            0.45000 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.92250 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.45000 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.47250 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.72050 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.72050 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.27950 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.90000 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.72050 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.27950 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.27950 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.55000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.05000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.52750 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.10000 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.55000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.07750 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.55000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.02250 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.52750 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.22450 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.22450 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.77550 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.22450 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.50000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.77550 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.77550 * activityIndicatorGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.95000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.45000 * activityIndicatorGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                1.00000 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.47250 * activityIndicatorGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(activityIndicatorGroup) +
                                                0.97750 * activityIndicatorGroup.size.width,
                                            CGRectGetMinY(activityIndicatorGroup) +
                                                0.45000 * activityIndicatorGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawAnimationTimingTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect animationGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                     floor((frame.size.width - 1) * 0.98765 + 0.5),
                                     floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* ringsBezierPath = [UIBezierPath bezierPath];
    [ringsBezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(animationGroup) + 0.65000 * animationGroup.size.width,
                        CGRectGetMinY(animationGroup) + 0.00000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.33900 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.18900 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.51450 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.00000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.39750 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.07700 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.18900 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.33900 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.27500 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.22250 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.22200 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.27500 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.65000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.07700 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.39750 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.51450 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.35000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 1.00000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.84350 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.15650 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 1.00000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.66100 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.81100 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.48550 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 1.00000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.60250 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.92300 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.81100 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.66100 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.72500 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.77750 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.77800 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.72500 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 1.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.35000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.92300 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.60250 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 1.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.48550 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.65000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.00000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 1.00000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.15650 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.84350 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.00000 * animationGroup.size.height)];
    [ringsBezierPath closePath];
    [ringsBezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(animationGroup) + 0.35000 * animationGroup.size.width,
                        CGRectGetMinY(animationGroup) + 0.90000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.10000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.65000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.21200 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.90000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.10000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.78800 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.15000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.50000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.10000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.59400 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.11850 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.54200 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.50000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.85000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.15000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.69350 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.30650 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.85000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.35000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.90000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.45800 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.88150 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.40600 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.90000 * animationGroup.size.height)];
    [ringsBezierPath closePath];
    [ringsBezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(animationGroup) + 0.50000 * animationGroup.size.width,
                        CGRectGetMinY(animationGroup) + 0.75000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.25000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.50000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.36200 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.75000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.25000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.63800 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.30000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.35000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.25000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.44400 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.26850 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.39200 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.65000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.70000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.30000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.54300 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.45650 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.69950 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.50000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.75000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.60800 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.73150 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.55600 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.75000 * animationGroup.size.height)];
    [ringsBezierPath closePath];
    [ringsBezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(animationGroup) + 0.73500 * animationGroup.size.width,
                        CGRectGetMinY(animationGroup) + 0.58500 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.65000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.60000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.70850 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.59450 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.68000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.60000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.40000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.35000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.51200 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.60000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.40000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.48800 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.41500 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.26500 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.40000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.32000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.40550 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.29150 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.50000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.25000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.44150 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.25550 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.47000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.25000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.75000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.50000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.63800 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.25000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.75000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.36200 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.73500 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.58500 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.75000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.53000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.74450 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.55850 * animationGroup.size.height)];
    [ringsBezierPath closePath];
    [ringsBezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(animationGroup) + 0.85000 * animationGroup.size.width,
                        CGRectGetMinY(animationGroup) + 0.50000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.50000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.15000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.85000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.30700 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.69350 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.15050 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.65000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.10000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.54200 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.11850 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.59350 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.10000 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.90000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.35000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.78800 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.10000 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.90000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.21200 * animationGroup.size.height)];
    [ringsBezierPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.85000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.50000 * animationGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.90000 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.40600 * animationGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(animationGroup) + 0.88150 * animationGroup.size.width,
                            CGRectGetMinY(animationGroup) + 0.45800 * animationGroup.size.height)];
    [ringsBezierPath closePath];
    [fillColor setFill];
    [ringsBezierPath fill];
  }
}

void MDCCatalogDrawAppBarTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect appBarGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame),
                                  floor((frame.size.width) * 1.00000 + 0.5),
                                  floor((frame.size.height) * 1.00000 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.00000 * appBarGroup.size.width,
                                CGRectGetMinY(appBarGroup) + 0.00000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.00000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 1.00000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 1.00000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 1.00000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 1.00000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.00000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.00000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.00000 * appBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                CGRectGetMinY(appBarGroup) + 0.10000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.90000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.10000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.90000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.25000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.25000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.10000 * appBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                CGRectGetMinY(appBarGroup) + 0.90000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.35000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.90000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.35000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.90000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.90000 * appBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(appBarGroup) + 0.10000 * appBarGroup.size.width,
                                   CGRectGetMinY(appBarGroup) + 0.90000 * appBarGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawBottomAppBarTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect bottomAppBarGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                        floor((frame.size.width - 1) * 0.98765 + 0.5),
                                        floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                            0.00000 * bottomAppBarGroup.size.width,
                                        CGRectGetMinY(bottomAppBarGroup) +
                                            0.00000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.65000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               1.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.00000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.00000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.00000 * bottomAppBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                            0.90000 * bottomAppBarGroup.size.width,
                                        CGRectGetMinY(bottomAppBarGroup) +
                                            0.90000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.75000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.35700 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.75000 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.50000 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.82500 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.38850 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.79500 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.44100 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.82500 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.64300 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.75000 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.55900 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.82500 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.61150 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.79500 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.75000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                            0.50000 * bottomAppBarGroup.size.width,
                                        CGRectGetMinY(bottomAppBarGroup) +
                                            0.72500 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.42500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.65000 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.45850 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.72500 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.42500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.69150 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.50000 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.42500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.60850 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.45850 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.65000 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.54150 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.60850 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.50000 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.72500 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.57500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.69150 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.54150 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.72500 * bottomAppBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                            0.67500 * bottomAppBarGroup.size.width,
                                        CGRectGetMinY(bottomAppBarGroup) +
                                            0.65000 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.50000 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.47500 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.67500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.55350 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.59650 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.47500 * bottomAppBarGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.32500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.65000 * bottomAppBarGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.40350 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.47500 * bottomAppBarGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                                0.32500 * bottomAppBarGroup.size.width,
                                            CGRectGetMinY(bottomAppBarGroup) +
                                                0.55350 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.65000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.10000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.90000 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.65000 * bottomAppBarGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomAppBarGroup) +
                                               0.67500 * bottomAppBarGroup.size.width,
                                           CGRectGetMinY(bottomAppBarGroup) +
                                               0.65000 * bottomAppBarGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawBottomNavTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect bottomNavGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                     floor((frame.size.width - 1) * 0.98765 + 0.5),
                                     floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(bottomNavGroup) + 1.00000 * bottomNavGroup.size.width,
                        CGRectGetMinY(bottomNavGroup) + 1.00000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 1.00000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.00000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.00000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.00000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.00000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 1.00000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 1.00000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 1.00000 * bottomNavGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                        CGRectGetMinY(bottomNavGroup) + 0.90000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.10000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.90000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.10000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.75000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.75000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.90000 * bottomNavGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                        CGRectGetMinY(bottomNavGroup) + 0.10000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.65000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.10000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.65000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.10000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.10000 * bottomNavGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(bottomNavGroup) + 0.90000 * bottomNavGroup.size.width,
                           CGRectGetMinY(bottomNavGroup) + 0.10000 * bottomNavGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawBottomSheetTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect bottomSheetGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                       floor((frame.size.width - 1) * 0.98765 + 0.5),
                                       floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(bottomSheetGroup) + 0.00000 * bottomSheetGroup.size.width,
                        CGRectGetMinY(bottomSheetGroup) + 0.00000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.50000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               1.00000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               1.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               1.00000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               1.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.50000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               1.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.00000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.00000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.00000 * bottomSheetGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(bottomSheetGroup) + 0.10000 * bottomSheetGroup.size.width,
                        CGRectGetMinY(bottomSheetGroup) + 0.50000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.10000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.10000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.90000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.10000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.90000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.50000 * bottomSheetGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(bottomSheetGroup) +
                                               0.10000 * bottomSheetGroup.size.width,
                                           CGRectGetMinY(bottomSheetGroup) +
                                               0.50000 * bottomSheetGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawButtonBarTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  UIColor* fillColor2 = [UIColor whiteColor];
  CGRect buttonBarGroup = CGRectMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 24,
                                     floor((frame.size.width - 8) * 0.89189 + 0.5),
                                     floor((frame.size.height - 24) * 0.58621 + 0.5));
  {
    UIBezierPath* outlinePath = [UIBezierPath
        bezierPathWithRoundedRect:CGRectMake(CGRectGetMinX(buttonBarGroup) +
                                                 floor(buttonBarGroup.size.width * 0.00000 + 0.5),
                                             CGRectGetMinY(buttonBarGroup) +
                                                 floor(buttonBarGroup.size.height * 0.00000 + 0.5),
                                             floor(buttonBarGroup.size.width * 1.00000 + 0.5) -
                                                 floor(buttonBarGroup.size.width * 0.00000 + 0.5),
                                             floor(buttonBarGroup.size.height * 1.00000 + 0.5) -
                                                 floor(buttonBarGroup.size.height * 0.00000 + 0.5))
                     cornerRadius:2];
    [fillColor setFill];
    [outlinePath fill];

    UIBezierPath* crossPath = [UIBezierPath bezierPath];
    [crossPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                        CGRectGetMinY(buttonBarGroup) + 0.20597 * buttonBarGroup.size.height)];
    [crossPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.45588 * buttonBarGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.20588 * buttonBarGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.32491 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.39394 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.45588 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.39394 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.54412 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.54412 * buttonBarGroup.size.height)];
    [crossPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.79412 * buttonBarGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.67509 * buttonBarGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.79412 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.79412 * buttonBarGroup.size.height)];
    [crossPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.54412 * buttonBarGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.79412 * buttonBarGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.67509 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.09091 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.54412 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.09091 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.45588 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.45588 * buttonBarGroup.size.height)];
    [crossPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.20588 * buttonBarGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.32491 * buttonBarGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonBarGroup) + 0.21970 * buttonBarGroup.size.width,
                            CGRectGetMinY(buttonBarGroup) + 0.20588 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.20588 * buttonBarGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonBarGroup) + 0.28030 * buttonBarGroup.size.width,
                           CGRectGetMinY(buttonBarGroup) + 0.20597 * buttonBarGroup.size.height)];
    [crossPath closePath];
    [fillColor2 setFill];
    [crossPath fill];
  }
}

void MDCCatalogDrawButtonsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;

  CGRect buttonsGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                   floor((frame.size.width - 1) * 0.98765 + 0.5),
                                   floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* circlePath = [UIBezierPath bezierPath];
    [circlePath
        moveToPoint:CGPointMake(CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                                CGRectGetMinY(buttonsGroup) + 0.00000 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.50000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.22400 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.00000 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.22400 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 1.00000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.77600 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.22400 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 1.00000 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 1.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.50000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.77600 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 1.00000 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 1.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.77600 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.00000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 1.00000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.22400 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.77600 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.00000 * buttonsGroup.size.height)];
    [circlePath closePath];
    [circlePath
        moveToPoint:CGPointMake(CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                                CGRectGetMinY(buttonsGroup) + 0.90000 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.10000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.50000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.27950 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.90000 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.10000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.72050 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.10000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.10000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.27950 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.27950 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.10000 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.90000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.50000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.72050 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.10000 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.90000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.27950 * buttonsGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.50000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.90000 * buttonsGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.90000 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.72050 * buttonsGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(buttonsGroup) + 0.72050 * buttonsGroup.size.width,
                            CGRectGetMinY(buttonsGroup) + 0.90000 * buttonsGroup.size.height)];
    [circlePath closePath];
    [fillColor setFill];
    [circlePath fill];

    UIBezierPath* crossPath = [UIBezierPath bezierPath];
    [crossPath
        moveToPoint:CGPointMake(CGRectGetMinX(buttonsGroup) + 0.55000 * buttonsGroup.size.width,
                                CGRectGetMinY(buttonsGroup) + 0.25000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.45000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.25000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.45000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.45000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.25000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.45000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.25000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.55000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.45000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.55000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.45000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.75000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.55000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.75000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.55000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.55000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.75000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.55000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.75000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.45000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.55000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.45000 * buttonsGroup.size.height)];
    [crossPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(buttonsGroup) + 0.55000 * buttonsGroup.size.width,
                           CGRectGetMinY(buttonsGroup) + 0.25000 * buttonsGroup.size.height)];
    [crossPath closePath];
    [fillColor setFill];
    [crossPath fill];
  }
}

void MDCCatalogDrawCollectionCellsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect collectionCellsGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                           floor((frame.size.width - 1) * 0.98765 + 0.5),
                                           floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* outlinesPath = [UIBezierPath bezierPath];
    [outlinesPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              0.00000 * collectionCellsGroup.size.width,
                                          CGRectGetMinY(collectionCellsGroup) +
                                              0.00000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.30000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.40000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.60000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.70000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.70000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.60000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.40000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.30000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 1.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.00000 * collectionCellsGroup.size.height)];
    [outlinesPath closePath];
    [outlinesPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              0.90000 * collectionCellsGroup.size.width,
                                          CGRectGetMinY(collectionCellsGroup) +
                                              0.90000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.70000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.70000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.height)];
    [outlinesPath closePath];
    [outlinesPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              0.90000 * collectionCellsGroup.size.width,
                                          CGRectGetMinY(collectionCellsGroup) +
                                              0.60000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.60000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.40000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.40000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.60000 * collectionCellsGroup.size.height)];
    [outlinesPath closePath];
    [outlinesPath moveToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                              0.90000 * collectionCellsGroup.size.width,
                                          CGRectGetMinY(collectionCellsGroup) +
                                              0.30000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.30000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.10000 * collectionCellsGroup.size.height)];
    [outlinesPath addLineToPoint:CGPointMake(CGRectGetMinX(collectionCellsGroup) +
                                                 0.90000 * collectionCellsGroup.size.width,
                                             CGRectGetMinY(collectionCellsGroup) +
                                                 0.30000 * collectionCellsGroup.size.height)];
    [outlinesPath closePath];
    [fillColor setFill];
    [outlinesPath fill];

    UIBezierPath* bottomSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      CGRectGetMinY(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.height * 0.75000 + 0.5),
                                      floor(collectionCellsGroup.size.width * 0.25000 + 0.5) -
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      floor(collectionCellsGroup.size.height * 0.85000 + 0.5) -
                                          floor(collectionCellsGroup.size.height * 0.75000 + 0.5))];
    [fillColor setFill];
    [bottomSquarePath fill];

    UIBezierPath* middleSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      CGRectGetMinY(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.height * 0.45000 + 0.5),
                                      floor(collectionCellsGroup.size.width * 0.25000 + 0.5) -
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      floor(collectionCellsGroup.size.height * 0.55000 + 0.5) -
                                          floor(collectionCellsGroup.size.height * 0.45000 + 0.5))];
    [fillColor setFill];
    [middleSquarePath fill];

    UIBezierPath* topSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      CGRectGetMinY(collectionCellsGroup) +
                                          floor(collectionCellsGroup.size.height * 0.15000 + 0.5),
                                      floor(collectionCellsGroup.size.width * 0.25000 + 0.5) -
                                          floor(collectionCellsGroup.size.width * 0.15000 + 0.5),
                                      floor(collectionCellsGroup.size.height * 0.25000 + 0.5) -
                                          floor(collectionCellsGroup.size.height * 0.15000 + 0.5))];
    [fillColor setFill];
    [topSquarePath fill];
  }
}

void MDCCatalogDrawCollectionsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect collectionsGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                       floor((frame.size.width - 1) * 0.98765 + 0.5),
                                       floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* topLeftSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(collectionsGroup) +
                                          floor(collectionsGroup.size.width * 0.15000 + 0.5),
                                      CGRectGetMinY(collectionsGroup) +
                                          floor(collectionsGroup.size.height * 0.15000 + 0.5),
                                      floor(collectionsGroup.size.width * 0.46825 + 0.04) -
                                          floor(collectionsGroup.size.width * 0.15000 + 0.5) + 0.46,
                                      floor(collectionsGroup.size.height * 0.46825 + 0.04) -
                                          floor(collectionsGroup.size.height * 0.15000 + 0.5) +
                                          0.46)];
    [fillColor setFill];
    [topLeftSquarePath fill];

    UIBezierPath* topRightSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(collectionsGroup) +
                                   floor(collectionsGroup.size.width * 0.53175 - 0.04) + 0.54,
                               CGRectGetMinY(collectionsGroup) +
                                   floor(collectionsGroup.size.height * 0.15000 + 0.5),
                               floor(collectionsGroup.size.width * 0.85000 + 0.5) -
                                   floor(collectionsGroup.size.width * 0.53175 - 0.04) - 0.54,
                               floor(collectionsGroup.size.height * 0.46825 + 0.04) -
                                   floor(collectionsGroup.size.height * 0.15000 + 0.5) + 0.46)];
    [fillColor setFill];
    [topRightSquarePath fill];

    UIBezierPath* bottomRightSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(collectionsGroup) +
                                   floor(collectionsGroup.size.width * 0.53175 - 0.04) + 0.54,
                               CGRectGetMinY(collectionsGroup) +
                                   floor(collectionsGroup.size.height * 0.53175 - 0.04) + 0.54,
                               floor(collectionsGroup.size.width * 0.85000 + 0.5) -
                                   floor(collectionsGroup.size.width * 0.53175 - 0.04) - 0.54,
                               floor(collectionsGroup.size.height * 0.85000 + 0.5) -
                                   floor(collectionsGroup.size.height * 0.53175 - 0.04) - 0.54)];
    [fillColor setFill];
    [bottomRightSquarePath fill];

    UIBezierPath* bottomLeftSquarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(
                               CGRectGetMinX(collectionsGroup) +
                                   floor(collectionsGroup.size.width * 0.15000 + 0.5),
                               CGRectGetMinY(collectionsGroup) +
                                   floor(collectionsGroup.size.height * 0.53175 - 0.04) + 0.54,
                               floor(collectionsGroup.size.width * 0.46825 + 0.04) -
                                   floor(collectionsGroup.size.width * 0.15000 + 0.5) + 0.46,
                               floor(collectionsGroup.size.height * 0.85000 + 0.5) -
                                   floor(collectionsGroup.size.height * 0.53175 - 0.04) - 0.54)];
    [fillColor setFill];
    [bottomLeftSquarePath fill];

    UIBezierPath* outlinePath = [UIBezierPath bezierPath];
    [outlinePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(collectionsGroup) + 0.90000 * collectionsGroup.size.width,
                        CGRectGetMinY(collectionsGroup) + 0.10000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.90000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.90000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.10000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.90000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.10000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.10000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.90000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.10000 * collectionsGroup.size.height)];
    [outlinePath closePath];
    [outlinePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(collectionsGroup) + 1.00000 * collectionsGroup.size.width,
                        CGRectGetMinY(collectionsGroup) + 0.00000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.00000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.00000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                0.00000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                1.00000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                1.00000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                1.00000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                1.00000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.00000 * collectionsGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(collectionsGroup) +
                                                1.00000 * collectionsGroup.size.width,
                                            CGRectGetMinY(collectionsGroup) +
                                                0.00000 * collectionsGroup.size.height)];
    [outlinePath closePath];
    [fillColor setFill];
    [outlinePath fill];
  }
}

void MDCCatalogDrawDialogsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect dialogsGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                   floor((frame.size.width - 1) * 0.98765 + 0.5),
                                   floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* squarePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(dialogsGroup) +
                                          floor(dialogsGroup.size.width * 0.25000 + 0.5),
                                      CGRectGetMinY(dialogsGroup) +
                                          floor(dialogsGroup.size.height * 0.25000 + 0.5),
                                      floor(dialogsGroup.size.width * 0.75000 + 0.5) -
                                          floor(dialogsGroup.size.width * 0.25000 + 0.5),
                                      floor(dialogsGroup.size.height * 0.75000 + 0.5) -
                                          floor(dialogsGroup.size.height * 0.25000 + 0.5))];
    [fillColor setFill];
    [squarePath fill];

    UIBezierPath* outlinePath = [UIBezierPath bezierPath];
    [outlinePath
        moveToPoint:CGPointMake(CGRectGetMinX(dialogsGroup) + 0.90000 * dialogsGroup.size.width,
                                CGRectGetMinY(dialogsGroup) + 0.10000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.90000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.90000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.10000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.90000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.10000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.10000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.90000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.10000 * dialogsGroup.size.height)];
    [outlinePath closePath];
    [outlinePath
        moveToPoint:CGPointMake(CGRectGetMinX(dialogsGroup) + 1.00000 * dialogsGroup.size.width,
                                CGRectGetMinY(dialogsGroup) + 0.00000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.00000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.00000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 0.00000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 1.00000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 1.00000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 1.00000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 1.00000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.00000 * dialogsGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(dialogsGroup) + 1.00000 * dialogsGroup.size.width,
                           CGRectGetMinY(dialogsGroup) + 0.00000 * dialogsGroup.size.height)];
    [outlinePath closePath];
    [fillColor setFill];
    [outlinePath fill];
  }
}

void MDCCatalogDrawFeatureHighlightTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect featureHighlightGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                            floor((frame.size.width - 1) * 0.98765 + 0.5),
                                            floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                            0.50000 * featureHighlightGroup.size.width,
                                        CGRectGetMinY(featureHighlightGroup) +
                                            0.00000 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.22400 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.22400 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.77600 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.22400 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.77600 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.77600 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                1.00000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.22400 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.77600 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.00000 * featureHighlightGroup.size.height)];
    [circlePath closePath];
    [circlePath moveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                            0.50000 * featureHighlightGroup.size.width,
                                        CGRectGetMinY(featureHighlightGroup) +
                                            0.90000 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.27950 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.72050 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.27950 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.27950 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.72050 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.10000 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.27950 * featureHighlightGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.50000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.72050 * featureHighlightGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                                0.72050 * featureHighlightGroup.size.width,
                                            CGRectGetMinY(featureHighlightGroup) +
                                                0.90000 * featureHighlightGroup.size.height)];
    [circlePath closePath];
    [fillColor setFill];
    [circlePath fill];

    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                          0.50000 * featureHighlightGroup.size.width,
                                      CGRectGetMinY(featureHighlightGroup) +
                                          0.23500 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.57509 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.42062 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.77105 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.43625 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.62151 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.56660 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.66752 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.76188 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.50000 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.65681 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.33248 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.76188 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.37849 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.56660 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.22895 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.43625 * featureHighlightGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(featureHighlightGroup) +
                                             0.42491 * featureHighlightGroup.size.width,
                                         CGRectGetMinY(featureHighlightGroup) +
                                             0.42062 * featureHighlightGroup.size.height)];
    [starPath closePath];
    [fillColor setFill];
    [starPath fill];
  }
}

void MDCCatalogDrawFlexibleHeaderTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect flexibleHeaderGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                          floor((frame.size.width - 1) * 0.98354 + 0.83) - 0.33,
                                          floor((frame.size.height - 1) * 0.98354 + 0.83) - 0.33);
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                            0.00000 * flexibleHeaderGroup.size.width,
                                        CGRectGetMinY(flexibleHeaderGroup) +
                                            0.00000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.00000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               1.00000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               1.00000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               1.00000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               1.00000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.00000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.00000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.00000 * flexibleHeaderGroup.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                            0.90000 * flexibleHeaderGroup.size.width,
                                        CGRectGetMinY(flexibleHeaderGroup) +
                                            0.90000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.10000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.90000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.10000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.60000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.90000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.60000 * flexibleHeaderGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(flexibleHeaderGroup) +
                                               0.90000 * flexibleHeaderGroup.size.width,
                                           CGRectGetMinY(flexibleHeaderGroup) +
                                               0.90000 * flexibleHeaderGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawHeaderStackViewTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = colorScheme.primaryColor;
  UIColor* fillColor = colorScheme.primaryColor;

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
  UIColor* blue80 = colorScheme.primaryColor;

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

void MDCCatalogDrawInkTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect inkGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                               floor((frame.size.width - 1) * 0.98765 + 0.5),
                               floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.00000 * inkGroup.size.width,
                                        CGRectGetMinY(inkGroup) + 0.00000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.00000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 1.00000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 1.00000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 1.00000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 1.00000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.00000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.00000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.00000 * inkGroup.size.height)];
    [bezierPath closePath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.10000 * inkGroup.size.width,
                                        CGRectGetMinY(inkGroup) + 0.90000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.10000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.10000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.58800 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.10000 * inkGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.55000 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.22500 * inkGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(inkGroup) + 0.56400 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.13600 * inkGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(inkGroup) + 0.55000 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.17850 * inkGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.77500 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.45000 * inkGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(inkGroup) + 0.55000 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.34950 * inkGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(inkGroup) + 0.65050 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.45000 * inkGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.90000 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.41200 * inkGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(inkGroup) + 0.82150 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.45000 * inkGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(inkGroup) + 0.86400 * inkGroup.size.width,
                                    CGRectGetMinY(inkGroup) + 0.43600 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.90000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.90000 * inkGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(inkGroup) + 0.10000 * inkGroup.size.width,
                                   CGRectGetMinY(inkGroup) + 0.90000 * inkGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawMaskedTransitionTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect maskedTransitionsGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                             floor((frame.size.width - 1) * 0.98765 + 0.5),
                                             floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* moonPath = [UIBezierPath bezierPath];
    [moonPath moveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                          0.65000 * maskedTransitionsGroup.size.width,
                                      CGRectGetMinY(maskedTransitionsGroup) +
                                          0.00000 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.31400 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.25200 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.49100 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.00000 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.35650 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.10650 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.35000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.25000 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.32600 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.25100 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.33800 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.25000 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.75000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.65000 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.57100 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.25000 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.75000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.42900 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.74800 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.68600 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.75000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.66200 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.74900 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.67400 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              1.00000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.35000 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.89350 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.64350 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              1.00000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.50900 * maskedTransitionsGroup.size.height)];
    [moonPath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.65000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.00000 * maskedTransitionsGroup.size.height)
                controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              1.00000 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.15650 * maskedTransitionsGroup.size.height)
                controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                              0.84350 * maskedTransitionsGroup.size.width,
                                          CGRectGetMinY(maskedTransitionsGroup) +
                                              0.00000 * maskedTransitionsGroup.size.height)];
    [moonPath closePath];
    [fillColor setFill];
    [moonPath fill];

    UIBezierPath* circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                            0.35000 * maskedTransitionsGroup.size.width,
                                        CGRectGetMinY(maskedTransitionsGroup) +
                                            0.30000 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.00000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.65000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.15650 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.30000 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.00000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.45650 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.35000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                1.00000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.00000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.84350 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.15650 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                1.00000 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.70000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.65000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.54350 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                1.00000 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.70000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.84350 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.35000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.30000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.70000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.45650 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.54350 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.30000 * maskedTransitionsGroup.size.height)];
    [circlePath closePath];
    [circlePath moveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                            0.35000 * maskedTransitionsGroup.size.width,
                                        CGRectGetMinY(maskedTransitionsGroup) +
                                            0.90000 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.10000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.65000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.21200 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.90000 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.10000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.78800 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.35000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.40000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.10000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.51200 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.21200 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.40000 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.60000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.65000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.48800 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.40000 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.60000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.51200 * maskedTransitionsGroup.size.height)];
    [circlePath addCurveToPoint:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.35000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.90000 * maskedTransitionsGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.60000 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.78800 * maskedTransitionsGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(maskedTransitionsGroup) +
                                                0.48800 * maskedTransitionsGroup.size.width,
                                            CGRectGetMinY(maskedTransitionsGroup) +
                                                0.90000 * maskedTransitionsGroup.size.height)];
    [circlePath closePath];
    [fillColor setFill];
    [circlePath fill];
  }
}

void MDCCatalogDrawMiscTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect miscGroup = CGRectMake(CGRectGetMinX(frame) + 7.67, CGRectGetMinY(frame) + 7.67,
                                floor((frame.size.width - 7.67) * 0.89686 + 7.83) - 7.33,
                                floor((frame.size.height - 7.67) * 0.89686 + 7.83) - 7.33);
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.70000 * miscGroup.size.width,
                                CGRectGetMinY(miscGroup) + 0.30500 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.70000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.00000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.00000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.00000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.00000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.70000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.30500 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.70000 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.65000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 1.00000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.33000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.87000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.47500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 1.00000 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 1.00000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.65000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.84500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 1.00000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 1.00000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.84500 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.70000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.30500 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 1.00000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.47500 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.87000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.33000 * miscGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.30500 * miscGroup.size.width,
                                CGRectGetMinY(miscGroup) + 0.60000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.10000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.60000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.10000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.10000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.60000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.10000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.60000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.30500 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.30500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.60000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.44500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.32500 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.32500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.44500 * miscGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.60000 * miscGroup.size.width,
                                CGRectGetMinY(miscGroup) + 0.40500 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.60000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.60000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.40500 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.60000 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.60000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.40500 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.42500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.50000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.50000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.42500 * miscGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.65000 * miscGroup.size.width,
                                CGRectGetMinY(miscGroup) + 0.90000 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.40500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.70000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.53000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.90000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.43000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.81500 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.70000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.70000 * miscGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.70000 * miscGroup.size.width,
                                   CGRectGetMinY(miscGroup) + 0.40500 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.90000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.65000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.81500 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.43000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.90000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.53000 * miscGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(miscGroup) + 0.65000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.90000 * miscGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(miscGroup) + 0.90000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.79000 * miscGroup.size.height)
          controlPoint2:CGPointMake(CGRectGetMinX(miscGroup) + 0.79000 * miscGroup.size.width,
                                    CGRectGetMinY(miscGroup) + 0.90000 * miscGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawNavigationBarTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* gradientColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  UIColor* fillColor = colorScheme.primaryColor;
  UIColor* fillColor2 = colorScheme.primaryColor;
  UIColor* textForeground = [fillColor colorWithAlphaComponent:0.2f];
  UIColor* gradientColor2 = colorScheme.primaryColor;

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

      UIFont* font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
      NSDictionary* labelFontAttributes = @{
        NSFontAttributeName : font,
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

void MDCCatalogDrawOverlayWindow(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  UIColor* fillColor2 = colorScheme.primaryColor;
  UIColor* fillColor3 = [UIColor colorWithWhite:0.5f alpha:1.0f];

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

void MDCCatalogDrawPageControlTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect pageControlGroup = CGRectMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 34.5,
                                       floor((frame.size.width - 8) * 0.89189 + 0.5),
                                       floor((frame.size.height - 34.5) * 0.27368 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.09848 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.33250 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.13148 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.50000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.11670 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.33250 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.13148 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.40750 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.09848 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.66750 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.13148 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.59250 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.11670 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.66750 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.06549 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.50000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.08027 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.66750 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.06549 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.59250 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.09848 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.33250 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.06549 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.40750 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.08027 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.33250 * pageControlGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.09848 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.00000 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.50000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.04432 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.22500 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.09848 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                1.00000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.77500 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.04432 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                1.00000 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.19697 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.50000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.15265 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                1.00000 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.19697 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.77500 * pageControlGroup.size.height)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.09848 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.height)
                  controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.19697 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.22500 * pageControlGroup.size.height)
                  controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.15265 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.height)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                               0.09848 * pageControlGroup.size.width,
                                           CGRectGetMinY(pageControlGroup) +
                                               0.00000 * pageControlGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];

    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.36106 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.33250 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.39405 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.37928 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.39405 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.40750 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.36106 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.39405 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.59250 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.37928 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.32856 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.34284 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.32856 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.59250 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.36106 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.32856 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.40750 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.34333 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)];
    [bezier2Path closePath];
    [bezier2Path
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.36106 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.00000 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.26258 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.30689 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.26258 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.22500 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.36106 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.26258 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.77500 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.30689 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.45955 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.41523 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.45955 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.77500 * pageControlGroup.size.height)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.36106 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.45955 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.22500 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.41572 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)];
    [bezier2Path addLineToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.36106 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.height)];
    [bezier2Path closePath];
    [fillColor setFill];
    [bezier2Path fill];

    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.63894 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.33250 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.67193 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.65716 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.67193 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.40750 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.63894 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.67193 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.59250 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.65716 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.60595 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.62072 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.66750 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.60595 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.59250 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.63894 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.60595 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.40750 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.62072 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.33250 * pageControlGroup.size.height)];
    [bezier3Path closePath];
    [bezier3Path
        moveToPoint:CGPointMake(
                        CGRectGetMinX(pageControlGroup) + 0.63894 * pageControlGroup.size.width,
                        CGRectGetMinY(pageControlGroup) + 0.00000 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.54045 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.58477 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.54045 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.22500 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.63894 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.54045 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.77500 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.58477 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.73742 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.50000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.69311 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 1.00000 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.73742 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.77500 * pageControlGroup.size.height)];
    [bezier3Path addCurveToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.63894 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)
                   controlPoint1:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.73742 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.22500 * pageControlGroup.size.height)
                   controlPoint2:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                 0.69311 * pageControlGroup.size.width,
                                             CGRectGetMinY(pageControlGroup) +
                                                 0.00000 * pageControlGroup.size.height)];
    [bezier3Path addLineToPoint:CGPointMake(CGRectGetMinX(pageControlGroup) +
                                                0.63894 * pageControlGroup.size.width,
                                            CGRectGetMinY(pageControlGroup) +
                                                0.00000 * pageControlGroup.size.height)];
    [bezier3Path closePath];
    [fillColor setFill];
    [bezier3Path fill];

    UIBezierPath* ovalPath = [UIBezierPath
        bezierPathWithOvalInRect:CGRectMake(
                                     CGRectGetMinX(pageControlGroup) +
                                         floor(pageControlGroup.size.width * 0.80303 + 0.5),
                                     CGRectGetMinY(pageControlGroup) +
                                         floor(pageControlGroup.size.height * 0.00000 + 0.5),
                                     floor(pageControlGroup.size.width * 1.00000 + 0.5) -
                                         floor(pageControlGroup.size.width * 0.80303 + 0.5),
                                     floor(pageControlGroup.size.height * 1.00000 + 0.5) -
                                         floor(pageControlGroup.size.height * 0.00000 + 0.5))];
    [fillColor setFill];
    [ovalPath fill];
  }
}

void MDCCatalogDrawPalettesTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect palettesGroup = CGRectMake(CGRectGetMinX(frame) + 7.65, CGRectGetMinY(frame) + 7.67,
                                    floor((frame.size.width - 7.65) * 0.89688 + 7.82) - 7.32,
                                    floor((frame.size.height - 7.67) * 0.85202 + 8.17) - 7.67);
  {
    UIBezierPath* bucketPath = [UIBezierPath bezierPath];
    [bucketPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(palettesGroup) + 0.75806 * palettesGroup.size.width,
                        CGRectGetMinY(palettesGroup) + 0.52579 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.25869 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.00000 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.17971 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.08316 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.31267 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.22316 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.02474 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.52632 * palettesGroup.size.height)];
    [bucketPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.02474 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.65105 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + -0.00825 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.56105 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + -0.00825 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.61684 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.33217 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.97474 * palettesGroup.size.height)];
    [bucketPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.39165 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.34866 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.99105 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.37016 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)];
    [bucketPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.45064 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.97421 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.41315 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.43464 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.99105 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.75806 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.65053 * palettesGroup.size.height)];
    [bucketPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.75806 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.52579 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.79105 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.61632 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.79105 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.56053 * palettesGroup.size.height)];
    [bucketPath closePath];
    [bucketPath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(palettesGroup) + 0.12372 * palettesGroup.size.width,
                        CGRectGetMinY(palettesGroup) + 0.58842 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.39115 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.30684 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.65859 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.58842 * palettesGroup.size.height)];
    [bucketPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(palettesGroup) + 0.12372 * palettesGroup.size.width,
                           CGRectGetMinY(palettesGroup) + 0.58842 * palettesGroup.size.height)];
    [bucketPath closePath];
    [fillColor setFill];
    [bucketPath fill];

    UIBezierPath* dropPath = [UIBezierPath bezierPath];
    [dropPath moveToPoint:CGPointMake(
                              CGRectGetMinX(palettesGroup) + 0.89103 * palettesGroup.size.width,
                              CGRectGetMinY(palettesGroup) + 0.68421 * palettesGroup.size.height)];
    [dropPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.78205 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.88526 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.89103 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.68421 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.78205 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.80895 * palettesGroup.size.height)];
    [dropPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.89103 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.78205 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.94842 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.83104 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)];
    [dropPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 1.00000 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.88526 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.95101 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 1.00000 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 1.00000 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.94842 * palettesGroup.size.height)];
    [dropPath
        addCurveToPoint:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.89103 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.68421 * palettesGroup.size.height)
          controlPoint1:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 1.00000 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.80895 * palettesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(palettesGroup) + 0.89103 * palettesGroup.size.width,
                            CGRectGetMinY(palettesGroup) + 0.68421 * palettesGroup.size.height)];
    [dropPath closePath];
    [fillColor setFill];
    [dropPath fill];
  }
}

void MDCCatalogDrawProgressViewTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor* fillColor = colorScheme.primaryColor;
  UIColor* fillColor2 = colorScheme.primaryColor;
  UIColor* gradientColor = colorScheme.secondaryColor;

  CGFloat gradientLocations[] = {0.14, 1};
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace,
      (__bridge CFArrayRef) @[
        (id)gradientColor.CGColor, (id)[colorScheme.primaryColor colorWithAlphaComponent:0].CGColor
      ],
      gradientLocations);

  CGRect progressViewGroup = CGRectMake(CGRectGetMinX(frame) + 24.5, CGRectGetMinY(frame) + 24,
                                        floor((CGRectGetWidth(frame) - 24.5) * 0.85015 + 0.5),
                                        floor((CGRectGetHeight(frame) - 24) * 0.61069 + 0.5));

  {
    CGRect gradientRectangleRect = CGRectMake(
        CGRectGetMinX(progressViewGroup) + floor(CGRectGetWidth(progressViewGroup) * 0.00000 + 0.5),
        CGRectGetMinY(progressViewGroup) + floor(CGRectGetHeight(progressViewGroup) * 0.30500),
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

void MDCCatalogDrawShadowLayerTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect shadowGroup = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 1,
                                  floor((frame.size.width - 1) * 0.98765 + 0.5),
                                  floor((frame.size.height - 1) * 0.98765 + 0.5));
  {
    UIBezierPath* squarePath = [UIBezierPath bezierPath];
    [squarePath
        moveToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.20000 * shadowGroup.size.width,
                                CGRectGetMinY(shadowGroup) + 0.00000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.20000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.80000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 1.00000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.80000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 1.00000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.00000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.20000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.00000 * shadowGroup.size.height)];
    [squarePath closePath];
    [squarePath
        moveToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.90000 * shadowGroup.size.width,
                                CGRectGetMinY(shadowGroup) + 0.70000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.30000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.70000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.30000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.10000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.90000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.10000 * shadowGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.90000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.70000 * shadowGroup.size.height)];
    [squarePath closePath];
    [fillColor setFill];
    [squarePath fill];

    UIBezierPath* cornerPath = [UIBezierPath bezierPath];
    [cornerPath
        moveToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.10000 * shadowGroup.size.width,
                                CGRectGetMinY(shadowGroup) + 0.10000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.00000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.10000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.00000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 1.00000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.90000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 1.00000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.90000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.90000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.10000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.90000 * shadowGroup.size.height)];
    [cornerPath
        addLineToPoint:CGPointMake(CGRectGetMinX(shadowGroup) + 0.10000 * shadowGroup.size.width,
                                   CGRectGetMinY(shadowGroup) + 0.10000 * shadowGroup.size.height)];
    [cornerPath closePath];
    [fillColor setFill];
    [cornerPath fill];
  }
}

void MDCCatalogDrawSliderTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect sliderGroup = CGRectMake(CGRectGetMinX(frame) + 7.67, CGRectGetMinY(frame) + 31,
                                  floor((frame.size.width - 7.67) * 0.89686 + 7.83) - 7.33,
                                  floor((frame.size.height - 31) * 0.39216 + 0.5));
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                CGRectGetMinY(sliderGroup) + 0.00000 * sliderGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.15000 * sliderGroup.size.width,
                                   CGRectGetMinY(sliderGroup) + 0.00000 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.00000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.50000 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 0.06700 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.00000 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 0.00000 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 0.22333 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.15000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 1.00000 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 0.00000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.77667 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 0.06700 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 1.00000 * sliderGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                   CGRectGetMinY(sliderGroup) + 1.00000 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 1.00000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.50000 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 0.93300 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 1.00000 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 1.00000 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 0.77667 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.00000 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 1.00000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.22333 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 0.93300 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 0.00000 * sliderGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                CGRectGetMinY(sliderGroup) + 0.66667 * sliderGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.60000 * sliderGroup.size.width,
                                   CGRectGetMinY(sliderGroup) + 0.66667 * sliderGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.60000 * sliderGroup.size.width,
                                   CGRectGetMinY(sliderGroup) + 0.33333 * sliderGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                   CGRectGetMinY(sliderGroup) + 0.33333 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.90000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.50000 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 0.87750 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.33333 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 0.90000 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 0.40833 * sliderGroup.size.height)];
    [bezierPath
        addCurveToPoint:CGPointMake(CGRectGetMinX(sliderGroup) + 0.85000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.66667 * sliderGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(sliderGroup) + 0.90000 * sliderGroup.size.width,
                                    CGRectGetMinY(sliderGroup) + 0.59167 * sliderGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(sliderGroup) + 0.87750 * sliderGroup.size.width,
                            CGRectGetMinY(sliderGroup) + 0.66667 * sliderGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawSnackbarTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect snackbarGroup = CGRectMake(CGRectGetMinX(frame) + 7.67, CGRectGetMinY(frame) + 7.67,
                                    floor((frame.size.width - 7.67) * 0.89686 + 7.83) - 7.33,
                                    floor((frame.size.height - 7.67) * 0.89686 + 7.83) - 7.33);
  {
    UIBezierPath* outlinePath = [UIBezierPath bezierPath];
    [outlinePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(snackbarGroup) + 0.90000 * snackbarGroup.size.width,
                        CGRectGetMinY(snackbarGroup) + 0.90000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 0.10000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 0.90000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 0.10000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 0.10000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 0.90000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 0.10000 * snackbarGroup.size.height)];
    [outlinePath
        moveToPoint:CGPointMake(
                        CGRectGetMinX(snackbarGroup) + 0.00000 * snackbarGroup.size.width,
                        CGRectGetMinY(snackbarGroup) + 0.00000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 0.00000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 1.00000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 1.00000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 1.00000 * snackbarGroup.size.height)];
    [outlinePath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(snackbarGroup) + 1.00000 * snackbarGroup.size.width,
                           CGRectGetMinY(snackbarGroup) + 0.00000 * snackbarGroup.size.height)];
    [fillColor setFill];
    [outlinePath fill];

    UIBezierPath* linePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(snackbarGroup) +
                                          floor(snackbarGroup.size.width * 0.15500 + 0.17) + 0.33,
                                      CGRectGetMinY(snackbarGroup) +
                                          floor(snackbarGroup.size.height * 0.75500 + 0.17) + 0.33,
                                      floor(snackbarGroup.size.width * 0.84500 + 0.17) -
                                          floor(snackbarGroup.size.width * 0.15500 + 0.17),
                                      floor(snackbarGroup.size.height * 0.84500 + 0.17) -
                                          floor(snackbarGroup.size.height * 0.75500 + 0.17))];
    [fillColor setFill];
    [linePath fill];
  }
}

void MDCCatalogDrawTabsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect tabBarGroup = CGRectMake(CGRectGetMinX(frame) + 7.67, CGRectGetMinY(frame) + 7.67,
                                  floor((frame.size.width - 7.67) * 0.89686 + 7.83) - 7.33,
                                  floor((frame.size.height - 7.67) * 0.89686 + 7.83) - 7.33);
  {
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.00000 * tabBarGroup.size.width,
                                CGRectGetMinY(tabBarGroup) + 0.00000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.00000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 1.00000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 1.00000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 1.00000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 1.00000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.00000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.00000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.00000 * tabBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                CGRectGetMinY(tabBarGroup) + 0.90000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.10000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.90000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.10000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.40000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.40000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.90000 * tabBarGroup.size.height)];
    [bezierPath closePath];
    [bezierPath
        moveToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                CGRectGetMinY(tabBarGroup) + 0.30000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.50000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.30000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.50000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.15000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.15000 * tabBarGroup.size.height)];
    [bezierPath
        addLineToPoint:CGPointMake(CGRectGetMinX(tabBarGroup) + 0.90000 * tabBarGroup.size.width,
                                   CGRectGetMinY(tabBarGroup) + 0.30000 * tabBarGroup.size.height)];
    [bezierPath closePath];
    [fillColor setFill];
    [bezierPath fill];
  }
}

void MDCCatalogDrawTextFieldTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect textFieldGroup = CGRectMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 11,
                                     floor((frame.size.width - 8) * 0.89189 + 0.5),
                                     floor((frame.size.height - 11) * 0.84507 + 0.5));
  {
    UIBezierPath* horizontalLinePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(textFieldGroup) +
                                          floor(textFieldGroup.size.width * 0.00000 + 0.5),
                                      CGRectGetMinY(textFieldGroup) +
                                          floor(textFieldGroup.size.height * 0.88333 + 0.5),
                                      floor(textFieldGroup.size.width * 1.00000 + 0.5) -
                                          floor(textFieldGroup.size.width * 0.00000 + 0.5),
                                      floor(textFieldGroup.size.height * 1.00000 + 0.5) -
                                          floor(textFieldGroup.size.height * 0.88333 + 0.5))];
    [fillColor setFill];
    [horizontalLinePath fill];

    UIBezierPath* verticalLinePath = [UIBezierPath
        bezierPathWithRect:CGRectMake(CGRectGetMinX(textFieldGroup) +
                                          floor(textFieldGroup.size.width * 0.84848 + 0.5),
                                      CGRectGetMinY(textFieldGroup) +
                                          floor(textFieldGroup.size.height * 0.00000 + 0.5),
                                      floor(textFieldGroup.size.width * 0.90909 + 0.5) -
                                          floor(textFieldGroup.size.width * 0.84848 + 0.5),
                                      floor(textFieldGroup.size.height * 0.78333 + 0.5) -
                                          floor(textFieldGroup.size.height * 0.00000 + 0.5))];
    [fillColor setFill];
    [verticalLinePath fill];

    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.37424 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.00000 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.09646 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.77778 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.21010 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.77778 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.26667 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.61111 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.58232 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.61111 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.63889 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.77778 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.75253 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.77778 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.47525 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.00000 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.37424 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.00000 * textFieldGroup.size.height)];
    [aPath closePath];
    [aPath moveToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.30455 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.50000 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.42475 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.14833 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.54495 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.50000 * textFieldGroup.size.height)];
    [aPath
        addLineToPoint:CGPointMake(
                           CGRectGetMinX(textFieldGroup) + 0.30455 * textFieldGroup.size.width,
                           CGRectGetMinY(textFieldGroup) + 0.50000 * textFieldGroup.size.height)];
    [aPath closePath];
    [fillColor setFill];
    [aPath fill];
  }
}

void MDCCatalogDrawThemesTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;
  CGRect themesGroup = CGRectMake(CGRectGetMinX(frame) + 11, CGRectGetMinY(frame) + 8,
                                  floor((frame.size.width - 11) * 0.88732 + 0.5),
                                  floor((frame.size.height - 8) * 0.89189 + 0.5));
  {
    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.47619 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.19394 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.57924 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.35354 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.37261 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.35354 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.47619 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.19394 * themesGroup.size.height)];
    [trianglePath closePath];
    [trianglePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.47619 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.00000 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.18254 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.45455 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76984 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.45455 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.47619 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.00000 * themesGroup.size.height)];
    [trianglePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.47619 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.00000 * themesGroup.size.height)];
    [trianglePath closePath];
    [fillColor setFill];
    [trianglePath fill];

    UIBezierPath* circlePath = [UIBezierPath bezierPath];
    [circlePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.64646 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.89418 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.77273 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.83492 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.64646 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.89418 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.70303 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.89899 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.89418 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.84242 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.83492 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.89899 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.62963 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.77273 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.68889 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.89899 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.62963 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.84242 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.64646 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.62963 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.70303 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.68889 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.64646 * themesGroup.size.height)];
    [circlePath closePath];
    [circlePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.54545 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.52381 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.77273 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.63016 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.54545 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.52381 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.64697 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 1.00000 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.52381 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.89848 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.63016 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 1.00000 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 1.00000 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.77273 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 0.89365 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 1.00000 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 1.00000 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.89848 * themesGroup.size.height)];
    [circlePath
        addCurveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.54545 * themesGroup.size.height)
          controlPoint1:CGPointMake(CGRectGetMinX(themesGroup) + 1.00000 * themesGroup.size.width,
                                    CGRectGetMinY(themesGroup) + 0.64697 * themesGroup.size.height)
          controlPoint2:CGPointMake(
                            CGRectGetMinX(themesGroup) + 0.89365 * themesGroup.size.width,
                            CGRectGetMinY(themesGroup) + 0.54545 * themesGroup.size.height)];
    [circlePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.76190 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.54545 * themesGroup.size.height)];
    [circlePath closePath];
    [fillColor setFill];
    [circlePath fill];

    UIBezierPath* squarePath = [UIBezierPath bezierPath];
    [squarePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.32143 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.67045 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.32143 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.87500 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.10714 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.87500 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.10714 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.67045 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.32143 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.67045 * themesGroup.size.height)];
    [squarePath closePath];
    [squarePath
        moveToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.42857 * themesGroup.size.width,
                                CGRectGetMinY(themesGroup) + 0.56818 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.00000 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.56818 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.00000 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.97727 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.42857 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.97727 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.42857 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.56818 * themesGroup.size.height)];
    [squarePath
        addLineToPoint:CGPointMake(CGRectGetMinX(themesGroup) + 0.42857 * themesGroup.size.width,
                                   CGRectGetMinY(themesGroup) + 0.56818 * themesGroup.size.height)];
    [squarePath closePath];
    [fillColor setFill];
    [squarePath fill];
  }
}

void MDCCatalogDrawTypographyTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;

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

void MDCCatalogDrawTypographyCustomFontsTile(CGRect frame, id<MDCColorScheming> colorScheme) {
  UIColor* fillColor = colorScheme.primaryColor;

  CGRect typographyCustomFontGroup =
      CGRectMake(CGRectGetMinX(frame) + 8.02, CGRectGetMinY(frame) + 8,
                 floor((frame.size.width - 8.02) * 0.89213 + 0.5),
                 floor((frame.size.height - 8) * 0.89189 + 0.5));
  {
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                       0.45700 * typographyCustomFontGroup.size.width,
                                   CGRectGetMinY(typographyCustomFontGroup) +
                                       0.20350 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.22400 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.79650 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.31950 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.79650 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.36700 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.66950 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.63150 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.66950 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.67900 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.79650 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.77450 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.79650 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.54150 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.20350 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.45700 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.20350 * typographyCustomFontGroup.size.height)];
    [aPath closePath];
    [aPath moveToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                       0.39850 * typographyCustomFontGroup.size.width,
                                   CGRectGetMinY(typographyCustomFontGroup) +
                                       0.58450 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.49900 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.31650 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.60000 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.58450 * typographyCustomFontGroup.size.height)];
    [aPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.39850 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.58450 * typographyCustomFontGroup.size.height)];
    [aPath closePath];
    [fillColor setFill];
    [aPath fill];

    UIBezierPath* outlinePath = [UIBezierPath bezierPath];
    [outlinePath moveToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.90000 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.35000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.90000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.90000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.09900 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.90000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.09900 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.10000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.64900 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.10000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.64900 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.00000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.00000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.00000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.00000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                1.00000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                1.00000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                1.00000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                1.00000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.35000 * typographyCustomFontGroup.size.height)];
    [outlinePath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                                0.90000 * typographyCustomFontGroup.size.width,
                                            CGRectGetMinY(typographyCustomFontGroup) +
                                                0.35000 * typographyCustomFontGroup.size.height)];
    [outlinePath closePath];
    [fillColor setFill];
    [outlinePath fill];

    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                          0.80273 * typographyCustomFontGroup.size.width,
                                      CGRectGetMinY(typographyCustomFontGroup) +
                                          0.04545 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.85094 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.14876 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.95424 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.19697 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.85094 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.24518 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.80273 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.34848 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.75452 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.24518 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.65121 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.19697 * typographyCustomFontGroup.size.height)];
    [starPath addLineToPoint:CGPointMake(CGRectGetMinX(typographyCustomFontGroup) +
                                             0.75452 * typographyCustomFontGroup.size.width,
                                         CGRectGetMinY(typographyCustomFontGroup) +
                                             0.14876 * typographyCustomFontGroup.size.height)];
    [starPath closePath];
    [fillColor setFill];
    [starPath fill];
  }
}

#pragma clang diagnostic pop
