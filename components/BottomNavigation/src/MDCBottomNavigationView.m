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

#import "MDCBottomNavigationView.h"

#import "MDCBottomNavigationItem.h"
#import "private/MDCBottomNavigationCell.h"

@implementation MDCBottomNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationViewInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationViewInit {
  self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  NSInteger numItems = self.navBarItems.count;
  NSInteger i = 0;
  CGFloat itemWidth = self.bounds.size.width / numItems;
  for (MDCBottomNavigationItem *tabBarItem in self.navBarItems) {
    CGRect cellFrame = CGRectMake(i * itemWidth, 0, itemWidth, 72);
    tabBarItem.frame = cellFrame;
    [tabBarItem addToView:self];
    [tabBarItem.cellButton addTarget:self
                              action:@selector(didTapButton:)
                    forControlEvents:UIControlEventTouchUpInside];
    i++;
  }
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationItem *tabBarItem in self.navBarItems) {
    if (tabBarItem.cellButton != button) {
      tabBarItem.selected = NO;
    }
  }
  MDCBottomNavigationCell *cell = (MDCBottomNavigationCell *)button.superview;
  cell.selected = YES;
}

@end
