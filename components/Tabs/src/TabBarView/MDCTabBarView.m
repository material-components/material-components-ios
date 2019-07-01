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

/** The stack view that contains all tab item views. */
@property(nonnull, nonatomic, strong) UIStackView *containerView;

/** Used to avoid duplicating containerView's constraints twice. */
@property(nonatomic, assign) BOOL containerViewConstraintsActive;

/** Used to scroll to the selected item during the first call to @c layoutSubviews. */
@property(nonatomic, assign) BOOL initialScrollDone;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

/** The image tint colors for bar items. */
@property(nonnull, nonatomic, strong)
    NSMutableDictionary<NSNumber *, UIColor *> *stateToImageTintColor;

/** The constraints for the justified layout style. */
@property(nullable, nonatomic) NSArray<NSLayoutConstraint *> *justifiedLayoutConstraints;

/** The constraints for the scrollable layout style. */
@property(nullable, nonatomic) NSArray<NSLayoutConstraint *> *scrollableLayoutConstraints;

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

    _containerView = [[UIStackView alloc] init];
    _containerView.axis = UILayoutConstraintAxisHorizontal;
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;

    // By deafult, inset the content within the safe area. This is generally the desired behavior,
    // but clients can override it if they want.
    if (@available(iOS 11.0, *)) {
      [super setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAlways];
    }
    [self addSubview:_containerView];
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
  for (UIView *view in self.containerView.arrangedSubviews) {
    [view removeFromSuperview];
  }

  _items = [items copy];

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
    [itemView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                              forAxis:UILayoutConstraintAxisHorizontal];
    [itemView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                              forAxis:UILayoutConstraintAxisVertical];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)];
    [itemView addGestureRecognizer:tapGesture];

    [self.containerView addArrangedSubview:itemView];
  }

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
    UIView *oldSelectedItemView = self.containerView.arrangedSubviews[oldSelectedItemIndex];
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

  UIView *newSelectedItemView = self.containerView.arrangedSubviews[itemIndex];
  newSelectedItemView.accessibilityTraits =
      (newSelectedItemView.accessibilityTraits | UIAccessibilityTraitSelected);
  [self updateTitleColorForAllViews];
  [self updateImageTintColorForAllViews];
  [self updateTitleFontForAllViews];
  CGRect itemFrameInScrollViewBounds =
      [self convertRect:self.containerView.arrangedSubviews[itemIndex].frame
               fromView:self.containerView];
  [self scrollRectToVisible:itemFrameInScrollViewBounds animated:animated];
}

