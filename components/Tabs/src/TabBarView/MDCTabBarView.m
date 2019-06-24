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

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

static NSString *const kImageString = @"image";
static NSString *const kSelectedImageString = @"selectedImage";
static NSString *const kTitleString = @"title";

@interface MDCTabBarView ()

/** The views representing the items of this tab bar. */
@property(nonatomic, strong) NSArray<UIView *> *itemViews;

@end

@implementation MDCTabBarView

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _items = @[];
    _itemViews = @[];
  }
  return self;
}

#pragma mark - Properties

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
    itemView.title = item.title;
    itemView.image = item.image;
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

  NSUInteger itemIndex = [self.items indexOfObject:selectedItem];
  if (selectedItem && (itemIndex == NSNotFound)) {
    NSString *itemTitle = selectedItem.title;
    NSString *exceptionMessage =
        [NSString stringWithFormat:@"%@ is not a member of the tab bar's `items`.", itemTitle];
    [[NSException exceptionWithName:NSInvalidArgumentException reason:exceptionMessage
                           userInfo:nil] raise];
  }

  _selectedItem = selectedItem;
  UIView *itemView = self.itemViews[itemIndex];
  if ([itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
    MDCTabBarViewItemView *selectedItemView = (MDCTabBarViewItemView *)itemView;
    selectedItemView.image = selectedItem.selectedImage ?: selectedItem.image;
  }
}

#pragma mark - Key-Value Observing (KVO)

- (void)addObserversToTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item addObserver:self
           forKeyPath:kImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kSelectedImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kTitleString
              options:NSKeyValueObservingOptionNew
              context:nil];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    @try {
      [item removeObserver:self forKeyPath:kImageString];
      [item removeObserver:self forKeyPath:kSelectedImageString];
      [item removeObserver:self forKeyPath:kTitleString];
    } @catch (NSException *exception) {
      if (exception) {
        // No need to do anything if there are no observers.
      }
    }
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
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
    // Don't try to update custom views
    UIView *itemView = self.itemViews[selectedItemNum];
    if (![itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
      return;
    }
    MDCTabBarViewItemView *tabBarItemView = (MDCTabBarViewItemView *)itemView;

    if ([keyPath isEqualToString:kImageString]) {
      tabBarItemView.image = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kSelectedImageString] && self.selectedItem == object) {
      tabBarItemView.image = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kTitleString]) {
      tabBarItemView.title = change[NSKeyValueChangeNewKey];
    }
  }
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

@end
