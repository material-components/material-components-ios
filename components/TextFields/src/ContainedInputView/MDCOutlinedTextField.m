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

#import "private/MDCBaseTextField+ContainedInputView.h"
#import "private/MDCContainedInputView.h"
#import "private/MDCContainedInputViewStyleOutlined.h"

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
  self.containerStyle = [[MDCContainedInputViewStyleOutlined alloc] init];
  self.borderStyle = UITextBorderStyleNone;
}

#pragma mark Stateful Color APIs

- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelOutlined class]]) {
    MDCContainedInputViewColorViewModelOutlined *outlinedColorViewModel =
        (MDCContainedInputViewColorViewModelOutlined *)colorViewModel;
    outlinedColorViewModel.outlineColor = outlineColor;
  }
}

- (nonnull UIColor *)outlineColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  id<MDCContainedInputViewColorViewModel> colorViewModel =
      [self containedInputViewColorSchemingForState:containedInputViewState];
  if ([colorViewModel isKindOfClass:[MDCContainedInputViewColorViewModelOutlined class]]) {
    MDCContainedInputViewColorViewModelOutlined *outlinedColorViewModel =
        (MDCContainedInputViewColorViewModelOutlined *)colorViewModel;
    return outlinedColorViewModel.outlineColor;
  }
  return [UIColor clearColor];
}

@end
