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
#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialTypography.h"

@implementation MDCFeatureHighlightAccessibilityMutator

+ (void)changeTitleAndBodyColorForFeatureHighlightViewControllerIfApplicable:
    (MDCFeatureHighlightViewController *)featureHighlightViewController {
  MDCFeatureHighlightView *featureHighlightView =
      (MDCFeatureHighlightView *)featureHighlightViewController.view;
  NSAssert([featureHighlightView isKindOfClass:[MDCFeatureHighlightView class]],
           @"FeatureHighlightViewController should have FeatureHighlightView");
  MDFTextAccessibilityOptions options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:featureHighlightView.bodyFont]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }

  UIColor *outerColor =
      [featureHighlightViewController.outerHighlightColor colorWithAlphaComponent:1.0f];
  if (![MDFTextAccessibility textColor:featureHighlightViewController.bodyColor
               passesOnBackgroundColor:outerColor
                               options:options]) {
    featureHighlightViewController.bodyColor =
        [MDFTextAccessibility textColorOnBackgroundColor:outerColor
                                         targetTextAlpha:[MDCTypography captionFontOpacity]
                                                 options:options];
  }

  options = MDFTextAccessibilityOptionsPreferLighter;
  if ([MDFTextAccessibility isLargeForContrastRatios:featureHighlightView.titleFont]) {
    options |= MDFTextAccessibilityOptionsLargeFont;
  }
  // Since MDFTextAccessibility can return either a dark value or light value color we want to
  // guarantee that the title and body have the same value.
  if (![MDFTextAccessibility textColor:featureHighlightViewController.titleColor
               passesOnBackgroundColor:outerColor
                               options:options]) {
    CGFloat titleAlpha =
        [MDFTextAccessibility minAlphaOfTextColor:featureHighlightViewController.bodyColor
                                onBackgroundColor:outerColor
                                          options:options];
    titleAlpha = MAX([MDCTypography titleFontOpacity], titleAlpha);
    featureHighlightViewController.titleColor =
        [featureHighlightViewController.bodyColor colorWithAlphaComponent:titleAlpha];
  }
}

@end

