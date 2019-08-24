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

#import "MDCContainedInputView.h"
#import "MDCContainedInputViewVerticalPositioningGuideBase.h"

static const CGFloat kMinPaddingBetweenTopAndFloatingLabel = (CGFloat)6.0;
static const CGFloat kMaxPaddingBetweenTopAndFloatingLabel = (CGFloat)10.0;
static const CGFloat kMinPaddingBetweenFloatingLabelAndText = (CGFloat)3.0;
static const CGFloat kMaxPaddingBetweenFloatingLabelAndText = (CGFloat)6.0;
static const CGFloat kMinPaddingBetweenTextAndBottom = (CGFloat)6.0;
static const CGFloat kMaxPaddingBetweenTextAndBottom = (CGFloat)10.0;
static const CGFloat kMinPaddingAroundAssistiveLabels = (CGFloat)3.0;
static const CGFloat kMaxPaddingAroundAssistiveLabels = (CGFloat)6.0;

@interface MDCContainedInputViewVerticalPositioningGuideBase ()
@end

@implementation MDCContainedInputViewVerticalPositioningGuideBase

@synthesize paddingBetweenTopAndFloatingLabel = _paddingBetweenTopAndFloatingLabel;
@synthesize paddingBetweenTopAndNormalLabel = _paddingBetweenTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndText = _paddingBetweenFloatingLabelAndText;
@synthesize paddingBetweenTextAndBottom = _paddingBetweenTextAndBottom;
@synthesize containerHeight = _containerHeight;
@synthesize paddingAroundAssistiveLabels = _paddingAroundAssistiveLabels;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight {
  self = [super init];
  if (self) {
    [self updatePaddingValuesWithFoatingFontLineHeight:floatingLabelHeight
                                  normalFontLineHeight:normalFontLineHeight
                                         textRowHeight:textRowHeight
                                      numberOfTextRows:numberOfTextRows
                                               density:density
                              preferredContainerHeight:preferredContainerHeight];
  }
  return self;
}

