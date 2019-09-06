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

#import "MDCContainedInputViewColorViewModel.h"

#import <Foundation/Foundation.h>

@implementation MDCContainedInputViewColorViewModel

- (instancetype)initWithState:(MDCContainedInputViewState)state {
  self = [super init];
  if (self) {
    [self setUpColorsWithState:state];
  }
  return self;
}

- (instancetype)init {
  self = [self initWithState:MDCContainedInputViewStateNormal];
  if (self) {
  }
  return self;
}

- (void)setUpColorsWithState:(MDCContainedInputViewState)state {
  UIColor *textColor = [UIColor blackColor];
  UIColor *floatingLabelColor = [UIColor blackColor];
  UIColor *normalLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *assistiveLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateFocused:
      break;
    case MDCContainedInputViewStateDisabled:
      textColor = [textColor colorWithAlphaComponent:(CGFloat)0.60];
      floatingLabelColor = [floatingLabelColor colorWithAlphaComponent:(CGFloat)0.60];
      normalLabelColor = [normalLabelColor colorWithAlphaComponent:(CGFloat)0.60];
      assistiveLabelColor = [assistiveLabelColor colorWithAlphaComponent:(CGFloat)0.60];
      break;
  }
  self.textColor = textColor;
  self.floatingLabelColor = floatingLabelColor;
  self.normalLabelColor = normalLabelColor;
  self.assistiveLabelColor = assistiveLabelColor;
}

@end
