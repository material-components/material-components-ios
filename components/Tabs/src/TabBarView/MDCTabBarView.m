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
#import "MDCTabBarItemCustomViewing.h"
#import "MDCTabBarViewDelegate.h"
#import "private/MDCTabBarViewItemView.h"

#import <CoreGraphics/CoreGraphics.h>
#import <MDFInternationalization/MDFInternationalization.h>

// KVO contexts
static char *const kKVOContextMDCTabBarView = "kKVOContextMDCTabBarView";

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

static NSString *const kImageKeyPath = @"image";
static NSString *const kTitleKeyPath = @"title";
static NSString *const kAccessibilityLabelKeyPath = @"accessibilityLabel";
static NSString *const kAccessibilityHintKeyPath = @"accessibilityHint";
static NSString *const kAccessibilityIdentifierKeyPath = @"accessibilityIdentifier";
static NSString *const kAccessibilityTraitsKeyPath = @"accessibilityTraits";

@interface MDCTabBarView ()

/** The views representing each tab bar item. */
@property(nonnull, nonatomic, copy) NSArray<UIView *> *itemViews;

/** @c YES if the items are laid-out in a justified style. */
@property(nonatomic, readonly) BOOL isJustifiedLayoutStyle;

/** Used to scroll to the selected item during the first call to @c layoutSubviews. */
@property(nonatomic, assign) BOOL initialScrollDone;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

/** The image tint colors for bar items. */
@property(nonnull, nonatomic, strong)
    NSMutableDictionary<NSNumber *, UIColor *> *stateToImageTintColor;

