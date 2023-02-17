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
#import "MDCAvailability.h"
#import "UIView+MaterialElevationResponding.h"

#import "private/MDCBottomNavigationBar+Private.h"
#import "private/MDCBottomNavigationItemView.h"
#import "MDCBadgeAppearance.h"
#import "MDCBottomNavigationBarDelegate.h"
#import "MDCBottomNavigationBar+ItemView.h"
#import "MDCPalettes.h"
#import "MDCRippleTouchController.h"
#import "MDCRippleTouchControllerDelegate.h"
#import "MDCRippleView.h"
#import "MDCShadow.h"
#import "MDCShadowsCollection.h"
#import "MDCShadowElevations.h"
#import "MDCShadowLayer.h"
#import "MDCFontTextStyle.h"
#import "UIFont+MaterialTypography.h"
#import "MDCMath.h"

// KVO context
static char *const kKVOContextMDCBottomNavigationBar = "kKVOContextMDCBottomNavigationBar";

static const CGFloat kMinItemWidth = 80;
static const CGFloat kPreferredItemWidth = 120;
static const CGFloat kMaxItemWidth = 350;
// The default amount of internal padding on the leading/trailing edges of each bar item.
static const CGFloat kDefaultItemHorizontalPadding = 0;
static const CGFloat kBarHeightStackedTitle = 56;
static const CGFloat kBarHeightAdjacentTitle = 40;
static const CGFloat kItemsHorizontalMargin = 12;
static const CGFloat kBadgeFontSize = 8;
// Active indicator
static const CGFloat kDefaultActiveIndicatorHeight = 30;
static const CGFloat kDefaultActiveIndicatorWidth = 60;

// Vertical layout
static const CGFloat kDefaultVerticalLayoutWidth = 80;
static const CGFloat kDefaultVerticalPadding = 45;
static const CGFloat kDefaultItemSpacingInVerticalLayoutOniPad = 10;

@interface MDCBottomNavigationBar () <MDCRippleTouchControllerDelegate>

