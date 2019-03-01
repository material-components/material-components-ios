// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

#import "MDCBottomNavigationBar.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialMath.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "private/MDCBottomNavigationItemView.h"
#import "private/MaterialBottomNavigationStrings.h"
#import "private/MaterialBottomNavigationStrings_table.h"

// The Bundle for string resources.
static NSString *const kMaterialBottomNavigationBundle = @"MaterialBottomNavigation.bundle";

static const CGFloat kMinItemWidth = 80;
static const CGFloat kPreferredItemWidth = 120;
static const CGFloat kMaxItemWidth = 168;
// The amount of internal padding on the leading/trailing edges of each bar item.
static const CGFloat kItemHorizontalPadding = 12;
static const CGFloat kBarHeightStackedTitle = 56;
static const CGFloat kBarHeightAdjacentTitle = 40;
static const CGFloat kMDCBottomNavigationBarItemsHorizontalMargin = 12;
static NSString *const kMDCBottomNavigationBarBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationBarBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationBarAccessibilityValueString = @"accessibilityValue";
static NSString *const kMDCBottomNavigationBarImageString = @"image";
static NSString *const kMDCBottomNavigationBarSelectedImageString = @"selectedImage";
// TODO: - Change to NSKeyValueChangeNewKey
static NSString *const kMDCBottomNavigationBarNewString = @"new";
static NSString *const kMDCBottomNavigationBarTitleString = @"title";
static NSString *const kMDCBottomNavigationBarAccessibilityIdentifier = @"accessibilityIdentifier";
static NSString *const kMDCBottomNavigationBarAccessibilityLabel = @"accessibilityLabel";
static NSString *const kMDCBottomNavigationBarAccessibilityHint = @"accessibilityHint";
static NSString *const kMDCBottomNavigationBarIsAccessibilityElement = @"isAccessibilityElement";
static NSString *const kTitlePositionAdjustment = @"titlePositionAdjustment";

static NSString *const kMDCBottomNavigationBarOfAnnouncement = @"of";

@interface MDCBottomNavigationBar () <MDCInkTouchControllerDelegate>

@property(nonatomic, assign) BOOL itemsDistributed;
@property(nonatomic, readonly) BOOL isTitleBelowIcon;
@property(nonatomic, assign) CGFloat maxLandscapeClusterContainerWidth;
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@property(nonatomic, readonly) UIEdgeInsets mdc_safeAreaInsets;
@property(nonatomic, strong) UIView *barView;
@property(nonatomic, assign) CGRect itemLayoutFrame;
@property(nonatomic, strong) UIVisualEffectView *blurEffectView;
@property(nonatomic, strong) UIView *itemsLayoutView;
@property(nonatomic, strong) NSMutableArray *inkControllers;
@property(nonatomic) BOOL shouldPretendToBeATabBar;
@property(nonatomic, strong) UILayoutGuide *barItemsLayoutGuide;
@end

@implementation MDCBottomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
    self.isAccessibilityElement = NO;
    [self commonMDCBottomNavigationBarInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationBarInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationBarInit {
  _itemsContentHorizontalMargin = kMDCBottomNavigationBarItemsHorizontalMargin;
  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];
  _selectedItemTitleColor = _selectedItemTintColor;
  _titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _alignment = MDCBottomNavigationBarAlignmentJustified;
  _itemsDistributed = YES;
  _barTintColor = [UIColor whiteColor];
  _truncatesLongTitles = YES;
  _sizeThatFitsIncludesSafeArea = YES;

  // Remove any unarchived subviews and reconfigure the view hierarchy
  if (self.subviews.count) {
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
      [view removeFromSuperview];
    }
  }

  UIBlurEffect *defaultBlurEffect = [UIBlurEffect effectWithStyle:_backgroundBlurEffectStyle];
  _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:defaultBlurEffect];
  _blurEffectView.hidden = !_backgroundBlurEnabled;
  _blurEffectView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self addSubview:_blurEffectView];  // Needs to always be at the bottom

  _barView = [[UIView alloc] init];
  _barView.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  _barView.clipsToBounds = YES;
  _barView.backgroundColor = _barTintColor;
  [self addSubview:_barView];

  _itemsLayoutView = [[UIView alloc] initWithFrame:CGRectZero];
  // By default, the autoresizing mask pins the itemsLayoutView to the top and bottom of the bar.
  // However, if the `barItemsLayoutGuide` has a constraint moving the position of the view, those
  // can override the autoresizing mask.
  _itemsLayoutView.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  _itemsLayoutView.clipsToBounds = NO;
  [_barView addSubview:_itemsLayoutView];

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
  if (&UIAccessibilityTraitTabBar != NULL) {
    _itemsLayoutView.accessibilityTraits = UIAccessibilityTraitTabBar;
  } else {
    _shouldPretendToBeATabBar = YES;
  }
