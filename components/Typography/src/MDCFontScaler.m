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

#import "MDCFontTraits.h"
#import "UIApplication+AppExtensions.h"
#import "UIFont+MaterialScalable.h"

NSString *MaterialTextStyleHeadline1 = @"Material.TextStyle.Headline1";
NSString *MaterialTextStyleHeadline2 = @"Material.TextStyle.Headline2";
NSString *MaterialTextStyleHeadline3 = @"Material.TextStyle.Headline3";
NSString *MaterialTextStyleHeadline4 = @"Material.TextStyle.Headline4";
NSString *MaterialTextStyleHeadline5 = @"Material.TextStyle.Headline5";
NSString *MaterialTextStyleHeadline6 = @"Material.TextStyle.Headline6";
NSString *MaterialTextStyleSubtitle1 = @"Material.TextStyle.Subtitle1";
NSString *MaterialTextStyleSubtitle2 = @"Material.TextStyle.Subtitle2";
NSString *MaterialTextStyleBody1 = @"Material.TextStyle.Body1";
NSString *MaterialTextStyleBody2 = @"Material.TextStyle.Body2";
NSString *MaterialTextStyleButton = @"Material.TextStyle.Button";
NSString *MaterialTextStyleCaption = @"Material.TextStyle.Caption";
NSString *MaterialTextStyleOverline = @"Material.TextStyle.Overline";

@implementation MDCFontScaler {
  NSDictionary<NSString *, NSNumber *> *_scalingCurve;
}

+ (instancetype)scalerForMaterialTextStyle:(NSString *)textStyle {
  return [[MDCFontScaler alloc] initForMaterialTextStyle:textStyle];
}

- (instancetype)initForMaterialTextStyle:(NSString *)textStyle {
  self = [super init];
  if (self) {
    // TODO(iangordon): Fill in missing fonts
    if ([MaterialTextStyleHeadline1 isEqualToString:textStyle]) {
      NSDictionary<UIContentSizeCategory, NSNumber *> *scalingCurve = @{
        UIContentSizeCategoryExtraSmall : @30,
        UIContentSizeCategorySmall : @32,
        UIContentSizeCategoryMedium : @34,
        UIContentSizeCategoryLarge : @36,
        UIContentSizeCategoryExtraLarge : @38,
        UIContentSizeCategoryExtraExtraLarge : @40,
        UIContentSizeCategoryExtraExtraExtraLarge : @42,
        UIContentSizeCategoryAccessibilityMedium : @46,
        UIContentSizeCategoryAccessibilityLarge : @50,
        UIContentSizeCategoryAccessibilityExtraLarge : @54,
        UIContentSizeCategoryAccessibilityExtraExtraLarge : @58,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @62
      };
      _scalingCurve = scalingCurve;
    } else {
      // If nothing matches, return the metrics for MaterialTextStyleBody1
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

- (UIFont *)scalableFontWithFont:(UIFont *)font {
  // If we are within an application, query the preferredContentSizeCategory.
  UIContentSizeCategory sizeCategory = UIContentSizeCategoryLarge;
  if ([UIApplication mdc_safeSharedApplication]) {
    sizeCategory = [UIApplication mdc_safeSharedApplication].preferredContentSizeCategory;
  } else if (@available(iOS 10.0, *)) {
    sizeCategory = UIScreen.mainScreen.traitCollection.preferredContentSizeCategory;
  }

  //??? Should we scale here
  // Do what Apple does
  UIFont *scaledFont = [font mdc_scaledFontForSizeCategory:sizeCategory];

  return scaledFont;
}

- (CGFloat)scaledValueForValue:(CGFloat)value {
  // If it is available, query the preferredContentSizeCategory.
  UIContentSizeCategory defaultSizeCategory = UIContentSizeCategoryLarge;
  UIContentSizeCategory currentSizeCategory = UIContentSizeCategoryLarge;
  if ([UIApplication mdc_safeSharedApplication]) {
    currentSizeCategory = [UIApplication mdc_safeSharedApplication].preferredContentSizeCategory;
  } else if (@available(iOS 10.0, *)) {
    currentSizeCategory = UIScreen.mainScreen.traitCollection.preferredContentSizeCategory;
  }

  NSNumber *defaultFontSizeNumber = _scalingCurve[defaultSizeCategory];

  NSNumber *currentFontSizeNumber = _scalingCurve[currentSizeCategory];
  // If you have queried the table for a sizeCategory that doesn't exist, we will return the
  // traits for XXXL.  This handles the case where the values are requested for one of the
  // accessibility size categories beyond XXXL such as
  // UIContentSizeCategoryAccessibilityExtraLarge.
  if (currentFontSizeNumber == nil) {
    currentFontSizeNumber = _scalingCurve[UIContentSizeCategoryExtraExtraExtraLarge];
  }

  // Guard against broken / incomplete scaling curves by returning self if fontSizeNumber is nil.
  if (currentFontSizeNumber == nil || defaultFontSizeNumber == nil) {
    return value;
  }

  CGFloat currentFontSize = (CGFloat)currentFontSizeNumber.doubleValue;
  CGFloat defaultFontSize = (CGFloat)currentFontSizeNumber.doubleValue;

  // Guard against broken / incomplete scaling curves by returning self if fontSize <= 0.0.
  if (currentFontSize <= 0.0 || defaultFontSize <= 0.0) {
    return value;
  }

  return currentFontSize / defaultFontSize;
}

@end
