// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFeatureHighlightAccessibilityMutator.h"

#import "MaterialFeatureHighlight.h"
#import "MaterialTypography.h"

@implementation MDCFeatureHighlightAccessibilityMutator

+ (void)mutate:(MDCFeatureHighlightViewController *)featureHighlightViewController {
  [MDCFeatureHighlightAccessibilityMutator mutateTitleColor:featureHighlightViewController];
  [MDCFeatureHighlightAccessibilityMutator mutateBodyColor:featureHighlightViewController];
}

+ (void)mutateTitleColor:(MDCFeatureHighlightViewController *)featureHighlightViewController {
  MDFTextAccessibilityOptions options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:featureHighlightViewController.titleFont]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }

  UIColor *textColor = featureHighlightViewController.titleColor;
  UIColor *backgroundColor =
      [featureHighlightViewController.outerHighlightColor colorWithAlphaComponent:1];
  UIColor *titleColor =
      [MDCFeatureHighlightAccessibilityMutator accessibleColorForTextColor:textColor
                                                       withBackgroundColor:backgroundColor
                                                                   options:options];
  // no change needed.
  if ([titleColor isEqual:textColor]) {
    return;
  }

  // Make title alpha the maximum it can be.
  CGFloat titleAlpha = [MDFTextAccessibility minAlphaOfTextColor:titleColor
                                               onBackgroundColor:backgroundColor
                                                         options:options];
  titleAlpha = MAX([MDCTypography titleFontOpacity], titleAlpha);
  featureHighlightViewController.titleColor = [titleColor colorWithAlphaComponent:titleAlpha];
}

+ (void)mutateBodyColor:(MDCFeatureHighlightViewController *)featureHighlightViewController {
  MDFTextAccessibilityOptions options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:featureHighlightViewController.bodyFont]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }

  UIColor *textColor = featureHighlightViewController.bodyColor;
  UIColor *backgroundColor =
      [featureHighlightViewController.outerHighlightColor colorWithAlphaComponent:1];
  featureHighlightViewController.bodyColor =
      [MDCFeatureHighlightAccessibilityMutator accessibleColorForTextColor:textColor
                                                       withBackgroundColor:backgroundColor
                                                                   options:options];
}

#pragma mark - Private

+ (UIColor *)accessibleColorForTextColor:(UIColor *)textColor
                     withBackgroundColor:(UIColor *)backgroundColor
                                 options:(MDFTextAccessibilityOptions)options {
  if (textColor && [MDFTextAccessibility textColor:textColor
                           passesOnBackgroundColor:backgroundColor
                                           options:options]) {
    return textColor;
  }
  return [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                          targetTextAlpha:[MDCTypography captionFontOpacity]
                                                  options:options];
}

@end