@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationItemView *> *itemViews;
@property(nonatomic, readonly) UIEdgeInsets mdc_safeAreaInsets;
@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong) UIVisualEffectView *blurEffectView;
@property(nonatomic, strong) UIStackView *itemsLayoutView;
@property(nonatomic, strong) UILayoutGuide *barItemsLayoutGuide NS_AVAILABLE_IOS(9_0);
@property(nonatomic, strong) NSLayoutConstraint *itemsLayoutViewAlignmentConstraint;
@property(nonatomic, strong) NSLayoutConstraint *itemsLayoutViewHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *itemsLayoutViewBottomAnchorConstraint;
@property(nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *itemViewHeightConstraints;
@property(nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *itemViewWidthConstraints;
@property(nonatomic, strong)
    NSMutableArray<NSLayoutConstraint *> *itemsLayoutViewHorizontalConstraints;
@property(nonatomic, strong)
    NSMutableArray<NSLayoutConstraint *> *itemsLayoutViewVerticalConstraints;

#if MDC_AVAILABLE_SDK_IOS(13_0)
/**
 The last large content viewer item displayed by the content viewer while the interaction is
 running. When the interaction ends this property is nil.
 */
@property(nonatomic, nullable) id<UILargeContentViewerItem> lastLargeContentViewerItem
    NS_AVAILABLE_IOS(13_0);
@property(nonatomic, assign) BOOL isLargeContentLongPressInProgress;
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

@end

@implementation MDCBottomNavigationBar

static BOOL gEnablePerformantShadow = NO;

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@synthesize shadowsCollection = _shadowsCollection;
@synthesize elevation = _elevation;

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
  _selectedItemTintColor = UIColor.blackColor;
  _unselectedItemTintColor = UIColor.grayColor;
  _selectedItemTitleColor = _selectedItemTintColor;
  _titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _alignment = MDCBottomNavigationBarAlignmentJustified;
  _barTintColor = UIColor.whiteColor;
  _truncatesLongTitles = YES;
  _titlesNumberOfLines = 1;
  _mdc_overrideBaseElevation = -1;
  _rippleEnabled = YES;
  _itemsAlignmentInVerticalMode = MDCNavigationBarItemsVerticalAlignmentCenter;
  _itemBadgeAppearance = [[MDCBadgeAppearance alloc] init];

  // TODO(featherless): Delete once everyone has migrated to itemBadgeAppearance.
  _itemBadgeTextColor = UIColor.whiteColor;
  _itemBadgeTextFont = [UIFont systemFontOfSize:kBadgeFontSize];
  _itemBadgeBackgroundColor = MDCPalette.redPalette.tint700;
  _itemsHorizontalPadding = kDefaultItemHorizontalPadding;
  _showsSelectionIndicator = NO;
  _selectionIndicatorColor = [UIColor colorWithRed:195.f / 255.f
                                             green:217.f / 255.f
                                              blue:242.f / 255.f
                                             alpha:1];
  _selectionIndicatorSize = CGSizeMake(kDefaultActiveIndicatorWidth, kDefaultActiveIndicatorHeight);

  // Remove any unarchived subviews and reconfigure the view hierarchy
  if (self.subviews.count) {
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
      [view removeFromSuperview];
    }
  }

  _barView = [[UIView alloc] init];
  _barView.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  _barView.clipsToBounds = YES;
  _barView.backgroundColor = _barTintColor;
  [self addSubview:_barView];

  _itemsLayoutView = [[UIStackView alloc] initWithFrame:CGRectZero];
  _itemsLayoutView.layoutMarginsRelativeArrangement = YES;
  _itemsLayoutView.spacing = kDefaultItemHorizontalPadding;
  _itemsLayoutView.alignment = UIStackViewAlignmentCenter;
  _itemsLayoutView.distribution = UIStackViewDistributionFillEqually;
  _itemsLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
  _itemsLayoutView.clipsToBounds = NO;
  [_barView addSubview:_itemsLayoutView];

  _itemsLayoutView.accessibilityTraits = UIAccessibilityTraitTabBar;
  self.elevation = MDCShadowElevationBottomNavigationBar;
  self.shadowColor = gEnablePerformantShadow ? MDCShadowColor() : UIColor.blackColor;
  _itemViews = [NSMutableArray array];
  _itemViewHeightConstraints = [NSMutableArray array];
  _itemViewWidthConstraints = [NSMutableArray array];
  _itemsLayoutViewHorizontalConstraints = [NSMutableArray array];
  _itemsLayoutViewVerticalConstraints = [NSMutableArray array];
  _itemTitleFont = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];

  // Horizontal layout constraints.
  [_itemsLayoutViewHorizontalConstraints
      addObject:[_itemsLayoutView.leadingAnchor constraintEqualToAnchor:_barView.leadingAnchor]];
  [_itemsLayoutViewHorizontalConstraints
      addObject:[_itemsLayoutView.trailingAnchor constraintEqualToAnchor:_barView.trailingAnchor]];
  [_itemsLayoutViewHorizontalConstraints
      addObject:[_itemsLayoutView.topAnchor constraintEqualToAnchor:_barView.topAnchor]];
  _itemsLayoutViewHeightConstraint =
      [_itemsLayoutView.heightAnchor constraintEqualToConstant:[self calculateBarHeight]];
  [_itemsLayoutViewHorizontalConstraints addObject:_itemsLayoutViewHeightConstraint];

  // Vertical layout constraints.
  [_itemsLayoutViewVerticalConstraints
      addObject:[_itemsLayoutView.widthAnchor
                    constraintEqualToConstant:kDefaultVerticalLayoutWidth]];
  [_itemsLayoutViewVerticalConstraints
      addObject:[_itemsLayoutView.leadingAnchor
                    constraintEqualToAnchor:_barView.safeAreaLayoutGuide.leadingAnchor]];
  _itemsLayoutViewAlignmentConstraint =
      [_itemsLayoutView.centerYAnchor constraintEqualToAnchor:_barView.centerYAnchor];

  // Layout guide to control items stack view's bottom anchor.
  _barItemsLayoutGuide = [[UILayoutGuide alloc] init];
  _barItemsLayoutGuide.identifier = @"MDCBottomNavigationBarItemsLayoutGuide";
  [_itemsLayoutView addLayoutGuide:_barItemsLayoutGuide];
  _itemsLayoutViewBottomAnchorConstraint =
      [_barItemsLayoutGuide.bottomAnchor constraintEqualToAnchor:_itemsLayoutView.bottomAnchor];

  _enableVerticalLayout = NO;
  _displayItemTitlesInVerticalLayout = NO;
  [self loadConstraints];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect standardBounds = CGRectStandardize(self.bounds);
  if (self.blurEffectView) {
    self.blurEffectView.frame = standardBounds;
  }
  self.barView.frame = standardBounds;

  self.layer.shadowColor = self.shadowColor.CGColor;

  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    [self configureTitleStateForItemView:itemView];
  }

  UIUserInterfaceLayoutDirection layoutDirection = self.effectiveUserInterfaceLayoutDirection;
  if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
    _itemsLayoutView.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
  } else {
    _itemsLayoutView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  }

  if (gEnablePerformantShadow) {
    [self updateShadow];
  }
}

