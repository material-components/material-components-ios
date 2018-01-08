/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import <CoreGraphics/CoreGraphics.h>

#import "MDCBottomNavigationBar.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialMath.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "private/MaterialBottomNavigationStrings.h"
#import "private/MaterialBottomNavigationStrings_table.h"
#import "private/MDCBottomNavigationItemView.h"

// The Bundle for string resources.
static NSString *const kMaterialBottomNavigationBundle = @"MaterialBottomNavigation.bundle";

static NSString *const kMDCBottomNavigationBarDelegateKey = @"kMDCBottomNavigationBarDelegateKey";
static NSString *const kMDCBottomNavigationBarTitleVisibilityKey =
    @"kMDCBottomNavigationBarTitleVisibilityKey";
static NSString *const kMDCBottomNavigationBarAlignmentKey = @"kMDCBottomNavigationBarAlignmentKey";
static NSString *const KMDCBottomNavigationBarItemsKey = @"KMDCBottomNavigationBarItemsKey";
static NSString *const kMDCBottomNavigationBarSelectedItemKey =
    @"kMDCBottomNavigationBarSelectedItemKey";
static NSString *const kMDCBottomNavigationBarItemTitleFontKey =
    @"kMDCBottomNavigationBarItemTitleFontKey";
static NSString *const kMDCBottomNavigationBarSelectedItemTintColorKey =
    @"kMDCBottomNavigationBarSelectedItemTintColorKey";
static NSString *const kMDCBottomNavigationBarUnselectedItemTintColorKey =
    @"kMDCBottomNavigationBarUnselectedItemTintColorKey";
static NSString *const kMDCBottomNavigationBarItemsDistributedKey =
    @"kMDCBottomNavigationBarItemsDistributedKey";
static NSString *const kMDCBottomNavigationBarTitleBelowItemKey =
    @"kMDCBottomNavigationBarTitleBelowItemKey";

static const CGFloat kMDCBottomNavigationBarHeight = 56.f;
static const CGFloat kMDCBottomNavigationBarHeightAdjacentTitles = 40.f;
static const CGFloat kMDCBottomNavigationBarLandscapeContainerWidth = 320.f;
static const MDCShadowElevation kMDCBottomNavigationBarElevation = 6.f;
static NSString *const kMDCBottomNavigationBarBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationBarBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationBarImageString = @"image";
static NSString *const kMDCBottomNavigationBarNewString = @"new";
static NSString *const kMDCBottomNavigationBarOfString = @"of";
static NSString *const kMDCBottomNavigationBarTitleString = @"title";

@interface MDCBottomNavigationBar ()

@property(nonatomic, assign) BOOL itemsDistributed;
@property(nonatomic, assign) BOOL titleBelowItem;
@property(nonatomic, assign) CGFloat maxLandscapeClusterContainerWidth;
@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@property(nonatomic, readonly) UIEdgeInsets mdc_safeAreaInsets;
@property(nonatomic, strong) UIView *containerView;

@end

