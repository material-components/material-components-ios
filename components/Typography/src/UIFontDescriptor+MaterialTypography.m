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

#import "UIFontDescriptor+MaterialTypography.h"

#import "MaterialApplication.h"

#import "private/MDCFontTraits.h"

@implementation UIFontDescriptor (MaterialTypography)

+ (nonnull UIFontDescriptor *)mdc_fontDescriptorForMaterialTextStyle:(MDCFontTextStyle)style
                                                        sizeCategory:(NSString *)sizeCategory {
  // TODO(#1179): We should include our leading and tracking metrics when creating this descriptor.
  MDCFontTraits *materialTraits = [MDCFontTraits traitsForTextStyle:style
                                                       sizeCategory:sizeCategory];

  // Store the system font family name to ensure that we load the system font.
  // If we do not explicitly include this UIFontDescriptorFamilyAttribute in the
  // FontDescriptor the OS will default to Helvetica. On iOS 9+, the Font Family
  // changes from San Francisco to San Francisco Display at point size 20.
  static NSString *smallSystemFontFamilyName;
  static NSString *largeSystemFontFamilyName;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    UIFont *smallSystemFont;
    UIFont *largeSystemFont;
    smallSystemFont = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    largeSystemFont = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    smallSystemFontFamilyName = [smallSystemFont.familyName copy];
    largeSystemFontFamilyName = [largeSystemFont.familyName copy];
  });

  NSDictionary *traits = @{UIFontWeightTrait : @(materialTraits.weight)};
  NSString *fontFamily =
      materialTraits.pointSize < 19.5 ? smallSystemFontFamilyName : largeSystemFontFamilyName;
  NSDictionary *attributes = @{
    UIFontDescriptorSizeAttribute : @(materialTraits.pointSize),
    UIFontDescriptorTraitsAttribute : traits,
    UIFontDescriptorFamilyAttribute : fontFamily
  };

  UIFontDescriptor *fontDescriptor = [[UIFontDescriptor alloc] initWithFontAttributes:attributes];

  return fontDescriptor;
}

+ (nonnull UIFontDescriptor *)mdc_preferredFontDescriptorForMaterialTextStyle:
    (MDCFontTextStyle)style {
  // iOS' default UIContentSizeCategory is Large.
  NSString *sizeCategory = UIContentSizeCategoryLarge;

  // If we are within an application, query the preferredContentSizeCategory.
  if ([UIApplication mdc_safeSharedApplication]) {
    sizeCategory = [UIApplication mdc_safeSharedApplication].preferredContentSizeCategory;
  } else {
    sizeCategory = UIScreen.mainScreen.traitCollection.preferredContentSizeCategory;
  }

  return [UIFontDescriptor mdc_fontDescriptorForMaterialTextStyle:style sizeCategory:sizeCategory];
}

+ (nonnull UIFontDescriptor *)mdc_standardFontDescriptorForMaterialTextStyle:
    (MDCFontTextStyle)style {
  // iOS' default UIContentSizeCategory is Large.
  // Since we don't want to scale with Dynamic Type create the font descriptor based on that.
  NSString *sizeCategory = UIContentSizeCategoryLarge;

  return [UIFontDescriptor mdc_fontDescriptorForMaterialTextStyle:style sizeCategory:sizeCategory];
}

@end
