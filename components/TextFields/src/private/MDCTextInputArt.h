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

#import "MaterialMath.h"

#pragma mark - Drawing

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
