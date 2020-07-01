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

#import "MDCTextControlVerticalPositioningReference.h"
#import "MDCTextControlLabelBehavior.h"

CGFloat MDCTextControlCalculateContainerHeightWhenNoFloatingLabelWithTextRowHeight(
    CGFloat textRowHeight, CGFloat numberOfTextRows, CGFloat paddingAroundTextWhenNoFloatingLabel) {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return (paddingAroundTextWhenNoFloatingLabel * 2.0f) + totalTextHeight;
}

CGFloat MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
    CGFloat floatingLabelHeight, CGFloat textRowHeight, CGFloat numberOfTextRows,
    CGFloat paddingBetweenContainerTopAndFloatingLabel,
    CGFloat paddingBetweenFloatingLabelAndEditingText,
    CGFloat paddingBetweenEditingTextAndContainerBottom) {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return paddingBetweenContainerTopAndFloatingLabel + floatingLabelHeight +
         paddingBetweenFloatingLabelAndEditingText + totalTextHeight +
         paddingBetweenEditingTextAndContainerBottom;
}

CGFloat MDCTextControlClampDensity(CGFloat density) {
  CGFloat clampedDensity = density;
  if (clampedDensity < 0) {
    clampedDensity = 0;
  } else if (clampedDensity > 1) {
    clampedDensity = 1;
  }
  return clampedDensity;
}

CGFloat MDCTextControlPaddingValueWithMinimumPadding(CGFloat minimumPadding, CGFloat maximumPadding,
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

BOOL MDCTextControlShouldLayoutForFloatingLabelWithLabelPosition(
    MDCTextControlLabelPosition labelPosition, MDCTextControlLabelBehavior labelBehavior,
    NSString *labelText) {
  if (labelBehavior == MDCTextControlLabelBehaviorDisappears) {
    return NO;
  } else {
    BOOL hasLabelText = labelText.length > 0;
    return hasLabelText;
  }
}
