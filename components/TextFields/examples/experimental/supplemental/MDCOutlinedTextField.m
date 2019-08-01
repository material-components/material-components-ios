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

#import "MDCOutlinedTextField.h"

#import <Foundation/Foundation.h>

#import "MDCBaseTextField+Private.h"
#import "MDCContainedInputView.h"
#import "MDCContainerStylerOutlined.h"

@interface MDCOutlinedTextFieldPositioningDelegate
    : NSObject <MDCContainedInputViewStylerPositioningDelegate>
@end

@interface MDCOutlinedTextField ()
@end

@implementation MDCOutlinedTextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCOutlinedTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCOutlinedTextFieldInit];
  }
  return self;
}

- (void)commonMDCOutlinedTextFieldInit {
  MDCContainerStylerOutlined *outlinedStyle =
      [[MDCContainerStylerOutlined alloc] init];
  self.containerStyler = outlinedStyle;
}

#pragma mark Stateful Color APIs

- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeOutlined class]]) {
    MDCContainedInputViewColorSchemeOutlined *outlinedColorScheme =
        (MDCContainedInputViewColorSchemeOutlined *)colorScheme;
    outlinedColorScheme.outlineColor = outlineColor;
  }
}

- (nonnull UIColor *)outlineColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorScheme isKindOfClass:[MDCContainedInputViewColorSchemeOutlined class]]) {
    MDCContainedInputViewColorSchemeOutlined *outlinedColorScheme =
        (MDCContainedInputViewColorSchemeOutlined *)colorScheme;
    return outlinedColorScheme.outlineColor;
  }
  return [UIColor clearColor];
}

@end

@implementation MDCOutlinedTextFieldPositioningDelegate

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
  return 0 - ((CGFloat)0.5 * floatingLabelHeight);
}

- (CGFloat)textMinYWithFloatingLabelWithTextHeight:(CGFloat)textHeight
                               floatingLabelHeight:(CGFloat)floatingLabelHeight
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  CGFloat containerHeight = [self containerHeightWithTextHeight:textHeight
                                       preferredContainerHeight:preferredContainerHeight];
  CGFloat offset = containerHeight * (CGFloat)0.5;
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
