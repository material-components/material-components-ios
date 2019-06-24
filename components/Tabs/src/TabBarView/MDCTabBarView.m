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

#import "private/MDCTabBarViewItemView.h"

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

@interface MDCTabBarView ()

/** The stack view that contains all tab items. */
@property(nonatomic) UIStackView *stackView;

@end

@implementation MDCTabBarView

#pragma mark - Initialization

- (instancetype)init {
  self = [super initWithFrame:CGRectZero];
  self.translatesAutoresizingMaskIntoConstraints = NO;
  if (self) {
    _items = @[];
    [self setUpSubviews];
  }
  return self;
}

#pragma mark - Properties

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
  if (selectedItem && (itemIndex == NSNotFound)) {
    NSString *itemTitle = selectedItem.title;
    NSString *exceptionMessage =
    [NSString stringWithFormat:@"%@ is not a member of the tab bar's `items`.", itemTitle];
    [[NSException exceptionWithName:NSInvalidArgumentException reason:exceptionMessage
                           userInfo:nil] raise];
  }

  _selectedItem = selectedItem;
}

- (void)setUpSubviews {
  self.backgroundColor = UIColor.whiteColor;

  [self setUpStackView];
  [self setUpItemViews];

  [NSLayoutConstraint activateConstraints:@[
                                            [self.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                            [self.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                            [self.topAnchor constraintEqualToAnchor:self.topAnchor],
                                            [self.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],

                                            [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                            [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                            [_stackView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.widthAnchor],
                                            [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                            [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                            ]];
}

- (void)setUpStackView {
  _stackView = [[UIStackView alloc] init];
  _stackView.axis = UILayoutConstraintAxisHorizontal;
  _stackView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:_stackView];
}

- (void)setUpItemViews {
  for (UIView *view in self.stackView.arrangedSubviews) {
    [view removeFromSuperview];
    [_stackView removeArrangedSubview:view];
  }

  for (UITabBarItem *item in self.items) {
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] initWithFrame:CGRectZero];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.title = item.title;
    itemView.image = item.image;
    [_stackView addArrangedSubview:itemView];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat availableWidth = self.frame.size.width;
  CGFloat maxWidth = 0;
  for (UIView *itemView in self.stackView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.width > maxWidth) {
      maxWidth = contentSize.width;
    }
  }
  CGFloat requiredWidth = maxWidth * self.items.count;
  BOOL canBeJustified = requiredWidth > availableWidth;
  self.stackView.distribution = canBeJustified ? UIStackViewDistributionFillProportionally
  : UIStackViewDistributionFillEqually;
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(UIViewNoIntrinsicMetric, kMinHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
  return CGSizeMake(size.width, MAX(size.height, kMinHeight));
}

@end
