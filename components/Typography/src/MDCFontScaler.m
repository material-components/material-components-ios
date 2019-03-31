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

#import "MDCFontScaler.h"

#import <objc/runtime.h>

#import "UIFont+MaterialScalable.h"
#import "private/MDCFontTraits.h"
#import "private/MDCTypographyUtilities.h"

MDCTextStyle const MDCTextStyleHeadline1 = @"MDC.TextStyle.Headline1";
MDCTextStyle const MDCTextStyleHeadline2 = @"MDC.TextStyle.Headline2";
MDCTextStyle const MDCTextStyleHeadline3 = @"MDC.TextStyle.Headline3";
MDCTextStyle const MDCTextStyleHeadline4 = @"MDC.TextStyle.Headline4";
MDCTextStyle const MDCTextStyleHeadline5 = @"MDC.TextStyle.Headline5";
MDCTextStyle const MDCTextStyleHeadline6 = @"MDC.TextStyle.Headline6";
MDCTextStyle const MDCTextStyleSubtitle1 = @"MDC.TextStyle.Subtitle1";
MDCTextStyle const MDCTextStyleSubtitle2 = @"MDC.TextStyle.Subtitle2";
MDCTextStyle const MDCTextStyleBody1 = @"MDC.TextStyle.Body1";
MDCTextStyle const MDCTextStyleBody2 = @"MDC.TextStyle.Body2";
MDCTextStyle const MDCTextStyleButton = @"MDC.TextStyle.Button";
MDCTextStyle const MDCTextStyleCaption = @"MDC.TextStyle.Caption";
MDCTextStyle const MDCTextStyleOverline = @"MDC.TextStyle.Overline";

@implementation MDCFontScaler {
  NSDictionary<UIContentSizeCategory, NSNumber *> *_scalingCurve;
  MDCTextStyle _textStyle;
}

+ (instancetype)scalerForMaterialTextStyle:(MDCTextStyle)textStyle {
  return [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];
}

