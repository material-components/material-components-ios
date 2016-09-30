/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCTabBar.h"

#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "private/MDCItemBar.h"
#import "private/MDCItemBarAlignment.h"
#import "private/MDCItemBarStyle.h"

/// Padding between image and title in points, according to the spec.
static const CGFloat kImageTitleSpecPadding = 10;

/// Adjustment added to spec measurements to compensate for internal paddings.
static const CGFloat kImageTitlePaddingAdjustment = -3;

// Heights based on the spec: https://www.google.com/design/spec/components/tabs.html

/// Height for image-only tab bars, in points.
static const CGFloat kImageOnlyBarHeight = 48;

/// Height for image-only tab bars, in points.
static const CGFloat kTitleOnlyBarHeight = 48;

/// Height for image-and-title tab bars, in points.
static const CGFloat kTitledImageBarHeight = 72;

static MDCTabBarAlignment MDCTabBarAlignmentForItemBarAlignment(MDCItemBarAlignment alignment) {
  switch (alignment) {
    case MDCItemBarAlignmentCenter:
      return MDCTabBarAlignmentCenter;

    case MDCItemBarAlignmentLeading:
      return MDCTabBarAlignmentLeading;

    case MDCItemBarAlignmentJustified:
      return MDCTabBarAlignmentJustified;

    case MDCItemBarAlignmentCenterSelected:
      return MDCTabBarAlignmentCenterSelected;
  }
}

static MDCItemBarAlignment MDCItemBarAlignmentForTabBarAlignment(MDCTabBarAlignment alignment) {
  switch (alignment) {
    case MDCTabBarAlignmentCenter:
      return MDCItemBarAlignmentCenter;

    case MDCTabBarAlignmentLeading:
      return MDCItemBarAlignmentLeading;

    case MDCTabBarAlignmentJustified:
      return MDCItemBarAlignmentJustified;

    case MDCTabBarAlignmentCenterSelected:
      return MDCItemBarAlignmentCenterSelected;
  }
}

@interface MDCTabBar () <MDCItemBarDelegate>
@end

@implementation MDCTabBar {
  /// Item bar responsible for displaying the actual tab bar content.
  MDCItemBar *_itemBar;
}
// Inherit UIView's tintColor logic.
@dynamic tintColor;

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonTabBarInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonTabBarInit];
  }
  return self;
}

- (void)commonTabBarInit {
  _itemAppearance = MDCTabBarItemAppearanceTitles;
  _selectedItemTintColor = [UIColor whiteColor];
  _unselectedItemTintColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
  _displaysUppercaseTitles = YES;

  // Create item bar.
  _itemBar = [[MDCItemBar alloc] initWithFrame:self.bounds];
  _itemBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _itemBar.delegate = self;
  _itemBar.alignment = MDCItemBarAlignmentLeading;
  [self addSubview:_itemBar];

  [self updateItemBarStyle];
}

#pragma mark - Public

+ (CGFloat)defaultHeightForItemAppearance:(MDCTabBarItemAppearance)appearance {
  return [MDCItemBar defaultHeightForStyle:[self defaultStyleForItemAppearance:appearance]];
}

- (NSArray<UITabBarItem *> *)items {
  return _itemBar.items;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  [_itemBar setItems:items];
}

