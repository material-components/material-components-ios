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

#import "MDCTextControlVerticalPositioningReferenceFilled.h"

/**
 For slightly more context on what this class is doing look at
 MDCTextControlVerticalPositioningReferenceBase. It's very similar and has some comments. Maybe at
 some point all the positioning references should be refactored to share a superclass, because
 there's currently a lot of duplicated code among the three of them.
*/
@interface MDCTextControlVerticalPositioningReferenceFilled ()
@end

@implementation MDCTextControlVerticalPositioningReferenceFilled

@synthesize paddingBetweenContainerTopAndNormalLabel = _paddingBetweenContainerTopAndNormalLabel;

- (instancetype)initWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                          normalFontLineHeight:(CGFloat)normalFontLineHeight
                                 textRowHeight:(CGFloat)textRowHeight
                              numberOfTextRows:(CGFloat)numberOfTextRows
                                       density:(CGFloat)density
                      preferredContainerHeight:(CGFloat)preferredContainerHeight {
  self = [super initWithFloatingFontLineHeight:floatingLabelHeight
                          normalFontLineHeight:normalFontLineHeight
                                 textRowHeight:textRowHeight
                              numberOfTextRows:numberOfTextRows
                                       density:density
                      preferredContainerHeight:preferredContainerHeight];
  if (self) {
    BOOL isMultiline = numberOfTextRows > 1 || numberOfTextRows == 0;
    CGFloat halfOfNormalFontLineHeight = (CGFloat)0.5 * normalFontLineHeight;
    if (isMultiline) {
      CGFloat heightWithOneRow = MDCTextControlCalculateContainerHeightWithFoatingLabelHeight(
          floatingLabelHeight, textRowHeight, 1, self.paddingBetweenContainerTopAndFloatingLabel,
          self.paddingBetweenFloatingLabelAndEditingText,
          self.paddingBetweenEditingTextAndContainerBottom);
      CGFloat halfOfHeightWithOneRow = (CGFloat)0.5 * heightWithOneRow;
      _paddingBetweenContainerTopAndNormalLabel =
          halfOfHeightWithOneRow - halfOfNormalFontLineHeight;
    } else {
      CGFloat halfOfContainerHeight = (CGFloat)0.5 * self.containerHeight;
      _paddingBetweenContainerTopAndNormalLabel =
          halfOfContainerHeight - halfOfNormalFontLineHeight;
    }
  }
  return self;
}

- (CGFloat)paddingBetweenContainerTopAndNormalLabel {
  return _paddingBetweenContainerTopAndNormalLabel;
}

@end
