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

#import "MDCBaseTextArea.h"

#import "private/MDCBaseTextAreaTextView.h"

@interface MDCBaseTextArea ()

@property(strong, nonatomic) MDCBaseTextAreaTextView *textAreaTextView;
@end

@implementation MDCBaseTextArea

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (void)commonMDCBaseTextAreaInit {
  [self setUpTextAreaSpecificSubviews];
  [self observeTextViewNotifications];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)setUpTextAreaSpecificSubviews {
  self.textAreaTextView = [[MDCBaseTextAreaTextView alloc] init];
  self.textAreaTextView.textAreaTextViewDelegate = self;
  [self addSubview:self.textAreaTextView];
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [super layoutSubviews];
  self.textAreaTextView.frame = self.bounds;
}

#pragma mark Responding to text view changes

- (void)textViewChanged:(NSNotification *)notification {
  [self setNeedsLayout];
}

#pragma mark Custom Accessors

- (UITextView *)textView {
  return self.textAreaTextView;
}

#pragma mark InputChipViewTextViewDelegate

- (void)textAreaTextViewWillResignFirstResponder:(BOOL)didBecome {
  [self setNeedsLayout];
}

- (void)textAreaTextViewWillBecomeFirstResponder:(BOOL)didBecome {
  [self setNeedsLayout];
}

#pragma mark Notifications


- (void)observeTextViewNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textViewChanged:)
                                               name:UITextViewTextDidChangeNotification
                                             object:nil];
}

@end
