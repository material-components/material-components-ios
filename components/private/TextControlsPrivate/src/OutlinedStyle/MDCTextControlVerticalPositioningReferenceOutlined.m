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

#import "MDCTextControlVerticalPositioningReferenceOutlined.h"
#import "MDCTextControlVerticalPositioningReference.h"

/**
 These values do not come from anywhere in particular. They are values I chose in an attempt to
 achieve the look and feel of the textfields at
 https://material.io/design/components/text-fields.html.
*/
static const CGFloat kMinPaddingAroundTextWhenNoFloatingLabel = 4.0f;
static const CGFloat kMaxPaddingAroundTextWhenNoFloatingLabel = 10.0f;
static const CGFloat kMinPaddingBetweenFloatingLabelAndEditingText = (CGFloat)3.0;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndEditingText = (CGFloat)12.0;
static const CGFloat kMinPaddingBelowAssistiveLabels = (CGFloat)3.0;
static const CGFloat kMaxPaddingBelowAssistiveLabels = (CGFloat)6.0;

/**
 For slightly more context on what this class is doing look at
 MDCTextControlVerticalPositioningReferenceBase. It's very similar and has some comments. Maybe at
 some point all the positioning references should be refactored to share a superclass, because
 there's currently a lot of duplicated code among the three of them.
*/
@implementation MDCTextControlVerticalPositioningReferenceOutlined
@synthesize paddingBetweenContainerTopAndFloatingLabel =
    _paddingBetweenContainerTopAndFloatingLabel;
@synthesize paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndEditingText = _paddingBetweenFloatingLabelAndEditingText;
@synthesize paddingBetweenEditingTextAndContainerBottom =
    _paddingBetweenEditingTextAndContainerBottom;
@synthesize containerHeightWithFloatingLabel = _containerHeightWithFloatingLabel;
@synthesize containerHeightWithoutFloatingLabel = _containerHeightWithoutFloatingLabel;
@synthesize paddingAroundTextWhenNoFloatingLabel = _paddingAroundTextWhenNoFloatingLabel;
@synthesize paddingAboveAssistiveLabels = _paddingAboveAssistiveLabels;
@synthesize paddingBelowAssistiveLabels = _paddingBelowAssistiveLabels;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight
                        isMultilineTextControl:(BOOL)isMultilineTextControl {
  self = [super init];
  if (self) {
    [self calculatePaddingValuesWithFoatingFontLineHeight:floatingLabelHeight
                                     normalFontLineHeight:normalFontLineHeight
                                            textRowHeight:textRowHeight
                                         numberOfTextRows:numberOfTextRows
                                                  density:density
                                 preferredContainerHeight:preferredContainerHeight
                                   isMultilineTextControl:isMultilineTextControl];
  }
  return self;
}

