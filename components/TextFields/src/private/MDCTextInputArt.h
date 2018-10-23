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

#import "MaterialMath.h"

static const CGFloat MDCTextInputClearButtonImageBuiltInPadding = 2.0f;

#pragma mark - Drawing

static inline UIBezierPath *MDCPathForClearButtonImageFrame(CGRect frame) {
  // GENERATED CODE

  CGRect innerBounds = CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
                                  MDCFloor((frame.size.width - 2) * 0.90909f + 0.5f),
                                  MDCFloor((frame.size.height - 2) * 0.90909f + 0.5f));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path
      moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000f * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.50000f * innerBounds.size.height)
        controlPoint1:CGPointMake(CGRectGetMinX(innerBounds) + 0.77600f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)
        controlPoint2:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.22400f * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 1.00000f * innerBounds.size.height)
        controlPoint1:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.77600f * innerBounds.size.height)
        controlPoint2:CGPointMake(CGRectGetMinX(innerBounds) + 0.77600f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 1.00000f * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.50000f * innerBounds.size.height)
        controlPoint1:CGPointMake(CGRectGetMinX(innerBounds) + 0.22400f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 1.00000f * innerBounds.size.height)
        controlPoint2:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.77600f * innerBounds.size.height)];
  [ic_clear_path
      addCurveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)
        controlPoint1:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.22400f * innerBounds.size.height)
        controlPoint2:CGPointMake(CGRectGetMinX(innerBounds) + 0.22400f * innerBounds.size.width,
                                  CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
      moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.73417f * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + 0.31467f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.68700f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.26750f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50083f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.45367f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.31467f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.26750f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.26750f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.31467f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.45367f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50083f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.26750f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.68700f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.31467f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.73417f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50083f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.54800f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.68700f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.73417f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.73417f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.68700f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.54800f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50083f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.73417f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.31467f * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

static inline UIBezierPath *MDCPathForClearButtonLegacyImageFrame(CGRect frame) {
  // GENERATED CODE

  CGRect innerBounds = CGRectMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 10,
                                  MDCFloor((frame.size.width - 10) * 0.73684f + 0.5f),
                                  MDCFloor((frame.size.height - 10) * 0.73684f + 0.5f));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path
      moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + 0.10107f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.89893f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.39893f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.10107f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.00000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.10107f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.39893f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.00000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.89893f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.10107f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 1.00000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.50000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.60107f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.89893f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 1.00000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.89893f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 0.60107f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.50000f * innerBounds.size.height)];
  [ic_clear_path
      addLineToPoint:CGPointMake(CGRectGetMinX(innerBounds) + 1.00000f * innerBounds.size.width,
                                 CGRectGetMinY(innerBounds) + 0.10107f * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}
