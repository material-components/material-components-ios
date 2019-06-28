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
#import "MDCTabBarViewDelegate.h"
#import "MDFInternationalization.h"
#import "private/MDCTabBarViewItemView.h"

// KVO contexts
static char *const kKVOContextMDCTabBarView = "kKVOContextMDCTabBarView";

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

/** Leading padding for tab bar in a scrollable layout style. */
static const CGFloat kScrollablePadding = 52;

static NSString *const kImageKeyPath = @"image";
static NSString *const kTitleKeyPath = @"title";
static NSString *const kAccessibilityLabelKeyPath = @"accessibilityLabel";
static NSString *const kAccessibilityHintKeyPath = @"accessibilityHint";
static NSString *const kAccessibilityIdentifierKeyPath = @"accessibilityIdentifier";

@interface MDCTabBarView ()

/** The stack view that contains all tab item views. */
@property(nonnull, nonatomic, strong) UIStackView *containerView;

/** Used to avoid duplicating containerView's constraints twice. */
@property(nonatomic, assign) BOOL containerViewConstraintsActive;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

/** The image tint colors for bar items. */
@property(nonnull, nonatomic, strong)
    NSMutableDictionary<NSNumber *, UIColor *> *stateToImageTintColor;

/** Constrains @c containerView's leading edge. */
@property(nonnull, nonatomic, strong) NSLayoutConstraint *leadingConstraint;

/** Constrains @c containerView's trailing edge. */
@property(nonnull, nonatomic, strong) NSLayoutConstraint *trailingConstraint;

/** Constrains @c containerView's top edge. */
@property(nonnull, nonatomic, strong) NSLayoutConstraint *topConstraint;

/** Constrains @c containerView's bottom edge. */
@property(nonnull, nonatomic, strong) NSLayoutConstraint *bottomConstraint;

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
    self.backgroundColor = UIColor.whiteColor;
    self.showsHorizontalScrollIndicator = NO;

    _containerView = [[UIStackView alloc] init];
    _containerView.axis = UILayoutConstraintAxisHorizontal;
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
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
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.titleLabel.text = item.title;
    itemView.accessibilityLabel = item.accessibilityLabel;
    itemView.accessibilityHint = item.accessibilityHint;
    itemView.accessibilityIdentifier = item.accessibilityIdentifier;
    itemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
    itemView.iconImageView.image = item.image;
    [itemView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                              forAxis:UILayoutConstraintAxisHorizontal];
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

  [self updateTitleColorForAllViews];
  [self updateImageTintColorForAllViews];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  _contentEdgeInsets = contentEdgeInsets;
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (UIEdgeInsets)directionalContentEdgeInsets {
  UIEdgeInsets effectiveInsets = self.contentEdgeInsets;
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    effectiveInsets.left = self.contentEdgeInsets.right;
    effectiveInsets.right = self.contentEdgeInsets.left;
  }
  return effectiveInsets;
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
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  [self updateTitleColorForAllViews];
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];
  UIEdgeInsets directionalContentEdgeInsets = [self directionalContentEdgeInsets];
  CGRect availableBounds =
      UIEdgeInsetsInsetRect(CGRectStandardize(self.bounds), directionalContentEdgeInsets);
  if (@available(iOS 11.0, *)) {
    availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.safeAreaInsets);
  }
  CGFloat requiredWidth = [self justifiedWidth];

  BOOL canBeJustified = CGRectGetWidth(availableBounds) >= requiredWidth;
  UIEdgeInsets paddingInsets = UIEdgeInsetsZero;
  if (canBeJustified) {
    self.containerView.distribution = UIStackViewDistributionFillEqually;
  } else {
    self.containerView.distribution = UIStackViewDistributionFillProportionally;
    if (self.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionLeftToRight) {
      paddingInsets.left = kScrollablePadding;
    } else {
      paddingInsets.right = kScrollablePadding;
    }
  }

  // The padding insets should not be added to the safe area insets. Instead, allow the design-based
  // padding insets to overlap the safe are insets if possible.
  if (@available(iOS 11.0, *)) {
    UIEdgeInsets safeAreaInsets = self.safeAreaInsets;
    paddingInsets.left = MAX(safeAreaInsets.left, paddingInsets.left);
    paddingInsets.right = MAX(safeAreaInsets.right, paddingInsets.right);
    paddingInsets.top = MAX(safeAreaInsets.top, paddingInsets.top);
    paddingInsets.bottom = MAX(safeAreaInsets.bottom, paddingInsets.bottom);
  }
  // Apply any user-provided contentEdgeInsets to the padding and safe area insets.
  self.leadingConstraint.constant = paddingInsets.left + directionalContentEdgeInsets.left;
  self.trailingConstraint.constant = -(paddingInsets.right + directionalContentEdgeInsets.right);
  self.topConstraint.constant = paddingInsets.top + directionalContentEdgeInsets.top;
  self.bottomConstraint.constant = -(paddingInsets.bottom + directionalContentEdgeInsets.bottom);
}

- (void)updateConstraints {
  if (self.containerViewConstraintsActive) {
    [super updateConstraints];
    return;
  }

  self.leadingConstraint =
      [self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
  self.trailingConstraint =
      [self.containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
  self.topConstraint = [self.containerView.topAnchor constraintEqualToAnchor:self.topAnchor];
  self.bottomConstraint =
      [self.containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];

  [NSLayoutConstraint activateConstraints:@[
    self.leadingConstraint,
    self.trailingConstraint,
    self.topConstraint,
    self.bottomConstraint,
  ]];
  if (@available(iOS 11.0, *)) {
    [self.containerView.widthAnchor
        constraintGreaterThanOrEqualToAnchor:self.safeAreaLayoutGuide.widthAnchor]
        .active = YES;
  } else {
    [self.containerView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.widthAnchor].active =
        YES;
  }

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
  UIEdgeInsets directionalContentEdgeInsets = [self directionalContentEdgeInsets];
  maxHeight += directionalContentEdgeInsets.top + directionalContentEdgeInsets.bottom;
  totalWidth += directionalContentEdgeInsets.left + directionalContentEdgeInsets.right;
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
  UIEdgeInsets directionalContentEdgeInsets = [self directionalContentEdgeInsets];
  requiredWidth += directionalContentEdgeInsets.left + directionalContentEdgeInsets.right;
  if (@available(iOS 11.0, *)) {
    requiredWidth += self.safeAreaInsets.left + self.safeAreaInsets.right;
  }
  return requiredWidth;
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