- (instancetype)initForMaterialTextStyle:(MDCTextStyle)textStyle {
  self = [super init];
  if (self) {
    _textStyle = [textStyle copy];

    // NOTE: All scaling curves MUST include a full set of values for ALL UIContentSizeCategory
    // values. This values must not decrease as the category size increases. To put it another
    // way, the value for UIContentSizeCategoryLarge must not be smaller than the value for
    // UIContentSizeCategoryMedium.
    if ([MDCTextStyleHeadline1 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @84,
        UIContentSizeCategorySmall : @88,
        UIContentSizeCategoryMedium : @92,
        UIContentSizeCategoryLarge : @96,
        UIContentSizeCategoryExtraLarge : @100,
        UIContentSizeCategoryExtraExtraLarge : @104,
        UIContentSizeCategoryExtraExtraExtraLarge : @108,
        UIContentSizeCategoryAccessibilityMedium : @108,
        UIContentSizeCategoryAccessibilityLarge : @108,
        UIContentSizeCategoryAccessibilityExtraLarge : @108,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @108,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @108
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleHeadline2 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @54,
        UIContentSizeCategorySmall : @56,
        UIContentSizeCategoryMedium : @58,
        UIContentSizeCategoryLarge : @60,
        UIContentSizeCategoryExtraLarge : @62,
        UIContentSizeCategoryExtraExtraLarge : @64,
        UIContentSizeCategoryExtraExtraExtraLarge : @66,
        UIContentSizeCategoryAccessibilityMedium : @66,
        UIContentSizeCategoryAccessibilityLarge : @66,
        UIContentSizeCategoryAccessibilityExtraLarge : @66,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @66,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @66
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleHeadline3 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @42,
        UIContentSizeCategorySmall : @44,
        UIContentSizeCategoryMedium : @46,
        UIContentSizeCategoryLarge : @48,
        UIContentSizeCategoryExtraLarge : @50,
        UIContentSizeCategoryExtraExtraLarge : @52,
        UIContentSizeCategoryExtraExtraExtraLarge : @54,
        UIContentSizeCategoryAccessibilityMedium : @54,
        UIContentSizeCategoryAccessibilityLarge : @54,
        UIContentSizeCategoryAccessibilityExtraLarge : @54,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @54,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @54
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleHeadline4 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @28,
        UIContentSizeCategorySmall : @30,
        UIContentSizeCategoryMedium : @32,
        UIContentSizeCategoryLarge : @34,
        UIContentSizeCategoryExtraLarge : @36,
        UIContentSizeCategoryExtraExtraLarge : @38,
        UIContentSizeCategoryExtraExtraExtraLarge : @40,
        UIContentSizeCategoryAccessibilityMedium : @42,
        UIContentSizeCategoryAccessibilityLarge : @42,
        UIContentSizeCategoryAccessibilityExtraLarge : @42,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @42,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @42
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleHeadline5 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @21,
        UIContentSizeCategorySmall : @22,
        UIContentSizeCategoryMedium : @23,
        UIContentSizeCategoryLarge : @24,
        UIContentSizeCategoryExtraLarge : @26,
        UIContentSizeCategoryExtraExtraLarge : @28,
        UIContentSizeCategoryExtraExtraExtraLarge : @30,
        UIContentSizeCategoryAccessibilityMedium : @32,
        UIContentSizeCategoryAccessibilityLarge : @32,
        UIContentSizeCategoryAccessibilityExtraLarge : @32,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @32,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @32
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleHeadline6 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @17,
        UIContentSizeCategorySmall : @18,
        UIContentSizeCategoryMedium : @19,
        UIContentSizeCategoryLarge : @20,
        UIContentSizeCategoryExtraLarge : @22,
        UIContentSizeCategoryExtraExtraLarge : @24,
        UIContentSizeCategoryExtraExtraExtraLarge : @26,
        UIContentSizeCategoryAccessibilityMedium : @28,
        UIContentSizeCategoryAccessibilityLarge : @28,
        UIContentSizeCategoryAccessibilityExtraLarge : @28,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @28,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @28
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleSubtitle1 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @13,
        UIContentSizeCategorySmall : @14,
        UIContentSizeCategoryMedium : @15,
        UIContentSizeCategoryLarge : @16,
        UIContentSizeCategoryExtraLarge : @18,
        UIContentSizeCategoryExtraExtraLarge : @20,
        UIContentSizeCategoryExtraExtraExtraLarge : @22,
        UIContentSizeCategoryAccessibilityMedium : @25,
        UIContentSizeCategoryAccessibilityLarge : @30,
        UIContentSizeCategoryAccessibilityExtraLarge : @37,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @44,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @52
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleSubtitle2 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @11,
        UIContentSizeCategorySmall : @12,
        UIContentSizeCategoryMedium : @13,
        UIContentSizeCategoryLarge : @14,
        UIContentSizeCategoryExtraLarge : @16,
        UIContentSizeCategoryExtraExtraLarge : @18,
        UIContentSizeCategoryExtraExtraExtraLarge : @20,
        UIContentSizeCategoryAccessibilityMedium : @22,
        UIContentSizeCategoryAccessibilityLarge : @25,
        UIContentSizeCategoryAccessibilityExtraLarge : @30,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @36,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @42
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleBody2 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @11,
        UIContentSizeCategorySmall : @12,
        UIContentSizeCategoryMedium : @13,
        UIContentSizeCategoryLarge : @14,
        UIContentSizeCategoryExtraLarge : @16,
        UIContentSizeCategoryExtraExtraLarge : @18,
        UIContentSizeCategoryExtraExtraExtraLarge : @20,
        UIContentSizeCategoryAccessibilityMedium : @22,
        UIContentSizeCategoryAccessibilityLarge : @25,
        UIContentSizeCategoryAccessibilityExtraLarge : @30,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @36,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @42
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleButton isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @11,
        UIContentSizeCategorySmall : @12,
        UIContentSizeCategoryMedium : @13,
        UIContentSizeCategoryLarge : @14,
        UIContentSizeCategoryExtraLarge : @16,
        UIContentSizeCategoryExtraExtraLarge : @18,
        UIContentSizeCategoryExtraExtraExtraLarge : @20,
        UIContentSizeCategoryAccessibilityMedium : @22,
        UIContentSizeCategoryAccessibilityLarge : @24,
        UIContentSizeCategoryAccessibilityExtraLarge : @26,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @28,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @30
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleCaption isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @11,
        UIContentSizeCategorySmall : @11,
        UIContentSizeCategoryMedium : @11,
        UIContentSizeCategoryLarge : @12,
        UIContentSizeCategoryExtraLarge : @14,
        UIContentSizeCategoryExtraExtraLarge : @16,
        UIContentSizeCategoryExtraExtraExtraLarge : @18,
        UIContentSizeCategoryAccessibilityMedium : @20,
        UIContentSizeCategoryAccessibilityLarge : @22,
        UIContentSizeCategoryAccessibilityExtraLarge : @24,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @26,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @28
      };
      _scalingCurve = scalingCurve;
    } else if ([MDCTextStyleOverline isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @8,
        UIContentSizeCategorySmall : @8,
        UIContentSizeCategoryMedium : @9,
        UIContentSizeCategoryLarge : @10,
        UIContentSizeCategoryExtraLarge : @12,
        UIContentSizeCategoryExtraExtraLarge : @14,
        UIContentSizeCategoryExtraExtraExtraLarge : @16,
        UIContentSizeCategoryAccessibilityMedium : @18,
        UIContentSizeCategoryAccessibilityLarge : @20,
        UIContentSizeCategoryAccessibilityExtraLarge : @22,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @24,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @26
      };
      _scalingCurve = scalingCurve;
    } else {
      // If nothing matches, return the metrics for MDCTextStyleBody1
      _textStyle = [MDCTextStyleBody1 copy];
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @13,
        UIContentSizeCategorySmall : @14,
        UIContentSizeCategoryMedium : @15,
        UIContentSizeCategoryLarge : @16,
        UIContentSizeCategoryExtraLarge : @18,
        UIContentSizeCategoryExtraExtraLarge : @20,
        UIContentSizeCategoryExtraExtraExtraLarge : @22,
        UIContentSizeCategoryAccessibilityMedium : @26,
        UIContentSizeCategoryAccessibilityLarge : @30,
        UIContentSizeCategoryAccessibilityExtraLarge : @34,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @38,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @42
      };
      _scalingCurve = scalingCurve;
    }
  }

  return self;
}