- (UITabBarItem *)selectedItem {
  return _itemBar.selectedItem;
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  [_itemBar setSelectedItem:selectedItem];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem animated:(BOOL)animated {
  [_itemBar setSelectedItem:selectedItem animated:animated];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
  if (_barTintColor != barTintColor && ![_barTintColor isEqual:barTintColor]) {
    _barTintColor = barTintColor;

    // Update background color.
    _itemBar.backgroundColor = barTintColor;
  }
}

- (void)setInkColor:(UIColor *)inkColor {
  if (_inkColor != inkColor && ![_inkColor isEqual:inkColor]) {
    _inkColor = inkColor;

    [self updateItemBarStyle];
  }
}

- (MDCTabBarAlignment)alignment {
  return MDCTabBarAlignmentForItemBarAlignment(_itemBar.alignment);
}

- (void)setAlignment:(MDCTabBarAlignment)alignment {
  [_itemBar setAlignment:MDCItemBarAlignmentForTabBarAlignment(alignment)];
}

- (void)setAlignment:(MDCTabBarAlignment)alignment animated:(BOOL)animated {
  [_itemBar setAlignment:MDCItemBarAlignmentForTabBarAlignment(alignment) animated:animated];
}

- (void)setItemAppearance:(MDCTabBarItemAppearance)itemAppearance {
  if (itemAppearance != _itemAppearance) {
    _itemAppearance = itemAppearance;

    [self updateItemBarStyle];
  }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  if (_selectedItemTintColor != selectedItemTintColor &&
      ![_selectedItemTintColor isEqual:selectedItemTintColor]) {
    _selectedItemTintColor = selectedItemTintColor;

    [self updateItemBarStyle];
  }
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  if (_unselectedItemTintColor != unselectedItemTintColor &&
      ![_unselectedItemTintColor isEqual:unselectedItemTintColor]) {
    _unselectedItemTintColor = unselectedItemTintColor;

    [self updateItemBarStyle];
  }
}

- (void)setDisplaysUppercaseTitles:(BOOL)displaysUppercaseTitles {
  if (displaysUppercaseTitles != _displaysUppercaseTitles) {
    _displaysUppercaseTitles = displaysUppercaseTitles;

    [self updateItemBarStyle];
  }
}

#pragma mark - MDCItemBarDelegate

- (void)itemBar:(MDCItemBar *)itemBar didSelectItem:(UITabBarItem *)item {
  id<MDCTabBarDelegate> delegate = self.delegate;
  [delegate tabBar:self didSelectItem:item];
}

- (void)itemBar:(MDCItemBar *)itemBar willSelectItem:(UITabBarItem *)item {
  id<MDCTabBarDelegate> delegate = self.delegate;
  [delegate tabBar:self willSelectItem:item];
}

#pragma mark - UIView

- (void)tintColorDidChange {
  [super tintColorDidChange];

  [self updateItemBarStyle];
}

- (CGSize)intrinsicContentSize {
  return _itemBar.intrinsicContentSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [_itemBar sizeThatFits:size];
}

#pragma mark - Private

+ (MDCItemBarStyle *)defaultStyleForItemAppearance:(MDCTabBarItemAppearance)appearance {
  MDCItemBarStyle *style = [[MDCItemBarStyle alloc] init];

  style.shouldDisplaySelectionIndicator = YES;
  style.shouldDisplayBadge = YES;
  style.shouldGrowOnSelection = NO;
  style.titleFont = [MDCTypography buttonFont];
  style.inkStyle = MDCInkStyleBounded;
  style.titleImagePadding =
      (kImageTitleSpecPadding + kImageTitlePaddingAdjustment);

  switch (appearance) {
    case MDCTabBarItemAppearanceImages:
      style.shouldDisplayImage = YES;
      style.shouldDisplayTitle = NO;
      style.defaultHeight = kImageOnlyBarHeight;
      break;

    case MDCTabBarItemAppearanceTitles:
      style.shouldDisplayImage = NO;
      style.shouldDisplayTitle = YES;
      style.defaultHeight = kTitleOnlyBarHeight;
      break;

    case MDCTabBarItemAppearanceTitledImages:
      style.shouldDisplayImage = YES;
      style.shouldDisplayTitle = YES;
      style.defaultHeight = kTitledImageBarHeight;
      break;
  }

  return style;
}

- (void)updateItemBarStyle {
  MDCItemBarStyle *style;

  style = [[self class] defaultStyleForItemAppearance:_itemAppearance];

  style.selectionIndicatorColor = self.tintColor;
  style.inkColor = _inkColor;
  style.selectedTitleColor = (_selectedItemTintColor ?: self.tintColor);
  style.titleColor = _unselectedItemTintColor;
  style.displaysUppercaseTitles = _displaysUppercaseTitles;

  [_itemBar applyStyle:style];
}

@end