- (void)updatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                normalFontLineHeight:(CGFloat)normalFontLineHeight
                                       textRowHeight:(CGFloat)textRowHeight
                                    numberOfTextRows:(CGFloat)numberOfTextRows
                                             density:(CGFloat)density
                            preferredContainerHeight:(CGFloat)preferredContainerHeight {
  BOOL isMultiline = numberOfTextRows > 1 || numberOfTextRows == 0;
  CGFloat standardizedDensity = [self standardizeDensity:density];

  CGFloat paddingBetweenTopAndFloatingLabelRange =
      kMaxPaddingBetweenTopAndFloatingLabel - kMinPaddingBetweenTopAndFloatingLabel;
  CGFloat paddingBetweenTopAndFloatingLabelAddition =
      paddingBetweenTopAndFloatingLabelRange * (1 - standardizedDensity);
  _paddingBetweenTopAndFloatingLabel =
      kMinPaddingBetweenTopAndFloatingLabel + paddingBetweenTopAndFloatingLabelAddition;

  CGFloat paddingBetweenFloatingLabelAndTextRange =
      kMaxPaddingBetweenFloatingLabelAndText - kMinPaddingBetweenFloatingLabelAndText;
  CGFloat paddingBetweenFloatingLabelAndTextAddition =
      paddingBetweenFloatingLabelAndTextRange * (1 - standardizedDensity);
  _paddingBetweenFloatingLabelAndText =
      kMinPaddingBetweenFloatingLabelAndText + paddingBetweenFloatingLabelAndTextAddition;

  CGFloat paddingBetweenTextAndBottomRange =
      kMaxPaddingBetweenTextAndBottom - kMinPaddingBetweenTextAndBottom;
  CGFloat paddingBetweenTextAndBottomAddition =
      paddingBetweenTextAndBottomRange * (1 - standardizedDensity);
  _paddingBetweenTextAndBottom =
      kMinPaddingBetweenTextAndBottom + paddingBetweenTextAndBottomAddition;

  CGFloat paddingAroundAssistiveLabelsRange =
      kMaxPaddingAroundAssistiveLabels - kMinPaddingAroundAssistiveLabels;
  CGFloat paddingAroundAssistiveLabelsAddition =
      paddingAroundAssistiveLabelsRange * (1 - standardizedDensity);
  _paddingAroundAssistiveLabels =
      kMinPaddingAroundAssistiveLabels + paddingAroundAssistiveLabelsAddition;

  CGFloat heightWithPaddingsDeterminedByDensity =
      [self calculateHeightWithFoatingLabelHeight:floatingLabelHeight
                                    textRowHeight:textRowHeight
                                 numberOfTextRows:numberOfTextRows
                paddingBetweenTopAndFloatingLabel:_paddingBetweenTopAndFloatingLabel
               paddingBetweenFloatingLabelAndText:_paddingBetweenFloatingLabelAndText
                      paddingBetweenTextAndBottom:_paddingBetweenTextAndBottom];
  if (preferredContainerHeight > 0) {
    if (preferredContainerHeight > heightWithPaddingsDeterminedByDensity) {
      if (!isMultiline) {
        CGFloat difference = preferredContainerHeight - heightWithPaddingsDeterminedByDensity;
        CGFloat sumOfPaddingValues = _paddingBetweenTopAndFloatingLabel +
                                     _paddingBetweenFloatingLabelAndText +
                                     _paddingBetweenTextAndBottom;
        _paddingBetweenTopAndFloatingLabel =
            _paddingBetweenTopAndFloatingLabel +
            ((_paddingBetweenTopAndFloatingLabel / sumOfPaddingValues) * difference);
        _paddingBetweenFloatingLabelAndText =
            _paddingBetweenFloatingLabelAndText +
            ((_paddingBetweenFloatingLabelAndText / sumOfPaddingValues) * difference);
        _paddingBetweenTextAndBottom =
            _paddingBetweenTextAndBottom +
            ((_paddingBetweenTextAndBottom / sumOfPaddingValues) * difference);
      }
    }
  }

  _containerHeight = heightWithPaddingsDeterminedByDensity;
  if (preferredContainerHeight > heightWithPaddingsDeterminedByDensity) {
    _containerHeight = preferredContainerHeight;
  }
  
  _paddingBetweenTopAndNormalLabel = _paddingBetweenTopAndFloatingLabel + floatingLabelHeight + _paddingBetweenFloatingLabelAndText;
//
//  CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
//  if (isMultiline) {
//    CGFloat heightWithOneRow =
//        [self calculateHeightWithFoatingLabelHeight:floatingLabelHeight
//                                      textRowHeight:textRowHeight
//                                   numberOfTextRows:1
//                  paddingBetweenTopAndFloatingLabel:_paddingBetweenTopAndFloatingLabel
//                 paddingBetweenFloatingLabelAndText:_paddingBetweenFloatingLabelAndText
//                        paddingBetweenTextAndBottom:_paddingBetweenTextAndBottom];
//    CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
//    _paddingBetweenTopAndNormalLabel = halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
//  } else {
//    CGFloat halfOfContainerHeight = (CGFloat)0.5 * _containerHeight;
//    _paddingBetweenTopAndNormalLabel = halfOfContainerHeight - halfOfNormalFontLineHeight;
//  }
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

- (CGFloat)calculateHeightWithFoatingLabelHeight:(CGFloat)floatingLabelHeight
                                   textRowHeight:(CGFloat)textRowHeight
                                numberOfTextRows:(CGFloat)numberOfTextRows
               paddingBetweenTopAndFloatingLabel:(CGFloat)paddingBetweenTopAndFloatingLabel
              paddingBetweenFloatingLabelAndText:(CGFloat)paddingBetweenFloatingLabelAndText
                     paddingBetweenTextAndBottom:(CGFloat)paddingBetweenTextAndBottom {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return paddingBetweenTopAndFloatingLabel + floatingLabelHeight +
         paddingBetweenFloatingLabelAndText + totalTextHeight + paddingBetweenTextAndBottom;
}

- (CGFloat)paddingBetweenTopAndFloatingLabel {
  return _paddingBetweenTopAndFloatingLabel;
}

- (CGFloat)paddingBetweenTopAndNormalLabel {
  return _paddingBetweenTopAndNormalLabel;
}

- (CGFloat)paddingBetweenFloatingLabelAndText {
  return _paddingBetweenFloatingLabelAndText;
}

- (CGFloat)paddingBetweenTextAndBottom {
  return _paddingBetweenTextAndBottom;
}

- (CGFloat)paddingAroundAssistiveLabels {
  return _paddingAroundAssistiveLabels;
}

- (CGFloat)containerHeight {
  return _containerHeight;
}

@end
