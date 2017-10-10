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
#import "private/MDCBottomNavigationItemView.h"

static const CGFloat kMDCBottomNavigationBarHeight = 72.f;
static NSString *const kMDCBottomNavigationBarBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationBarBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationBarImageString = @"image";
static NSString *const kMDCBottomNavigationBarTitleString = @"title";
static NSString *const kMDCBottomNavigationBarNewString = @"new";

@interface MDCBottomNavigationBar ()

@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
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
  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];
  _titleHideState = MDCBottomNavigationBarTitleHideStateDefault;
  _containerView = [[UIView alloc] initWithFrame:CGRectZero];
  [self addSubview:_containerView];
  _itemViews = [NSMutableArray array];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Accommodate bottom inset for iPhone X.
  CGFloat bottomInset = 0;
  if (@available(iOS 11.0, *)) {
    bottomInset = self.safeAreaInsets.bottom;
  }

  CGRect superViewRect = self.superview.bounds;
  CGFloat heightWithInset = kMDCBottomNavigationBarHeight + bottomInset;

  self.frame = CGRectMake(0, 0, CGRectGetWidth(superViewRect), heightWithInset);
  self.center = CGPointMake(CGRectGetWidth(superViewRect) / 2,
                            CGRectGetHeight(superViewRect) - heightWithInset / 2);

  // The bottom navigation bar always spans the width of the device. However, the container view
  // that holds the items has a fixed width based on the device's portrait view width. This allows
  // the items to have a consistent distance from one another independent of device orientation.
  CGFloat itemContainerWidth = MIN(CGRectGetWidth(superViewRect), CGRectGetHeight(superViewRect));
  CGFloat containerOffsetY = (CGRectGetWidth(self.bounds) - itemContainerWidth) / 2;
  _containerView.frame =
      CGRectMake(containerOffsetY, 0, itemContainerWidth, kMDCBottomNavigationBarHeight);
  _containerView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin);

  [self layoutitemViewsWithLayoutDirection:self.mdc_effectiveUserInterfaceLayoutDirection];
}

- (void)layoutitemViewsWithLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  NSInteger numItems = self.items.count;
  CGSize navBarSize = self.containerView.bounds.size;
  CGFloat itemWidth = navBarSize.width / numItems;
  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
      itemView.frame = CGRectMake(i * itemWidth, 0, itemWidth, navBarSize.height);
    } else {
      itemView.frame =
          CGRectMake(navBarSize.width - (i + 1) * itemWidth, 0,  itemWidth, navBarSize.height);
    }
  }
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  if (_items == items) {
    return;
  }
  NSAssert(items.count >= 3, @"Need to have at least 3 items in navigation bar.");
  NSAssert(items.count <= 5, @"Navigation bar has a maximum of 5 items.");

  _items = items;

  [self removeBottomNavigationitemViews];
  [self removeObserversFromTabBarItems];

  for (UITabBarItem *item in items) {
    MDCBottomNavigationItemView *itemView =
        [[MDCBottomNavigationItemView alloc] initWithFrame:CGRectZero];
    itemView.title = item.title;
    itemView.selectedItemTintColor = self.selectedItemTintColor;
    itemView.unselectedItemTintColor = self.unselectedItemTintColor;
    itemView.titleHideState = self.titleHideState;

    if (item.image) {
      itemView.image = item.image;
    }
    if (item.badgeValue) {
      itemView.badgeValue = item.badgeValue;
    }
    if (item.badgeColor) {
      itemView.badgeColor = item.badgeColor;
    }
    itemView.selected = NO;
    [itemView.button addTarget:self
                    action:@selector(didTapButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.itemViews addObject:itemView];
    [self.containerView addSubview:itemView];
  }
  [self addObserversToTabBarItems];
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

- (void)removeBottomNavigationitemViews {
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    [itemView removeFromSuperview];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if (!context) {
    NSInteger selectedItemNum = 0;
    for (NSUInteger i = 0; i < self.items.count; i++) {
      UITabBarItem *item = self.items[i];
      if (object == item) {
        selectedItemNum = i;
        break;
      }
    }
    MDCBottomNavigationItemView *itemView = _itemViews[selectedItemNum];
    if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeColorString]) {
      [itemView setBadgeColor:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeValueString]) {
      [itemView setBadgeValue:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarImageString]) {
      [itemView setImage:change[kMDCBottomNavigationBarNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarTitleString]) {
      [itemView setTitle:change[kMDCBottomNavigationBarNewString]];
    }
  }
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    if (itemView.button != button) {
      [itemView setSelected:NO animated:YES];
    }
  }
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView setSelected:YES animated:YES];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  if (_selectedItem == selectedItem) {
    return;
  }
  _selectedItem = selectedItem;
  for (NSUInteger i = 0; i < self.items.count; i++) {
    UITabBarItem *item = self.items[i];
    if (selectedItem == item) {
      self.itemViews[i].selected = YES;
    } else {
      self.itemViews[i].selected = NO;
    }
  }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.selectedItemTintColor = selectedItemTintColor;
  }
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.unselectedItemTintColor = unselectedItemTintColor;
  }
}

- (void)setTitleHideState:(MDCBottomNavigationBarTitleHideState)titleHideState {
  _titleHideState = titleHideState;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleHideState = titleHideState;
  }
}

@end