- (void)calculatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                   normalFontLineHeight:(CGFloat)normalFontLineHeight
                                          textRowHeight:(CGFloat)textRowHeight
                                       numberOfTextRows:(CGFloat)numberOfTextRows
                                                density:(CGFloat)density
                               preferredContainerHeight:(CGFloat)preferredContainerHeight
                                 isMultilineTextControl:(BOOL)isMultilineTextControl {
  CGFloat clampedDensity = MDCTextControlClampDensity(density);
  _paddingBetweenContainerTopAndFloatingLabel = 0.0f;

  _paddingBetweenFloatingLabelAndEditingText = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenFloatingLabelAndEditingText, kMaxPaddingBetweenFloatingLabelAndEditingText,
      clampedDensity);

  _paddingBetweenContainerTopAndNormalLabel =
      floatingLabelHeight + _paddingBetweenFloatingLabelAndEditingText;
  CGFloat halfOfFloatingLabelHeight = 0.5f * floatingLabelHeight;
  _paddingBetweenEditingTextAndContainerBottom =
      _paddingBetweenContainerTopAndNormalLabel - halfOfFloatingLabelHeight;

  _paddingBelowAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBelowAssistiveLabels, kMaxPaddingBelowAssistiveLabels, clampedDensity);
  _paddingAboveAssistiveLabels = _paddingBelowAssistiveLabels;

  CGFloat defaultContainerHeightForFloatingLabel =
      MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
          floatingLabelHeight, textRowHeight, numberOfTextRows,
          _paddingBetweenContainerTopAndFloatingLabel, _paddingBetweenFloatingLabelAndEditingText,
          _paddingBetweenEditingTextAndContainerBottom);
  BOOL preferredContainerHeightIsValidForFloatingLabel =
      preferredContainerHeight > defaultContainerHeightForFloatingLabel;
  if (preferredContainerHeightIsValidForFloatingLabel) {
    _containerHeightWithFloatingLabel = preferredContainerHeight;
  } else {
    _containerHeightWithFloatingLabel = defaultContainerHeightForFloatingLabel;
  }

  _paddingAroundTextWhenNoFloatingLabel = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingAroundTextWhenNoFloatingLabel, kMaxPaddingAroundTextWhenNoFloatingLabel,
      clampedDensity);

  CGFloat defaultContainerHeightForNoFloatingLabel =
      MDCTextControlCalculateContainerHeightWhenNoFloatingLabelWithTextRowHeight(
          textRowHeight, numberOfTextRows, _paddingAroundTextWhenNoFloatingLabel);
  BOOL preferredContainerHeightIsValidForNoFloatingLabel =
      preferredContainerHeight > defaultContainerHeightForNoFloatingLabel;
  CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
  if (preferredContainerHeightIsValidForNoFloatingLabel) {
    _containerHeightWithoutFloatingLabel = preferredContainerHeight;
    BOOL shouldUpdatePaddingValuesToMeetMinimumHeight = !isMultilineTextControl;
    if (shouldUpdatePaddingValuesToMeetMinimumHeight) {
      CGFloat halfOfContainerHeight = (CGFloat)0.5 * _containerHeightWithoutFloatingLabel;
      _paddingAroundTextWhenNoFloatingLabel = halfOfContainerHeight - halfOfNormalFontLineHeight;
    }
  } else {
    _containerHeightWithoutFloatingLabel = defaultContainerHeightForNoFloatingLabel;
  }

  CGFloat heightForDeterminingFinalPaddingValues = _containerHeightWithFloatingLabel;
  if (isMultilineTextControl) {
    heightForDeterminingFinalPaddingValues =
        MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
            floatingLabelHeight, textRowHeight, 1, _paddingBetweenContainerTopAndFloatingLabel,
            _paddingBetweenFloatingLabelAndEditingText,
            _paddingBetweenEditingTextAndContainerBottom);
  }
  CGFloat heightOfOutline = heightForDeterminingFinalPaddingValues - halfOfFloatingLabelHeight;
  CGFloat halfOfOutlineHeight = 0.5f * heightOfOutline;
  CGFloat verticalCenterOfOutline = halfOfFloatingLabelHeight + halfOfOutlineHeight;
  _paddingBetweenContainerTopAndNormalLabel = verticalCenterOfOutline - halfOfNormalFontLineHeight;
  _paddingBetweenFloatingLabelAndEditingText =
      _paddingBetweenContainerTopAndNormalLabel - floatingLabelHeight;
}

- (CGFloat)paddingBetweenContainerTopAndFloatingLabel {
  return _paddingBetweenContainerTopAndFloatingLabel;
}

- (CGFloat)paddingBetweenContainerTopAndNormalLabel {
  return _paddingBetweenContainerTopAndNormalLabel;
}

- (CGFloat)paddingBetweenFloatingLabelAndEditingText {
  return _paddingBetweenFloatingLabelAndEditingText;
}

- (CGFloat)paddingBetweenEditingTextAndContainerBottom {
  return _paddingBetweenEditingTextAndContainerBottom;
}

- (CGFloat)paddingAboveAssistiveLabels {
  return _paddingAboveAssistiveLabels;
}

- (CGFloat)paddingBelowAssistiveLabels {
  return _paddingBelowAssistiveLabels;
}

- (CGFloat)containerHeightWithFloatingLabel {
  return _containerHeightWithFloatingLabel;
}

- (CGFloat)containerHeightWithoutFloatingLabel {
  return _containerHeightWithoutFloatingLabel;
}

- (CGFloat)paddingAroundTextWhenNoFloatingLabel {
  return _paddingAroundTextWhenNoFloatingLabel;
}

@end
