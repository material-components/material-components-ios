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
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"

MDCContainedInputViewState MDCContainedInputViewStateWithUIControlState(
    UIControlState controlState) {
  if ((controlState & UIControlStateDisabled) == UIControlStateDisabled) {
    return MDCContainedInputViewStateDisabled;
  } else if ((controlState & UIControlStateEditing) == UIControlStateEditing) {
    return MDCContainedInputViewStateFocused;
  } else {
    return MDCContainedInputViewStateNormal;
  }
}

@implementation MDCContainedInputViewColorScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCContainedInputViewColorSchemeInit];
  }
  return self;
}

- (void)commonMDCContainedInputViewColorSchemeInit {
  UIColor *textColor = [UIColor blackColor];
  UIColor *assistiveLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *normalLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  self.textColor = textColor;
  self.assistiveLabelColor = assistiveLabelColor;
  self.floatingLabelColor = floatingLabelColor;
  self.normalLabelColor = normalLabelColor;
  self.placeholderColor = floatingLabelColor;
}

@end
