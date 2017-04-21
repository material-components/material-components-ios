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

#import "MDCRTL.h"

static CGFloat MDCOriginForLeadingInset(CGFloat leadingInset,
                                        CGFloat width,
                                        CGFloat boundingWidth,
                                        UIUserInterfaceLayoutDirection layoutDirection) {
  switch (layoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      return leadingInset;
    case UIUserInterfaceLayoutDirectionRightToLeft:
      return boundingWidth - leadingInset - width;
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)layoutDirection);
  return UIUserInterfaceLayoutDirectionLeftToRight;
}

UIViewAutoresizing MDCAutoresizingFlexibleLeadingMargin(
    UIUserInterfaceLayoutDirection layoutDirection) {
  switch (layoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      return UIViewAutoresizingFlexibleLeftMargin;
    case UIUserInterfaceLayoutDirectionRightToLeft:
      return UIViewAutoresizingFlexibleRightMargin;
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)layoutDirection);
  return UIViewAutoresizingFlexibleLeftMargin;
}

UIViewAutoresizing MDCAutoresizingFlexibleTrailingMargin(
    UIUserInterfaceLayoutDirection layoutDirection) {
  switch (layoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      return UIViewAutoresizingFlexibleRightMargin;
    case UIUserInterfaceLayoutDirectionRightToLeft:
      return UIViewAutoresizingFlexibleLeftMargin;
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)layoutDirection);
  return UIViewAutoresizingFlexibleRightMargin;
}

CGRect MDCRectFlippedForRTL(CGRect leftToRightRect,
                            CGFloat boundingWidth,
                            UIUserInterfaceLayoutDirection layoutDirection) {
  leftToRightRect = CGRectStandardize(leftToRightRect);
  leftToRightRect.origin.x =
      MDCOriginForLeadingInset(CGRectGetMinX(leftToRightRect), CGRectGetWidth(leftToRightRect),
                               boundingWidth, layoutDirection);
  return leftToRightRect;
}

UIEdgeInsets MDCInsetsMakeWithLayoutDirection(CGFloat top,
                                              CGFloat leading,
                                              CGFloat bottom,
                                              CGFloat trailing,
                                              UIUserInterfaceLayoutDirection layoutDirection) {
  switch (layoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      return UIEdgeInsetsMake(top, leading, bottom, trailing);
    case UIUserInterfaceLayoutDirectionRightToLeft:
      return UIEdgeInsetsMake(top, trailing, bottom, leading);
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)layoutDirection);
  return UIEdgeInsetsMake(top, leading, bottom, trailing);
}
