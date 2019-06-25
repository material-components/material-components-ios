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
    itemView.iconImageView.image = item.image;
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