- (void)updateImageTintColorForAllViews {
  for (UITabBarItem *item in self.items) {
    NSUInteger indexOfItem = [self.items indexOfObject:item];
    // This is a significant error, but defensive coding is preferred.
    if (indexOfItem == NSNotFound || indexOfItem >= self.containerView.arrangedSubviews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.containerView.arrangedSubviews[indexOfItem];
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
    if (indexOfItem == NSNotFound || indexOfItem >= self.containerView.arrangedSubviews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.containerView.arrangedSubviews[indexOfItem];
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
    if (indexOfItem == NSNotFound || indexOfItem >= self.containerView.arrangedSubviews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.containerView.arrangedSubviews[indexOfItem];
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
    UIView *updatedItemView = self.containerView.arrangedSubviews[indexOfObject];
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

  CGRect availableBounds = self.bounds;
  if (@available(iOS 11.0, *)) {
    availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.safeAreaInsets);
  }
  CGFloat availableWidth = CGRectGetWidth(availableBounds);
  CGFloat requiredWidth = [self justifiedWidth];
  BOOL canBeJustified = availableWidth >= requiredWidth;
  if (canBeJustified) {
    [NSLayoutConstraint deactivateConstraints:self.scrollableLayoutConstraints];
    self.containerView.distribution = UIStackViewDistributionFillEqually;
    [NSLayoutConstraint activateConstraints:self.justifiedLayoutConstraints];
  } else {
    [NSLayoutConstraint deactivateConstraints:self.justifiedLayoutConstraints];
    self.containerView.distribution = UIStackViewDistributionFillProportionally;
    [NSLayoutConstraint activateConstraints:self.scrollableLayoutConstraints];
  }

  if (!self.initialScrollDone) {
    self.initialScrollDone = YES;
    [self scrollUntilSelectedItemIsVisibleWithoutAnimation];
  }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.initialScrollDone = NO;
}

- (void)setBounds:(CGRect)bounds {
  BOOL shouldScroll =
      !CGSizeEqualToSize(CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)),
                         CGSizeMake(CGRectGetWidth(bounds), CGRectGetHeight(bounds)));
  [super setBounds:bounds];
  if (shouldScroll) {
    [self scrollUntilSelectedItemIsVisibleWithoutAnimation];
  }
}

- (void)updateConstraints {
  if (self.containerViewConstraintsActive) {
    [super updateConstraints];
    return;
  }

  if (@available(iOS 11.0, *)) {
    self.justifiedLayoutConstraints = @[
      [self.safeAreaLayoutGuide.leadingAnchor
          constraintEqualToAnchor:self.containerView.leadingAnchor],
      [self.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
      [self.safeAreaLayoutGuide.trailingAnchor
          constraintEqualToAnchor:self.containerView.trailingAnchor],
      [self.safeAreaLayoutGuide.bottomAnchor
          constraintEqualToAnchor:self.containerView.bottomAnchor],
    ];
    self.scrollableLayoutConstraints = @[
      [self.contentLayoutGuide.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
      [self.contentLayoutGuide.bottomAnchor
          constraintEqualToAnchor:self.containerView.bottomAnchor],
      [self.contentLayoutGuide.leadingAnchor
          constraintEqualToAnchor:self.containerView.leadingAnchor],
      [self.contentLayoutGuide.trailingAnchor
          constraintEqualToAnchor:self.containerView.trailingAnchor],
      [self.contentLayoutGuide.widthAnchor constraintEqualToAnchor:self.containerView.widthAnchor],
      [self.contentLayoutGuide.heightAnchor
          constraintEqualToAnchor:self.containerView.heightAnchor],
      // Ensures items are never larger than the bar.
      [self.frameLayoutGuide.heightAnchor
          constraintGreaterThanOrEqualToAnchor:self.containerView.heightAnchor],
    ];
  } else {
    self.justifiedLayoutConstraints = @[
      [self.heightAnchor constraintEqualToAnchor:self.containerView.heightAnchor],
      [self.widthAnchor constraintEqualToAnchor:self.containerView.widthAnchor],
    ];
    self.scrollableLayoutConstraints = @[];
    [self.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor].active = YES;
    [self.topAnchor constraintEqualToAnchor:self.containerView.topAnchor].active = YES;
    [self.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor].active = YES;
  }
  self.containerViewConstraintsActive = YES;

  // Must always be called last according to the documentation.
  [super updateConstraints];
}

- (CGSize)intrinsicContentSize {
  CGFloat totalWidth = [self justifiedWidth];
  CGFloat maxHeight = 0;
  for (UIView *itemView in self.containerView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.height > maxHeight) {
      maxHeight = contentSize.height;
    }
  }
  return CGSizeMake(totalWidth, MAX(kMinHeight, maxHeight));
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize intrinsicSize = self.intrinsicContentSize;
  return CGSizeMake(MAX(intrinsicSize.width, size.width), MAX(intrinsicSize.height, size.height));
}

#pragma mark - Helpers

- (CGFloat)justifiedWidth {
  CGFloat maxWidth = 0;
  for (UIView *itemView in self.containerView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.width > maxWidth) {
      maxWidth = contentSize.width;
    }
  }
  CGFloat requiredWidth = maxWidth * self.items.count;
  return requiredWidth;
}

- (void)scrollUntilSelectedItemIsVisibleWithoutAnimation {
  NSUInteger index = [self.items indexOfObject:self.selectedItem];
  if (index == NSNotFound || index >= self.containerView.arrangedSubviews.count) {
    index = 0;
  }
  if (self.containerView.arrangedSubviews.count == 0U) {
    return;
  }

  CGRect estimatedItemFrame = [self estimatedFrameInContainerViewForItemAtIndex:index];
  [self scrollRectToVisible:[self convertRect:estimatedItemFrame fromView:self.containerView]
                   animated:NO];
}

- (CGRect)estimatedFrameInContainerViewForItemAtIndex:(NSUInteger)index {
  if (index == NSNotFound || index >= self.containerView.arrangedSubviews.count) {
    return CGRectZero;
  }

  BOOL isRTL =
      [self mdf_effectiveUserInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft;
  CGFloat viewOriginX =
      isRTL ? CGRectGetMaxX(self.containerView.bounds) : CGRectGetMinX(self.containerView.bounds);

  for (NSUInteger i = 0; i < index; ++i) {
    CGSize viewSize = [self expectedSizeForView:self.containerView.arrangedSubviews[i]];
    if (isRTL) {
      viewOriginX -= viewSize.width;
    } else {
      viewOriginX += viewSize.width;
    }
  }
  CGSize viewSize = [self expectedSizeForView:self.containerView.arrangedSubviews[index]];
  if (isRTL) {
    viewOriginX -= viewSize.width;
  }
  CGRect itemFrameInContainerView = CGRectMake(
      viewOriginX, CGRectGetMinY(self.containerView.bounds), viewSize.width, viewSize.height);
  CGRect convertedRect = [self convertRect:itemFrameInContainerView fromView:self.containerView];
  return convertedRect;
}

- (CGSize)expectedSizeForView:(UIView *)view {
  // TODO(https://github.com/material-components/material-components-ios/issues/7748): This
  // condition is potentially dead code. It's not clear if it can be triggered in a view controller
  // because the stack view defaults to `.Proportionally`.  However, it is being left here for now
  // as a more defensive bit of code that quickly dividing the containerView's bounds is more
  // efficient (and accurate) than computing every other view's size.
  if (self.containerView.distribution == UIStackViewDistributionFillEqually &&
      CGRectGetWidth(self.containerView.bounds) > 0) {
    return CGSizeMake(
        CGRectGetWidth(self.containerView.bounds) / self.containerView.arrangedSubviews.count,
        CGRectGetHeight(self.containerView.bounds));
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
  NSUInteger index = [self.containerView.arrangedSubviews indexOfObject:tap.view];
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
