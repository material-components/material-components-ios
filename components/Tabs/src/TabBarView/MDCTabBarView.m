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

#import "MDCTabBarItemCustomViewing.h"
#import "MDCTabBarViewCustomViewable.h"
#import "MDCTabBarViewDelegate.h"
#import "MDCTabBarViewIndicatorTemplate.h"
#import "MDCTabBarViewUnderlineIndicatorTemplate.h"
#import "private/MDCTabBarViewIndicatorView.h"
#import "private/MDCTabBarViewItemView.h"
#import "private/MDCTabBarViewPrivateIndicatorContext.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "MaterialAnimationTiming.h"  // ComponentImport
#import <MDFInternationalization/MDFInternationalization.h>

// KVO contexts
static char *const kKVOContextMDCTabBarView = "kKVOContextMDCTabBarView";

/** Minimum (typical) height of a Material Tab bar. */
static const CGFloat kMinHeight = 48;

/** Maximum width of an item view. */
static const CGFloat kMaxItemWidth = 360;

/** The leading edge inset for scrollable tabs. */
static const CGFloat kScrollableTabsLeadingEdgeInset = 52;

/** The height of the bottom divider view. */
static const CGFloat kBottomDividerHeight = 1;

/// Default duration in seconds for selection change animations.
static const NSTimeInterval kSelectionChangeAnimationDuration = 0.3;

static NSString *const kSelectedImageKeyPath = @"selectedImage";
static NSString *const kImageKeyPath = @"image";
static NSString *const kTitleKeyPath = @"title";
static NSString *const kAccessibilityLabelKeyPath = @"accessibilityLabel";
static NSString *const kAccessibilityHintKeyPath = @"accessibilityHint";
static NSString *const kAccessibilityIdentifierKeyPath = @"accessibilityIdentifier";
static NSString *const kAccessibilityTraitsKeyPath = @"accessibilityTraits";

#ifdef __IPHONE_13_4
@interface MDCTabBarView (PointerInteractions) <UIPointerInteractionDelegate>
@end
#endif

@interface MDCTabBarView ()

/** The views representing each tab bar item. */
@property(nonnull, nonatomic, copy) NSArray<UIView *> *itemViews;

/** The bottom divider view shown behind the default indicator template. */
@property(nonnull, nonatomic, strong) UIView *bottomDividerView;

/** @c YES if the items are laid-out in a scrollable style. */
@property(nonatomic, readonly) BOOL isScrollableLayoutStyle;

/** Used to scroll to the selected item during the first call to @c layoutSubviews. */
@property(nonatomic, assign) BOOL needsScrollToSelectedItem;

/** The view that renders @c selectionIndicatorTemplate. */
@property(nonnull, nonatomic, strong) MDCTabBarViewIndicatorView *selectionIndicatorView;

/** The title colors for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *stateToTitleColor;

/** The image tint colors for bar items. */
@property(nonnull, nonatomic, strong)
    NSMutableDictionary<NSNumber *, UIColor *> *stateToImageTintColor;

/** The title font for bar items. */
@property(nonnull, nonatomic, strong) NSMutableDictionary<NSNumber *, UIFont *> *stateToTitleFont;

/**
 The content padding (as UIEdgeInsets) for each layout style. The layout style is stored as an
 @c NSNumber of the raw enumeration value. The padding @c UIEdgeInsets is stored as an @c NSValue.
 */
@property(nonnull, nonatomic, strong)
    NSMutableDictionary<NSNumber *, NSValue *> *layoutStyleToContentPadding;

@end

@implementation MDCTabBarView
// We're overriding UIScrollViewDelegate's delegate solely to change its type (we don't provide
// a getter or setter implementation), thus the @dynamic.
@dynamic delegate;

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _rippleColor = [[UIColor alloc] initWithWhite:0 alpha:(CGFloat)0.16];
    _needsScrollToSelectedItem = YES;
    _shouldAdjustForSafeAreaInsets = YES;
    _items = @[];
    _stateToImageTintColor = [NSMutableDictionary dictionary];
    _stateToTitleColor = [NSMutableDictionary dictionary];
    _stateToTitleFont = [NSMutableDictionary dictionary];
    _preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
    _layoutStyleToContentPadding = [NSMutableDictionary dictionary];
    _layoutStyleToContentPadding[@(MDCTabBarViewLayoutStyleScrollable)] =
        [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, kScrollableTabsLeadingEdgeInset, 0, 0)];
    self.backgroundColor = UIColor.whiteColor;
    self.showsHorizontalScrollIndicator = NO;

    _selectionIndicatorView = [[MDCTabBarViewIndicatorView alloc] init];
    _selectionIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    _selectionIndicatorView.userInteractionEnabled = NO;
    _selectionIndicatorView.tintColor = UIColor.blackColor;
    _selectionIndicatorView.indicatorPathAnimationDuration = kSelectionChangeAnimationDuration;
    _selectionIndicatorView.indicatorPathTimingFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];

    _selectionIndicatorTemplate = [[MDCTabBarViewUnderlineIndicatorTemplate alloc] init];

    // The bottom divider is positioned behind the selection indicator.
    _bottomDividerView = [[UIView alloc] init];
    _bottomDividerView.backgroundColor = UIColor.clearColor;
    [self addSubview:_bottomDividerView];

    // The selection indicator is positioned behind the item views.
    [self addSubview:_selectionIndicatorView];

    // By default, inset the content within the safe area. This is generally the desired behavior,
    // but clients can override it if they want.
    if (@available(iOS 11.0, *)) {
      [super setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAlways];
    }
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

- (void)updateRippleColorForAllViews {
  for (UIView *subview in self.itemViews) {
    if (![subview isKindOfClass:[MDCTabBarViewItemView class]]) {
      continue;
    }
    MDCTabBarViewItemView *itemView = (MDCTabBarViewItemView *)subview;
    itemView.rippleTouchController.rippleView.rippleColor = self.rippleColor;
  }
}

