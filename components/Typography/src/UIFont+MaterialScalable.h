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

@interface UIFont (MaterialScalable)

/**
 An associated scaling curve that can be used to create resized versions of the font based on a
 UIContentSizeCategory.

 An associated scaling curve that is a dictionary that maps UISizeCategory to fontsize.
 The dictionary keys MUST include a complete set of size categories, from
 UIContentSizeCategoryExtraSmall to UIContentSizeCategoryExtraExtraExtraLarge AND all
 UIContentSizeCategoryAccessibility categories.

 The dictionary values are the desired pointSize stored as a CGFloat wrapped in an NSNumber.

 Generally, clients will use MDCFontScaler to attach particular scaling curves to a font.

 Note that this curve should be immutable as it is retained, not copied.
 */
@property(nonatomic, strong, nullable, setter=mdc_setScalingCurve:)
    NSDictionary<UIContentSizeCategory, NSNumber *> *mdc_scalingCurve;

/**
 Return a font with the same family, weight and traits, with a size based on the given size
 category and an associated scaling curve.

 @param sizeCategory used to query the associated scaling curve for font size
 @return Font sized for the current size category OR self if there is no associated curve
 */
- (nonnull UIFont *)mdc_scaledFontForSizeCategory:(nonnull UIContentSizeCategory)sizeCategory;

/**
 Return a font with the same family, weight and traits, with a size based on the device's
 text size setting and an associated scaling curve.

 @return Font sized for the current size category OR self if there is no associated curve
 */
- (nonnull UIFont *)mdc_scaledFontForCurrentSizeCategory;

/**
 Return a font with the same family, weight and traits, with a font size based on the default
 size category of UIContentSizeCategoryLarge.

 This can be used to return a font for a text element that should *not* be scaled with Dynamic
 Type.

 @return Font sized for UIContentSizeCategoryLarge OR self if there is no associated curve
 */
- (nonnull UIFont *)mdc_scaledFontAtDefaultSize;

/**
 Scales an arbitrary value based on the current Dynamic Type settings and the scaling curve.

 For instance, assume you have a font that is normally 10pt, but because of the device's Dynamic
 Type settings the font is currently 24pt.
 Scale factor = 24.0 current size / 10.0 standard size = 2.4
 This method calculates the current scale factor and multiplies it by the given value.

 @param value The original layout value.
 @return A value that has been scaled based on the attached scaling curve
 */
- (CGFloat)mdc_scaledValueForValue:(CGFloat)value;

@end
