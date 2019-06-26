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

/** The stack view that contains all tab item views. */
@property(nonnull, nonatomic, strong) UIStackView *containerView;

/** Used to avoid duplicating containerView's constraints twice. */
@property(nonatomic, assign) BOOL containerViewConstraintsActive;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

@end

@implementation MDCTabBarView

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _items = @[];
    _stateToTitleColor = [NSMutableDictionary dictionary];
    self.backgroundColor = UIColor.whiteColor;

    _containerView = [[UIStackView alloc] init];
    _containerView.axis = UILayoutConstraintAxisHorizontal;
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_containerView];
  }
  return self;
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

  for (UIView *view in self.containerView.arrangedSubviews) {
    [view removeFromSuperview];
  }

  _items = [items copy];

  for (UITabBarItem *item in self.items) {
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.titleLabel.text = item.title;
    itemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
    itemView.iconImageView.image = item.image;
    [_containerView addArrangedSubview:itemView];
  }

  // Determine new selected item, defaulting to nil.
  UITabBarItem *newSelectedItem = nil;
  if (self.selectedItem && [self.items containsObject:self.selectedItem]) {
    // Previously-selected item still around: Preserve selection.
    newSelectedItem = self.selectedItem;
  }

  self.selectedItem = newSelectedItem;
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  if (self.selectedItem == selectedItem) {
    return;
  }

  NSUInteger itemIndex = [self.items indexOfObject:selectedItem];
  // Don't crash, just ignore if `selectedItem` isn't present in `_items`. This is the same behavior
  // as UITabBar.
  if (selectedItem && (itemIndex == NSNotFound)) {
    return;
  }

  _selectedItem = selectedItem;
  [self updateTitleColorForAllViews];
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

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat availableWidth = CGRectGetWidth(self.bounds);
  CGFloat requiredWidth = [self justifiedWidth];
  BOOL canBeJustified = availableWidth >= requiredWidth;
  self.containerView.distribution = canBeJustified ? UIStackViewDistributionFillEqually
                                                   : UIStackViewDistributionFillProportionally;
}

- (void)updateConstraints {
  if (self.containerViewConstraintsActive) {
    [super updateConstraints];
    return;
  }

  [_containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
  [_containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
  [_containerView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.widthAnchor].active = YES;
  [_containerView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
  [_containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
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

@end
