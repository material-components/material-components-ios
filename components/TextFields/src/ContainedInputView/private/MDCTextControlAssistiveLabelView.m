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

#import "MDCTextControlAssistiveLabelView.h"

@interface MDCTextControlAssistiveLabelView ()
@property(nonatomic, strong) UILabel *leftAssistiveLabel;
@property(nonatomic, strong) UILabel *rightAssistiveLabel;
@end

@implementation MDCTextControlAssistiveLabelView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTextControlAssistiveLabelViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCTextControlAssistiveLabelViewInit];
  }
  return self;
}

- (void)commonMDCTextControlAssistiveLabelViewInit {
  self.leftAssistiveLabel = [[UILabel alloc] init];
  self.leftAssistiveLabel.numberOfLines = 0;
  [self addSubview:self.leftAssistiveLabel];
  self.rightAssistiveLabel = [[UILabel alloc] init];
  self.rightAssistiveLabel.numberOfLines = 0;
  [self addSubview:self.rightAssistiveLabel];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.leftAssistiveLabel.frame = self.layout.leftAssistiveLabelFrame;
  self.leftAssistiveLabel.hidden = self.layout == nil;
  self.rightAssistiveLabel.frame = self.layout.rightAssistiveLabelFrame;
  self.rightAssistiveLabel.hidden = self.layout == nil;
}

@end
