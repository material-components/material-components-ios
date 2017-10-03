/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCBottomNavigationItem.h"

#import "private/MDCBottomNavigationCell.h"

@interface MDCBottomNavigationItem ()

@property(nonatomic, strong) MDCBottomNavigationCell *bottomNavCell;

@end

@implementation MDCBottomNavigationItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag {
  self = [super initWithTitle:title image:image tag:tag];
  if (self) {
    [self commonMDCBottomNavigationItemInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationItemInit {
  _bottomNavCell =
      [[MDCBottomNavigationCell alloc] initWithFrame:_frame title:self.title image:self.image];
  _selected = NO;
}

- (void)setFrame:(CGRect)frame {
  _frame = frame;
  _bottomNavCell.frame = frame;
}

- (void)setTitle:(NSString *)title {
  [super setTitle:title];
  _bottomNavCell.title = title;
}

- (void)setImage:(UIImage *)image {
  [super setImage:image];
  _bottomNavCell.image = image;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  [super setBadgeValue:badgeValue];
  _bottomNavCell.badgeValue = badgeValue;
}

- (void)setSelected:(BOOL)selected {
  _selected = selected;
  _bottomNavCell.selected = selected;
}

- (void)addToView:(UIView *)view {
  [view addSubview:_bottomNavCell];
}

@end