- (void)safeAreaInsetsDidChange {
  [super safeAreaInsetsDidChange];
  [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize {
  CGFloat height = [self calculateBarHeight];
  CGFloat itemWidth = [self widthForItemsWhenCenteredWithAvailableWidth:CGFLOAT_MAX height:height];
  CGSize size = CGSizeMake(itemWidth * self.items.count, height);
  if (self.enableVerticalLayout) {
    size.width = kDefaultVerticalLayoutWidth;
  }
  return size;
}

- (CGFloat)widthForItemsWhenCenteredWithAvailableWidth:(CGFloat)availableWidth
                                                height:(CGFloat)barHeight {
  CGFloat maxItemWidth = kPreferredItemWidth;
  for (UIView *itemView in self.itemViews) {
    maxItemWidth =
        MAX(maxItemWidth, [itemView sizeThatFits:CGSizeMake(availableWidth, barHeight)].width +
                              self.itemsHorizontalPadding * 2);
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

- (NSLayoutYAxisAnchor *)barItemsBottomAnchor {
  return self.barItemsLayoutGuide.bottomAnchor;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat height;
  CGFloat width = size.width;
  if ([self shouldUseAnchoredLayout]) {
    height = [self calculateBarHeight];
  } else {
    height = self.barHeight;

    if (height <= 0) {
      height = kBarHeightStackedTitle;
      if (self.alignment == MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles &&
          self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        height = kBarHeightAdjacentTitle;
      }
    }
  }

  if (self.enableVerticalLayout) {
    width = kDefaultVerticalLayoutWidth;
  }

  return CGSizeMake(width, height);
}

+ (Class)layerClass {
  if (gEnablePerformantShadow) {
    return [super layerClass];
  } else {
    return [MDCShadowLayer class];
  }
}

- (void)setElevation:(MDCShadowElevation)elevation {
  if (MDCCGFloatEqual(_elevation, elevation)) {
    return;
  }
  _elevation = elevation;
  if (gEnablePerformantShadow) {
    [self updateShadow];
  } else {
    MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
    shadowLayer.elevation = elevation;
  }
  [self mdc_elevationDidChange];
}

- (void)updateShadow {
  MDCShadow *shadow = [self.shadowsCollection shadowForElevation:self.mdc_currentElevation];
  shadow = [[MDCShadowBuilder builderWithColor:self.shadowColor
                                       opacity:shadow.opacity
                                        radius:shadow.radius
                                        offset:shadow.offset
                                        spread:shadow.spread] build];
  MDCConfigureShadowForView(self, shadow);
}

- (void)setShadowColor:(UIColor *)shadowColor {
  UIColor *shadowColorCopy = [shadowColor copy];
  _shadowColor = shadowColorCopy;
  self.layer.shadowColor = shadowColorCopy.CGColor;
}

- (BOOL)isTitleBelowIcon {
  switch (self.alignment) {
    case MDCBottomNavigationBarAlignmentCentered:
    case MDCBottomNavigationBarAlignmentJustified:
      return YES;
      break;
    case MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles:
      return self.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassRegular;
      break;
  }
}

- (void)setBarHeight:(CGFloat)barHeight {
  _barHeight = barHeight;
  _itemsLayoutViewHeightConstraint.constant = [self calculateBarHeight];
}

- (void)setBarHeightWithoutTitles:(CGFloat)barHeightWithoutTitles {
  _barHeightWithoutTitles = barHeightWithoutTitles;
  _itemsLayoutViewHeightConstraint.constant = [self calculateBarHeight];
}

- (CGFloat)calculateBarHeight {
  if ([self shouldUseAnchoredLayout]) {
    if ([self itemViewsShouldAlwaysHideTitles] ||
        [self barHeightShouldShrinkBasedOnTraitCollection:self.traitCollection]) {
      // Return _barHeightWithoutTitles if it has been set to a positive value.
      // If _barHeightWithoutTitles is 0 (default value) or negative, return _barHeight instead.
      return _barHeightWithoutTitles > 0 ? _barHeightWithoutTitles : _barHeight;
    } else {
      return _barHeight;
    }
  }

  CGFloat height = self.isTitleBelowIcon ? kBarHeightStackedTitle : kBarHeightAdjacentTitle;
  if (self.barHeight > 0) {
    height = self.barHeight;
  }
  return height;
}

- (void)setEnableVerticalLayout:(BOOL)enableVerticalLayout {
  if (_enableVerticalLayout == enableVerticalLayout) {
    return;
  }
  _enableVerticalLayout = enableVerticalLayout;
  for (MDCBottomNavigationItemView *item in self.itemViews) {
    item.enableVerticalLayout = enableVerticalLayout;
  }
  if (_enableVerticalLayout) {
    [self loadConstraints];
  }
}

- (void)setdisplayItemTitlesInVerticalLayout:(BOOL)displayItemTitlesInVerticalLayout {
  if (_displayItemTitlesInVerticalLayout == displayItemTitlesInVerticalLayout) {
    return;
  }
  _displayItemTitlesInVerticalLayout = displayItemTitlesInVerticalLayout;
  for (MDCBottomNavigationItemView *item in self.itemViews) {
    item.displayTitleInVerticalLayout = _displayItemTitlesInVerticalLayout;
  }
}

- (void)setItemsAlignmentInVerticalMode:
    (MDCNavigationBarItemsVerticalAlignment)itemsAlignmentInVerticalMode {
  _itemsAlignmentInVerticalMode = itemsAlignmentInVerticalMode;
  _itemsLayoutViewAlignmentConstraint.active = NO;
  switch (_itemsAlignmentInVerticalMode) {
    case MDCNavigationBarItemsVerticalAlignmentCenter:
      _itemsLayoutViewAlignmentConstraint =
          [_itemsLayoutView.centerYAnchor constraintEqualToAnchor:_barView.centerYAnchor];
      break;
    case MDCNavigationBarItemsVerticalAlignmentTop:
      _itemsLayoutViewAlignmentConstraint =
          [_itemsLayoutView.topAnchor constraintEqualToAnchor:_barView.topAnchor
                                                     constant:kDefaultVerticalPadding];
      break;
    case MDCNavigationBarItemsVerticalAlignmentBottom:
      _itemsLayoutViewAlignmentConstraint =
          [_itemsLayoutView.bottomAnchor constraintEqualToAnchor:_barView.bottomAnchor
                                                        constant:-kDefaultVerticalPadding];
      break;
  }
  [self loadConstraints];
}

- (void)loadConstraints {
  if (self.enableVerticalLayout) {
    [self activateVerticalLayoutConstraints];
  } else {
    [self activateHorizontalLayoutConstraints];
  }
}
- (void)activateVerticalLayoutConstraints {
  _itemsLayoutViewBottomAnchorConstraint.active = NO;
  [NSLayoutConstraint deactivateConstraints:self.itemsLayoutViewHorizontalConstraints];
  for (NSLayoutConstraint *constraint in self.itemViewHeightConstraints) {
    constraint.constant = kBarHeightStackedTitle;
  }
  _itemsLayoutViewAlignmentConstraint.active = YES;
  self.itemsLayoutView.axis = UILayoutConstraintAxisVertical;

  if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
    self.itemsLayoutView.spacing = kDefaultItemSpacingInVerticalLayoutOniPad;
  }
  [NSLayoutConstraint activateConstraints:self.itemViewWidthConstraints];
  [NSLayoutConstraint activateConstraints:self.itemsLayoutViewVerticalConstraints];
}

- (void)activateHorizontalLayoutConstraints {
  _itemsLayoutViewAlignmentConstraint.active = NO;
  [NSLayoutConstraint deactivateConstraints:self.itemViewWidthConstraints];
  [NSLayoutConstraint deactivateConstraints:self.itemsLayoutViewVerticalConstraints];
  CGFloat barHeight = [self calculateBarHeight];
  _itemsLayoutViewHeightConstraint.constant = barHeight;
  self.itemsLayoutView.axis = UILayoutConstraintAxisHorizontal;
  self.itemsLayoutView.spacing = kDefaultItemHorizontalPadding;
  _itemsLayoutViewBottomAnchorConstraint.active = YES;
  for (NSLayoutConstraint *constraint in self.itemViewHeightConstraints) {
    constraint.constant = barHeight;
  }
  [NSLayoutConstraint activateConstraints:self.itemsLayoutViewHorizontalConstraints];
}

- (void)dealloc {
  [self removeObserversFromTabBarItems];
}

- (NSArray<NSString *> *)kvoKeyPaths {
  static NSArray<NSString *> *keyPaths;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    keyPaths = @[
      NSStringFromSelector(@selector(badgeColor)),
      NSStringFromSelector(@selector(badgeValue)),
      NSStringFromSelector(@selector(title)),
      NSStringFromSelector(@selector(image)),
      NSStringFromSelector(@selector(selectedImage)),
      NSStringFromSelector(@selector(accessibilityValue)),
      NSStringFromSelector(@selector(accessibilityLabel)),
      NSStringFromSelector(@selector(accessibilityHint)),
      NSStringFromSelector(@selector(accessibilityIdentifier)),
      NSStringFromSelector(@selector(isAccessibilityElement)),
      NSStringFromSelector(@selector(titlePositionAdjustment)),
      NSStringFromSelector(@selector(largeContentSizeImage)),
      NSStringFromSelector(@selector(largeContentSizeImageInsets)),
      NSStringFromSelector(@selector(tag)),
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
      itemView.badgeText = newValue;
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
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(largeContentSizeImage))]) {
      if (@available(iOS 13.0, *)) {
        itemView.largeContentImage = newValue;
      }
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(tag))]) {
      itemView.tag = [newValue integerValue];
    }