#pragma clang diagnostic pop
#else
  _shouldPretendToBeATabBar = YES;
#endif
  _elevation = MDCShadowElevationBottomNavigationBar;
  [(MDCShadowLayer *)self.layer setElevation:_elevation];
  _itemViews = [NSMutableArray array];
  _itemTitleFont = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];

  if (@available(iOS 9.0, *)) {
    _barItemsLayoutGuide = [[UILayoutGuide alloc] init];
    _barItemsLayoutGuide.identifier = @"MDCBottomNavigationBarItemsLayoutGuide";
    [_itemsLayoutView addLayoutGuide:_barItemsLayoutGuide];
    [_barItemsLayoutGuide.bottomAnchor constraintEqualToAnchor:_itemsLayoutView.bottomAnchor]
        .active = YES;
    [_barItemsLayoutGuide.topAnchor constraintEqualToAnchor:_itemsLayoutView.topAnchor].active =
        YES;
    [_barItemsLayoutGuide.leadingAnchor constraintEqualToAnchor:_itemsLayoutView.leadingAnchor]
        .active = YES;
    [_barItemsLayoutGuide.trailingAnchor constraintEqualToAnchor:_itemsLayoutView.trailingAnchor]
        .active = YES;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect standardBounds = CGRectStandardize(self.bounds);
  self.blurEffectView.frame = standardBounds;
  self.barView.frame = standardBounds;

  CGSize size = standardBounds.size;
  if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
    [self layoutLandscapeModeWithBottomNavSize:size containerWidth:size.width];
  } else {
    [self sizeItemsLayoutViewItemsDistributed:YES withBottomNavSize:size containerWidth:size.width];
  }
  [self layoutItemViews];
}

