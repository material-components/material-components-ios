/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MDFTextAccessibility.h"

#import "private/MDFColorCalculations.h"
#import "private/MDFImageCalculations.h"
#import "private/NSArray+MDFUtils.h"

static const CGFloat kMinContrastRatioNormalText = 4.5f;
static const CGFloat kMinContrastRatioLargeText = 3.0f;
static const CGFloat kMinContrastRatioNormalTextEnhanced = 7.0f;
static const CGFloat kMinContrastRatioLargeTextEnhanced = 4.5f;

@implementation MDFTextAccessibility

+ (nonnull UIColor *)textColorOnBackgroundColor:(nonnull UIColor *)backgroundColor
                                targetTextAlpha:(CGFloat)targetTextAlpha
                                           font:(nullable UIFont *)font {
  MDFTextAccessibilityOptions options = 0;
  if ([self isLargeForContrastRatios:font]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }
  return [self textColorOnBackgroundColor:backgroundColor
                          targetTextAlpha:targetTextAlpha
                                  options:options];
}

+ (nullable UIColor *)textColorOnBackgroundImage:(nonnull UIImage *)backgroundImage
                                        inRegion:(CGRect)region
                                 targetTextAlpha:(CGFloat)targetTextAlpha
                                            font:(nullable UIFont *)font {
  UIColor *backgroundColor = MDFAverageColorOfOpaqueImage(backgroundImage, region);
  if (!backgroundColor) {
    return nil;
  }

  return
      [self textColorOnBackgroundColor:backgroundColor targetTextAlpha:targetTextAlpha font:font];
}

+ (nullable UIColor *)textColorOnBackgroundColor:(nonnull UIColor *)backgroundColor
                                 targetTextAlpha:(CGFloat)targetTextAlpha
                                         options:(MDFTextAccessibilityOptions)options {
  NSArray *colors = @[
    [UIColor colorWithWhite:1 alpha:targetTextAlpha],
    [UIColor colorWithWhite:0 alpha:targetTextAlpha]
  ];
  UIColor *textColor =
      [self textColorFromChoices:colors onBackgroundColor:backgroundColor options:options];
  return textColor;
}

+ (nullable UIColor *)textColorFromChoices:(nonnull NSArray<UIColor *> *)choices
                         onBackgroundColor:(nonnull UIColor *)backgroundColor
                                   options:(MDFTextAccessibilityOptions)options {
  [choices enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSAssert([obj isKindOfClass:[UIColor class]], @"Choices must be UIColors.");
  }];

  // Sort by luminance if requested.
  if ((options & MDFTextAccessibilityOptionsPreferLighter) ||
      (options & MDFTextAccessibilityOptionsPreferDarker)) {
    NSArray *luminances = [choices mdf_arrayByMappingObjects:^id(id object) {
      return @([self luminanceOfColor:object]);
    }];

    BOOL inverse = (options & MDFTextAccessibilityOptionsPreferDarker) ? YES : NO;
    choices = [luminances mdf_sortArray:choices
                        usingComparator:^NSComparisonResult(id obj1, id obj2) {
                          float first = inverse ? [obj1 floatValue] : [obj2 floatValue];
                          float second = inverse ? [obj2 floatValue] : [obj1 floatValue];

                          if (first < second) {
                            return NSOrderedAscending;
                          } else if (first > second) {
                            return NSOrderedDescending;
                          } else {
                            return NSOrderedSame;
                          }
                        }];
  }

  // Search the array for a color that can be used, adjusting alpha values upwards if requested.
  // The first acceptable color (adjusted or not) is returned.
  BOOL adjustAlphas = (options & MDFTextAccessibilityOptionsPreserveAlpha) ? NO : YES;
  for (UIColor *choice in choices) {
    if ([self textColor:choice passesOnBackgroundColor:backgroundColor options:options]) {
      return choice;
    }

    if (!adjustAlphas) {
      continue;
    }

    CGFloat alpha = CGColorGetAlpha(choice.CGColor);
    CGFloat minAlpha =
        [self minAlphaOfTextColor:choice onBackgroundColor:backgroundColor options:options];
    if (minAlpha > 0) {
      if (alpha > minAlpha) {
        NSAssert(NO,
                 @"Logic error: computed an acceptable minimum alpha (%f) that is *less* than the "
                 @"unacceptable current alpha (%f).",
                 minAlpha, alpha);
        continue;
      }
      return [choice colorWithAlphaComponent:minAlpha];
    }
  }

  return nil;
}

+ (CGFloat)minAlphaOfTextColor:(nonnull UIColor *)textColor
             onBackgroundColor:(nonnull UIColor *)backgroundColor
                       options:(MDFTextAccessibilityOptions)options {
  CGFloat minContrastRatio = [self minContrastRatioForOptions:options];
  return MDFMinAlphaOfColorOnBackgroundColor(textColor, backgroundColor, minContrastRatio);
}

+ (CGFloat)contrastRatioForTextColor:(UIColor *)textColor
                   onBackgroundColor:(UIColor *)backgroundColor {
  CGFloat colorComponents[4];
  CGFloat backgroundColorComponents[4];
  MDFCopyRGBAComponents(textColor.CGColor, colorComponents);
  MDFCopyRGBAComponents(backgroundColor.CGColor, backgroundColorComponents);

  NSAssert(backgroundColorComponents[3] == 1,
           @"Background color %@ must be opaque for a valid contrast ratio calculation.",
           backgroundColor);
  backgroundColorComponents[3] = 1;

  return MDFContrastRatioOfRGBAComponents(colorComponents, backgroundColorComponents);
}

+ (BOOL)textColor:(nonnull UIColor *)textColor
    passesOnBackgroundColor:(nonnull UIColor *)backgroundColor
                    options:(MDFTextAccessibilityOptions)options {
  CGFloat minContrastRatio = [self minContrastRatioForOptions:options];
  CGFloat ratio = [self contrastRatioForTextColor:textColor onBackgroundColor:backgroundColor];
  return ratio >= minContrastRatio ? YES : NO;
}

+ (BOOL)isLargeForContrastRatios:(nullable UIFont *)font {
  UIFontDescriptor *fontDescriptor = font.fontDescriptor;
  BOOL isBold =
      (fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) == UIFontDescriptorTraitBold;
  return font.pointSize >= 18 || (isBold && font.pointSize >= 14);
}

#pragma mark - Private methods

+ (CGFloat)luminanceOfColor:(UIColor *)color {
  CGFloat colorComponents[4];
  MDFCopyRGBAComponents(color.CGColor, colorComponents);
  return MDFRelativeLuminanceOfRGBComponents(colorComponents);
}

+ (CGFloat)minContrastRatioForOptions:(MDFTextAccessibilityOptions)options {
  BOOL isLarge =
      (options & MDFTextAccessibilityOptionsLargeFont) == MDFTextAccessibilityOptionsLargeFont;
  BOOL isEnhanced = (options & MDFTextAccessibilityOptionsEnhancedContrast) ==
                    MDFTextAccessibilityOptionsEnhancedContrast;

  if (isEnhanced) {
    return isLarge ? kMinContrastRatioLargeTextEnhanced : kMinContrastRatioNormalTextEnhanced;
  } else {
    return isLarge ? kMinContrastRatioLargeText : kMinContrastRatioNormalText;
  }
}

@end