- (void)setRippleColor:(UIColor *)rippleColor {
  _rippleColor = [rippleColor copy];
  [self updateRippleColorForAllViews];
}

- (void)setSelectionIndicatorStrokeColor:(UIColor *)selectionIndicatorStrokeColor {
  _selectionIndicatorStrokeColor = selectionIndicatorStrokeColor ?: UIColor.blackColor;
  self.selectionIndicatorView.tintColor = self.selectionIndicatorStrokeColor;
}

- (void)setBottomDividerColor:(UIColor *)bottomDividerColor {
  self.bottomDividerView.backgroundColor = bottomDividerColor;
}

- (UIColor *)bottomDividerColor {
  return self.bottomDividerView.backgroundColor;
}

- (void)setPreferredLayoutStyle:(MDCTabBarViewLayoutStyle)preferredLayoutStyle {
  _preferredLayoutStyle = preferredLayoutStyle;
  [self setNeedsLayout];
  [self invalidateIntrinsicContentSize];
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  NSParameterAssert(items);

  if (self.items == items || [self.items isEqual:items]) {
    return;
  }

  [self removeObserversFromTabBarItems];
  for (UIView *view in self.itemViews) {
    [view removeFromSuperview];
  }

  _items = [items copy];
  NSMutableArray<UIView *> *itemViews = [NSMutableArray array];

  for (UITabBarItem *item in self.items) {
    UIView *itemView;
    if ([item conformsToProtocol:@protocol(MDCTabBarItemCustomViewing)]) {
      UITabBarItem<MDCTabBarItemCustomViewing> *customItem =
          (UITabBarItem<MDCTabBarItemCustomViewing> *)item;
      UIView *customView = customItem.mdc_customView;
      if (customView) {
        itemView = customView;
      }
    }
    if (!itemView) {
      MDCTabBarViewItemView *mdcItemView = [[MDCTabBarViewItemView alloc] init];
      mdcItemView.titleLabel.text = item.title;
      mdcItemView.accessibilityLabel = item.accessibilityLabel;
      mdcItemView.accessibilityHint = item.accessibilityHint;
      mdcItemView.accessibilityIdentifier = item.accessibilityIdentifier;
      mdcItemView.accessibilityTraits = item.accessibilityTraits == UIAccessibilityTraitNone
                                            ? UIAccessibilityTraitButton
                                            : item.accessibilityTraits;
      mdcItemView.titleLabel.textColor = [self titleColorForState:UIControlStateNormal];
      mdcItemView.image = item.image;
      mdcItemView.selectedImage = item.selectedImage;
      mdcItemView.rippleTouchController.rippleView.rippleColor = self.rippleColor;
      mdcItemView.rippleTouchController.shouldProcessRippleWithScrollViewGestures = NO;
      itemView = mdcItemView;
    }
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)];
    [itemView addGestureRecognizer:tapGesture];

#ifdef __IPHONE_13_4
    if (@available(iOS 13.4, *)) {
      // Because some iOS 13 betas did not have the UIPointerInteraction class, we need to verify
      // that it exists before attempting to use it.
      if (NSClassFromString(@"UIPointerInteraction")) {
        UIPointerInteraction *pointerInteraction =
            [[UIPointerInteraction alloc] initWithDelegate:self];
        [itemView addInteraction:pointerInteraction];
      }
    }
#endif

    [self addSubview:itemView];
    [itemViews addObject:itemView];
  }

  self.itemViews = itemViews;

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
  [self setSelectedItem:selectedItem animated:YES];
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem animated:(BOOL)animated {
  if (self.selectedItem == selectedItem) {
    return;
  }

  // Sets the old selected item view's traits back.
  NSUInteger oldSelectedItemIndex = [self.items indexOfObject:self.selectedItem];
  if (oldSelectedItemIndex != NSNotFound) {
    UIView *oldSelectedItemView = self.itemViews[oldSelectedItemIndex];
    oldSelectedItemView.accessibilityTraits =
        (oldSelectedItemView.accessibilityTraits & ~UIAccessibilityTraitSelected);
    if ([oldSelectedItemView conformsToProtocol:@protocol(MDCTabBarViewCustomViewable)]) {
      UIView<MDCTabBarViewCustomViewable> *customViewableView =
          (UIView<MDCTabBarViewCustomViewable> *)oldSelectedItemView;
      [customViewableView setSelected:NO animated:animated];
    }
  }

  // Handle setting to `nil` without passing it to the nonnull parameter in `indexOfObject:`
  if (!selectedItem) {
    _selectedItem = selectedItem;
    [self updateTitleColorForAllViews];
    [self updateImageTintColorForAllViews];
    [self updateTitleFontForAllViews];
    [self didSelectItemAtIndex:NSNotFound animateTransition:animated];
    return;
  }

  NSUInteger itemIndex = [self.items indexOfObject:selectedItem];
  // Don't crash, just ignore if `selectedItem` isn't present in `_items`. This is the same behavior
  // as UITabBar.
  if (itemIndex == NSNotFound) {
    return;
  }
  _selectedItem = selectedItem;

  UIView *newSelectedItemView = self.itemViews[itemIndex];
  newSelectedItemView.accessibilityTraits =
      (newSelectedItemView.accessibilityTraits | UIAccessibilityTraitSelected);
  if ([newSelectedItemView conformsToProtocol:@protocol(MDCTabBarViewCustomViewable)]) {
    UIView<MDCTabBarViewCustomViewable> *customViewableView =
        (UIView<MDCTabBarViewCustomViewable> *)newSelectedItemView;
    [customViewableView setSelected:YES animated:animated];
  }
  [self updateTitleColorForAllViews];
  [self updateImageTintColorForAllViews];
  [self updateTitleFontForAllViews];
  [self scrollToItem:self.items[itemIndex] animated:animated];
  [self didSelectItemAtIndex:itemIndex animateTransition:animated];
}

