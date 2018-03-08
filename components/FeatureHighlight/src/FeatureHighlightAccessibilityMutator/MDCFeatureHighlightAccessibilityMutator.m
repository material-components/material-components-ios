/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFeatureHighlightAccessibilityMutator.h"

#import "MaterialFeatureHighlight.h"
#import "MaterialTypography.h"

@implementation MDCFeatureHighlightAccessibilityMutator

+ (void)mutateTitleColorForFeatureHighlightViewController:(MDCFeatureHighlightViewController *)fhvc
                             withTextAccessibilityOptions:(MDFTextAccessibilityOptions)options {
  MDCFeatureHighlightView *featureHighlightView =
      (MDCFeatureHighlightView *)fhvc.view;
  if (![featureHighlightView isKindOfClass:[MDCFeatureHighlightView class]]) {
    NSAssert(NO, @"FeatureHighlightViewController should have FeatureHighlightView");
    return;
  }
  UIColor *textColor = fhvc.titleColor;
  UIColor *backgroundColor = [fhvc.outerHighlightColor colorWithAlphaComponent:1.0f];
  UIColor *titleColor =
      [MDCFeatureHighlightAccessibilityMutator accessibleColorForTextColor:textColor
                                                       withBackgroundColor:backgroundColor
                                                                   options:options];
  // no change needed.
  if ([titleColor isEqual:textColor]) {
    return;
  }

  // Make title alpha the maximum it can be.
  CGFloat titleAlpha =
      [MDFTextAccessibility minAlphaOfTextColor:titleColor
                              onBackgroundColor:backgroundColor
                                        options:options];
  titleAlpha = MAX([MDCTypography titleFontOpacity], titleAlpha);
  fhvc.titleColor = [titleColor colorWithAlphaComponent:titleAlpha];
}

+ (void)mutateBodyColorForFeatureHighlightViewController:(MDCFeatureHighlightViewController *)fhvc
                            withTextAccessibilityOptions:(MDFTextAccessibilityOptions)options {
  MDCFeatureHighlightView *featureHighlightView =
      (MDCFeatureHighlightView *)fhvc.view;
  if (![featureHighlightView isKindOfClass:[MDCFeatureHighlightView class]]) {
    NSAssert(NO, @"FeatureHighlightViewController should have FeatureHighlightView");
    return;
  }
  UIColor *textColor = fhvc.bodyColor;
  UIColor *backgroundColor =
      [fhvc.outerHighlightColor colorWithAlphaComponent:1.0f];
  fhvc.bodyColor =
      [MDCFeatureHighlightAccessibilityMutator accessibleColorForTextColor:textColor
                                                       withBackgroundColor:backgroundColor
                                                                   options:options];
}

#pragma mark - private

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

