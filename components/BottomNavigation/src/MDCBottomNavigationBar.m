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

#import "MDCBottomNavigationBar.h"

#import "MaterialMath.h"
#import "MaterialRTL.h"
#import "private/MDCBottomNavigationCell.h"

static NSString *const kMDCBottomNavigationBarBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationBarBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationBarImageString = @"image";
static NSString *const kMDCBottomNavigationBarTitleString = @"title";
static NSString *const kMDCBottomNavigationBarNewString = @"new";

@interface MDCBottomNavigationBar ()

@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationCell *> *cells;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
@property(nonatomic, strong) UIView *containerView;

@end

@implementation MDCBottomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationBarInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationBarInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationBarInit {
  self.backgroundColor = [UIColor whiteColor];
  self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
  
  _selectedColor = [UIColor blackColor];
  _unselectedColor = [UIColor grayColor];
  _layoutDirection = self.mdc_effectiveUserInterfaceLayoutDirection;
  _titleHideState = MDCBottomNavigationBarTitleHideStateDefault;

  // Content in bottom navigation always uses the width of the device portrait orientation width.
  CGSize appSize = [[UIScreen mainScreen] applicationFrame].size;
  CGFloat minDimension = MIN(appSize.width, appSize.height);
  CGRect adjustedFrame = CGRectMake(0, 0, minDimension, self.frame.size.height);
  _containerView = [[UIView alloc] initWithFrame:adjustedFrame];
  _containerView.autoresizingMask = (UIViewAutoresizingFlexibleHeight |
                                           UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin );
  [self addSubview:_containerView];
  _cells = [NSMutableArray array];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self layoutCellsWithLayoutDirection:self.layoutDirection];
  self.containerView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                CGRectGetMidY(self.bounds));
}

- (void)layoutCellsWithLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  NSInteger numItems = self.items.count;
  NSInteger i = 0;
  CGSize navBarSize = self.containerView.bounds.size;
  CGFloat itemWidth = navBarSize.width / numItems;
  if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    for (MDCBottomNavigationCell *cell in self.cells) {
      cell.frame = CGRectMake(navBarSize.width - (i + 1) * itemWidth,
                              0,
                              itemWidth,
                              navBarSize.height);
      i++;
    }
  } else {
    for (MDCBottomNavigationCell *cell in self.cells) {
      cell.frame = CGRectMake(i * itemWidth,
                              0,
                              itemWidth,
                              navBarSize.height);
      i++;
    }
  }
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  if (_items == items) {
    return;
  }
  NSAssert(items.count > 2, @"Need to have at least 3 items in navigation bar.");
  NSAssert(items.count < 6, @"Navigation bar has a maximum of 5 items.");

  _items = items;

  [self removeBottomNavigationCells];
  [self removeObserversFromTabBarItems];

  for (UITabBarItem *item in items) {
    MDCBottomNavigationCell *cell = [[MDCBottomNavigationCell alloc] initWithFrame:CGRectZero];
    cell.title = item.title;
    cell.selectedColor = self.selectedColor;
    cell.unselectedColor = self.unselectedColor;
    cell.titleHideState = self.titleHideState;

    if (item.image) {
      cell.image = item.image;
    }
    if (item.badgeValue) {
      cell.badgeValue = item.badgeValue;
    }
    if (item.badgeColor) {
      cell.badgeColor = item.badgeColor;
    }
    cell.selected = NO;
    [cell.button addTarget:self
                    action:@selector(didTapButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.cells addObject:cell];
    [self.containerView addSubview:cell];
  }
  [self addObserversToTabBarItems];

  // Select the first item by default.
  [self.cells.firstObject setSelected:YES];
}

- (void)dealloc {
  [self removeObserversFromTabBarItems];
}

- (void)addObserversToTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarBadgeColorString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarBadgeValueString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarTitleString
              options:NSKeyValueObservingOptionNew
              context:nil];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    @try {
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeColorString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeValueString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarImageString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarTitleString];
    }
    @catch (NSException *exception) {
      if (exception) {
        // No need to do anything if there are no observers.
      }
    }
  }
}

- (void)removeBottomNavigationCells {
  for (MDCBottomNavigationCell *cell in self.cells) {
    [cell removeFromSuperview];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if (!context) {
    NSInteger i = 0;
    NSInteger selectedItemNum = 0;
    for (UITabBarItem *item in self.items) {
      if (object == item) {
        selectedItemNum = i;
        break;
      }
      i++;
    }
    MDCBottomNavigationCell *cell = _cells[selectedItemNum];
    if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeColorString]) {
      [cell setBadgeColor:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeValueString]) {
      [cell setBadgeValue:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarImageString]) {
      [cell setImage:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarTitleString]) {
      [cell setTitle:change[kMDCBottomNavigationBarNewString]];
    }
  }
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationCell *cell in self.cells) {
    if (cell.button != button) {
      [cell setSelected:NO animated:YES];
    }
  }
  MDCBottomNavigationCell *cell = (MDCBottomNavigationCell *)button.superview;
  [cell setSelected:YES animated:YES];
}

- (void)selectItem:(UITabBarItem *)item {
  NSInteger i = 0;
  for (UITabBarItem *tabBarItem in self.items) {
    if (item == tabBarItem) {
      [self.cells[i] setSelected:YES];
    } else {
      [self.cells[i] setSelected:NO];
    }
    i++;
  }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
  _selectedColor = selectedColor;
  for (MDCBottomNavigationCell *cell in self.cells) {
    cell.selectedColor = selectedColor;
  }
}

- (void)setUnselectedColor:(UIColor *)unselectedColor {
  _unselectedColor = unselectedColor;
  for (MDCBottomNavigationCell *cell in self.cells) {
    cell.unselectedColor = unselectedColor;
  }
}

- (void)setTitleHideState:(MDCBottomNavigationBarTitleHideState)titleHideState {
  _titleHideState = titleHideState;
  for (MDCBottomNavigationCell *cell in self.cells) {
    cell.titleHideState = titleHideState;
  }
}

@end
