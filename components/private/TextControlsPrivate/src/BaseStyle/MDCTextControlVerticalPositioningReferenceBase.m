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

#import "MDCTextControlVerticalPositioningReferenceBase.h"
#import "MaterialMath.h"
#import "MDCTextControlVerticalPositioningReference.h"

static const CGFloat kMinPaddingAroundTextWhenNoFloatingLabel = 6.0f;
static const CGFloat kMaxPaddingAroundTextWhenNoFloatingLabel = 10.0f;
static const CGFloat kMinPaddingBetweenContainerTopAndFloatingLabel = (CGFloat)6.0;
static const CGFloat kMaxPaddingBetweenContainerTopAndFloatingLabel = (CGFloat)10.0;
static const CGFloat kMinPaddingBetweenFloatingLabelAndEditingText = (CGFloat)3.0;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndEditingText = (CGFloat)6.0;
static const CGFloat kMinPaddingBetweenEditingTextAndContainerBottom = (CGFloat)3.0;
static const CGFloat kMaxPaddingBetweenEditingTextAndContainerBottom = (CGFloat)6.0;
static const CGFloat kMinPaddingAboveAssistiveLabels = (CGFloat)0.0;
static const CGFloat kMaxPaddingAboveAssistiveLabels = (CGFloat)0.0;
static const CGFloat kMinPaddingBelowAssistiveLabels = (CGFloat)3.0;
static const CGFloat kMaxPaddingBelowAssistiveLabels = (CGFloat)6.0;

@interface MDCTextControlVerticalPositioningReferenceBase ()
@end

@implementation MDCTextControlVerticalPositioningReferenceBase

@synthesize paddingBetweenContainerTopAndFloatingLabel =
    _paddingBetweenContainerTopAndFloatingLabel;
@synthesize paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndEditingText = _paddingBetweenFloatingLabelAndEditingText;
@synthesize paddingBetweenEditingTextAndContainerBottom =
    _paddingBetweenEditingTextAndContainerBottom;
@synthesize paddingAboveAssistiveLabels = _paddingAboveAssistiveLabels;
@synthesize paddingBelowAssistiveLabels = _paddingBelowAssistiveLabels;
@synthesize containerHeightWithFloatingLabel = _containerHeightWithFloatingLabel;
@synthesize containerHeightWithoutFloatingLabel = _containerHeightWithoutFloatingLabel;
@synthesize paddingAroundTextWhenNoFloatingLabel = _paddingAroundTextWhenNoFloatingLabel;

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

  _paddingBetweenContainerTopAndFloatingLabel = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenContainerTopAndFloatingLabel,
      kMaxPaddingBetweenContainerTopAndFloatingLabel, clampedDensity);

  _paddingBetweenFloatingLabelAndEditingText = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenFloatingLabelAndEditingText, kMaxPaddingBetweenFloatingLabelAndEditingText,
      clampedDensity);

  _paddingBetweenEditingTextAndContainerBottom = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenEditingTextAndContainerBottom,
      kMaxPaddingBetweenEditingTextAndContainerBottom, clampedDensity);

  _paddingAboveAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingAboveAssistiveLabels, kMaxPaddingAboveAssistiveLabels, clampedDensity);
  _paddingBelowAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBelowAssistiveLabels, kMaxPaddingBelowAssistiveLabels, clampedDensity);

  CGFloat defaultContainerHeightForFloatingLabel =
      MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
          floatingLabelHeight, textRowHeight, numberOfTextRows,
          _paddingBetweenContainerTopAndFloatingLabel, _paddingBetweenFloatingLabelAndEditingText,
          _paddingBetweenEditingTextAndContainerBottom);
  BOOL preferredContainerHeightIsValidForFloatingLabel =
      preferredContainerHeight > defaultContainerHeightForFloatingLabel;
  if (preferredContainerHeightIsValidForFloatingLabel) {
    _containerHeightWithFloatingLabel = preferredContainerHeight;
    BOOL shouldUpdatePaddingValuesToMeetMinimumHeight = !isMultilineTextControl;
    if (shouldUpdatePaddingValuesToMeetMinimumHeight) {
      CGFloat difference = preferredContainerHeight - defaultContainerHeightForFloatingLabel;
      CGFloat sumOfPaddingValues = _paddingBetweenContainerTopAndFloatingLabel +
                                   _paddingBetweenFloatingLabelAndEditingText +
                                   _paddingBetweenEditingTextAndContainerBottom;
      _paddingBetweenContainerTopAndFloatingLabel =
          _paddingBetweenContainerTopAndFloatingLabel +
          ((_paddingBetweenContainerTopAndFloatingLabel / sumOfPaddingValues) * difference);
      _paddingBetweenFloatingLabelAndEditingText =
          _paddingBetweenFloatingLabelAndEditingText +
          ((_paddingBetweenFloatingLabelAndEditingText / sumOfPaddingValues) * difference);
      _paddingBetweenEditingTextAndContainerBottom =
          _paddingBetweenEditingTextAndContainerBottom +
          ((_paddingBetweenEditingTextAndContainerBottom / sumOfPaddingValues) * difference);
    }
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
  if (preferredContainerHeightIsValidForNoFloatingLabel) {
    _containerHeightWithoutFloatingLabel = preferredContainerHeight;
    BOOL shouldUpdatePaddingValuesToMeetMinimumHeight = !isMultilineTextControl;
    if (shouldUpdatePaddingValuesToMeetMinimumHeight) {
      CGFloat difference = preferredContainerHeight - defaultContainerHeightForNoFloatingLabel;
      CGFloat sumOfPaddingValues = _paddingAroundTextWhenNoFloatingLabel * 2.0f;
      _paddingAroundTextWhenNoFloatingLabel =
          _paddingAroundTextWhenNoFloatingLabel +
          ((_paddingAroundTextWhenNoFloatingLabel / sumOfPaddingValues) * difference);
    }
  } else {
    _containerHeightWithoutFloatingLabel = defaultContainerHeightForNoFloatingLabel;
  }

  CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
  if (isMultilineTextControl) {
    CGFloat heightWithOneRow = MDCTextControlCalculateContainerHeightWithFloatingLabelHeight(
        floatingLabelHeight, textRowHeight, 1, _paddingBetweenContainerTopAndFloatingLabel,
        _paddingBetweenFloatingLabelAndEditingText, _paddingBetweenEditingTextAndContainerBottom);
    CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
    _paddingBetweenContainerTopAndNormalLabel = halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
  } else {
    CGFloat halfOfContainerHeight = (CGFloat)0.5 * _containerHeightWithFloatingLabel;
    _paddingBetweenContainerTopAndNormalLabel = halfOfContainerHeight - halfOfNormalFontLineHeight;
  }
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