- (void)safeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];
  }
  [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize {
  CGFloat height = self.isTitleBelowIcon ? kBarHeightStackedTitle : kBarHeightAdjacentTitle;
  CGFloat itemWidth = [self widthForItemsWhenCenteredWithAvailableWidth:CGFLOAT_MAX height:height];
  CGSize size = CGSizeMake(itemWidth * self.items.count, height);
  return size;
}

- (NSLayoutYAxisAnchor *)barItemsBottomAnchor {
  return self.barItemsLayoutGuide.bottomAnchor;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat height = kBarHeightStackedTitle;
  if (self.alignment == MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles &&
      self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
    height = kBarHeightAdjacentTitle;
  }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  if (@available(iOS 11.0, *)) {
    if (self.sizeThatFitsIncludesSafeArea) {
      height += self.safeAreaInsets.bottom;
    }
  }
#pragma clang diagnostic pop

  return CGSizeMake(size.width, height);
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setElevation:(MDCShadowElevation)elevation {
  _elevation = elevation;
  [(MDCShadowLayer *)self.layer setElevation:elevation];
}

- (BOOL)isTitleBelowIcon {
  switch (self.alignment) {
    case MDCBottomNavigationBarAlignmentJustified:
      return YES;
      break;
    case MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles:
      return self.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassRegular;
      break;
    case MDCBottomNavigationBarAlignmentCentered:
      return YES;
      break;
  }
}

- (void)layoutLandscapeModeWithBottomNavSize:(CGSize)bottomNavSize
                              containerWidth:(CGFloat)containerWidth {
  switch (self.alignment) {
    case MDCBottomNavigationBarAlignmentJustified:
      [self sizeItemsLayoutViewItemsDistributed:YES
                              withBottomNavSize:bottomNavSize
                                 containerWidth:containerWidth];
      break;
    case MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles:
      [self sizeItemsLayoutViewItemsDistributed:YES
                              withBottomNavSize:bottomNavSize
                                 containerWidth:containerWidth];
      break;
    case MDCBottomNavigationBarAlignmentCentered:
      [self sizeItemsLayoutViewItemsDistributed:NO
                              withBottomNavSize:bottomNavSize
                                 containerWidth:containerWidth];
      break;
  }
}

- (CGFloat)widthForItemsWhenCenteredWithAvailableWidth:(CGFloat)availableWidth
                                                height:(CGFloat)barHeight {
  CGFloat maxItemWidth = kPreferredItemWidth;
  for (UIView *itemView in self.itemViews) {
    maxItemWidth =
        MAX(maxItemWidth, [itemView sizeThatFits:CGSizeMake(availableWidth, barHeight)].width +
                              kItemHorizontalPadding * 2);
  }
  maxItemWidth = MIN(kMaxItemWidth, maxItemWidth);
  CGFloat totalWidth = maxItemWidth * self.items.count;
  if (totalWidth > availableWidth) {
    maxItemWidth = availableWidth / self.items.count;
  }
  if (maxItemWidth < kMinItemWidth) {
    maxItemWidth = kMinItemWidth;
  }
  return maxItemWidth;
}

- (void)sizeItemsLayoutViewItemsDistributed:(BOOL)itemsDistributed
                          withBottomNavSize:(CGSize)bottomNavSize
                             containerWidth:(CGFloat)containerWidth {
  CGFloat barHeight = self.isTitleBelowIcon ? kBarHeightStackedTitle : kBarHeightAdjacentTitle;
  UIEdgeInsets insets = self.mdc_safeAreaInsets;
  CGFloat bottomNavWidthInset = bottomNavSize.width - insets.left - insets.right;
  if (itemsDistributed) {
    self.itemsLayoutView.frame = CGRectMake(insets.left, 0, bottomNavWidthInset, barHeight);
    self.itemLayoutFrame = CGRectMake(0, 0, CGRectGetWidth(self.itemsLayoutView.frame), barHeight);
  } else {
    CGFloat maxItemWidth = [self widthForItemsWhenCenteredWithAvailableWidth:bottomNavWidthInset
                                                                      height:barHeight];
    CGFloat layoutFrameWidth = maxItemWidth * self.items.count;
    layoutFrameWidth = MIN(bottomNavWidthInset, layoutFrameWidth);
    containerWidth = MIN(bottomNavWidthInset, MAX(containerWidth, layoutFrameWidth));
    CGFloat clusteredOffsetX = (bottomNavSize.width - containerWidth) / 2;
    self.itemsLayoutView.frame = CGRectMake(clusteredOffsetX, 0, containerWidth, barHeight);
    CGFloat itemLayoutFrameOffsetX = (containerWidth - layoutFrameWidth) / 2;
    self.itemLayoutFrame = CGRectMake(itemLayoutFrameOffsetX, 0, layoutFrameWidth, barHeight);
  }
}

- (void)layoutItemViews {
  UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  NSInteger numItems = self.items.count;
  if (numItems == 0) {
    return;
  }
  CGFloat navBarHeight = CGRectGetHeight(self.itemsLayoutView.bounds);
  CGFloat itemWidth = CGRectGetWidth(self.itemLayoutFrame) / numItems;
  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.titleBelowIcon = self.isTitleBelowIcon;
    if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
      itemView.frame =
          CGRectMake(CGRectGetMinX(self.itemLayoutFrame) + i * itemWidth + kItemHorizontalPadding,
                     0, itemWidth - 2 * kItemHorizontalPadding, navBarHeight);
    } else {
      itemView.frame = CGRectMake(
          CGRectGetMaxX(self.itemLayoutFrame) - (i + 1) * itemWidth + kItemHorizontalPadding, 0,
          itemWidth - 2 * kItemHorizontalPadding, navBarHeight);
    }
  }
}

- (void)dealloc {
  [self removeObserversFromTabBarItems];
}

- (void)addObserversToTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarBadgeColorString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarBadgeValueString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarAccessibilityValueString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarSelectedImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarTitleString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarAccessibilityIdentifier
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarAccessibilityLabel
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarAccessibilityHint
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarIsAccessibilityElement
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kTitlePositionAdjustment
              options:NSKeyValueObservingOptionNew
              context:nil];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    @try {
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeColorString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeValueString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarAccessibilityValueString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarImageString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarSelectedImageString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarTitleString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarAccessibilityIdentifier];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarAccessibilityLabel];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarAccessibilityHint];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarIsAccessibilityElement];
      [item removeObserver:self forKeyPath:kTitlePositionAdjustment];
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
    MDCBottomNavigationItemView *itemView = _itemViews[selectedItemNum];
    if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeColorString]) {
      itemView.badgeColor = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarAccessibilityValueString]) {
      itemView.accessibilityValue = change[NSKeyValueChangeNewKey];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeValueString]) {
      itemView.badgeValue = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarImageString]) {
      itemView.image = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarSelectedImageString]) {
      itemView.selectedImage = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarTitleString]) {
      itemView.title = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarAccessibilityIdentifier]) {
      itemView.accessibilityIdentifier = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarAccessibilityLabel]) {
      itemView.accessibilityLabel = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarAccessibilityHint]) {
      itemView.accessibilityHint = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarIsAccessibilityElement]) {
      itemView.isAccessibilityElement = [change[kMDCBottomNavigationBarNewString] boolValue];
    } else if ([keyPath isEqualToString:kTitlePositionAdjustment]) {
      itemView.titlePositionAdjustment = [change[kMDCBottomNavigationBarNewString] UIOffsetValue];
    }
  }
}

