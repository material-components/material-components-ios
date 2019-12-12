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

#import "MDCTextControlColorViewModel.h"

#import <Foundation/Foundation.h>

@implementation MDCTextControlColorViewModel

- (instancetype)initWithState:(MDCTextControlState)state {
  self = [super init];
  if (self) {
    [self setUpColorsWithState:state];
  }
  return self;
}

- (instancetype)init {
  self = [self initWithState:MDCTextControlStateNormal];
  if (self) {
  }
  return self;
}

- (void)setUpColorsWithState:(MDCTextControlState)state {
  UIColor *textColor = [UIColor blackColor];
  UIColor *floatingLabelColor = [UIColor blackColor];
  UIColor *normalLabelColor = [UIColor darkGrayColor];
  UIColor *leadingAssistiveLabelColor = [UIColor darkGrayColor];
  UIColor *trailingAssistiveLabelColor = [UIColor darkGrayColor];

#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    textColor = [UIColor labelColor];
    floatingLabelColor = [UIColor labelColor];
    normalLabelColor = [UIColor labelColor];
    leadingAssistiveLabelColor = [UIColor labelColor];
    trailingAssistiveLabelColor = [UIColor labelColor];
  }
#endif

  CGFloat disabledAlpha = (CGFloat)0.60;
  switch (state) {
    case MDCTextControlStateNormal:
      break;
    case MDCTextControlStateEditing:
      break;
    case MDCTextControlStateDisabled:
      textColor = [textColor colorWithAlphaComponent:disabledAlpha];
      floatingLabelColor = [floatingLabelColor colorWithAlphaComponent:disabledAlpha];
      normalLabelColor = [normalLabelColor colorWithAlphaComponent:disabledAlpha];
      leadingAssistiveLabelColor =
          [leadingAssistiveLabelColor colorWithAlphaComponent:disabledAlpha];
      trailingAssistiveLabelColor =
          [trailingAssistiveLabelColor colorWithAlphaComponent:disabledAlpha];
      break;
  }
  self.textColor = textColor;
  self.floatingLabelColor = floatingLabelColor;
  self.normalLabelColor = normalLabelColor;
  self.leadingAssistiveLabelColor = leadingAssistiveLabelColor;
  self.trailingAssistiveLabelColor = trailingAssistiveLabelColor;
}

@end
