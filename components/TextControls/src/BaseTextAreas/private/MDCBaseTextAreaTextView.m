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

#import "MDCBaseTextAreaTextView.h"
#import "MDCTextControl.h"

@implementation MDCBaseTextAreaTextView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCBaseTextAreaTextViewInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextAreaTextViewInit];
  }
  return self;
}

- (void)commonMDCBaseTextAreaTextViewInit {
  self.backgroundColor = [UIColor clearColor];
  self.textContainerInset = UIEdgeInsetsZero;
  self.layoutMargins = UIEdgeInsetsZero;
  self.textContainer.lineFragmentPadding = 0;
  self.font = MDCTextControlDefaultUITextFieldFont();
  self.clipsToBounds = NO;
}

- (void)setFont:(UIFont *)font {
  [super setFont:font ?: MDCTextControlDefaultUITextFieldFont()];
}

- (UIFont *)font {
  return [super font] ?: MDCTextControlDefaultUITextFieldFont();
}

- (BOOL)resignFirstResponder {
  BOOL superclassDidResignFirstResponder = [super resignFirstResponder];
  if ([self.textAreaTextViewDelegate respondsToSelector:@selector(textAreaTextViewWillResignFirstResponder:)]) {
    [self.textAreaTextViewDelegate
     textAreaTextViewWillResignFirstResponder:superclassDidResignFirstResponder];
  }
  return superclassDidResignFirstResponder;
}

- (BOOL)becomeFirstResponder {
  BOOL superclassDidBecomeFirstResponder = [super becomeFirstResponder];
  if ([self.textAreaTextViewDelegate respondsToSelector:@selector(textAreaTextViewWillBecomeFirstResponder:)]) {
    [self.textAreaTextViewDelegate
     textAreaTextViewWillBecomeFirstResponder:superclassDidBecomeFirstResponder];
  }
  return superclassDidBecomeFirstResponder;
}

@end