- (void)updateImageTintColorForAllViews {
  for (UITabBarItem *item in self.items) {
    NSUInteger indexOfItem = [self.items indexOfObject:item];
    // This is a significant error, but defensive coding is preferred.
    if (indexOfItem == NSNotFound || indexOfItem >= self.itemViews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.itemViews[indexOfItem];
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
    if (indexOfItem == NSNotFound || indexOfItem >= self.itemViews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.itemViews[indexOfItem];
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

- (void)updateTitleFontForAllViews {
  for (UITabBarItem *item in self.items) {
    NSUInteger indexOfItem = [self.items indexOfObject:item];
    // This is a significant error, but defensive coding is preferred.
    if (indexOfItem == NSNotFound || indexOfItem >= self.itemViews.count) {
      NSAssert(NO, @"Unable to find associated item view for (%@)", item);
      continue;
    }
    UIView *itemView = self.itemViews[indexOfItem];
    // Skip custom views
    if (![itemView isKindOfClass:[MDCTabBarViewItemView class]]) {
      continue;
    }
    MDCTabBarViewItemView *tabBarViewItemView = (MDCTabBarViewItemView *)itemView;
    if (item == self.selectedItem) {
      tabBarViewItemView.titleLabel.font = [self titleFontForState:UIControlStateSelected];
    } else {
      tabBarViewItemView.titleLabel.font = [self titleFontForState:UIControlStateNormal];
    }
    [itemView invalidateIntrinsicContentSize];
    [itemView setNeedsLayout];
  }
}

- (void)setTitleFont:(UIFont *)titleFont forState:(UIControlState)state {
  self.stateToTitleFont[@(state)] = titleFont;
  [self updateTitleFontForAllViews];
}

- (UIFont *)titleFontForState:(UIControlState)state {
  UIFont *titleFont = self.stateToTitleFont[@(state)];
  if (!titleFont) {
    titleFont = self.stateToTitleFont[@(UIControlStateNormal)];
  }
  return titleFont;
}

- (void)setSelectionIndicatorTemplate:
    (id<MDCTabBarViewIndicatorTemplate>)selectionIndicatorTemplate {
  _selectionIndicatorTemplate = selectionIndicatorTemplate;
  if (self.selectedItem) {
    [self.selectionIndicatorView setNeedsLayout];
  }
}

- (void)setContentPadding:(UIEdgeInsets)contentPadding
           forLayoutStyle:(MDCTabBarViewLayoutStyle)layoutStyle {
  self.layoutStyleToContentPadding[@(layoutStyle)] = [NSValue valueWithUIEdgeInsets:contentPadding];
  if ([self effectiveLayoutStyle] == layoutStyle) {
    [self setNeedsLayout];
  }
}

- (UIEdgeInsets)contentPaddingForLayoutStyle:(MDCTabBarViewLayoutStyle)layoutStyle {
  NSValue *paddingValue = self.layoutStyleToContentPadding[@(layoutStyle)];
  if (paddingValue) {
    return paddingValue.UIEdgeInsetsValue;
  }
  return UIEdgeInsetsZero;
}

#pragma mark - UIAccessibility

- (BOOL)isAccessibilityElement {
  return NO;
}

- (UIAccessibilityTraits)accessibilityTraits {
  if (@available(iOS 10.0, *)) {
    return [super accessibilityTraits] | UIAccessibilityTraitTabBar;
  }
  return [super accessibilityTraits];
}

#pragma mark - Custom APIs

- (id)accessibilityElementForItem:(UITabBarItem *)item {
  NSUInteger itemIndex = [self.items indexOfObject:item];
  if (itemIndex == NSNotFound || itemIndex >= self.itemViews.count) {
    return nil;
  }
  return self.itemViews[itemIndex];
}

- (CGRect)rectForItem:(UITabBarItem *)item
    inCoordinateSpace:(id<UICoordinateSpace>)coordinateSpace {
  if (item == nil) {
    return CGRectNull;
  }
  NSUInteger index = [self.items indexOfObject:item];
  if (index == NSNotFound || index >= self.itemViews.count) {
    return CGRectNull;
  }
  CGRect frame = CGRectStandardize(self.itemViews[index].frame);
  return [coordinateSpace convertRect:frame fromCoordinateSpace:self];
}

- (CFTimeInterval)selectionChangeAnimationDuration {
  return kSelectionChangeAnimationDuration;
}

- (CAMediaTimingFunction *)selectionChangeAnimationTimingFunction {
  return [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
}

#pragma mark - Key-Value Observing (KVO)

- (void)addObserversToTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item addObserver:self
           forKeyPath:kImageKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
    [item addObserver:self
           forKeyPath:kSelectedImageKeyPath
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
    [item addObserver:self
           forKeyPath:kAccessibilityTraitsKeyPath
              options:NSKeyValueObservingOptionNew
              context:kKVOContextMDCTabBarView];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *item in self.items) {
    [item removeObserver:self forKeyPath:kImageKeyPath context:kKVOContextMDCTabBarView];
    [item removeObserver:self forKeyPath:kSelectedImageKeyPath context:kKVOContextMDCTabBarView];
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
    [item removeObserver:self
              forKeyPath:kAccessibilityTraitsKeyPath
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
    UIView *updatedItemView = self.itemViews[indexOfObject];
    if (![updatedItemView isKindOfClass:[MDCTabBarViewItemView class]]) {
      return;
    }
    MDCTabBarViewItemView *tabBarItemView = (MDCTabBarViewItemView *)updatedItemView;
    id newValue = [object valueForKey:keyPath];
    if (newValue == [NSNull null]) {
      newValue = nil;
    }
    if ([keyPath isEqualToString:kImageKeyPath]) {
      tabBarItemView.image = newValue;
      [self markIntrinsicContentSizeAndLayoutNeedingUpdateForSelfAndItemView:tabBarItemView];
    } else if ([keyPath isEqualToString:kSelectedImageKeyPath]) {
      tabBarItemView.selectedImage = newValue;
      [self markIntrinsicContentSizeAndLayoutNeedingUpdateForSelfAndItemView:tabBarItemView];
    } else if ([keyPath isEqualToString:kTitleKeyPath]) {
      tabBarItemView.titleLabel.text = newValue;
      [self markIntrinsicContentSizeAndLayoutNeedingUpdateForSelfAndItemView:tabBarItemView];
    } else if ([keyPath isEqualToString:kAccessibilityLabelKeyPath]) {
      tabBarItemView.accessibilityLabel = newValue;
    } else if ([keyPath isEqualToString:kAccessibilityHintKeyPath]) {
      tabBarItemView.accessibilityHint = newValue;
    } else if ([keyPath isEqualToString:kAccessibilityIdentifierKeyPath]) {
      tabBarItemView.accessibilityIdentifier = newValue;
    } else if ([keyPath isEqualToString:kAccessibilityTraitsKeyPath]) {
      tabBarItemView.accessibilityTraits = [change[NSKeyValueChangeNewKey] unsignedLongLongValue];
      if (tabBarItemView.accessibilityTraits == UIAccessibilityTraitNone) {
        tabBarItemView.accessibilityTraits = UIAccessibilityTraitButton;
      }
      if (object == self.selectedItem) {
        tabBarItemView.accessibilityTraits =
            (tabBarItemView.accessibilityTraits | UIAccessibilityTraitSelected);
      }
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

- (void)markIntrinsicContentSizeAndLayoutNeedingUpdateForSelfAndItemView:(UIView *)itemView {
  [itemView invalidateIntrinsicContentSize];
  [itemView setNeedsLayout];
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  MDCTabBarViewLayoutStyle layoutStyle = [self effectiveLayoutStyle];
  switch (layoutStyle) {
    case MDCTabBarViewLayoutStyleFixed: {
      [self layoutSubviewsForJustifiedLayout];
      break;
    }
    case MDCTabBarViewLayoutStyleFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleFixedClusteredTrailing:
    case MDCTabBarViewLayoutStyleFixedClusteredLeading: {
      [self layoutSubviewsForFixedClusteredLayout:layoutStyle];
      break;
    }
    case MDCTabBarViewLayoutStyleScrollableCentered:
    case MDCTabBarViewLayoutStyleScrollable: {
      [self layoutSubviewsForScrollableLayout:layoutStyle];
      break;
    }
    case MDCTabBarViewLayoutStyleNonFixedClusteredCentered: {
      [self layoutSubviewsForNonFixedClusteredCentered];
      break;
    }
  }

  self.contentSize = [self calculatedContentSize];
  [self updateSelectionIndicatorToIndex:[self.items indexOfObject:self.selectedItem]];

  if (self.needsScrollToSelectedItem) {
    self.needsScrollToSelectedItem = NO;
    // In RTL layouts, make sure we "begin" the selected item scroll offset from the leading edge.
    if (self.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      CGFloat viewWidth = CGRectGetWidth(self.bounds);
      if (viewWidth < self.contentSize.width) {
        self.contentOffset = CGPointMake(self.contentSize.width - viewWidth, self.contentOffset.y);
      }
    }
    [self scrollToItem:self.selectedItem animated:NO];
  }
  // It's possible that after scrolling the minX of bounds could have changed. Positioning it last
  // ensures that its frame matches the displayed content bounds.
  self.bottomDividerView.frame =
      CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds) - kBottomDividerHeight,
                 CGRectGetWidth(self.bounds), kBottomDividerHeight);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (BOOL)isScrollableLayoutStyle {
  return [self effectiveLayoutStyle] == MDCTabBarViewLayoutStyleScrollable;
}

- (MDCTabBarViewLayoutStyle)effectiveLayoutStyle {
  return [self effectiveLayoutStyleWithStyle:self.preferredLayoutStyle];
}

- (MDCTabBarViewLayoutStyle)effectiveLayoutStyleWithStyle:(MDCTabBarViewLayoutStyle)layoutStyle {
  if (self.items.count == 0) {
    return MDCTabBarViewLayoutStyleFixed;
  }

  CGSize availableSize = [self availableSizeForSubviewLayout];
  switch (layoutStyle) {
    case MDCTabBarViewLayoutStyleNonFixedClusteredCentered: {
      CGFloat nonFixedClusteredCenteredWidth =
          [self intrinsicContentSizeForNonFixedLayoutStyle:
                    MDCTabBarViewLayoutStyleNonFixedClusteredCentered]
              .width;
      BOOL tabBarIsTooNarrow = availableSize.width < nonFixedClusteredCenteredWidth;
      if (tabBarIsTooNarrow) {
        return MDCTabBarViewLayoutStyleScrollable;
      } else {
        return MDCTabBarViewLayoutStyleNonFixedClusteredCentered;
      }
    }
    case MDCTabBarViewLayoutStyleScrollableCentered: {
      CGFloat scrollableCenteredWidth =
          [self
              intrinsicContentSizeForNonFixedLayoutStyle:MDCTabBarViewLayoutStyleScrollableCentered]
              .width;
      BOOL tabBarIsTooWide = availableSize.width > scrollableCenteredWidth;
      if (tabBarIsTooWide) {
        return
            [self effectiveLayoutStyleWithStyle:MDCTabBarViewLayoutStyleNonFixedClusteredCentered];
      } else {
        return MDCTabBarViewLayoutStyleScrollableCentered;
      }
    }
    case MDCTabBarViewLayoutStyleScrollable: {
      return MDCTabBarViewLayoutStyleScrollable;
    }
    case MDCTabBarViewLayoutStyleFixed: {
      CGFloat requiredWidthForJustifiedLayout = [self intrinsicContentSizeForJustifiedLayout].width;
      if (availableSize.width < requiredWidthForJustifiedLayout) {
        return MDCTabBarViewLayoutStyleScrollable;
      }
      UIEdgeInsets contentPadding =
          [self contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixed];
      CGFloat itemLayoutWidth = availableSize.width - contentPadding.left - contentPadding.right;
      if ((itemLayoutWidth / self.items.count) > kMaxItemWidth) {
        return MDCTabBarViewLayoutStyleFixedClusteredCentered;
      }
      return MDCTabBarViewLayoutStyleFixed;
    }
    case MDCTabBarViewLayoutStyleFixedClusteredCentered: {
      CGFloat requiredWidthForClusteredCenteredLayout =
          [self
              intrinsicContentSizeForClusteredLayout:MDCTabBarViewLayoutStyleFixedClusteredCentered]
              .width;
      if (availableSize.width < requiredWidthForClusteredCenteredLayout) {
        return MDCTabBarViewLayoutStyleScrollable;
      }
      return MDCTabBarViewLayoutStyleFixedClusteredCentered;
    }
    case MDCTabBarViewLayoutStyleFixedClusteredLeading: {
      CGFloat requiredWidthForClusteredLeadingLayout =
          [self
              intrinsicContentSizeForClusteredLayout:MDCTabBarViewLayoutStyleFixedClusteredLeading]
              .width;
      if (availableSize.width < requiredWidthForClusteredLeadingLayout) {
        return MDCTabBarViewLayoutStyleScrollable;
      }
      return MDCTabBarViewLayoutStyleFixedClusteredLeading;
    }
    case MDCTabBarViewLayoutStyleFixedClusteredTrailing: {
      CGFloat requiredWidthForClusteredTrailingLayout =
          [self
              intrinsicContentSizeForClusteredLayout:MDCTabBarViewLayoutStyleFixedClusteredTrailing]
              .width;
      if (availableSize.width < requiredWidthForClusteredTrailingLayout) {
        return MDCTabBarViewLayoutStyleScrollable;
      }
      return MDCTabBarViewLayoutStyleFixedClusteredTrailing;
    }
  }
}

- (void)layoutSubviewsForJustifiedLayout {
  if (self.itemViews.count == 0) {
    return;
  }
  BOOL isRTL = [self isRTL];

  CGSize contentSize = [self availableSizeForSubviewLayout];
  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  CGFloat itemLayoutWidth = contentSize.width - contentPadding.left - contentPadding.right;
  CGFloat itemViewWidth = itemLayoutWidth / self.itemViews.count;
  CGFloat itemViewOriginX = isRTL ? contentPadding.right : contentPadding.left;
  CGFloat itemViewOriginY = contentPadding.top;
  CGFloat itemViewHeight = contentSize.height - contentPadding.top - contentPadding.bottom;
  NSEnumerator<UIView *> *itemViewEnumerator =
      isRTL ? [self.itemViews reverseObjectEnumerator] : [self.itemViews objectEnumerator];

  for (UIView *itemView in itemViewEnumerator) {
    itemView.frame = CGRectMake(itemViewOriginX, itemViewOriginY, itemViewWidth, itemViewHeight);
    itemViewOriginX += itemViewWidth;
  }
}

- (void)layoutSubviewsForFixedClusteredLayout:(MDCTabBarViewLayoutStyle)layoutStyle {
  if (self.itemViews.count == 0) {
    return;
  }

  BOOL isRTL = [self isRTL];

  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:layoutStyle];
  CGSize contentSize = [self availableSizeForSubviewLayout];
  CGFloat itemViewWidth = [self itemViewSizeForClusteredFixedLayout].width;
  CGFloat totalRequiredWidth = itemViewWidth * self.items.count;
  // Start-out assuming left-aligned because it requires no computation.
  CGFloat itemViewOriginX = isRTL ? contentPadding.right : contentPadding.left;
  // Right-aligned
  if ((isRTL && layoutStyle == MDCTabBarViewLayoutStyleFixedClusteredLeading) ||
      (!isRTL && layoutStyle == MDCTabBarViewLayoutStyleFixedClusteredTrailing)) {
    itemViewOriginX = (contentSize.width - totalRequiredWidth);
    itemViewOriginX -= isRTL ? contentPadding.left : contentPadding.right;
  }
  // Centered
  else if (layoutStyle == MDCTabBarViewLayoutStyleFixedClusteredCentered) {
    itemViewOriginX =
        (contentSize.width - totalRequiredWidth - contentPadding.left - contentPadding.right) / 2;
    itemViewOriginX += isRTL ? contentPadding.right : contentPadding.left;
  }

  CGFloat itemViewOriginY = contentPadding.top;
  CGFloat itemViewHeight = contentSize.height - contentPadding.top - contentPadding.bottom;
  NSEnumerator<UIView *> *itemViewEnumerator =
      isRTL ? [self.itemViews reverseObjectEnumerator] : [self.itemViews objectEnumerator];

  for (UIView *itemView in itemViewEnumerator) {
    itemView.frame = CGRectMake(itemViewOriginX, itemViewOriginY, itemViewWidth, itemViewHeight);
    itemViewOriginX += itemViewWidth;
  }
}

- (void)layoutSubviewsForScrollableLayout:(MDCTabBarViewLayoutStyle)layoutStyle {
  BOOL isRTL = [self isRTL];
  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:layoutStyle];

  // Default for LTR
  CGFloat itemViewOriginX = contentPadding.left;
  if (isRTL) {
    itemViewOriginX = 0;
    CGFloat requiredBarSize = [self intrinsicContentSizeForNonFixedLayoutStyle:layoutStyle].width;
    CGFloat boundsBarDiff = [self availableSizeForSubviewLayout].width - requiredBarSize;
    if (boundsBarDiff > 0) {
      itemViewOriginX = boundsBarDiff;
    }
    itemViewOriginX += contentPadding.right;
  }
  CGFloat itemViewOriginY = contentPadding.top;
  CGFloat itemViewHeight =
      [self availableSizeForSubviewLayout].height - contentPadding.top - contentPadding.bottom;
  NSEnumerator<UIView *> *itemViewEnumerator =
      isRTL ? [self.itemViews reverseObjectEnumerator] : [self.itemViews objectEnumerator];
  for (UIView *view in itemViewEnumerator) {
    CGSize intrinsicContentSize = view.intrinsicContentSize;
    view.frame =
        CGRectMake(itemViewOriginX, itemViewOriginY, intrinsicContentSize.width, itemViewHeight);
    itemViewOriginX += intrinsicContentSize.width;
  }
}

- (void)layoutSubviewsForNonFixedClusteredCentered {
  UIEdgeInsets contentPadding =
      [self contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleNonFixedClusteredCentered];
  BOOL isRTL = [self isRTL];
  if (isRTL) {
    CGFloat right = contentPadding.right;
    contentPadding.right = contentPadding.left;
    contentPadding.left = right;
  }
  CGFloat availableSpaceMinX = contentPadding.left;
  CGFloat availableSpaceMaxX = [self availableSizeForSubviewLayout].width - contentPadding.right;
  CGFloat availableSpaceWidth = availableSpaceMaxX - availableSpaceMinX;
  CGFloat centerOfAvailableSpace = availableSpaceMinX + availableSpaceWidth * 0.5f;
  CGSize combineditemSize = [self nonFixedCombinedItemSize];
  CGFloat halfOfCombinedItemSizeWidth = combineditemSize.width * 0.5f;
  CGFloat itemViewMinX = centerOfAvailableSpace - halfOfCombinedItemSizeWidth;
  CGFloat itemViewMinY = contentPadding.top;
  NSEnumerator<UIView *> *itemViewEnumerator =
      isRTL ? [self.itemViews reverseObjectEnumerator] : [self.itemViews objectEnumerator];
  for (UIView *view in itemViewEnumerator) {
    CGSize intrinsicContentSize = view.intrinsicContentSize;
    view.frame =
        CGRectMake(itemViewMinX, itemViewMinY, intrinsicContentSize.width, combineditemSize.height);
    itemViewMinX += intrinsicContentSize.width;
  }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.needsScrollToSelectedItem = YES;
}

- (CGSize)intrinsicContentSize {
  switch (self.preferredLayoutStyle) {
    case MDCTabBarViewLayoutStyleFixed: {
      return [self intrinsicContentSizeForJustifiedLayout];
    }
    case MDCTabBarViewLayoutStyleScrollableCentered:
    case MDCTabBarViewLayoutStyleNonFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleScrollable: {
      return [self intrinsicContentSizeForNonFixedLayoutStyle:self.preferredLayoutStyle];
    }
    case MDCTabBarViewLayoutStyleFixedClusteredLeading:
    case MDCTabBarViewLayoutStyleFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleFixedClusteredTrailing: {
      return [self intrinsicContentSizeForClusteredLayout:self.preferredLayoutStyle];
    }
  }
}

/**
 The content size of the tabs in their current layout style.

 For @c FixedJustified:  The content size is the maximum of the bounds within the safe area or the
                         intrinsic size of the tabs when all tabs have the widest tab's width.
 For @c FixedClustered*: The bounds within the safe area. This ensures they are positionined
                         accurately within the content area.
 For @c Scrollable:      The intrinsic size size of the tabs.
 */
- (CGSize)calculatedContentSize {
  MDCTabBarViewLayoutStyle layoutStyle = [self effectiveLayoutStyle];
  switch (layoutStyle) {
    case MDCTabBarViewLayoutStyleFixed: {
      CGSize intrinsicContentSize = [self intrinsicContentSizeForJustifiedLayout];
      CGSize boundsSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

      return CGSizeMake(MAX(boundsSize.width, intrinsicContentSize.width),
                        MAX(boundsSize.height, intrinsicContentSize.height));
    }
    case MDCTabBarViewLayoutStyleFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleFixedClusteredTrailing:
    case MDCTabBarViewLayoutStyleFixedClusteredLeading: {
      return [self availableSizeForSubviewLayout];
    }
    case MDCTabBarViewLayoutStyleScrollableCentered:
    case MDCTabBarViewLayoutStyleNonFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleScrollable: {
      return [self intrinsicContentSizeForNonFixedLayoutStyle:layoutStyle];
    }
  }
}

- (CGSize)intrinsicContentSizeForJustifiedLayout {
  CGFloat maxWidth = 0;
  CGFloat maxHeight = kMinHeight;
  for (UIView *itemView in self.itemViews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    maxHeight = MAX(maxHeight, contentSize.height);
    maxWidth = MAX(maxWidth, contentSize.width);
  }
  CGSize contentSize = CGSizeMake(maxWidth * self.items.count, maxHeight);
  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:MDCTabBarViewLayoutStyleFixed];
  contentSize = CGSizeMake(contentSize.width + contentPadding.left + contentPadding.right,
                           contentSize.height + contentPadding.top + contentPadding.bottom);
  return contentSize;
}

- (CGSize)nonFixedCombinedItemSize {
  CGFloat totalWidth = 0;
  CGFloat maxHeight = 0;
  for (UIView *itemView in self.itemViews) {
    CGSize contentSize = itemView.intrinsicContentSize;
    if (contentSize.height > maxHeight) {
      maxHeight = contentSize.height;
    }
    totalWidth += contentSize.width;
  }
  CGSize contentSize = CGSizeMake(totalWidth, MAX(kMinHeight, maxHeight));
  return contentSize;
}

- (CGSize)intrinsicContentSizeForNonFixedLayoutStyle:(MDCTabBarViewLayoutStyle)layoutStyle {
  CGSize contentSize = [self nonFixedCombinedItemSize];
  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:layoutStyle];
  contentSize = CGSizeMake(contentSize.width + contentPadding.left + contentPadding.right,
                           contentSize.height + contentPadding.top + contentPadding.bottom);
  return contentSize;
}

- (CGSize)intrinsicContentSizeForClusteredLayout:(MDCTabBarViewLayoutStyle)layoutStyle {
  if (self.items.count == 0) {
    return CGSizeZero;
  }
  CGSize estimatedItemSize = [self itemViewSizeForClusteredFixedLayout];
  CGSize contentSize =
      CGSizeMake(estimatedItemSize.width * self.items.count, estimatedItemSize.height);
  UIEdgeInsets contentPadding = [self contentPaddingForLayoutStyle:layoutStyle];
  contentSize = CGSizeMake(contentSize.width + contentPadding.left + contentPadding.right,
                           contentSize.height + contentPadding.top + contentPadding.bottom);
  return contentSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize fitSize = [self intrinsicContentSizeForJustifiedLayout];
  return CGSizeMake(size.width, fitSize.height);
}

#pragma mark - Helpers

- (BOOL)isRTL {
  return self.mdf_effectiveUserInterfaceLayoutDirection ==
         UIUserInterfaceLayoutDirectionRightToLeft;
}

- (void)scrollToItem:(UITabBarItem *)item animated:(BOOL)animated {
  NSUInteger index = [self.items indexOfObject:item];
  if (index == NSNotFound || index >= self.itemViews.count) {
    index = 0;
  }
  if (self.itemViews.count == 0U) {
    return;
  }

  if ([self effectiveLayoutStyle] == MDCTabBarViewLayoutStyleScrollableCentered) {
    CGPoint contentOffset = [self contentOffsetNeededToCenterItemView:self.itemViews[index]];
    void (^animationBlock)(void) = ^{
      self.contentOffset = contentOffset;
    };
    if (animated) {
      [self performAnimationBlockInCATransaction:animationBlock];
    } else {
      animationBlock();
    }
  } else {
    CGRect estimatedItemFrame = [self estimatedFrameForItemAtIndex:index];
    [self scrollRectToVisible:estimatedItemFrame animated:animated];
  }

  [self invalidateInteractionsForItemViews];
}

- (void)invalidateInteractionsForItemViews {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    for (MDCTabBarView *view in self.itemViews) {
      for (UIPointerInteraction *interaction in view.interactions) {
        [interaction invalidate];
      }
    }
  }
#endif
}

- (CGRect)estimatedFrameForItemAtIndex:(NSUInteger)index {
  if (index == NSNotFound || index >= self.itemViews.count) {
    return CGRectZero;
  }

  BOOL isRTL = [self isRTL];
  CGFloat originAdjustment = self.isScrollableLayoutStyle ? kScrollableTabsLeadingEdgeInset : 0;
  CGFloat viewOriginX = isRTL ? self.contentSize.width - originAdjustment : originAdjustment;

  for (NSUInteger i = 0; i < index; ++i) {
    CGSize viewSize = [self expectedSizeForView:self.itemViews[i]];
    if (isRTL) {
      viewOriginX -= viewSize.width;
    } else {
      viewOriginX += viewSize.width;
    }
  }
  CGSize viewSize = [self expectedSizeForView:self.itemViews[index]];
  if (isRTL) {
    viewOriginX -= viewSize.width;
  }
  return CGRectMake(viewOriginX, 0, viewSize.width, viewSize.height);
}

- (CGPoint)contentOffsetNeededToCenterItemView:(UIView *)itemView {
  CGFloat availableWidth = [self availableSizeForSubviewLayout].width;
  CGRect itemFrame = itemView.frame;
  if (CGSizeEqualToSize(itemView.frame.size, CGSizeZero)) {
    NSUInteger index = [self.itemViews indexOfObject:itemView];
    itemFrame = [self estimatedFrameForItemAtIndex:index];
  }
  CGFloat itemViewWidth = CGRectGetWidth(itemFrame);
  CGFloat contentOffsetX = CGRectGetMinX(itemFrame) - ((availableWidth - itemViewWidth) / 2.f);
  contentOffsetX = MAX(contentOffsetX, 0.f);
  CGSize contentSize = [self calculatedContentSize];
  contentOffsetX = MIN(contentOffsetX, MAX(contentSize.width - availableWidth, 0.f));
  return CGPointMake(contentOffsetX, self.contentOffset.y);
}

- (CGSize)expectedSizeForView:(UIView *)view {
  if (self.itemViews.count == 0) {
    return CGSizeZero;
  }

  switch ([self effectiveLayoutStyle]) {
    case MDCTabBarViewLayoutStyleFixed: {
      if (CGRectGetWidth(self.bounds) > 0) {
        CGSize contentSize = [self availableSizeForSubviewLayout];
        return CGSizeMake(contentSize.width / self.itemViews.count, contentSize.height);
      }
      return [self intrinsicContentSizeForView:view];
    }
    case MDCTabBarViewLayoutStyleFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleFixedClusteredTrailing:
    case MDCTabBarViewLayoutStyleFixedClusteredLeading: {
      return [self itemViewSizeForClusteredFixedLayout];
    }
    case MDCTabBarViewLayoutStyleNonFixedClusteredCentered:
    case MDCTabBarViewLayoutStyleScrollableCentered:
    case MDCTabBarViewLayoutStyleScrollable: {
      return [self intrinsicContentSizeForView:view];
    }
  }
}

- (CGSize)intrinsicContentSizeForView:(UIView *)view {
  CGSize expectedItemSize = view.intrinsicContentSize;
  if (expectedItemSize.width == UIViewNoIntrinsicMetric) {
    NSAssert(expectedItemSize.width != UIViewNoIntrinsicMetric,
             @"All tab bar item views must define an intrinsic content size.");
    expectedItemSize = [view sizeThatFits:self.contentSize];
  }
  return expectedItemSize;
}

- (CGSize)itemViewSizeForClusteredFixedLayout {
  CGFloat largestWidth = 0;
  CGFloat largestHeight = 0;
  for (UIView *view in self.itemViews) {
    CGSize intrinsicContentSize = view.intrinsicContentSize;
    if (intrinsicContentSize.width > largestWidth) {
      largestWidth = intrinsicContentSize.width;
    }
    if (intrinsicContentSize.height > largestHeight) {
      largestHeight = intrinsicContentSize.height;
    }
  }
  return CGSizeMake(largestWidth, largestHeight);
}

- (CGRect)availableBoundsForSubviewLayout {
  CGRect availableBounds = CGRectStandardize(self.bounds);
  if (@available(iOS 11.0, *)) {
    if (_shouldAdjustForSafeAreaInsets) {
      availableBounds = UIEdgeInsetsInsetRect(availableBounds, self.safeAreaInsets);
    }
  }
  return availableBounds;
}

- (CGSize)availableSizeForSubviewLayout {
  return [self availableBoundsForSubviewLayout].size;
}

- (void)performAnimationBlockInCATransaction:(void (^)(void))animationBlock {
  CAMediaTimingFunction *easeInOutFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  // Wrap in explicit CATransaction to allow layer-based animations with the correct duration.
  [CATransaction begin];
  [CATransaction setAnimationDuration:self.selectionChangeAnimationDuration];
  [CATransaction setAnimationTimingFunction:easeInOutFunction];
  [UIView animateWithDuration:self.selectionChangeAnimationDuration
                        delay:0
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:animationBlock
                   completion:nil];
  [CATransaction commit];
}

#pragma mark - Actions

- (void)didTapItemView:(UITapGestureRecognizer *)tap {
  NSUInteger index = [self.itemViews indexOfObject:tap.view];
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

/// Sets _selectionIndicator's bounds and center to display under the item at the given index with
/// no animation. May be called from an animation block to animate the transition.
- (void)updateSelectionIndicatorToIndex:(NSUInteger)index {
  if (index == NSNotFound || index >= self.items.count) {
    // Hide selection indicator.
    self.selectionIndicatorView.bounds = CGRectZero;
    return;
  }

  // Place selection indicator under the item's cell.
  CGRect selectedItemFrame = [self selectedItemView].frame;
  if (CGRectEqualToRect(selectedItemFrame, CGRectZero)) {
    selectedItemFrame =
        [self estimatedFrameForItemAtIndex:[self.items indexOfObject:self.selectedItem]];
  }
  self.selectionIndicatorView.frame = selectedItemFrame;

  CGRect selectionIndicatorBounds =
      CGRectMake(0, 0, CGRectGetWidth(self.selectionIndicatorView.bounds),
                 CGRectGetHeight(self.selectionIndicatorView.bounds));

  // Extract content frame from item view.
  CGRect contentFrame = selectionIndicatorBounds;
  UIView *itemView = self.itemViews[index];
  if ([itemView conformsToProtocol:@protocol(MDCTabBarViewCustomViewable)]) {
    UIView<MDCTabBarViewCustomViewable> *supportingView =
        (UIView<MDCTabBarViewCustomViewable> *)itemView;
    contentFrame = supportingView.contentFrame;
  }

  // Construct a context object describing the selected tab.
  UITabBarItem *item = self.items[index];
  MDCTabBarViewPrivateIndicatorContext *context =
      [[MDCTabBarViewPrivateIndicatorContext alloc] initWithItem:item
                                                          bounds:selectionIndicatorBounds
                                                    contentFrame:contentFrame];

  // Ask the template for attributes.
  id<MDCTabBarViewIndicatorTemplate> template = self.selectionIndicatorTemplate;
  MDCTabBarViewIndicatorAttributes *indicatorAttributes =
      [template indicatorAttributesForContext:context];

  // Update the selection indicator.
  [self.selectionIndicatorView applySelectionIndicatorAttributes:indicatorAttributes];
}

/**
 Updates the selection indicator with or without animation. Passing @c NSNotFound for @c index will
 cause the indicator to become invisible.

 @param index The index of the selected item.
 @param animate @c YES if the change should be animated, @c NO if it should be immediate.
 */
- (void)didSelectItemAtIndex:(NSUInteger)index animateTransition:(BOOL)animate {
  void (^animationBlock)(void) = ^{
    [self updateSelectionIndicatorToIndex:index];

    // Force layout so any changes to the selection indicator are captured by the animation block.
    [self.selectionIndicatorView layoutIfNeeded];
  };

  if (animate) {
    [self performAnimationBlockInCATransaction:animationBlock];
  } else {
    animationBlock();
  }
}

- (UIView *)selectedItemView {
  if (!self.selectedItem) {
    return nil;
  }

  return self.itemViews[[self.items indexOfObject:self.selectedItem]];
}

#pragma mark - UIPointerInteractionDelegate

#ifdef __IPHONE_13_4
- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction
                        styleForRegion:(UIPointerRegion *)region API_AVAILABLE(ios(13.4)) {
  UIPointerStyle *pointerStyle = nil;
  if (interaction.view) {
    UITargetedPreview *targetedPreview = [[UITargetedPreview alloc] initWithView:interaction.view];
    UIPointerEffect *highlightEffect = [UIPointerHighlightEffect effectWithPreview:targetedPreview];
    UIPointerShape *pointerShape = [UIPointerShape shapeWithRoundedRect:interaction.view.frame];
    pointerStyle = [UIPointerStyle styleWithEffect:highlightEffect shape:pointerShape];
  }
  return pointerStyle;
}
#endif

@end
