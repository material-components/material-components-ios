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

#import "MDCTabBarView.h"
#import "private/MDCTabBarViewItemView.h"

// KVO contexts
static char *const kKVOContextMDCTabBarView = "kKVOContextMDCTabBarView";

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

static NSString *const kImageKeyPath = @"image";
static NSString *const kTitleKeyPath = @"title";

@interface MDCTabBarView ()

/** The views representing the items of this tab bar. */
@property(nonnull, nonatomic, strong) NSArray<UIView *> *itemViews;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

@end

@implementation MDCTabBarView

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _items = @[];
    _itemViews = @[];
    _stateToTitleColor = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)dealloc {
  [self removeObserversFromTabBarItems];
}

#pragma mark - Properties

- (void)setBarTintColor:(UIColor *)barTintColor {
  self.backgroundColor = barTintColor;
}

- (UIColor *)barTintColor {
  return self.backgroundColor;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  NSParameterAssert(items);

  if (self.items == items || [self.items isEqual:items]) {
    return;
  }

  [self removeObserversFromTabBarItems];

  for (UIView *itemView in self.itemViews) {
    [itemView removeFromSuperview];
  }

  _items = [items copy];

  NSMutableArray<UIView *> *itemViews = [NSMutableArray array];
  for (UITabBarItem *item in self.items) {
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
    // TODO(#7645): Remove this if autoresizing masks are used.
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.titleLabel.text = item.title;
    itemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
    itemView.iconImageView.image = item.image;
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)];
    [itemView addGestureRecognizer:tapGesture];
    [itemViews addObject:itemView];
    [self addSubview:itemView];
  }
  _itemViews = [itemViews copy];

  // Determine new selected item, defaulting to nil.
  UITabBarItem *newSelectedItem = nil;
  if (self.selectedItem && [self.items containsObject:self.selectedItem]) {
    // Previously-selected item still around: Preserve selection.
    newSelectedItem = self.selectedItem;
  }

  self.selectedItem = newSelectedItem;

  [self addObserversToTabBarItems];
  [self setNeedsLayout];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  if (self.selectedItem == selectedItem) {
    return;
  }

  // Handle setting to `nil` without passing it to the nonnull parameter in `indexOfObject:`
  if (!selectedItem) {
    _selectedItem = selectedItem;
    [self updateTitleColorForAllViews];
    return;
  }

  NSUInteger itemIndex = [self.items indexOfObject:selectedItem];
  // Don't crash, just ignore if `selectedItem` isn't present in `_items`. This is the same behavior
  // as UITabBar.
  if (itemIndex == NSNotFound) {
    return;
  }

  _selectedItem = selectedItem;
  if (itemIndex == NSNotFound) {
    return;
  }

  UIView *itemView = self.itemViews[itemIndex];
  if ([itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
    MDCTabBarViewItemView *selectedItemView = (MDCTabBarViewItemView *)itemView;
    selectedItemView.iconImageView.image = selectedItem.image;
  }

  [self updateTitleColorForAllViews];
}

#pragma mark - Key-Value Observing (KVO)

- (void)addObserversToTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item addObserver:self
           forKeyPath:kImageKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
    [item addObserver:self
           forKeyPath:kTitleKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item removeObserver:self forKeyPath:kImageKeyPath context:kKVOContextMDCTabBarView];
    [item removeObserver:self forKeyPath:kTitleKeyPath context:kKVOContextMDCTabBarView];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (context == kKVOContextMDCTabBarView) {
    if (!object) {
      return;
    }
    NSUInteger indexOfObject = [self.items indexOfObject:object];
    if (indexOfObject == NSNotFound) {
      return;
    }
    // Don't try to update custom views
    UIView *updatedItemView = self.itemViews[indexOfObject];
    if (![updatedItemView isKindOfClass:[MDCTabBarViewItemView class]]) {
      return;
    }
    MDCTabBarViewItemView *tabBarItemView = (MDCTabBarViewItemView *)updatedItemView;

    if ([keyPath isEqualToString:kImageKeyPath]) {
      tabBarItemView.iconImageView.image = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kTitleKeyPath]) {
      tabBarItemView.titleLabel.text = change[NSKeyValueChangeNewKey];
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  [self updateTitleColorForAllViews];
}

- (void)updateTitleColorForAllViews {
  for (UITabBarItem *item in self.items) {
    NSUInteger indexOfItem = [self.items indexOfObject:item];
    // This is a significant error, but defensive coding is preferred.
    if (indexOfItem == NSNotFound || indexOfItem >= self.itemViews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.itemViews[indexOfItem];
    // Skip custom views
    if (![itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
      continue;
    }
    MDCTabBarViewItemView *tabBarViewItemView = (MDCTabBarViewItemView *)itemView;
    if (item == self.selectedItem) {
      tabBarViewItemView.titleLabel.textColor = [self titleColorForState:UIControlStateSelected];
    } else {
      tabBarViewItemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
    }
  }
}

- (void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state {
  self.stateToTitleColor[@(state)] = titleColor;
  [self updateTitleColorForAllViews];
}

- (UIColor *)titleColorForState:(UIControlState)state {
  UIColor *titleColor = self.stateToTitleColor[@(state)];
  if (!titleColor) {
    titleColor = self.stateToTitleColor[@(UIControlStateNormal)];
  }
  return titleColor;
}

#pragma mark - UIView

// TODO(#7645): Temporary layout until
// https://github.com/material-components/material-components-ios/issues/7645 lands
- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.items.count == 0) {
    return;
  }
  CGSize boundsSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  CGSize itemSize = CGSizeMake(boundsSize.width / self.items.count, boundsSize.height);

  CGPoint itemOrigin = CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds));
  for (UIView *itemView in self.itemViews) {
    itemView.frame = CGRectMake(itemOrigin.x, itemOrigin.y, itemSize.width, itemSize.height);
    itemOrigin = CGPointMake(itemOrigin.x + itemSize.width, itemOrigin.y);
  }
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(UIViewNoIntrinsicMetric, kMinHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, MAX(size.height, kMinHeight));
}

#pragma mark - Actions

- (void)didTapItemView:(UITapGestureRecognizer *)tap {
  NSUInteger index = [self.itemViews indexOfObject:tap.view];
  if (index == NSNotFound) {
    return;
  }
  self.selectedItem = self.items[index];
}

@end
