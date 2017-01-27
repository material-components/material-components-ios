/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "UIFontDescriptor+MaterialTypography.h"

#import "UIApplication+AppExtensions.h"

#import "private/MDCFontTraits.h"

@implementation UIFontDescriptor (MaterialTypography)

+ (nonnull UIFontDescriptor *)mdc_preferredFontDescriptorForMaterialTextStyle:
        (MDCFontTextStyle)style {
  // iOS' default UIContentSizeCategory is Large.
  NSString *sizeCategory = UIContentSizeCategoryLarge;

  // If we are within an application, query the preferredContentSizeCategory.
  if ([UIApplication mdc_safeSharedApplication]) {
    sizeCategory = [UIApplication mdc_safeSharedApplication].preferredContentSizeCategory;
  }

  // TODO(#1179): We should include our leading and tracking metrics when creating this descriptor.
  MDCFontTraits *materialTraits =
      [MDCFontTraits traitsForTextStyle:style sizeCategory:sizeCategory];

  NSDictionary *traits = @{ UIFontWeightTrait : @(materialTraits.weight) };
  NSDictionary *attributes = @{
    UIFontDescriptorSizeAttribute : @(materialTraits.pointSize),
    UIFontDescriptorTraitsAttribute : traits
  };

  UIFontDescriptor *fontDescriptor = [[UIFontDescriptor alloc] initWithFontAttributes:attributes];

  return fontDescriptor;
}

@end
