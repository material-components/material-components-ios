// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "CardTintExampleCell.h"

#import "MaterialCards.h"

@implementation CardTintExampleCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    _switchView = [[UISwitch alloc] init];
    [self.contentView addSubview:_switchView];
    _sliderView = [[UISlider alloc] init];
    [self.contentView addSubview:_sliderView];
    self.selectable = true;
    UIImage *img = [[self imageForState:MDCCardCellStateSelected] copy];
    [self setImage:img forState:MDCCardCellStateNormal];

    [self setImageTintColor:[UIColor blueColor] forState:MDCCardCellStateNormal];
    [self setImageTintColor:[UIColor blueColor] forState:MDCCardCellStateSelected];
    [self setInteractable:NO];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _switchView.center = CGPointMake(self.contentView.center.x, _switchView.bounds.size.height);
  _sliderView.center = CGPointMake(self.contentView.center.x,
                                   self.bounds.size.height - _sliderView.bounds.size.height);
}

@end