@implementation MDCBottomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
    self.backgroundColor = [UIColor whiteColor];
    self.isAccessibilityElement = NO;
    [self commonMDCBottomNavigationBarInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationBarInit];

    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarDelegateKey]) {
      _delegate = [aDecoder decodeObjectForKey:kMDCBottomNavigationBarDelegateKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarTitleVisibilityKey]) {
      _titleVisibility = [aDecoder decodeIntegerForKey:kMDCBottomNavigationBarTitleVisibilityKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarAlignmentKey]) {
      _alignment = [aDecoder decodeIntegerForKey:kMDCBottomNavigationBarAlignmentKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarItemTitleFontKey]) {
      _itemTitleFont = [aDecoder decodeObjectForKey:kMDCBottomNavigationBarItemTitleFontKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarSelectedItemTintColorKey]) {
      _selectedItemTintColor =
          [aDecoder decodeObjectForKey:kMDCBottomNavigationBarSelectedItemTintColorKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarUnselectedItemTintColorKey]) {
      _unselectedItemTintColor =
          [aDecoder decodeObjectForKey:kMDCBottomNavigationBarUnselectedItemTintColorKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarItemsDistributedKey]) {
      _itemsDistributed = [aDecoder decodeBoolForKey:kMDCBottomNavigationBarItemsDistributedKey];
    }
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarTitleBelowItemKey]) {
      _titleBelowItem = [aDecoder decodeBoolForKey:kMDCBottomNavigationBarTitleBelowItemKey];
    }

    // Should be second-last due to KVO
    if ([aDecoder containsValueForKey:KMDCBottomNavigationBarItemsKey]) {
      self.items = [aDecoder decodeObjectForKey:KMDCBottomNavigationBarItemsKey];
    }
    // Should be last due to updating views
    if ([aDecoder containsValueForKey:kMDCBottomNavigationBarSelectedItemKey]) {
      self.selectedItem = [aDecoder decodeObjectForKey:kMDCBottomNavigationBarSelectedItemKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  if (self.delegate) {
    [aCoder encodeObject:self.delegate forKey:kMDCBottomNavigationBarDelegateKey];
  }
  [aCoder encodeInteger:self.titleVisibility forKey:kMDCBottomNavigationBarTitleVisibilityKey];
  [aCoder encodeInteger:self.alignment forKey:kMDCBottomNavigationBarAlignmentKey];
  [aCoder encodeObject:self.items forKey:KMDCBottomNavigationBarItemsKey];
  [aCoder encodeObject:self.selectedItem forKey:kMDCBottomNavigationBarSelectedItemKey];
  if (self.itemTitleFont) {
    [aCoder encodeObject:self.itemTitleFont forKey:kMDCBottomNavigationBarItemTitleFontKey];
  }
  if (self.selectedItemTintColor) {
    [aCoder encodeObject:self.selectedItemTintColor
                  forKey:kMDCBottomNavigationBarSelectedItemTintColorKey];
  }
  if (self.unselectedItemTintColor) {
    [aCoder encodeObject:self.unselectedItemTintColor
                  forKey:kMDCBottomNavigationBarUnselectedItemTintColorKey];
  }
  [aCoder encodeBool:self.itemsDistributed forKey:kMDCBottomNavigationBarItemsDistributedKey];
  [aCoder encodeBool:self.titleBelowItem forKey:kMDCBottomNavigationBarTitleBelowItemKey];
}

- (void)commonMDCBottomNavigationBarInit {
  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];
  _titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _alignment = MDCBottomNavigationBarAlignmentJustified;
  _itemsDistributed = YES;
  _titleBelowItem = YES;

  // Remove any unarchived subviews and reconfigure the view hierarchy
  if (self.subviews.count) {
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
      [view removeFromSuperview];
    }
  }
  _maxLandscapeClusterContainerWidth = kMDCBottomNavigationBarLandscapeContainerWidth;
  _containerView = [[UIView alloc] initWithFrame:CGRectZero];
  _containerView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin);
  _containerView.clipsToBounds = YES;
  [self addSubview:_containerView];
  [self setElevation:kMDCBottomNavigationBarElevation];
  _itemViews = [NSMutableArray array];
  _itemTitleFont = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize size = self.bounds.size;
  if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    [self layoutLandscapeModeWithBottomNavSize:size
                                containerWidth:self.maxLandscapeClusterContainerWidth];
  } else {
    [self sizeContainerViewItemsDistributed:YES withBottomNavSize:size containerWidth:size.width];
    self.titleBelowItem = YES;
  }
  [self layoutItemViews];
}