- (UIEdgeInsets)mdc_safeAreaInsets {
  UIEdgeInsets insets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    insets = self.safeAreaInsets;
  }
  return insets;
}

- (UIView *)viewForItem:(UITabBarItem *)item {
  NSUInteger itemIndex = [_items indexOfObject:item];
  if (itemIndex == NSNotFound) {
    return nil;
  }
  if (itemIndex >= _itemViews.count) {
    NSAssert(NO, @"Item index should not be out of item view bounds");
    return nil;
  }
  return _itemViews[itemIndex];
}

#pragma mark - Touch handlers

- (void)didTouchDownButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  CGPoint centerPoint =
      CGPointMake(CGRectGetMidX(itemView.inkView.bounds), CGRectGetMidY(itemView.inkView.bounds));
  [itemView.inkView startTouchBeganAnimationAtPoint:centerPoint completion:nil];
}

- (void)didTouchUpInsideButton:(UIButton *)button {
  for (NSUInteger i = 0; i < self.items.count; i++) {
    UITabBarItem *item = self.items[i];
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (itemView.button == button) {
      BOOL shouldSelect = YES;
      if ([self.delegate respondsToSelector:@selector(bottomNavigationBar:shouldSelectItem:)]) {
        shouldSelect = [self.delegate bottomNavigationBar:self shouldSelectItem:item];
      }
      if (shouldSelect) {
        [self setSelectedItem:item animated:YES];
        if ([self.delegate respondsToSelector:@selector(bottomNavigationBar:didSelectItem:)]) {
          [self.delegate bottomNavigationBar:self didSelectItem:item];
        }
      }
    }
  }
}

- (void)didTouchUpOutsideButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView.inkView startTouchEndedAnimationAtPoint:CGPointZero completion:nil];
}

- (void)didCancelTouchesForButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView.inkView cancelAllAnimationsAnimated:NO];
}