/** The title font for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIFont *> *stateToTitleFont;
@end

@implementation MDCTabBarView
// We're overriding UIScrollViewDelegate's delegate solely to change its type (we don't provide
// a getter or setter implementation), thus the @dynamic.
@dynamic delegate;

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _items = @[];
    _stateToImageTintColor = [NSMutableDictionary dictionary];
    _stateToTitleColor = [NSMutableDictionary dictionary];
    _stateToTitleFont = [NSMutableDictionary dictionary];
    self.backgroundColor = UIColor.whiteColor;
    self.showsHorizontalScrollIndicator = NO;

    // By deafult, inset the content within the safe area. This is generally the desired behavior,
    // but clients can override it if they want.
    if (@available(iOS 11.0, *)) {
      [super setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAlways];
    }
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
  for (UIView *view in self.itemViews) {
    [view removeFromSuperview];
  }

  _items = [items copy];
  NSMutableArray<UIView *> *itemViews = [NSMutableArray array];

  for (UITabBarItem *item in self.items) {
    UIView *itemView;
    if ([item conformsToProtocol:@protocol(MDCTabBarItemCustomViewing)]) {
      UITabBarItem<MDCTabBarItemCustomViewing> *customItem =
          (UITabBarItem<MDCTabBarItemCustomViewing> *)item;
      if (customItem.mdc_customView) {
        itemView = customItem.mdc_customView;
      }
    }
    if (!itemView) {
      MDCTabBarViewItemView *mdcItemView = [[MDCTabBarViewItemView alloc] init];
      mdcItemView.titleLabel.text = item.title;
      mdcItemView.accessibilityLabel = item.accessibilityLabel;
      mdcItemView.accessibilityHint = item.accessibilityHint;
      mdcItemView.accessibilityIdentifier = item.accessibilityIdentifier;
      mdcItemView.accessibilityTraits = item.accessibilityTraits == UIAccessibilityTraitNone
                                            ? UIAccessibilityTraitButton
                                            : item.accessibilityTraits;
      mdcItemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
      mdcItemView.iconImageView.image = item.image;
      itemView = mdcItemView;
    }
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)];
    [itemView addGestureRecognizer:tapGesture];

    [self addSubview:itemView];
    [itemViews addObject:itemView];
  }

  self.itemViews = itemViews;

  // Determine new selected item, defaulting to nil.
  UITabBarItem *newSelectedItem = nil;
  if (self.selectedItem && [self.items containsObject:self.selectedItem]) {
    // Previously-selected item still around: Preserve selection.
    newSelectedItem = self.selectedItem;
  }

  self.selectedItem = newSelectedItem;
  [self addObserversToTabBarItems];

  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  [self setSelectedItem:selectedItem animated:YES];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem animated:(BOOL)animated {
  if (self.selectedItem == selectedItem) {
    return;
  }

  // Sets the old selected item view's traits back.
  NSUInteger oldSelectedItemIndex = [self.items indexOfObject:self.selectedItem];
  if (oldSelectedItemIndex != NSNotFound) {
    UIView *oldSelectedItemView = self.itemViews[oldSelectedItemIndex];
    oldSelectedItemView.accessibilityTraits =
        (oldSelectedItemView.accessibilityTraits & ~UIAccessibilityTraitSelected);
  }

  // Handle setting to `nil` without passing it to the nonnull parameter in `indexOfObject:`
  if (!selectedItem) {
    _selectedItem = selectedItem;
    [self updateTitleColorForAllViews];
    [self updateImageTintColorForAllViews];
    [self updateTitleFontForAllViews];
    return;
  }

  NSUInteger itemIndex = [self.items indexOfObject:selectedItem];
  // Don't crash, just ignore if `selectedItem` isn't present in `_items`. This is the same behavior
  // as UITabBar.
  if (itemIndex == NSNotFound) {
    return;
  }
  _selectedItem = selectedItem;

  UIView *newSelectedItemView = self.itemViews[itemIndex];
  newSelectedItemView.accessibilityTraits =
      (newSelectedItemView.accessibilityTraits | UIAccessibilityTraitSelected);
  [self updateTitleColorForAllViews];
  [self updateImageTintColorForAllViews];
  [self updateTitleFontForAllViews];
  [self scrollRectToVisible:self.itemViews[itemIndex].frame animated:animated];
}

- (void)updateImageTintColorForAllViews {
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
      tabBarViewItemView.iconImageView.tintColor =
          [self imageTintColorForState:UIControlStateSelected];
    } else {
      tabBarViewItemView.iconImageView.tintColor =
          [self imageTintColorForState:UIControlStateNormal];
    }
  }
}

- (void)setImageTintColor:(UIColor *)imageTintColor forState:(UIControlState)state {
  self.stateToImageTintColor[@(state)] = imageTintColor;
  [self updateImageTintColorForAllViews];
}

- (UIColor *)imageTintColorForState:(UIControlState)state {
  UIColor *color = self.stateToImageTintColor[@(state)];
  if (color == nil) {
    color = self.stateToImageTintColor[@(UIControlStateNormal)];
  }
  return color;
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

- (void)updateTitleFontForAllViews {
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
      tabBarViewItemView.titleLabel.font = [self titleFontForState:UIControlStateSelected];
    } else {
      tabBarViewItemView.titleLabel.font = [self titleFontForState:UIControlStateNormal];
    }
  }
}

- (void)setTitleFont:(UIFont *)titleFont forState:(UIControlState)state {
  self.stateToTitleFont[@(state)] = titleFont;
  [self updateTitleFontForAllViews];
}

- (UIFont *)titleFontForState:(UIControlState)state {
  UIFont *titleFont = self.stateToTitleFont[@(state)];
  if (!titleFont) {
    titleFont = self.stateToTitleFont[@(UIControlStateNormal)];
  }
  return titleFont;
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
    [item addObserver:self
           forKeyPath:kAccessibilityLabelKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
    [item addObserver:self
           forKeyPath:kAccessibilityHintKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
    [item addObserver:self
           forKeyPath:kAccessibilityIdentifierKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
    [item addObserver:self
           forKeyPath:kAccessibilityTraitsKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item removeObserver:self forKeyPath:kImageKeyPath context:kKVOContextMDCTabBarView];
    [item removeObserver:self forKeyPath:kTitleKeyPath context:kKVOContextMDCTabBarView];
    [item removeObserver:self
              forKeyPath:kAccessibilityLabelKeyPath
                 context:kKVOContextMDCTabBarView];
    [item removeObserver:self
              forKeyPath:kAccessibilityHintKeyPath
                 context:kKVOContextMDCTabBarView];
    [item removeObserver:self
              forKeyPath:kAccessibilityIdentifierKeyPath
                 context:kKVOContextMDCTabBarView];
    [item removeObserver:self
              forKeyPath:kAccessibilityTraitsKeyPath
                 context:kKVOContextMDCTabBarView];
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
    } else if ([keyPath isEqualToString:kAccessibilityLabelKeyPath]) {
      tabBarItemView.accessibilityLabel = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kAccessibilityHintKeyPath]) {
      tabBarItemView.accessibilityHint = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kAccessibilityIdentifierKeyPath]) {
      tabBarItemView.accessibilityIdentifier = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kAccessibilityTraitsKeyPath]) {
      tabBarItemView.accessibilityTraits = [change[NSKeyValueChangeNewKey] unsignedLongLongValue];
      if (tabBarItemView.accessibilityTraits == UIAccessibilityTraitNone) {
        tabBarItemView.accessibilityTraits = UIAccessibilityTraitButton;
      }
      if (object == self.selectedItem) {
        tabBarItemView.accessibilityTraits =
            (tabBarItemView.accessibilityTraits | UIAccessibilityTraitSelected);
      }
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.isJustifiedLayoutStyle) {
    [self layoutSubviewsForJustifiedLayout];
  } else {
    [self layoutSubviewsForScrollableLayout];
  }
  self.contentSize = [self calculatedContentSize];

  if (!self.initialScrollDone) {
    self.initialScrollDone = YES;
    [self scrollUntilSelectedItemIsVisibleWithoutAnimation];
  }
}

- (BOOL)isJustifiedLayoutStyle {
  CGRect availableBounds = self.bounds;
  if (@available(iOS 11.0, *)) {
    availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.adjustedContentInset);
  }
  CGFloat availableWidth = CGRectGetWidth(availableBounds);
  CGFloat requiredWidth = [self intrinsicContentSizeForJustifiedLayout].width;
  return availableWidth >= requiredWidth;
}

- (void)layoutSubviewsForJustifiedLayout {
  CGRect availableBounds = self.bounds;
  if (@available(iOS 11.0, *)) {
    availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.adjustedContentInset);
  }

  BOOL isRTL =
      [self mdf_effectiveUserInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft;

  CGFloat itemViewWidth = CGRectGetWidth(availableBounds) / self.itemViews.count;
  CGFloat itemViewOriginX = isRTL ? CGRectGetWidth(availableBounds) : 0;
  CGFloat itemViewOriginY = 0;
  CGFloat itemViewHeight = CGRectGetHeight(availableBounds);
  for (UIView *itemView in self.itemViews) {
    if (isRTL) {
      itemView.frame = CGRectMake(itemViewOriginX - itemViewWidth, itemViewOriginY, itemViewWidth,
                                  itemViewHeight);
      itemViewOriginX -= itemViewWidth;
    } else {
      itemView.frame = CGRectMake(itemViewOriginX, itemViewOriginY, itemViewWidth, itemViewHeight);
      itemViewOriginX += itemViewWidth;
    }
  }
}

- (void)layoutSubviewsForScrollableLayout {
  CGRect availableBounds = self.bounds;
  if (@available(iOS 11.0, *)) {
    availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.adjustedContentInset);
  }
  BOOL isRTL =
      [self mdf_effectiveUserInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft;

  CGFloat itemViewOriginX = isRTL ? CGRectGetWidth(availableBounds) : 0;
  CGFloat itemViewOriginY = 0;
  CGFloat itemViewHeight = CGRectGetHeight(availableBounds);
  for (UIView *view in self.itemViews) {
    CGSize intrinsicContentSize = view.intrinsicContentSize;
    if (isRTL) {
      view.frame = CGRectMake(itemViewOriginX - intrinsicContentSize.width, itemViewOriginY,
                              intrinsicContentSize.width, itemViewHeight);
      itemViewOriginX -= intrinsicContentSize.width;
    } else {
      view.frame =
          CGRectMake(itemViewOriginX, itemViewOriginY, intrinsicContentSize.width, itemViewHeight);
      itemViewOriginX += intrinsicContentSize.width;
    }
  }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.initialScrollDone = NO;
}

- (CGSize)intrinsicContentSize {
  //  if (self.isJustifiedLayoutStyle) {
  return [self intrinsicContentSizeForJustifiedLayout];
  //  } else {
  //    return [self intrinsicContentSizeForScrollableLayout];
  //  }
}

- (CGSize)calculatedContentSize {
  if (self.isJustifiedLayoutStyle) {
    return [self intrinsicContentSizeForJustifiedLayout];
  } else {
    return [self intrinsicContentSizeForScrollableLayout];
  }
}

- (CGSize)intrinsicContentSizeForJustifiedLayout {
  CGFloat maxWidth = 0;
  CGFloat maxHeight = kMinHeight;
  for (UIView *itemView in self.itemViews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    maxHeight = MAX(maxHeight, contentSize.height);
    maxWidth = MAX(maxWidth, contentSize.width);
  }
  return CGSizeMake(maxWidth * self.items.count, maxHeight);
}

- (CGSize)intrinsicContentSizeForScrollableLayout {
  CGFloat totalWidth = 0;
  CGFloat maxHeight = 0;
  for (UIView *itemView in self.itemViews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.height > maxHeight) {
      maxHeight = contentSize.height;
    }
    totalWidth += contentSize.width;
  }
  return CGSizeMake(totalWidth, MAX(kMinHeight, maxHeight));
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize intrinsicSize = self.intrinsicContentSize;
  return CGSizeMake(MAX(intrinsicSize.width, size.width), MAX(intrinsicSize.height, size.height));
}

#pragma mark - Helpers

- (void)scrollUntilSelectedItemIsVisibleWithoutAnimation {
  NSUInteger index = [self.items indexOfObject:self.selectedItem];
  if (index == NSNotFound || index >= self.itemViews.count) {
    index = 0;
  }
  if (self.itemViews.count == 0U) {
    return;
  }

  CGRect estimatedItemFrame = [self estimatedFrameForItemAtIndex:index];
  [self scrollRectToVisible:estimatedItemFrame animated:NO];
}

- (CGRect)estimatedFrameForItemAtIndex:(NSUInteger)index {
  if (index == NSNotFound || index >= self.itemViews.count) {
    return CGRectZero;
  }

  CGRect contentRect = self.bounds;
  if (@available(iOS 11.0, *)) {
    contentRect = UIEdgeInsetsInsetRect(contentRect, self.adjustedContentInset);
  }

  BOOL isRTL =
      [self mdf_effectiveUserInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft;
  CGFloat viewOriginX = isRTL ? CGRectGetWidth(contentRect) : 0;

  for (NSUInteger i = 0; i < index; ++i) {
    CGSize viewSize = [self expectedSizeForView:self.itemViews[i]];
    if (isRTL) {
      viewOriginX -= viewSize.width;
    } else {
      viewOriginX += viewSize.width;
    }
  }
  CGSize viewSize = [self expectedSizeForView:self.itemViews[index]];
  if (isRTL) {
    viewOriginX -= viewSize.width;
  }
  return CGRectMake(viewOriginX, 0, viewSize.width, viewSize.height);
}

- (CGSize)expectedSizeForView:(UIView *)view {
  if (self.isJustifiedLayoutStyle && CGRectGetWidth(self.bounds) > 0) {
    CGRect contentRect = self.bounds;
    if (@available(iOS 11.0, *)) {
      contentRect = UIEdgeInsetsInsetRect(contentRect, self.adjustedContentInset);
    }
    return CGSizeMake(CGRectGetWidth(contentRect) / self.itemViews.count,
                      CGRectGetHeight(contentRect));
  }
  CGSize expectedItemSize = view.intrinsicContentSize;
  if (expectedItemSize.width == UIViewNoIntrinsicMetric) {
    NSAssert(expectedItemSize.width != UIViewNoIntrinsicMetric,
             @"All tab bar item views must define an intrinsic content size.");
    expectedItemSize = [view sizeThatFits:self.contentSize];
  }
  return expectedItemSize;
}

#pragma mark - Actions

- (void)didTapItemView:(UITapGestureRecognizer *)tap {
  NSUInteger index = [self.itemViews indexOfObject:tap.view];
  if (index == NSNotFound) {
    return;
  }

  if ([self.tabBarDelegate respondsToSelector:@selector(tabBarView:shouldSelectItem:)] &&
      ![self.tabBarDelegate tabBarView:self shouldSelectItem:self.items[index]]) {
    return;
  }

  self.selectedItem = self.items[index];
  if ([self.tabBarDelegate respondsToSelector:@selector(tabBarView:didSelectItem:)]) {
    [self.tabBarDelegate tabBarView:self didSelectItem:self.items[index]];
  }
}

@end