#if MDC_AVAILABLE_SDK_IOS(13_0)
    else if ([keyPath
                 isEqualToString:NSStringFromSelector(@selector(largeContentSizeImageInsets))]) {
      if (@available(iOS 13.0, *)) {
        itemView.largeContentImageInsets = [newValue UIEdgeInsetsValue];
      }
    }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  [self layoutIfNeeded];
}

- (UIEdgeInsets)mdc_safeAreaInsets {
  return self.safeAreaInsets;
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

/** Returns the item view at the given point. Nil if there is no view at the given point. */
- (MDCBottomNavigationItemView *_Nullable)itemViewForPoint:(CGPoint)point {
  for (NSUInteger i = 0; i < self.itemViews.count; i++) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    if (CGRectContainsPoint(itemView.frame, point)) {
      return itemView;
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
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13, *)) {
    // If clients report conflicting gesture recognizers please see proposed solution in the
    // internal document: go/mdc-ios-bottomnavigation-largecontentvieweritem
    [self addInteraction:[[UILargeContentViewerInteraction alloc] initWithDelegate:self]];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  // Remove existing item views from the bottom navigation so it can be repopulated with new items.
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    [itemView removeFromSuperview];
  }
  [self.itemViews removeAllObjects];
  [self.itemViewHeightConstraints removeAllObjects];
  [self.itemViewWidthConstraints removeAllObjects];
  [self removeObserversFromTabBarItems];
  _items = [items copy];

  CGFloat barHeight = [self calculateBarHeight];

  for (NSUInteger i = 0; i < items.count; i++) {
    MDCBottomNavigationItemView *itemView =
        [[MDCBottomNavigationItemView alloc] initWithFrame:CGRectZero];

    itemView.rippleTouchController.delegate = self;
    itemView.selected = NO;
    itemView.displayTitleInVerticalLayout = self.displayItemTitlesInVerticalLayout;
    itemView.enableVerticalLayout = self.enableVerticalLayout;

    [self configureTitleStateForItemView:itemView];
    [self configureItemView:itemView withItem:items[i]];

    [itemView.button addTarget:self
                        action:@selector(didTouchUpInsideButton:)
              forControlEvents:UIControlEventTouchUpInside];

    [self.itemViews addObject:itemView];
    [self.itemsLayoutView addArrangedSubview:itemView];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *itemViewHeightConstraint =
        [itemView.heightAnchor constraintEqualToConstant:barHeight];
    // This priority is set to low to avoid conflict of constraints due to the itemView's height
    // being the same as the bar.
    itemViewHeightConstraint.priority = UILayoutPriorityDefaultLow;
    [self.itemViewHeightConstraints addObject:itemViewHeightConstraint];
    NSLayoutConstraint *itemViewWidthConstraint =
        [itemView.widthAnchor constraintEqualToConstant:kDefaultVerticalLayoutWidth];
    // This priority is set to low to avoid conflict of constraints due to the itemView's width
    // being the same as the bar.
    itemViewWidthConstraint.priority = UILayoutPriorityDefaultLow;
    [self.itemViewWidthConstraints addObject:itemViewWidthConstraint];
  }

  self.selectedItem = nil;
  [NSLayoutConstraint activateConstraints:self.itemViewHeightConstraints];
  [self loadConstraints];
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

- (void)setItemsHorizontalPadding:(CGFloat)itemsHorizontalPadding {
  if (MDCCGFloatEqual(_itemsHorizontalPadding, itemsHorizontalPadding)) {
    return;
  }
  _itemsHorizontalPadding = itemsHorizontalPadding;
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

- (void)setBackgroundBlurEffectStyle:(UIBlurEffectStyle)backgroundBlurEffectStyle {
  if (_backgroundBlurEffectStyle == backgroundBlurEffectStyle) {
    return;
  }
  _backgroundBlurEffectStyle = backgroundBlurEffectStyle;
  if (self.blurEffectView) {
    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:_backgroundBlurEffectStyle];
  }
}

- (void)setBackgroundBlurEnabled:(BOOL)backgroundBlurEnabled {
  if (_backgroundBlurEnabled == backgroundBlurEnabled) {
    return;
  }
  _backgroundBlurEnabled = backgroundBlurEnabled;

  if (_backgroundBlurEnabled & !self.blurEffectView) {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:_backgroundBlurEffectStyle];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.hidden = !_backgroundBlurEnabled;
    self.blurEffectView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self insertSubview:self.blurEffectView atIndex:0];  // Needs to always be at the bottom
    self.blurEffectView.frame = CGRectStandardize(self.bounds);
  } else if (self.blurEffectView) {
    self.blurEffectView.hidden = !_backgroundBlurEnabled;
  }
}

