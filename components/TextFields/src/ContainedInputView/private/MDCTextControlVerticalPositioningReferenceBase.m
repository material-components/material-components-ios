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

static const CGFloat kPaddingBetweenTopAndFloatingLabel = (CGFloat)10.0;
static const CGFloat kPaddingBetweenFloatingLabelAndText = (CGFloat)6.0;
static const CGFloat kPaddingBetweenTextAndBottom = (CGFloat)10.0;

@interface MDCTextControlVerticalPositioningReferenceBase ()
@end

@implementation MDCTextControlVerticalPositioningReferenceBase

@synthesize paddingBetweenTopAndFloatingLabel = _paddingBetweenTopAndFloatingLabel;
@synthesize paddingBetweenTopAndNormalLabel = _paddingBetweenTopAndNormalLabel;
@synthesize paddingBetweenFloatingLabelAndText = _paddingBetweenFloatingLabelAndText;
@synthesize paddingBetweenTextAndBottom = _paddingBetweenTextAndBottom;
@synthesize containerHeight = _containerHeight;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows {
  self = [super init];
  if (self) {
    [self calculatePaddingValuesWithFoatingFontLineHeight:floatingLabelHeight
                                     normalFontLineHeight:normalFontLineHeight
                                            textRowHeight:textRowHeight
                                         numberOfTextRows:numberOfTextRows];
  }
  return self;
}

- (void)calculatePaddingValuesWithFoatingFontLineHeight:(CGFloat)floatingLabelHeight
                                   normalFontLineHeight:(CGFloat)normalFontLineHeight
                                          textRowHeight:(CGFloat)textRowHeight
                                       numberOfTextRows:(CGFloat)numberOfTextRows {
  _paddingBetweenTopAndFloatingLabel = kPaddingBetweenTopAndFloatingLabel;
  _paddingBetweenFloatingLabelAndText = kPaddingBetweenFloatingLabelAndText;
  _paddingBetweenTextAndBottom = kPaddingBetweenTextAndBottom;

  _containerHeight =
      [self calculateContainerHeightWithFoatingLabelHeight:floatingLabelHeight
                                             textRowHeight:textRowHeight
                                          numberOfTextRows:numberOfTextRows
                         paddingBetweenTopAndFloatingLabel:_paddingBetweenTopAndFloatingLabel
                        paddingBetweenFloatingLabelAndText:_paddingBetweenFloatingLabelAndText
                               paddingBetweenTextAndBottom:_paddingBetweenTextAndBottom];

  _paddingBetweenTopAndNormalLabel = _paddingBetweenTopAndFloatingLabel + floatingLabelHeight +
                                     _paddingBetweenFloatingLabelAndText;
}

- (CGFloat)calculateContainerHeightWithFoatingLabelHeight:(CGFloat)floatingLabelHeight
                                            textRowHeight:(CGFloat)textRowHeight
                                         numberOfTextRows:(CGFloat)numberOfTextRows
                        paddingBetweenTopAndFloatingLabel:(CGFloat)paddingBetweenTopAndFloatingLabel
                       paddingBetweenFloatingLabelAndText:
                           (CGFloat)paddingBetweenFloatingLabelAndText
                              paddingBetweenTextAndBottom:(CGFloat)paddingBetweenTextAndBottom {
  CGFloat totalTextHeight = numberOfTextRows * textRowHeight;
  return paddingBetweenTopAndFloatingLabel + floatingLabelHeight +
         paddingBetweenFloatingLabelAndText + totalTextHeight + paddingBetweenTextAndBottom;
}

- (CGFloat)paddingBetweenContainerTopAndFloatingLabel {
  return _paddingBetweenTopAndFloatingLabel;
}

- (CGFloat)paddingBetweenContainerTopAndNormalLabel {
  return _paddingBetweenTopAndNormalLabel;
}

- (CGFloat)paddingBetweenFloatingLabelAndEditingText {
  return _paddingBetweenFloatingLabelAndText;
}

- (CGFloat)paddingBetweenEditingTextAndContainerBottom {
  return _paddingBetweenTextAndBottom;
}

- (CGFloat)containerHeight {
  return _containerHeight;
}

@end
