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

#import "MDCFilledTextField.h"

#import <Foundation/Foundation.h>

#import "MDCBaseTextField+Private.h"
#import "MDCContainedInputView.h"
#import "MDCContainerStylerFilled.h"

@interface MDCFilledTextFieldPositioningDelegate
    : NSObject <MDCContainedInputViewStylerPositioningDelegate>
@end

@interface MDCFilledTextField ()
@end

@implementation MDCFilledTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCFilledTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFilledTextFieldInit];
  }
  return self;
}

- (void)commonMDCFilledTextFieldInit {
  MDCFilledTextFieldPositioningDelegate *positioningDelegate =
      [[MDCFilledTextFieldPositioningDelegate alloc] init];
  MDCContainerStylerFilled *filledStyle =
      [[MDCContainerStylerFilled alloc] initWithPositioningDelegate:positioningDelegate];
  self.containerStyler = filledStyle;
}

#pragma mark Stateful Color APIs

- (void)setFilledBackgroundColor:(nonnull UIColor *)filledBackgroundColor
                        forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme =
        (MDCContainedInputViewColorSchemeFilled *)colorScheme;
    filledColorScheme.filledSublayerFillColor = filledBackgroundColor;
  }
  [self setNeedsLayout];
}

- (nonnull UIColor *)filledBackgroundColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme =
        (MDCContainedInputViewColorSchemeFilled *)colorScheme;
    return filledColorScheme.filledSublayerFillColor;
  }
  // TODO: Is it okay to return clear color here? Should it be nullable?
  return [UIColor clearColor];
}

- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme =
        (MDCContainedInputViewColorSchemeFilled *)colorScheme;
    filledColorScheme.thinUnderlineFillColor = underlineColor;
    filledColorScheme.thickUnderlineFillColor = underlineColor;
    // TODO: Explore setting either the thick or thin depending on the state!
  }
  [self setNeedsLayout];
}

- (nonnull UIColor *)underlineColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeFilled class]]) {
    MDCContainedInputViewColorSchemeFilled *filledColorScheme =
        (MDCContainedInputViewColorSchemeFilled *)colorScheme;
    return filledColorScheme.thinUnderlineFillColor;
    //    return filledColorScheme.thickUnderlineFillColor;
    // TODO: Determine which one of these you should actually return!
  }
  // TODO: Is it okay to return clear color here? Should it be nullable?
  return [UIColor clearColor];
}

@end

@implementation MDCFilledTextFieldPositioningDelegate

- (CGFloat)assistiveLabelPaddingWithContainerHeight:(CGFloat)containerHeight {
  return (CGFloat)0.13 * containerHeight;
}

- (CGFloat)defaultContainerHeightWithTextHeight:(CGFloat)textHeight {
    return (CGFloat)3.3 * textHeight;
}

- (CGFloat)containerHeightWithTextHeight:(CGFloat)textHeight
                preferredContainerHeight:(CGFloat)preferredContainerHeight {
  if (preferredContainerHeight > 0) {
    return preferredContainerHeight;
  }
  return [self defaultContainerHeightWithTextHeight:textHeight];
}

- (CGFloat)floatingLabelMinYWithTextHeight:(CGFloat)textHeight
                       floatingLabelHeight:(CGFloat)floatingLabelHeight
                  preferredContainerHeight:(CGFloat)preferredContainerHeight {
  CGFloat containerHeight = [self containerHeightWithTextHeight:textHeight
                                       preferredContainerHeight:preferredContainerHeight];
  CGFloat offset = containerHeight * (CGFloat)0.28;
  return offset - ((CGFloat)0.5 * floatingLabelHeight);
}

- (CGFloat)textMinYWithFloatingLabelWithTextHeight:(CGFloat)textHeight
                               floatingLabelHeight:(CGFloat)floatingLabelHeight
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  CGFloat containerHeight = [self containerHeightWithTextHeight:textHeight
                                       preferredContainerHeight:preferredContainerHeight];
  CGFloat offset = containerHeight * (CGFloat)0.64;
  return offset - ((CGFloat)0.5 * textHeight);
}

- (CGFloat)textMinYWithoutFloatingLabelWithTextHeight:(CGFloat)textHeight
                                  floatingLabelHeight:(CGFloat)floatingLabelHeight
                             preferredContainerHeight:(CGFloat)preferredContainerHeight {
  CGFloat containerHeight = [self containerHeightWithTextHeight:textHeight
                                       preferredContainerHeight:preferredContainerHeight];
  CGFloat offset = containerHeight * (CGFloat)0.5;
  return offset - ((CGFloat)0.5 * textHeight);
}



@end
