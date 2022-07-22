// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <math.h>

static inline BOOL MDCCGFloatEqual(CGFloat a, CGFloat b) {
  const CGFloat constantK = 3;
#if CGFLOAT_IS_DOUBLE
  const CGFloat epsilon = DBL_EPSILON;
  const CGFloat min = DBL_MIN;
#else
  const CGFloat epsilon = FLT_EPSILON;
  const CGFloat min = FLT_MIN;
#endif
  return (fabs(a - b) < constantK * epsilon * fabs(a + b) || fabs(a - b) < min);
}

/**
 Checks whether the provided floating point number is approximately zero based on a small epsilon.

 Note that ULP-based comparisons are not used because ULP-space is significantly distorted around
 zero.

 Reference:
 https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/
 */
static inline BOOL MDCFloatIsApproximatelyZero(CGFloat value) {
#if CGFLOAT_IS_DOUBLE
  return (fabs(value) < DBL_EPSILON);
#else
  return (fabsf(value) < FLT_EPSILON);
#endif
}

// Checks whether the provided floating point number is exactly zero.
static inline BOOL MDCCGFloatIsExactlyZero(CGFloat value) {
  return (value == 0);
}

/**
 Round the given value to ceiling with provided scale factor.
 If @c scale is zero, then the rounded value will be zero.

 @param value The value to round
 @param scale The scale factor
 @return The ceiling value calculated using the provided scale factor
 */
static inline CGFloat MDCCeilScaled(CGFloat value, CGFloat scale) {
  if (MDCCGFloatEqual(scale, 0)) {
    return 0;
  }

  return ceil(value * scale) / scale;
}

/**
 Round the given value to floor with provided scale factor.
 If @c scale is zero, then the rounded value will be zero.

 @param value The value to round
 @param scale The scale factor
 @return The floor value calculated using the provided scale factor
 */
static inline CGFloat MDCFloorScaled(CGFloat value, CGFloat scale) {
  if (MDCCGFloatEqual(scale, 0)) {
    return 0;
  }

  return floor(value * scale) / scale;
}

/**
 Expand `rect' to the smallest standardized rect containing it with pixel-aligned origin and size.
 If @c scale is zero, then a scale of 1 will be used instead.

 @param rect the rectangle to align.
 @param scale the scale factor to use for pixel alignment.

 @return the input rectangle aligned to the nearest pixels using the provided scale factor.

 @see CGRectIntegral
 */
static inline CGRect MDCRectAlignToScale(CGRect rect, CGFloat scale) {
  if (CGRectIsNull(rect)) {
    return CGRectNull;
  }
  if (MDCCGFloatEqual(scale, 0)) {
    scale = 1;
  }

  if (MDCCGFloatEqual(scale, 1)) {
    return CGRectIntegral(rect);
  }

  CGPoint originalMinimumPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
  CGPoint newOrigin = CGPointMake(floor(originalMinimumPoint.x * scale) / scale,
                                  floor(originalMinimumPoint.y * scale) / scale);
  CGSize adjustWidthHeight =
      CGSizeMake(originalMinimumPoint.x - newOrigin.x, originalMinimumPoint.y - newOrigin.y);
  return CGRectMake(newOrigin.x, newOrigin.y,
                    ceil((CGRectGetWidth(rect) + adjustWidthHeight.width) * scale) / scale,
                    ceil((CGRectGetHeight(rect) + adjustWidthHeight.height) * scale) / scale);
}

static inline CGPoint MDCPointRoundWithScale(CGPoint point, CGFloat scale) {
  if (MDCCGFloatEqual(scale, 0)) {
    return CGPointZero;
  }

  return CGPointMake(round(point.x * scale) / scale, round(point.y * scale) / scale);
}

/**
 Expand `size' to the closest larger pixel-aligned value.
 If @c scale is zero, then a CGSizeZero will be returned.

 @param size the size to align.
 @param scale the scale factor to use for pixel alignment.

 @return the size aligned to the closest larger pixel-aligned value using the provided scale factor.
 */
static inline CGSize MDCSizeCeilWithScale(CGSize size, CGFloat scale) {
  if (MDCCGFloatEqual(scale, 0)) {
    return CGSizeZero;
  }

  return CGSizeMake(ceil(size.width * scale) / scale, ceil(size.height * scale) / scale);
}

/**
 Align the centerPoint of a view so that its origin is pixel-aligned to the nearest pixel.
 Returns @c CGRectZero if @c scale is zero or @c bounds is @c CGRectNull.

 @param center the unaligned center of the view.
 @param bounds the bounds of the view.
 @param scale the native scaling factor for pixel alignment.

 @return the center point of the view such that its origin will be pixel-aligned.
 */
static inline CGPoint MDCRoundCenterWithBoundsAndScale(CGPoint center,
                                                       CGRect bounds,
                                                       CGFloat scale) {
  if (MDCCGFloatEqual(scale, 0) || CGRectIsNull(bounds)) {
    return CGPointZero;
  }

  CGFloat halfWidth = CGRectGetWidth(bounds) / 2;
  CGFloat halfHeight = CGRectGetHeight(bounds) / 2;
  CGPoint origin = CGPointMake(center.x - halfWidth, center.y - halfHeight);
  origin = MDCPointRoundWithScale(origin, scale);
  return CGPointMake(origin.x + halfWidth, origin.y + halfHeight);
}

/// Compare two edge insets using MDCCGFloatEqual.
/// @param insets1 An edge inset to compare with insets2
/// @param insets2 An edge inset to compare with insets1
static inline BOOL MDCEdgeInsetsEqualToEdgeInsets(UIEdgeInsets insets1, UIEdgeInsets insets2) {
  BOOL topEqual = MDCCGFloatEqual(insets1.top, insets2.top);
  BOOL leftEqual = MDCCGFloatEqual(insets1.left, insets2.left);
  BOOL bottomEqual = MDCCGFloatEqual(insets1.bottom, insets2.bottom);
  BOOL rightEqual = MDCCGFloatEqual(insets1.right, insets2.right);
  return topEqual && leftEqual && bottomEqual && rightEqual;
}
