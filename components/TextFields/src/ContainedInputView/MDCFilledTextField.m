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

#import "private/MDCBaseTextField+ContainedInputView.h"
#import "private/MDCContainedInputView.h"
#import "private/MDCContainedInputViewStyleFilled.h"

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
  self.containerStyle = [[MDCContainedInputViewStyleFilled alloc] init];
  self.borderStyle = UITextBorderStyleNone;
}

#pragma mark Stateful Color APIs

- (void)setFilledBackgroundColor:(nonnull UIColor *)filledBackgroundColor
                        forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelFilled class]]) {
    MDCContainedInputViewColorViewModelFilled *filledColorViewModel =
        (MDCContainedInputViewColorViewModelFilled *)colorViewModel;
    filledColorViewModel.filledSublayerFillColor = filledBackgroundColor;
  }
  [self setNeedsLayout];
}

- (nonnull UIColor *)filledBackgroundColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelFilled class]]) {
    MDCContainedInputViewColorViewModelFilled *filledColorViewModel =
        (MDCContainedInputViewColorViewModelFilled *)colorViewModel;
    return filledColorViewModel.filledSublayerFillColor;
  }
  // TODO: Is it okay to return clear color here? Should it be nullable?
  return [UIColor clearColor];
}

- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelFilled class]]) {
    MDCContainedInputViewColorViewModelFilled *filledColorViewModel =
        (MDCContainedInputViewColorViewModelFilled *)colorViewModel;
    filledColorViewModel.thinUnderlineFillColor = underlineColor;
    filledColorViewModel.thickUnderlineFillColor = underlineColor;
    // TODO: Explore setting either the thick or thin depending on the state!
  }
  [self setNeedsLayout];
}

- (nonnull UIColor *)underlineColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelFilled class]]) {
    MDCContainedInputViewColorViewModelFilled *filledColorViewModel =
        (MDCContainedInputViewColorViewModelFilled *)colorViewModel;
    return filledColorViewModel.thinUnderlineFillColor;
    //    return filledColorViewModel.thickUnderlineFillColor;
    // TODO: Determine which one of these you should actually return!
  }
  // TODO: Is it okay to return clear color here? Should it be nullable?
  return [UIColor clearColor];
}

@end
