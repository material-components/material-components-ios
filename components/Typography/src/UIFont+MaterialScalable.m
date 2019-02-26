// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "UIFont+MaterialScalable.h"

#import <objc/runtime.h>

#import "MDCTypography.h"
#import "UIApplication+AppExtensions.h"

static char MDCFontScaleObjectKey;

@implementation UIFont (MaterialTypography)

- (UIFont *)mdc_scaledFontForSizeCategory:(UIContentSizeCategory)sizeCategory {
  if (!self.mdc_hasScalingCurve) {
    return self;
  }

  NSNumber *fontSizeNumber;
  if (sizeCategory) {
    fontSizeNumber = self.mdc_scalingCurve[sizeCategory];
  }

  // If you have queried the table for a sizeCategory that doesn't exist, we will return the
  // traits for XXXL.  This handles the case where the values are requested for one of the
  // accessibility size categories beyond XXXL such as
  // UIContentSizeCategoryAccessibilityExtraLarge.  Accessbility size categories are only
  // defined for the Body Font Style.
  if (fontSizeNumber == nil) {
    fontSizeNumber = self.mdc_scalingCurve[UIContentSizeCategoryExtraExtraExtraLarge];
  }

  // Guard against broken / incomplete scaling curves by returning self if fontSizeNumber is nil.
  if (fontSizeNumber == nil) {
    return self;
  }

  CGFloat fontSize = (CGFloat)fontSizeNumber.doubleValue;
  UIFont *scaledFont = [UIFont fontWithDescriptor:self.fontDescriptor size:fontSize];

  return scaledFont;
}

- (UIFont *)mdc_scaledFontForCurrentSizeCategory {
  // If we are within an application, query the preferredContentSizeCategory.
  UIContentSizeCategory sizeCategory = UIContentSizeCategoryLarge;
  if ([UIApplication mdc_safeSharedApplication]) {
    sizeCategory = [UIApplication mdc_safeSharedApplication].preferredContentSizeCategory;
  } else if (@available(iOS 10.0, *)) {
    sizeCategory = UIScreen.mainScreen.traitCollection.preferredContentSizeCategory;
  }

  return [self mdc_scaledFontForSizeCategory:sizeCategory];
}

- (nonnull UIFont *)mdc_scaledFontAtDefaultSize {
  return [self mdc_scaledFontForSizeCategory:UIContentSizeCategoryLarge];
}

- (BOOL)mdc_hasScalingCurve {
  if (self.mdc_scalingCurve != nil) {
    return YES;
  } else {
    return NO;
  }
}

// @property(nonatomic, nullable, setter=mdc_setScalingCurve:) NSDictionary<UIContentSizeCategory, NSNumber*> *mdc_scalingCurve;
- (NSDictionary<UIContentSizeCategory, NSNumber*> *)mdc_scalingCurve {
  return (NSDictionary<UIContentSizeCategory, NSNumber*> *)objc_getAssociatedObject(self, &MDCFontScaleObjectKey);
}

- (void)mdc_setScalingCurve:(NSDictionary<UIContentSizeCategory,NSNumber *> *)scalingCurve {
  objc_setAssociatedObject(self, &MDCFontScaleObjectKey, scalingCurve, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
