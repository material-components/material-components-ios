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

#import "MDCTextControlVerticalPositioningReferenceUnderlined.h"

/**
 These values do not come from anywhere in particular. They are values I chose in an attempt to
 achieve the look and feel of the textfields at
 https://material.io/design/components/text-fields.html.
*/
static const CGFloat kMinPaddingBetweenContainerTopAndFloatingLabel = 6.0f;
static const CGFloat kMaxPaddingBetweenContainerTopAndFloatingLabel = 10.0f;
static const CGFloat kMinPaddingBetweenFloatingLabelAndEditingText = 3.0f;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndEditingText = 6.0f;
static const CGFloat kMinPaddingBetweenEditingTextAndContainerBottom = 6.0f;
static const CGFloat kMaxPaddingBetweenEditingTextAndContainerBottom = 10.0f;
static const CGFloat kMinPaddingAroundAssistiveLabels = 3.0f;
static const CGFloat kMaxPaddingAroundAssistiveLabels = 6.0f;

/**
 For slightly more context on what this class is doing look at
 MDCTextControlVerticalPositioningReferenceBase. It's very similar and has some comments. Maybe at
 some point all the positioning references should be refactored to share a superclass, because
 there's currently a lot of duplicated code among the three of them.
*/
@interface MDCTextControlVerticalPositioningReferenceUnderlined ()
@property(nonatomic, assign) CGFloat paddingAroundAssistiveLabels;
@end

@implementation MDCTextControlVerticalPositioningReferenceUnderlined

@synthesize paddingBetweenContainerTopAndFloatingLabel =
    _paddingBetweenContainerTopAndFloatingLabel;
@synthesize paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndEditingText = _paddingBetweenFloatingLabelAndEditingText;
@synthesize paddingBetweenEditingTextAndContainerBottom =
    _paddingBetweenEditingTextAndContainerBottom;
@synthesize containerHeight = _containerHeight;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight {
  self = [super init];
  if (self) {
    [self calculatePaddingValuesWithFoatingFontLineHeight:floatingLabelHeight
                                     normalFontLineHeight:normalFontLineHeight
                                            textRowHeight:textRowHeight
                                         numberOfTextRows:numberOfTextRows
                                                  density:density
                                 preferredContainerHeight:preferredContainerHeight];
  }
  return self;
}

- (void)calculatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                   normalFontLineHeight:(CGFloat)normalFontLineHeight
                                          textRowHeight:(CGFloat)textRowHeight
                                       numberOfTextRows:(CGFloat)numberOfTextRows
                                                density:(CGFloat)density
                               preferredContainerHeight:(CGFloat)preferredContainerHeight {
  BOOL isMultiline = numberOfTextRows > 1 || numberOfTextRows == 0;
  CGFloat normalizedDensity = MDCTextControlClampDensity(density);

  _paddingBetweenContainerTopAndFloatingLabel = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenContainerTopAndFloatingLabel,
      kMaxPaddingBetweenContainerTopAndFloatingLabel, normalizedDensity);

  _paddingBetweenFloatingLabelAndEditingText = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenFloatingLabelAndEditingText, kMaxPaddingBetweenFloatingLabelAndEditingText,
      normalizedDensity);

  _paddingBetweenEditingTextAndContainerBottom = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingBetweenEditingTextAndContainerBottom,
      kMaxPaddingBetweenEditingTextAndContainerBottom, normalizedDensity);

  _paddingAroundAssistiveLabels = MDCTextControlPaddingValueWithMinimumPadding(
      kMinPaddingAroundAssistiveLabels, kMaxPaddingAroundAssistiveLabels, normalizedDensity);

  _paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndFloatingLabel +
                                              floatingLabelHeight +
                                              _paddingBetweenFloatingLabelAndEditingText;

  CGFloat containerHeightWithPaddingsDeterminedByDensity =
      MDCTextControlCalculateContainerHeightWithFoatingLabelHeight(
          floatingLabelHeight, textRowHeight, numberOfTextRows,
          _paddingBetweenContainerTopAndFloatingLabel, _paddingBetweenFloatingLabelAndEditingText,
          _paddingBetweenEditingTextAndContainerBottom);

  BOOL clientHasSpecifiedValidPreferredContainerHeight =
      preferredContainerHeight > containerHeightWithPaddingsDeterminedByDensity;
  if (clientHasSpecifiedValidPreferredContainerHeight && !isMultiline) {
    CGFloat difference = preferredContainerHeight - containerHeightWithPaddingsDeterminedByDensity;
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

  if (clientHasSpecifiedValidPreferredContainerHeight) {
    _containerHeight = preferredContainerHeight;
  } else {
    _containerHeight = containerHeightWithPaddingsDeterminedByDensity;
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
  return self.paddingAroundAssistiveLabels;
}

- (CGFloat)paddingBelowAssistiveLabels {
  return self.paddingAroundAssistiveLabels;
}

- (CGFloat)containerHeight {
  return _containerHeight;
}

@end
