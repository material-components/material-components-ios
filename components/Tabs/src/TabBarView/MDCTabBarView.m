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

/** The constraints managing this view. */
@property(nonatomic, strong) NSArray *viewConstraints;

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
    [self commonMDCTabBarViewInit];
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

  _items = [items copy];
  [self setUpItemViews];

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

  CGFloat availableWidth = self.bounds.size.width;
  CGFloat maxWidth = 0;
  for (UIView *itemView in self.containerView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.width > maxWidth) {
      maxWidth = contentSize.width;
    }
  }
  CGFloat requiredWidth = maxWidth * self.items.count;
  BOOL canBeJustified = availableWidth > requiredWidth;
  self.containerView.distribution = canBeJustified ? UIStackViewDistributionFillEqually
                                                   : UIStackViewDistributionFillProportionally;
}

- (void)updateConstraints {
  [super updateConstraints];

  if (self.viewConstraints) {
    return;
  }

  NSMutableArray *constraints = [NSMutableArray array];
  [constraints addObjectsFromArray:@[
    [_containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    [_containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    [_containerView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.widthAnchor],
    [_containerView.topAnchor constraintEqualToAnchor:self.topAnchor],
    [_containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
  ]];

  [self addConstraints:constraints];
  self.viewConstraints = constraints;
}

- (CGSize)intrinsicContentSize {
  CGFloat totalWidth = 0;
  CGFloat maxHeight = 0;
  for (UIView *itemView in self.containerView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    totalWidth += contentSize.width;
    if (contentSize.height > maxHeight) {
      maxHeight = contentSize.height;
    }
  }
  return CGSizeMake(totalWidth, MAX(kMinHeight, maxHeight));
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize intrinsicSize = self.intrinsicContentSize;
  return CGSizeMake(MIN(intrinsicSize.width, size.width), MAX(intrinsicSize.height, size.height));
}

#pragma mark - Private Functions

- (void)commonMDCTabBarViewInit {
  self.backgroundColor = UIColor.whiteColor;

  [self setUpStackView];
  [self setUpItemViews];
}

- (void)setUpStackView {
  _containerView = [[UIStackView alloc] init];
  _containerView.axis = UILayoutConstraintAxisHorizontal;
  _containerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:_containerView];
}

- (void)setUpItemViews {
  for (UIView *view in self.containerView.arrangedSubviews) {
    [view removeFromSuperview];
    [_containerView removeArrangedSubview:view];
  }

  for (UITabBarItem *item in self.items) {
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.titleLabel.text = item.title;
    itemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
    itemView.iconImageView.image = item.image;
    [_containerView addArrangedSubview:itemView];
  }
}

@end
