// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCUnderlinedTextField.h"

#import <Foundation/Foundation.h>

#import "MaterialTextControlsPrivate+Shared.h"
#import "MaterialTextControlsPrivate+TextFields.h"
#import "MaterialTextControlsPrivate+UnderlinedStyle.h"

@interface MDCUnderlinedTextField (Private) <MDCTextControl>
@end

@implementation MDCUnderlinedTextField
@dynamic borderStyle;

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCUnderlinedTextFieldInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCUnderlinedTextFieldInit];
  }
  return self;
}

- (void)commonMDCUnderlinedTextFieldInit {
  self.containerStyle = [[MDCTextControlStyleUnderlined alloc] init];
}

- (MDCTextControlTextFieldSideViewAlignment)sideViewAlignment {
  return MDCTextControlTextFieldSideViewAlignmentAlignedWithText;
}

#pragma mark Stateful Color APIs

- (void)setUnderlineColor:(UIColor *)underlineColor forState:(MDCTextControlState)state {
  [self.underlinedStyle setUnderlineColor:underlineColor forState:state];
  [self setNeedsLayout];
}

- (UIColor *)underlineColorForState:(MDCTextControlState)state {
  return [self.underlinedStyle underlineColorForState:state];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark Private Helpers

- (MDCTextControlStyleUnderlined *)underlinedStyle {
  MDCTextControlStyleUnderlined *underlinedStyle = nil;
  if ([self.containerStyle isKindOfClass:[MDCTextControlStyleUnderlined class]]) {
    underlinedStyle = (MDCTextControlStyleUnderlined *)self.containerStyle;
  }
  return underlinedStyle;
}

@end
