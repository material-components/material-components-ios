// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFontTextStyle.h"

/**
 A representation of a mapping of UIContentSizeCategory keys to font size values.

 The values of this dictionary are CGFloat values represented as an NSNumber. Each value defines the
 font size to be used for a given content size category.
 */
typedef NSDictionary<UIContentSizeCategory, NSNumber *> * MDCScalingCurve;

@interface UIFont (MaterialScalable)

/**
 A custom scaling curve to be used when scaling this font for Dynamic Type.

 The keys of a scaling curve MUST include the complete set of UIContentSizeCategory values, from
 UIContentSizeCategoryExtraSmall to UIContentSizeCategoryExtraExtraExtraLarge AND all
 UIContentSizeCategoryAccessibility categories. If any of these keys are missing then any scaling
 behavior that reads from this property is undefined.
 */
@property(nonatomic, copy, nullable, setter=mdc_setScalingCurve:) MDCScalingCurve mdc_scalingCurve;

/**
 Returns a font with the same family, weight and traits, but whose point size is based on the given
 size category and the font's @c mdc_scalingCurve.

 @param sizeCategory The size category for which the font should be scaled.
 @return A font whose point size matches the @c mdc_scalingCurve's current size category value, or
 self if @c mdc_scalingCurve is nil.
 */
- (nonnull UIFont *)mdc_scaledFontForSizeCategory:(nonnull UIContentSizeCategory)sizeCategory;

/**
 Returns a font with the same family, weight and traits, with a font size based on the default
 size category of UIContentSizeCategoryLarge.

 This can be used to return a font for a text element that should *not* be scaled with Dynamic
 Type.

 @return Font sized for UIContentSizeCategoryLarge OR self if there is no associated curve
 */
- (nonnull UIFont *)mdc_scaledFontAtDefaultSize;

/**
 Returns a font with the same family, weight and traits, but whose point size is the device's
 text size setting and the font's @c mdc_scalingCurve.

 @note Prefer @c -mdc_scaledFontForSizeCategory: because it encourages use of trait collections
 instead.

 @return Font sized for the current size category OR self if there is no associated curve
 */
- (nonnull UIFont *)mdc_scaledFontForCurrentSizeCategory;

@end
