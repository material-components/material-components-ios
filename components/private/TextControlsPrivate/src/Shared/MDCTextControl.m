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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDCTextControl.h"

const CGFloat kMDCTextControlDefaultAnimationDuration = (CGFloat)0.15;

UIFont *_Nonnull MDCTextControlDefaultUITextFieldFont(void) {
  return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

CGFloat MDCTextControlPaddingValueWithMinimumPadding(CGFloat minimumPadding,
                                                     CGFloat maximumPadding,
                                                     CGFloat density) {
  if (minimumPadding > maximumPadding) {
    return 0;
  } else if (minimumPadding == maximumPadding) {
    return minimumPadding;
  } else {
    CGFloat minMaxPaddingDifference = maximumPadding - minimumPadding;
    CGFloat additionToMinPadding = minMaxPaddingDifference * (1 - density);
    return minimumPadding + additionToMinPadding;
  }
}

CGFloat MDCTextControlNormalizeDensity(CGFloat density) {
  CGFloat normalizedDensity = density;
  if (normalizedDensity < 0) {
    normalizedDensity = 0;
  } else if (normalizedDensity > 1) {
    normalizedDensity = 1;
  }
  return normalizedDensity;
}