- (void)setAlignment:(MDCBottomNavigationBarAlignment)alignment {
  if (_alignment == alignment) {
    return;
  }
  _alignment = alignment;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    [self configureTitleStateForItemView:itemView];
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
  _itemsLayoutViewHeightConstraint.constant = [self calculateBarHeight];
}

- (void)setShowsSelectionIndicator:(BOOL)showsSelectionIndicator {
  if (showsSelectionIndicator == _showsSelectionIndicator) {
    return;
  }
  _showsSelectionIndicator = showsSelectionIndicator;
  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.showsSelectionIndicator = _showsSelectionIndicator;
  }
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
  _selectionIndicatorColor = selectionIndicatorColor;

  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.selectionIndicatorColor = _selectionIndicatorColor;
  }
}

- (void)setSelectionIndicatorSize:(CGSize)selectionIndicatorSize {
  _selectionIndicatorSize = selectionIndicatorSize;

  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.selectionIndicatorSize = _selectionIndicatorSize;
  }
}

#pragma mark - MDCRippleTouchControllerDelegate methods

- (BOOL)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
    shouldProcessRippleTouchesAtTouchLocation:(CGPoint)location {
  return self.rippleEnabled;
}

#pragma mark - MDCElevation

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (MDCShadowsCollection *)shadowsCollection {
  if (!_shadowsCollection) {
    _shadowsCollection = MDCShadowsCollectionDefault();
  }
  return _shadowsCollection;
}

