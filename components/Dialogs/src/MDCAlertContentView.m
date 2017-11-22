/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCAlertContentView.h"

@implementation MDCAlertContentView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCAlertContentViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCAlertContentViewInit];
  }
  return self;
}

- (void)commonMDCAlertContentViewInit {
  self.backgroundColor = [UIColor whiteColor];
  
  self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.textAlignment = NSTextAlignmentNatural;
  
  self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.messageLabel.numberOfLines = 0;
  self.messageLabel.textAlignment = NSTextAlignmentNatural;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
  _titleLabelColor = titleLabelColor;
  self.titleLabel.textColor = _titleLabelColor;
}

- (void)setMessageLabelColor:(UIColor *)messageLabelColor {
  _messageLabelColor = messageLabelColor;
  self.messageLabel.textColor = _messageLabelColor;
}

@end
