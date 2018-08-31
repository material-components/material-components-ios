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

#import "UIFont+MaterialTypography.h"

#import "MDCTypography.h"
#import "UIFontDescriptor+MaterialTypography.h"

@implementation UIFont (MaterialTypography)

+ (UIFont *)mdc_preferredFontForMaterialTextStyle:(MDCFontTextStyle)style {
  // Due to the way iOS handles missing glyphs in fonts, we do not support using
  // our font loader with Dynamic Type.
  id<MDCTypographyFontLoading> fontLoader = [MDCTypography fontLoader];
  if (![fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    NSLog(@"MaterialTypography : Custom font loaders are not compatible with Dynamic Type.");
  }

  UIFontDescriptor *fontDescriptor =
      [UIFontDescriptor mdc_preferredFontDescriptorForMaterialTextStyle:style];

  // Size is included in the fontDescriptor, so we pass in 0.0 in the parameter.
  UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:0.0];

  return font;
}

+ (nonnull UIFont *)mdc_standardFontForMaterialTextStyle:(MDCFontTextStyle)style {
  // Due to the way iOS handles missing glyphs in fonts, we do not support using our
  // font loader with standardFont.
  id<MDCTypographyFontLoading> fontLoader = [MDCTypography fontLoader];
  if (![fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    NSLog(@"MaterialTypography : Custom font loaders are not compatible with Dynamic Type.");
  }

  UIFontDescriptor *fontDescriptor =
      [UIFontDescriptor mdc_standardFontDescriptorForMaterialTextStyle:style];

  // Size is included in the fontDescriptor, so we pass in 0.0 in the parameter.
  UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:0.0];

  return font;
}

- (nonnull UIFont *)mdc_fontSizedForMaterialTextStyle:(MDCFontTextStyle)style
                                 scaledForDynamicType:(BOOL)scaled {
  UIFontDescriptor *fontDescriptor;
  if (scaled) {
    fontDescriptor = [UIFontDescriptor mdc_preferredFontDescriptorForMaterialTextStyle:style];
  } else {
    fontDescriptor = [UIFontDescriptor mdc_standardFontDescriptorForMaterialTextStyle:style];
  }

  return [self fontWithSize:fontDescriptor.pointSize];
}

@end
