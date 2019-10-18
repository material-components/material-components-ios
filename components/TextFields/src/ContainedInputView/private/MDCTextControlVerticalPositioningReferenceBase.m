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
  CGFloat standardizedDensity = [self standardizeDensity:density];

  CGFloat paddingBetweenContainerTopAndFloatingLabelRange =
      kMaxPaddingBetweenContainerTopAndFloatingLabel -
      kMinPaddingBetweenContainerTopAndFloatingLabel;
  CGFloat paddingBetweenContainerTopAndFloatingLabelAddition =
      paddingBetweenContainerTopAndFloatingLabelRange * (1 - standardizedDensity);
  _paddingBetweenContainerTopAndFloatingLabel = kMinPaddingBetweenContainerTopAndFloatingLabel +
                                                paddingBetweenContainerTopAndFloatingLabelAddition;

  CGFloat paddingBetweenFloatingLabelAndEditingTextRange =
      kMaxPaddingBetweenFloatingLabelAndEditingText - kMinPaddingBetweenFloatingLabelAndEditingText;
  CGFloat paddingBetweenFloatingLabelAndEditingTextAddition =
      paddingBetweenFloatingLabelAndEditingTextRange * (1 - standardizedDensity);
  _paddingBetweenFloatingLabelAndEditingText = kMinPaddingBetweenFloatingLabelAndEditingText +
                                               paddingBetweenFloatingLabelAndEditingTextAddition;

  CGFloat paddingBetweenEditingTextAndContainerBottomRange =
      kMaxPaddingBetweenEditingTextAndContainerBottom -
      kMinPaddingBetweenEditingTextAndContainerBottom;
  CGFloat paddingBetweenEditingTextAndContainerBottomAddition =
      paddingBetweenEditingTextAndContainerBottomRange * (1 - standardizedDensity);
  _paddingBetweenEditingTextAndContainerBottom =
      kMinPaddingBetweenEditingTextAndContainerBottom +
      paddingBetweenEditingTextAndContainerBottomAddition;

  CGFloat paddingAboveAssistiveLabelsRange =
      kMaxPaddingAboveAssistiveLabels - kMinPaddingAboveAssistiveLabels;
  CGFloat paddingAboveAssistiveLabelsAddition =
      paddingAboveAssistiveLabelsRange * (1 - standardizedDensity);
  _paddingAboveAssistiveLabels =
      kMinPaddingAboveAssistiveLabels + paddingAboveAssistiveLabelsAddition;

  CGFloat paddingBelowAssistiveLabelsRange =
      kMaxPaddingBelowAssistiveLabels - kMinPaddingBelowAssistiveLabels;
  CGFloat paddingBelowAssistiveLabelsAddition =
      paddingBelowAssistiveLabelsRange * (1 - standardizedDensity);
  _paddingBelowAssistiveLabels =
      kMinPaddingBelowAssistiveLabels + paddingBelowAssistiveLabelsAddition;

  CGFloat containerHeightWithPaddingsDeterminedByDensity = [self
      calculateContainerHeightWithFoatingLabelHeight:floatingLabelHeight
                                       textRowHeight:textRowHeight
                                    numberOfTextRows:numberOfTextRows
          paddingBetweenContainerTopAndFloatingLabel:_paddingBetweenContainerTopAndFloatingLabel
           paddingBetweenFloatingLabelAndEditingText:_paddingBetweenFloatingLabelAndEditingText
         paddingBetweenEditingTextAndContainerBottom:_paddingBetweenEditingTextAndContainerBottom];
  if (preferredContainerHeight > 0) {
    if (preferredContainerHeight > containerHeightWithPaddingsDeterminedByDensity) {
      if (!isMultiline) {
        CGFloat difference =
            preferredContainerHeight - containerHeightWithPaddingsDeterminedByDensity;
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
    }
  }

  _containerHeight = containerHeightWithPaddingsDeterminedByDensity;
  if (preferredContainerHeight > containerHeightWithPaddingsDeterminedByDensity) {
    _containerHeight = preferredContainerHeight;
  }

  CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
  if (isMultiline) {
    CGFloat heightWithOneRow = [self
        calculateContainerHeightWithFoatingLabelHeight:floatingLabelHeight
                                         textRowHeight:textRowHeight
                                      numberOfTextRows:1
            paddingBetweenContainerTopAndFloatingLabel:_paddingBetweenContainerTopAndFloatingLabel
             paddingBetweenFloatingLabelAndEditingText:_paddingBetweenFloatingLabelAndEditingText
           paddingBetweenEditingTextAndContainerBottom:
               _paddingBetweenEditingTextAndContainerBottom];
    CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
    _paddingBetweenContainerTopAndNormalLabel = halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
  } else {
    CGFloat halfOfContainerHeight = (CGFloat)0.5 * _containerHeight;
    _paddingBetweenContainerTopAndNormalLabel = halfOfContainerHeight - halfOfNormalFontLineHeight;
  }
}

- (CGFloat)standardizeDensity:(CGFloat)density {
  CGFloat standardizedDensity = density;
  if (standardizedDensity < 0) {
    standardizedDensity = 0;
  } else if (standardizedDensity > 1) {
    standardizedDensity = 1;
  }
  return standardizedDensity;
}

- (CGFloat)calculateContainerHeightWithFoatingLabelHeight:(CGFloat)floatingLabelHeight
                                            textRowHeight:(CGFloat)textRowHeight
                                         numberOfTextRows:(CGFloat)numberOfTextRows
               paddingBetweenContainerTopAndFloatingLabel:
                   (CGFloat)paddingBetweenContainerTopAndFloatingLabel
                paddingBetweenFloatingLabelAndEditingText:
                    (CGFloat)paddingBetweenFloatingLabelAndEditingText
              paddingBetweenEditingTextAndContainerBottom:
                  (CGFloat)paddingBetweenEditingTextAndContainerBottom {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return paddingBetweenContainerTopAndFloatingLabel + floatingLabelHeight +
         paddingBetweenFloatingLabelAndEditingText + totalTextHeight +
         paddingBetweenEditingTextAndContainerBottom;
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

- (CGFloat)containerHeight {
  return _containerHeight;
}

@end
