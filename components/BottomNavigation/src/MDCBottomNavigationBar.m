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
#import "MaterialPalettes.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "private/MDCBottomNavigationBar+Private.h"
#import "private/MDCBottomNavigationItemView.h"
#import "private/MaterialBottomNavigationStrings.h"
#import "private/MaterialBottomNavigationStrings_table.h"

// The Bundle for string resources.
static NSString *const kBundleName = @"MaterialBottomNavigation.bundle";

// KVO context
static char *const kKVOContextMDCBottomNavigationBar = "kKVOContextMDCBottomNavigationBar";

static const CGFloat kMinItemWidth = 80;
static const CGFloat kPreferredItemWidth = 120;
static const CGFloat kMaxItemWidth = 168;
// The amount of internal padding on the leading/trailing edges of each bar item.
static const CGFloat kItemHorizontalPadding = 12;
static const CGFloat kBarHeightStackedTitle = 56;
static const CGFloat kBarHeightAdjacentTitle = 40;
static const CGFloat kItemsHorizontalMargin = 12;

static NSString *const kOfAnnouncement = @"of";

@interface MDCBottomNavigationBar () <MDCInkTouchControllerDelegate,
                                      MDCRippleTouchControllerDelegate>

// Declared in MDCBottomNavigationBar (ToBeDeprecated)
@property(nonatomic, assign) BOOL sizeThatFitsIncludesSafeArea;

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
@property(nonatomic, strong) UILayoutGuide *barItemsLayoutGuide NS_AVAILABLE_IOS(9_0);
@end

@implementation MDCBottomNavigationBar

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;

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
  _itemsContentHorizontalMargin = kItemsHorizontalMargin;
  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];
  _selectedItemTitleColor = _selectedItemTintColor;
  _titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _alignment = MDCBottomNavigationBarAlignmentJustified;
  _itemsDistributed = YES;
  _barTintColor = [UIColor whiteColor];
  _truncatesLongTitles = YES;
  _sizeThatFitsIncludesSafeArea = NO;
  _titlesNumberOfLines = 1;
  _mdc_overrideBaseElevation = -1;
  _itemBadgeTextColor = UIColor.whiteColor;
  _itemBadgeBackgroundColor = MDCPalette.redPalette.tint700;
  ;

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
  UIColor *defaultShadowColor = UIColor.blackColor;
  _shadowColor = defaultShadowColor;
  self.layer.shadowColor = defaultShadowColor.CGColor;
  _itemViews = [NSMutableArray array];
  _itemTitleFont = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];

  _barItemsLayoutGuide = [[UILayoutGuide alloc] init];
  _barItemsLayoutGuide.identifier = @"MDCBottomNavigationBarItemsLayoutGuide";
  [_itemsLayoutView addLayoutGuide:_barItemsLayoutGuide];
  [_barItemsLayoutGuide.bottomAnchor constraintEqualToAnchor:_itemsLayoutView.bottomAnchor].active =
      YES;
  [_barItemsLayoutGuide.topAnchor constraintEqualToAnchor:_itemsLayoutView.topAnchor].active = YES;
  [_barItemsLayoutGuide.leadingAnchor constraintEqualToAnchor:_itemsLayoutView.leadingAnchor]
      .active = YES;
  [_barItemsLayoutGuide.trailingAnchor constraintEqualToAnchor:_itemsLayoutView.trailingAnchor]
      .active = YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect standardBounds = CGRectStandardize(self.bounds);
  self.blurEffectView.frame = standardBounds;
  self.barView.frame = standardBounds;
  self.layer.shadowColor = self.shadowColor.CGColor;

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
  BOOL elevationChanged = !MDCCGFloatEqual(_elevation, elevation);
  _elevation = elevation;
  [(MDCShadowLayer *)self.layer setElevation:elevation];
  if (elevationChanged) {
    [self mdc_elevationDidChange];
  }
}

- (void)setShadowColor:(UIColor *)shadowColor {
  UIColor *shadowColorCopy = [shadowColor copy];
  _shadowColor = shadowColorCopy;
  self.layer.shadowColor = shadowColorCopy.CGColor;
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

- (NSArray<NSString *> *)kvoKeyPaths {
  static NSArray<NSString *> *keyPaths;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    keyPaths = @[
      NSStringFromSelector(@selector(badgeColor)), NSStringFromSelector(@selector(badgeValue)),
      NSStringFromSelector(@selector(title)), NSStringFromSelector(@selector(image)),
      NSStringFromSelector(@selector(selectedImage)),
      NSStringFromSelector(@selector(accessibilityValue)),
      NSStringFromSelector(@selector(accessibilityLabel)),
      NSStringFromSelector(@selector(accessibilityHint)),
      NSStringFromSelector(@selector(accessibilityIdentifier)),
      NSStringFromSelector(@selector(isAccessibilityElement)),
      NSStringFromSelector(@selector(titlePositionAdjustment))
    ];
  });
  return keyPaths;
}

- (void)addObserversToTabBarItems {
  NSArray<NSString *> *keyPaths = [self kvoKeyPaths];
  for (UITabBarItem *item in self.items) {
    for (NSString *keyPath in keyPaths) {
      [item addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:kKVOContextMDCBottomNavigationBar];
    }
  }
}