- (UIFont *)scaledFontWithFont:(UIFont *)font {
  // If it is available, query the preferredContentSizeCategory.
  UIContentSizeCategory sizeCategory = GetCurrentSizeCategory();

  // We create a new font to ensure we have a complete set of font traits.
  // They we apply our new scaling curve before returning a scaled font.
  UIFont *templateFont = [UIFont fontWithDescriptor:font.fontDescriptor size:0.0];
  templateFont.mdc_scalingCurve = _scalingCurve;
  UIFont *scaledFont = [templateFont mdc_scaledFontForSizeCategory:sizeCategory];

  return scaledFont;
}

- (CGFloat)scaledValueForValue:(CGFloat)value {
  UIContentSizeCategory defaultSizeCategory = UIContentSizeCategoryLarge;
  // If it is available, query the preferredContentSizeCategory.
  UIContentSizeCategory currentSizeCategory = GetCurrentSizeCategory();

  NSNumber *defaultFontSizeNumber = _scalingCurve[defaultSizeCategory];
  NSNumber *currentFontSizeNumber = _scalingCurve[currentSizeCategory];

  // Guard against broken / incomplete scaling curves by returning self if fontSizeNumber is nil.
  if (currentFontSizeNumber == nil || defaultFontSizeNumber == nil) {
    return value;
  }

  CGFloat currentFontSize = (CGFloat)currentFontSizeNumber.doubleValue;
  CGFloat defaultFontSize = (CGFloat)defaultFontSizeNumber.doubleValue;

  // Guard against broken / incomplete scaling curves by returning self if fontSize <= 0.0.
  if (currentFontSize <= 0.0 || defaultFontSize <= 0.0) {
    return value;
  }

  return (currentFontSize / defaultFontSize) * value;
}

- (NSString *)description {
  NSString *superDescription = [super description];
  NSString *styleDescription = @"No Attached Style";
  if (_textStyle) {
    styleDescription = _textStyle;
  }

  return [NSString stringWithFormat:@"%@ %@", superDescription, styleDescription];
}

@end