- (CGSize)sizeThatFits:(CGSize)size {
  self.maxLandscapeClusterContainerWidth = MIN(size.width, size.height);
  UIEdgeInsets insets = self.mdc_safeAreaInsets;
  CGFloat heightWithInset = kMDCBottomNavigationBarHeight + insets.bottom;
  if (self.alignment == MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles &&
      UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    heightWithInset = kMDCBottomNavigationBarHeightAdjacentTitles + insets.bottom;
  }
  CGSize insetSize = CGSizeMake(size.width, heightWithInset);
  return insetSize;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setElevation:(MDCShadowElevation)elevation {
  [(MDCShadowLayer *)self.layer setElevation:elevation];
}

- (void)layoutLandscapeModeWithBottomNavSize:(CGSize)bottomNavSize
                              containerWidth:(CGFloat)containerWidth {
  switch (self.alignment) {
    case MDCBottomNavigationBarAlignmentJustified:
      [self sizeContainerViewItemsDistributed:YES
                            withBottomNavSize:bottomNavSize
                               containerWidth:containerWidth];
      self.titleBelowItem = YES;
      break;
    case MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles:
      [self sizeContainerViewItemsDistributed:YES
                            withBottomNavSize:bottomNavSize
                               containerWidth:containerWidth];
      self.titleBelowItem = NO;
      break;
    case MDCBottomNavigationBarAlignmentCentered:
      [self sizeContainerViewItemsDistributed:NO
                            withBottomNavSize:bottomNavSize
                               containerWidth:containerWidth];
      self.titleBelowItem = YES;
      break;
  }
}

- (void)sizeContainerViewItemsDistributed:(BOOL)itemsDistributed
                        withBottomNavSize:(CGSize)bottomNavSize
                           containerWidth:(CGFloat)containerWidth {
  CGFloat barHeight = kMDCBottomNavigationBarHeight;
  if (self.alignment == MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles &&
      UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    barHeight = kMDCBottomNavigationBarHeightAdjacentTitles;
  }
  if (itemsDistributed) {
    UIEdgeInsets insets = self.mdc_safeAreaInsets;
    self.containerView.frame =
        CGRectMake(insets.left, 0, bottomNavSize.width - insets.left - insets.right, barHeight);
  } else {
    CGFloat clusteredOffsetX = (bottomNavSize.width - containerWidth) / 2;
    self.containerView.frame = CGRectMake(clusteredOffsetX, 0, containerWidth, barHeight);
  }
}

- (void)layoutItemViews {
  UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  NSInteger numItems = self.items.count;
  if (numItems == 0) {
    return;
  }
  CGFloat navBarWidth = CGRectGetWidth(self.containerView.bounds);
  CGFloat navBarHeight = CGRectGetHeight(self.containerView.bounds);
  CGFloat itemWidth = navBarWidth / numItems;
  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
      itemView.frame = CGRectMake(i * itemWidth, 0, itemWidth, navBarHeight);
    } else {
      itemView.frame =
          CGRectMake(navBarWidth - (i + 1) * itemWidth, 0,  itemWidth, navBarHeight);
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
           forKeyPath:kMDCBottomNavigationBarImageString
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:kMDCBottomNavigationBarTitleString
              options:NSKeyValueObservingOptionNew
              context:nil];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    @try {
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeColorString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarBadgeValueString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarImageString];
      [item removeObserver:self forKeyPath:kMDCBottomNavigationBarTitleString];
    }
    @catch (NSException *exception) {
      if (exception) {
        // No need to do anything if there are no observers.
      }
    }
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
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
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarBadgeValueString]) {
      itemView.badgeValue = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarImageString]) {
      itemView.image = change[kMDCBottomNavigationBarNewString];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationBarTitleString]) {
      itemView.title = change[kMDCBottomNavigationBarNewString];
    }
  }
}

- (UIEdgeInsets)mdc_safeAreaInsets {
  UIEdgeInsets insets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    insets = self.safeAreaInsets;
  }
#endif
  return insets;
}

#pragma mark - Touch handlers

- (void)didTouchDownButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  CGPoint centerPoint = CGPointMake(CGRectGetMidX(itemView.inkView.bounds),
                                    CGRectGetMidY(itemView.inkView.bounds));
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
      [itemView.inkView startTouchEndedAnimationAtPoint:CGPointZero completion:nil];
    }
  }
}

- (void)didTouchUpOutsideButton:(UIButton *)button {
  MDCBottomNavigationItemView *itemView = (MDCBottomNavigationItemView *)button.superview;
  [itemView.inkView startTouchEndedAnimationAtPoint:CGPointZero completion:nil];
}

#pragma mark - Setters

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  if (_items == items) {
    return;
  }

  // Remove existing item views from the bottom navigation so it can be repopulated with new items.
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    [itemView removeFromSuperview];
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
    itemView.unselectedItemTintColor = self.unselectedItemTintColor;
    itemView.titleVisibility = self.titleVisibility;
    itemView.titleBelowIcon = self.titleBelowItem;

    NSString *key =
        kMaterialBottomNavigationStringTable[kStr_MaterialBottomNavigationItemCountAccessibilityHint];
    NSString *itemOfTotalString =
        NSLocalizedStringFromTableInBundle(key,
                                           kMaterialBottomNavigationStringsTableName,
                                           [[self class] bundle],
                                           kMDCBottomNavigationBarOfString);
   NSString *localizedPosition =
        [NSString localizedStringWithFormat:itemOfTotalString, (i + 1), (int)items.count];
    itemView.button.accessibilityHint = localizedPosition;
    if (item.image) {
      itemView.image = item.image;
    }
    if (item.badgeValue) {
      itemView.badgeValue = item.badgeValue;
    }
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
      if (item.badgeColor) {
        itemView.badgeColor = item.badgeColor;
      }
    }
#pragma clang diagnostic pop
#endif
    itemView.selected = NO;
    [itemView.button addTarget:self
                        action:@selector(didTouchDownButton:)
              forControlEvents:UIControlEventTouchDown];
    [itemView.button addTarget:self
                        action:@selector(didTouchUpInsideButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [itemView.button addTarget:self
                        action:@selector(didTouchUpOutsideButton:)
              forControlEvents:UIControlEventTouchUpOutside];
    [self.itemViews addObject:itemView];
    [self.containerView addSubview:itemView];
  }
  [self addObserversToTabBarItems];
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

- (void)setTitleBelowItem:(BOOL)titleBelowItem {
  _titleBelowItem = titleBelowItem;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.titleBelowIcon = titleBelowItem;
  }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
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

@end
