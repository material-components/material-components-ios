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

#import "MDCOutlinedInputChipView.h"

#import <Foundation/Foundation.h>

#import "private/MDCBaseInputChipView+MDCContainedInputView.h"
#import "private/MDCContainedInputView.h"
#import "private/MDCContainedInputViewStyleOutlined.h"

@interface MDCOutlinedInputChipView ()
@end

@implementation MDCOutlinedInputChipView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCOutlinedInputChipViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCOutlinedInputChipViewInit];
  }
  return self;
}

- (void)commonMDCOutlinedInputChipViewInit {
  MDCContainedInputViewStyleOutlined *outlinedStyle =
      [[MDCContainedInputViewStyleOutlined alloc] init];
  self.containerStyle = outlinedStyle;
}

#pragma mark Stateful Color APIs

- (void)setOutlineColor:(nonnull UIColor *)outlineColor forState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  [self.outlinedStyle setOutlineColor:outlineColor forState:containedInputViewState];
  [self setNeedsLayout];
}

- (nonnull UIColor *)outlineColorForState:(UIControlState)state {
  MDCContainedInputViewState containedInputViewState =
      MDCContainedInputViewStateWithUIControlState(state);
  return [self.outlinedStyle outlineColorForState:containedInputViewState];
}

- (MDCContainedInputViewStyleOutlined *)outlinedStyle {
  MDCContainedInputViewStyleOutlined *outlinedStyle = nil;
  if ([self.containerStyle isKindOfClass:[MDCContainedInputViewStyleOutlined class]]) {
    outlinedStyle = (MDCContainedInputViewStyleOutlined *)self.containerStyle;
  }
  return outlinedStyle;
}

@end