#pragma mark - Setters

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  if ([_items isEqual:items] || _items == items) {
    return;
  }

  // Remove existing item views from the bottom navigation so it can be repopulated with new items.
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    [itemView removeFromSuperview];
  }
  [self.itemViews removeAllObjects];
  [self.inkControllers removeAllObjects];
  if (!self.inkControllers) {
    _inkControllers = [@[] mutableCopy];
  }
  [self removeObserversFromTabBarItems];

  _items = [items copy];

  for (NSUInteger i = 0; i < items.count; i++) {
    UITabBarItem *item = items[i];
    MDCBottomNavigationItemView *itemView =
        [[MDCBottomNavigationItemView alloc] initWithFrame:CGRectZero];
    itemView.title = item.title;
    itemView.itemTitleFont = self.itemTitleFont;
    itemView.selectedItemTintColor = self.selectedItemTintColor;
    itemView.selectedItemTitleColor = self.selectedItemTitleColor;
    itemView.unselectedItemTintColor = self.unselectedItemTintColor;
    itemView.titleVisibility = self.titleVisibility;
    itemView.titleBelowIcon = self.isTitleBelowIcon;
    itemView.accessibilityValue = item.accessibilityValue;
    itemView.accessibilityIdentifier = item.accessibilityIdentifier;
    itemView.accessibilityLabel = item.accessibilityLabel;
    itemView.accessibilityHint = item.accessibilityHint;
    itemView.isAccessibilityElement = item.isAccessibilityElement;
    itemView.contentVerticalMargin = self.itemsContentVerticalMargin;
    itemView.contentHorizontalMargin = self.itemsContentHorizontalMargin;
    itemView.truncatesTitle = self.truncatesLongTitles;
    itemView.titlePositionAdjustment = item.titlePositionAdjustment;
    MDCInkTouchController *controller = [[MDCInkTouchController alloc] initWithView:itemView];
    controller.delegate = self;
    [self.inkControllers addObject:controller];

    if (self.shouldPretendToBeATabBar) {
      NSString *key = kMaterialBottomNavigationStringTable
          [kStr_MaterialBottomNavigationItemCountAccessibilityHint];
      NSString *itemOfTotalString = NSLocalizedStringFromTableInBundle(
          key, kMaterialBottomNavigationStringsTableName, [[self class] bundle],
          kMDCBottomNavigationBarOfString);
      NSString *localizedPosition =
          [NSString localizedStringWithFormat:itemOfTotalString, (i + 1), (int)items.count];
      itemView.button.accessibilityHint = localizedPosition;
    }
    if (item.image) {
      itemView.image = item.image;
    }
    if (item.selectedImage) {
      itemView.selectedImage = item.selectedImage;
    }
    if (item.badgeValue) {
      itemView.badgeValue = item.badgeValue;
    }
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
    NSOperatingSystemVersion iOS10Version = {10, 0, 0};
    if ([NSProcessInfo.processInfo isOperatingSystemAtLeastVersion:iOS10Version]) {
      if (item.badgeColor) {
        itemView.badgeColor = item.badgeColor;
      }
    }
#pragma clang diagnostic pop
#endif
    itemView.selected = NO;
    [itemView.button addTarget:self
                        action:@selector(didTouchUpInsideButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.itemViews addObject:itemView];
    [self.itemsLayoutView addSubview:itemView];
  }
  self.selectedItem = nil;
  [self addObserversToTabBarItems];
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  [self setSelectedItem:selectedItem animated:NO];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem animated:(BOOL)animated {
  if (_selectedItem == selectedItem) {
    return;
  }
  _selectedItem = selectedItem;
  for (NSUInteger i = 0; i < self.items.count; i++) {
    UITabBarItem *item = self.items[i];
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (selectedItem == item) {
      [itemView setSelected:YES animated:animated];
    } else {
      [itemView setSelected:NO animated:animated];
    }
  }
}

- (void)setItemsContentVerticalMargin:(CGFloat)itemsContentsVerticalMargin {
  if (MDCCGFloatEqual(_itemsContentVerticalMargin, itemsContentsVerticalMargin)) {
    return;
  }
  _itemsContentVerticalMargin = itemsContentsVerticalMargin;
  for (NSUInteger i = 0; i < self.items.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.contentVerticalMargin = itemsContentsVerticalMargin;
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setItemsContentHorizontalMargin:(CGFloat)itemsContentHorizontalMargin {
  if (MDCCGFloatEqual(_itemsContentHorizontalMargin, itemsContentHorizontalMargin)) {
    return;
  }
  _itemsContentHorizontalMargin = itemsContentHorizontalMargin;
  for (NSUInteger i = 0; i < self.items.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.contentHorizontalMargin = itemsContentHorizontalMargin;
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setTruncatesLongTitles:(BOOL)truncatesLongTitles {
  _truncatesLongTitles = truncatesLongTitles;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.truncatesTitle = truncatesLongTitles;
    [itemView setNeedsLayout];
  }
  [self setNeedsLayout];
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  _selectedItemTitleColor = selectedItemTintColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.selectedItemTintColor = selectedItemTintColor;
  }
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.unselectedItemTintColor = unselectedItemTintColor;
  }
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
  _selectedItemTitleColor = selectedItemTitleColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.selectedItemTitleColor = selectedItemTitleColor;
  }
}

- (void)setTitleVisibility:(MDCBottomNavigationBarTitleVisibility)titleVisibility {
  _titleVisibility = titleVisibility;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleVisibility = titleVisibility;
  }
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.itemTitleFont = itemTitleFont;
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
  _barTintColor = barTintColor;
  self.barView.backgroundColor = barTintColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  self.barView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.barView.backgroundColor;
}

- (void)setBackgroundBlurEffectStyle:(UIBlurEffectStyle)backgroundBlurEffectStyle {
  if (_backgroundBlurEffectStyle == backgroundBlurEffectStyle) {
    return;
  }
  _backgroundBlurEffectStyle = backgroundBlurEffectStyle;
  self.blurEffectView.effect = [UIBlurEffect effectWithStyle:_backgroundBlurEffectStyle];
}

- (void)setBackgroundBlurEnabled:(BOOL)backgroundBlurEnabled {
  if (_backgroundBlurEnabled == backgroundBlurEnabled) {
    return;
  }
  _backgroundBlurEnabled = backgroundBlurEnabled;

  self.blurEffectView.hidden = !_backgroundBlurEnabled;
}

- (void)setAlignment:(MDCBottomNavigationBarAlignment)alignment {
  if (_alignment == alignment) {
    return;
  }
  _alignment = alignment;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleBelowIcon = self.isTitleBelowIcon;
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialBottomNavigationBundle]];
  });
  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCBottomNavigationBar class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

#pragma mark - MDCInkTouchControllerDelegate methods

- (MDCInkView *)inkTouchController:(MDCInkTouchController *)inkTouchController
            inkViewAtTouchLocation:(CGPoint)location {
  if ([inkTouchController.view isKindOfClass:[MDCBottomNavigationItemView class]]) {
    return ((MDCBottomNavigationItemView *)inkTouchController.view).inkView;
  }
  return nil;
}

@end
