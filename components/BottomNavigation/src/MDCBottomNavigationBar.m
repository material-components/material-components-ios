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
static const CGFloat kMDCBottomNavigationBarLandscapeContainerWidth = 320.f;
static NSString *const kMDCBottomNavigationBarBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationBarBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationBarImageString = @"image";
static NSString *const kMDCBottomNavigationBarTitleString = @"title";
static NSString *const kMDCBottomNavigationBarNewString = @"new";

@interface MDCBottomNavigationBar ()

@property(nonatomic, assign) BOOL itemsDistributed;
@property(nonatomic, assign) BOOL titleBelowItem;
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
  _landscapeItemMode = MDCBottomNavigationBarLandscapeItemModeDistributeCenteredTitles;
  _itemsDistributed = YES;
  _titleBelowItem = YES;
  _maxLandscapeContainerWidth = kMDCBottomNavigationBarLandscapeContainerWidth;
  _containerView = [[UIView alloc] initWithFrame:CGRectZero];
  _containerView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin);
  [self addSubview:_containerView];
  _itemViews = [NSMutableArray array];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize size = self.bounds.size;
  if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    [self layoutLandscapeModeWithSize:size width:self.maxLandscapeContainerWidth];
  } else {
    [self sizeContainerViewItemsDistributed:YES withSize:size width:size.width];
    [self showTitleBelowItem:YES];
  }
  [self layoutItemViewsWithLayoutDirection:self.mdc_effectiveUserInterfaceLayoutDirection];
}

- (CGSize)sizeThatFits:(CGSize)size {
  UIEdgeInsets insets = [self getUIEdgeInsets];
  CGFloat heightWithInset = kMDCBottomNavigationBarHeight + insets.bottom;
  return CGSizeMake(size.width, heightWithInset);
}

- (void)layoutLandscapeModeWithSize:(CGSize)size width:(CGFloat)width {
  switch (self.landscapeItemMode) {
    case MDCBottomNavigationBarLandscapeItemModeDistributeCenteredTitles:
      [self sizeContainerViewItemsDistributed:YES withSize:size width:width];
      [self showTitleBelowItem:YES];
      break;
    case MDCBottomNavigationBarLandscapeItemModeDistributeAdjacentTitles:
      [self sizeContainerViewItemsDistributed:YES withSize:size width:width];
      [self showTitleBelowItem:NO];
      break;
    case MDCBottomNavigationBarLandscapeItemModeCluster:
      [self sizeContainerViewItemsDistributed:NO withSize:size width:width];
      [self showTitleBelowItem:YES];
      break;
  }
}

- (UIEdgeInsets)getUIEdgeInsets {
  UIEdgeInsets insets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {

    // Accommodate insets for iPhone X.
    insets = self.safeAreaInsets;
  }
#endif
  return insets;
}

- (void)sizeContainerViewItemsDistributed:(BOOL)itemsDistributed
                                 withSize:(CGSize)size
                                    width:(CGFloat)width {
  if (itemsDistributed) {
    UIEdgeInsets insets = [self getUIEdgeInsets];
    self.containerView.frame =
        CGRectMake(insets.left,
                   0,
                   size.width - insets.left - insets.right,
                   kMDCBottomNavigationBarHeight);
  } else {
    CGFloat clusteredOffsetX = (size.width - width) / 2;
    self.containerView.frame = CGRectMake(clusteredOffsetX,
                                          0,
                                          width,
                                          kMDCBottomNavigationBarHeight);
  }
}

- (void)layoutItemViewsWithLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  NSInteger numItems = self.items.count;
  if (numItems == 0) {
    return;
  }
  CGFloat navBarWidth = CGRectGetWidth(self.containerView.bounds);
  CGFloat navBarHeight = CGRectGetHeight(self.containerView.bounds);
  CGFloat itemWidth = navBarWidth / numItems;
  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
      itemView.frame = CGRectMake(i * itemWidth, 0, itemWidth, navBarHeight);
    } else {
      itemView.frame =
          CGRectMake(navBarWidth - (i + 1) * itemWidth, 0,  itemWidth, navBarHeight);
    }
  }
}

- (void)showTitleBelowItem:(BOOL)titleBelowIcon {
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleBelowIcon = titleBelowIcon;
  }
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

#pragma mark - Touch handlers

- (void)didTouchDownButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView setCircleHighlightHidden:NO];
}

- (void)didTouchUpInsideButton:(UIButton *)button {
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    if (itemView.button != button) {
      [itemView setSelected:NO animated:YES];
    }
  }
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView setCircleHighlightHidden:YES];
  [itemView setSelected:YES animated:YES];
}

- (void)didTouchUpOutsideButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView setCircleHighlightHidden:YES];
}

#pragma mark - Setters

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
                        action:@selector(didTouchDownButton:)
              forControlEvents:UIControlEventTouchDown];
    [itemView.button addTarget:self
                        action:@selector(didTouchUpInsideButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [itemView.button addTarget:self
                        action:@selector(didTouchUpOutsideButton:)
              forControlEvents:UIControlEventTouchUpOutside];
    [self.itemViews addObject:itemView];
    [self.containerView addSubview:itemView];
  }
  [self addObserversToTabBarItems];
  [self showTitleBelowItem:self.titleBelowItem];
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

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.itemTitleFont = itemTitleFont;
  }
}

@end
