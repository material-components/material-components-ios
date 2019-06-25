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
@property(nonatomic) UIStackView *stackView;

/** The constraints managing this view. */
@property(nonatomic, strong) NSArray *viewConstraints;

@end

@implementation MDCTabBarView

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _items = @[];
    [self commonMDCTabBarViewInit];
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

- (void)commonMDCTabBarViewInit {
  self.backgroundColor = UIColor.whiteColor;

  [self setUpStackView];
  [self setUpItemViews];
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
    MDCTabBarViewItemView *itemView = [[MDCTabBarViewItemView alloc] init];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    itemView.titleLabel.text = item.title;
    itemView.iconImageView.image = item.image;
    [_stackView addArrangedSubview:itemView];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat availableWidth = self.bounds.size.width;
  CGFloat maxWidth = 0;
  for (UIView *itemView in self.stackView.arrangedSubviews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.width > maxWidth) {
      maxWidth = contentSize.width;
    }
  }
  CGFloat requiredWidth = maxWidth * self.items.count;
  BOOL canBeJustified = availableWidth > requiredWidth;
  self.stackView.distribution = canBeJustified ? UIStackViewDistributionFillEqually
                                               : UIStackViewDistributionFillProportionally;
}

- (void)updateConstraints {
  [super updateConstraints];

  if (self.viewConstraints) {
    return;
  }

  NSMutableArray *constraints = [NSMutableArray array];
  [constraints addObjectsFromArray:@[
    [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    [_stackView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.widthAnchor],
    [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
    [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
  ]];

  [self addConstraints:constraints];
  self.viewConstraints = constraints;
}

- (CGSize)intrinsicContentSize {
  CGFloat totalWidth = 0;
  CGFloat maxHeight = 0;
  for (UIView *itemView in self.stackView.arrangedSubviews) {
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

@end
