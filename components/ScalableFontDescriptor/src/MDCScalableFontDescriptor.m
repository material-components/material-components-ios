// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCScalableFontDescriptor.h"

@implementation MDCScalableFontDescriptor

- (instancetype)initWithFontDescriptor:(UIFontDescriptor *)fontDescriptor
                           fontMetrics:(UIFontMetrics *)fontMetrics {
  self = [self initWithFontDescriptor:fontDescriptor];
  if (self) {
    _fontDescriptor = fontDescriptor;
    _fontMetrics = fontMetrics;
  }
  return self;
}

- (instancetype)initWithFontDescriptor:(UIFontDescriptor *)fontDescriptor {
  self = [super init];
  if (self) {
    _fontDescriptor = fontDescriptor;
  }
  return self;
}

- (UIFont *)baseFont {
  return [UIFont fontWithDescriptor:self.fontDescriptor size:self.fontDescriptor.pointSize];
}

- (UIFont *)preferredFontCompatibleWithTraitCollection:(UITraitCollection *)traitCollection {
  return [self.fontMetrics scaledFontForFont:self.baseFont
               compatibleWithTraitCollection:traitCollection];
}

#if DEBUG

// NOTE: UIFontMetric detection is potentially broken on Forge on Mac due to b/142536380.
- (NSString *)description {
  // This method is unoptimized, and assumes it's only called in testing environments.
  if (@available(iOS 11.0, *)) {
    static NSArray<UIFontTextStyle> *textStyles;
    static NSArray<UIContentSizeCategory> *sizeCategories;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      textStyles = @[
#if !TARGET_OS_TV
        UIFontTextStyleLargeTitle,
#endif
        UIFontTextStyleTitle1,
        UIFontTextStyleTitle2,
        UIFontTextStyleTitle3,
        UIFontTextStyleHeadline,
        UIFontTextStyleSubheadline,
        UIFontTextStyleBody,
        UIFontTextStyleCallout,
        UIFontTextStyleCaption1,
        UIFontTextStyleCaption2,
        UIFontTextStyleFootnote,
      ];

      sizeCategories = @[
        UIContentSizeCategoryExtraSmall,
        UIContentSizeCategorySmall,
        UIContentSizeCategoryMedium,
        UIContentSizeCategoryLarge,
        UIContentSizeCategoryExtraLarge,
        UIContentSizeCategoryExtraExtraLarge,
        UIContentSizeCategoryExtraExtraExtraLarge,
        UIContentSizeCategoryAccessibilityMedium,
        UIContentSizeCategoryAccessibilityLarge,
        UIContentSizeCategoryAccessibilityExtraLarge,
        UIContentSizeCategoryAccessibilityExtraExtraLarge,
        UIContentSizeCategoryAccessibilityExtraExtraExtraLarge,
      ];
    });

    NSMutableString *descriptionString = [NSMutableString
        stringWithFormat:@"%@ Descriptor: %@\n", [super description], self.fontDescriptor];
    UIFont *testFont = [UIFont systemFontOfSize:99 weight:UIFontWeightRegular];

    // Check all UIFontTextStyle values and search for one that scales fonts equivalently to this
    // style's `fontMetrics`.
    for (UIFontTextStyle textStyle in textStyles) {
      BOOL matchedTextStyle = YES;
      UIFontMetrics *textStyleMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
      // Compare the scaled font at all UIContentSizeCategory values to determine if the metrics are
      // equivalent.
      for (UIContentSizeCategory sizeCategory in sizeCategories) {
        UITraitCollection *traitCollection =
            [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];
        UIFont *selfScaledFont = [self.fontMetrics scaledFontForFont:testFont
                                       compatibleWithTraitCollection:traitCollection];
        UIFont *otherScaledFont = [textStyleMetrics scaledFontForFont:testFont
                                        compatibleWithTraitCollection:traitCollection];
        if (![selfScaledFont isEqual:otherScaledFont]) {
          matchedTextStyle = NO;
          break;
        }
      }
      if (matchedTextStyle) {
        [descriptionString appendFormat:@"Metrics: %@", textStyle];
        break;
      }
    }
    return [descriptionString copy];
  } else {
    return [super description];
  }
}

#endif

@end
