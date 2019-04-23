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

#import "MDCContainedInputUnderlineLabelView.h"
#import "MDCContainedInputUnderlineLabelViewLayout.h"

@interface MDCContainedInputUnderlineLabelView ()
@property(nonatomic, strong) UILabel *leftUnderlineLabel;
@property(nonatomic, strong) UILabel *rightUnderlineLabel;
@end

@implementation MDCContainedInputUnderlineLabelView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCContainedInputUnderlineLabelViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCContainedInputUnderlineLabelViewInit];
  }
  return self;
}

- (void)commonMDCContainedInputUnderlineLabelViewInit {
  self.leftUnderlineLabel = [[UILabel alloc] init];
  self.rightUnderlineLabel = [[UILabel alloc] init];
  [self addSubview:self.leftUnderlineLabel];
  [self addSubview:self.rightUnderlineLabel];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.layout) {
    self.leftUnderlineLabel.frame = self.layout.leftUnderlineLabelFrame;
    self.rightUnderlineLabel.frame = self.layout.rightUnderlineLabelFrame;
    self.leftUnderlineLabel.hidden = NO;
    self.rightUnderlineLabel.hidden = NO;
  } else {
    self.leftUnderlineLabel.hidden = YES;
    self.rightUnderlineLabel.hidden = YES;
  }
}

@end
