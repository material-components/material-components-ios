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

static NSString *const kMDCBottomNavigationViewBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationViewBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationViewImageString = @"image";
static NSString *const kMDCBottomNavigationViewTitleString = @"title";
static NSString *const kMDCBottomNavigationViewNewString = @"new";

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
  self.backgroundColor = [UIColor whiteColor];
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
                 forKeyPath:kMDCBottomNavigationViewBadgeColorString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewBadgeValueString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewImageString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewTitleString
                    options:NSKeyValueObservingOptionNew
                    context:nil];

    [self.navBarCells addObject:bottomNavCell];
    [self addSubview:bottomNavCell];
  }

  // Select the first item by default.
  [self.navBarCells.firstObject setSelected:YES];
}

- (void)dealloc {
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewBadgeColorString];
    [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewBadgeValueString];
    [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewImageString];
    [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewTitleString];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if (!context) {
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
    if ([keyPath isEqualToString:kMDCBottomNavigationViewBadgeColorString]) {
      [cell setBadgeColor:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewBadgeValueString]) {
      [cell setBadgeValue:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewImageString]) {
      [cell setImage:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewTitleString]) {
      [cell setTitle:change[kMDCBottomNavigationViewNewString]];
    }
  }
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    if (cell.button != button) {
      [cell setSelected:NO animated:YES];
    }
  }
  MDCBottomNavigationCell *cell = (MDCBottomNavigationCell *)button.superview;
  [cell setSelected:YES animated:YES];
}

- (void)selectItem:(UITabBarItem *)item {
  NSInteger i = 0;
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    if (item == tabBarItem) {
      [self.navBarCells[i] setSelected:YES];
    } else {
      [self.navBarCells[i] setSelected:NO];
    }
    i++;
  }
}

@end