- (void)setShadowsCollection:(MDCShadowsCollection *)shadowsCollection {
  _shadowsCollection = shadowsCollection;

  [self updateShadow];
}

- (void)cancelRippleInItemView:(MDCBottomNavigationItemView *)itemView animated:(BOOL)animated {
  if (self.isRippleEnabled) {
    if (animated) {
      [itemView.rippleTouchController.rippleView beginRippleTouchUpAnimated:YES completion:nil];
    } else {
      [itemView.rippleTouchController.rippleView cancelAllRipplesAnimated:NO completion:nil];
    }
  }
}

- (void)beginRippleInItemView:(MDCBottomNavigationItemView *)itemView animated:(BOOL)animated {
  if (self.isRippleEnabled) {
    [itemView.rippleTouchController.rippleView beginRippleTouchDownAtPoint:itemView.center
                                                                  animated:animated
                                                                completion:nil];
  }
}

#pragma mark - UILargeContentViewerInteractionDelegate

#if MDC_AVAILABLE_SDK_IOS(13_0)
- (id<UILargeContentViewerItem>)largeContentViewerInteraction:
                                    (UILargeContentViewerInteraction *)interaction
                                                  itemAtPoint:(CGPoint)point
    NS_AVAILABLE_IOS(13_0) {
  MDCBottomNavigationItemView *lastItemView =
      (MDCBottomNavigationItemView *)self.lastLargeContentViewerItem;

  if (!CGRectContainsPoint(self.bounds, point)) {
    // The touch has wandered outside of the view. Clear the ripple and do not display the
    // content viewer.
    if (lastItemView) {
      [self cancelRippleInItemView:lastItemView animated:NO];
    }
    self.lastLargeContentViewerItem = nil;
    return nil;
  }

  MDCBottomNavigationItemView *itemView = [self itemViewForPoint:point];
  if (!itemView) {
    // The touch is still within the navigation bar. Return the last seen item view.
    return self.lastLargeContentViewerItem;
  }

  if (lastItemView != itemView) {
    if (lastItemView) {
      [self cancelRippleInItemView:lastItemView animated:NO];
    }
    // Only start ripple if it's not the first touch down of the long press
    if (self.isLargeContentLongPressInProgress) {
      [self beginRippleInItemView:itemView animated:NO];
    }
    self.lastLargeContentViewerItem = itemView;
  }
  self.isLargeContentLongPressInProgress = YES;
  return itemView;
}

