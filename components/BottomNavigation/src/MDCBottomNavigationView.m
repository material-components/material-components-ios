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

#import "private/MDCBottomNavigationCell.h"

@interface MDCBottomNavigationView ()

@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationCell *> *navBarCells;

@end


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
  _navBarCells = [NSMutableArray array];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  NSInteger numItems = self.navBarItems.count;
  NSInteger i = 0;
  CGFloat itemWidth = self.bounds.size.width / numItems;
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    CGRect cellFrame = CGRectMake(i * itemWidth, 0, itemWidth, 72);
    cell.frame = cellFrame;
    i++;
  }
}

- (void)setNavBarItems:(NSArray<UITabBarItem *> *)navBarItems {
  _navBarItems = navBarItems;

  for (UITabBarItem *tabBarItem in navBarItems) {
    MDCBottomNavigationCell *bottomNavCell =
        [[MDCBottomNavigationCell alloc] initWithFrame:CGRectZero];
    bottomNavCell.title = tabBarItem.title;
    bottomNavCell.image = tabBarItem.image;
    bottomNavCell.badgeValue = tabBarItem.badgeValue;
    bottomNavCell.selected = NO;
    [bottomNavCell.button addTarget:self
                             action:@selector(didTapButton:)
                   forControlEvents:UIControlEventTouchUpInside];

    [tabBarItem addObserver:self
                 forKeyPath:@"badgeColor"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:@"badgeValue"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:@"image"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:@"title"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    
    [_navBarCells addObject:bottomNavCell];
    [self addSubview:bottomNavCell];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  NSInteger i = 0;
  NSInteger selectedItemNum = 0;
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    if (object == tabBarItem) {
      selectedItemNum = i;
      break;
    }
    i++;
  }

  MDCBottomNavigationCell *cell = _navBarCells[selectedItemNum];
  if ([keyPath isEqualToString:@"badgeColor"]) {
    [cell setBadgeColor:change[@"new"]];
  } else if ([keyPath isEqualToString:@"badgeValue"]) {
    [cell setBadgeValue:change[@"new"]];
  } else if ([keyPath isEqualToString:@"image"]) {
    [cell setImage:change[@"new"]];
  } else if ([keyPath isEqualToString:@"title"]) {
    [cell setTitle:change[@"new"]];
  }

  NSLog(@"%@", context);
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    if (cell.button != button) {
      cell.selected = NO;
    }
  }
  MDCBottomNavigationCell *cell = (MDCBottomNavigationCell *)button.superview;
  cell.selected = YES;
}

@end