- (void)removeObserversFromTabBarItems {
  NSArray<NSString *> *keyPaths = [self kvoKeyPaths];
  for (UITabBarItem *item in self.items) {
    for (NSString *keyPath in keyPaths) {
      @try {
        [item removeObserver:self forKeyPath:keyPath context:kKVOContextMDCBottomNavigationBar];
      } @catch (NSException *exception) {
        if (exception) {
          // No need to do anything if there are no observers.
        }
      }
    }
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (context == kKVOContextMDCBottomNavigationBar) {
    if (!object) {
      return;
    }
    NSUInteger itemIndex = [self.items indexOfObject:object];
    if (itemIndex == NSNotFound || itemIndex >= _itemViews.count) {
      return;
    }
    id newValue = [object valueForKey:keyPath];
    if (newValue == [NSNull null]) {
      newValue = nil;
    }

    MDCBottomNavigationItemView *itemView = _itemViews[itemIndex];
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(badgeColor))]) {
      itemView.badgeColor = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(accessibilityValue))]) {
      itemView.accessibilityValue = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(badgeValue))]) {
      itemView.badgeValue = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(image))]) {
      itemView.image = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(selectedImage))]) {
      itemView.selectedImage = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
      itemView.title = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(accessibilityIdentifier))]) {
      itemView.accessibilityElementIdentifier = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(accessibilityLabel))]) {
      itemView.accessibilityLabel = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(accessibilityHint))]) {
      itemView.accessibilityHint = newValue;
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(isAccessibilityElement))]) {
      itemView.isAccessibilityElement = [newValue boolValue];
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(titlePositionAdjustment))]) {
      itemView.titlePositionAdjustment = [newValue UIOffsetValue];
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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

- (UITabBarItem *)tabBarItemForPoint:(CGPoint)point {
  for (NSUInteger i = 0; (i < self.itemViews.count) && (i < self.items.count); i++) {
    UIView *itemView = self.itemViews[i];
    BOOL isPointInView = CGRectContainsPoint(itemView.frame, point);
    if (isPointInView) {
      return self.items[i];
    }
  }

  return nil;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

#pragma mark - Touch handlers

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
    itemView.titleNumberOfLines = self.titlesNumberOfLines;
    itemView.itemTitleFont = self.itemTitleFont;
    itemView.selectedItemTintColor = self.selectedItemTintColor;
    itemView.selectedItemTitleColor = self.selectedItemTitleColor;
    itemView.unselectedItemTintColor = self.unselectedItemTintColor;
    itemView.titleVisibility = self.titleVisibility;
    itemView.titleBelowIcon = self.isTitleBelowIcon;
    itemView.accessibilityValue = item.accessibilityValue;
    itemView.accessibilityElementIdentifier = item.accessibilityIdentifier;
    itemView.accessibilityLabel = item.accessibilityLabel;
    itemView.accessibilityHint = item.accessibilityHint;
    itemView.isAccessibilityElement = item.isAccessibilityElement;
    itemView.contentVerticalMargin = self.itemsContentVerticalMargin;
    itemView.contentHorizontalMargin = self.itemsContentHorizontalMargin;
    itemView.truncatesTitle = self.truncatesLongTitles;
    itemView.titlePositionAdjustment = item.titlePositionAdjustment;
    itemView.badgeColor = self.itemBadgeBackgroundColor;
    itemView.badgeTextColor = self.itemBadgeTextColor;
    MDCInkTouchController *controller = [[MDCInkTouchController alloc] initWithView:itemView];
    controller.delegate = self;
    [self.inkControllers addObject:controller];
    itemView.rippleTouchController.delegate = self;

    if (self.shouldPretendToBeATabBar) {
      NSString *key = kMaterialBottomNavigationStringTable
          [kStr_MaterialBottomNavigationItemCountAccessibilityHint];
      NSString *itemOfTotalString = NSLocalizedStringFromTableInBundle(
          key, kMaterialBottomNavigationStringsTableName, [[self class] bundle], kOfString);
      NSString *localizedPosition =
          [NSString localizedStringWithFormat:itemOfTotalString, (i + 1), (int)items.count];
      // Allow a custom `accessibilityHint` to be assigned even if "faking" a tab bar is enabled.
      if (itemView.button.accessibilityHint.length) {
        itemView.button.accessibilityHint =
            [NSString stringWithFormat:@"%@. %@", localizedPosition, itemView.accessibilityHint];
      } else {
        itemView.button.accessibilityHint = localizedPosition;
      }
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

- (void)setTitlesNumberOfLines:(NSInteger)titlesNumberOfLines {
  _titlesNumberOfLines = titlesNumberOfLines;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleNumberOfLines = titlesNumberOfLines;
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

- (void)setItemBadgeTextColor:(UIColor *)itemBadgeTextColor {
  _itemBadgeTextColor = itemBadgeTextColor;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.badgeTextColor = itemBadgeTextColor;
  }
}

- (void)setItemBadgeBackgroundColor:(UIColor *)itemBadgeBackgroundColor {
  _itemBadgeBackgroundColor = itemBadgeBackgroundColor;
  for (NSUInteger i = 0; i < self.items.count; ++i) {
    UITabBarItem *item = self.items[i];
    if (@available(iOS 10.0, *)) {
      // Skip items with a custom color
      if (item.badgeColor) {
        continue;
      }
    }
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.badgeColor = itemBadgeBackgroundColor;
  }
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
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kBundleName]];
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

- (BOOL)inkTouchController:(MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  if (self.enableRippleBehavior) {
    return NO;
  }
  return YES;
}

#pragma mark - MDCRippleTouchControllerDelegate methods

- (BOOL)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location {
  if (self.enableRippleBehavior) {
    return YES;
  }
  return NO;
}

#pragma mark - MDCElevation

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

@end