- (void)largeContentViewerInteraction:(UILargeContentViewerInteraction *)interaction
                         didEndOnItem:(id<UILargeContentViewerItem>)item
                              atPoint:(CGPoint)point NS_AVAILABLE_IOS(13_0) {
  if (self.lastLargeContentViewerItem) {
    MDCBottomNavigationItemView *lastItemView =
        (MDCBottomNavigationItemView *)self.lastLargeContentViewerItem;
    [self cancelRippleInItemView:lastItemView animated:YES];
    [self didTouchUpInsideButton:lastItemView.button];
  }

  self.lastLargeContentViewerItem = nil;
  self.isLargeContentLongPressInProgress = NO;
}
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

#ifdef __IPHONE_13_4
#pragma mark - UIPointerInteractionDelegate

- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction
                        styleForRegion:(UIPointerRegion *)region API_AVAILABLE(ios(13.4)) {
  MDCBottomNavigationItemView *bottomNavigationView = interaction.view;
  if (![bottomNavigationView isKindOfClass:[MDCBottomNavigationItemView class]]) {
    return nil;
  }
  UITargetedPreview *targetedPreview = [[UITargetedPreview alloc] initWithView:interaction.view];
  UIPointerEffect *highlightEffect = [UIPointerHighlightEffect effectWithPreview:targetedPreview];
  CGRect hoverRect =
      [bottomNavigationView convertRect:[bottomNavigationView pointerEffectHighlightRect]
                                 toView:self];
  UIPointerShape *shape = [UIPointerShape shapeWithRoundedRect:hoverRect];
  return [UIPointerStyle styleWithEffect:highlightEffect shape:shape];
}
#endif

#pragma mark - Performant Shadow Toggle

+ (void)setEnablePerformantShadow:(BOOL)enable {
  gEnablePerformantShadow = enable;
}

+ (BOOL)enablePerformantShadow {
  return gEnablePerformantShadow;
}

#pragma mark - Configuring the ripple appearance

- (void)setRippleColor:(UIColor *)rippleColor {
  _rippleColor = rippleColor;

  for (NSUInteger i = 0; i < self.items.count; ++i) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.rippleColor = _rippleColor;
  }
}

#pragma mark - Configuring the visual appearance for all badges

- (void)setItemBadgeAppearance:(MDCBadgeAppearance *)itemBadgeAppearance {
  _itemBadgeAppearance = [itemBadgeAppearance copy];

  for (NSUInteger i = 0; i < self.items.count; ++i) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.badgeAppearance = _itemBadgeAppearance;
  }
}

- (void)setItemBadgeHorizontalOffset:(CGFloat)itemBadgeHorizontalOffset {
  _itemBadgeHorizontalOffset = itemBadgeHorizontalOffset;

  for (NSUInteger i = 0; i < self.items.count; ++i) {
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.badgeHorizontalOffset = itemBadgeHorizontalOffset;
  }
}

// TODO(featherless): Delete once everyone has migrated to itemBadgeAppearance.
- (void)setItemBadgeBackgroundColor:(UIColor *)itemBadgeBackgroundColor {
  _itemBadgeBackgroundColor = itemBadgeBackgroundColor;

  for (NSUInteger i = 0; i < self.items.count; ++i) {
    UITabBarItem *item = self.items[i];
    if (item.badgeColor) {
      continue;
    }
    MDCBottomNavigationItemView *itemView = self.itemViews[i];
    itemView.badgeColor = itemBadgeBackgroundColor;
  }
}

// TODO(featherless): Delete once everyone has migrated to itemBadgeAppearance.
- (void)setItemBadgeTextColor:(UIColor *)itemBadgeTextColor {
  _itemBadgeTextColor = itemBadgeTextColor;

  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.badgeTextColor = itemBadgeTextColor;
  }
}

// TODO(featherless): Delete once everyone has migrated to itemBadgeAppearance.
- (void)setItemBadgeTextFont:(UIFont *)itemBadgeTextFont {
  _itemBadgeTextFont = itemBadgeTextFont;

  for (MDCBottomNavigationItemView *itemView in self.itemViews) {
    itemView.badgeFont = itemBadgeTextFont;
  }
}

// TODO(b/244765238): Remove branching layout logic after GM3 migrations
// Assume that setting itemBadgeHorizontalOffset to any value other than its default (0) should
// activate the new anchored/GM3 layout, and assume that anyone applying GM3 branding for Bottom
// Navigation will use a non-zero offset.
- (BOOL)shouldUseAnchoredLayout {
  return _itemBadgeHorizontalOffset != 0;
}

- (BOOL)itemViewsShouldAlwaysHideTitles {
  return _titleVisibility == MDCBottomNavigationBarTitleVisibilityNever;
}

- (BOOL)barHeightShouldShrinkBasedOnTraitCollection:(UITraitCollection *)traitCollection {
  return traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ||
         [self itemViewsShouldAlwaysHideTitles];
}

- (void)configureTitleStateForItemView:(MDCBottomNavigationItemView *)itemView {
  if ([self shouldUseAnchoredLayout]) {
    itemView.titleBelowIcon = ![self itemViewsShouldAlwaysHideTitles];
  } else {
    itemView.titleBelowIcon = self.isTitleBelowIcon;
  }
}
@end
