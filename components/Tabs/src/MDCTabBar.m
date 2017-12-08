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

#import "MDCTabBarIndicatorTemplate.h"
#import "MDCTabBarUnderlineIndicatorTemplate.h"
#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "private/MDCItemBar.h"
#import "private/MDCItemBarAlignment.h"
#import "private/MDCItemBarStyle.h"

/// Padding between image and title in points, according to the spec.
static const CGFloat kImageTitleSpecPadding = 10;

/// Adjustment added to spec measurements to compensate for internal paddings.
static const CGFloat kImageTitlePaddingAdjustment = -3;

// Heights based on the spec: https://material.io/guidelines/components/tabs.html

/// Height for image-only tab bars, in points.
static const CGFloat kImageOnlyBarHeight = 48;

/// Height for image-only tab bars, in points.
static const CGFloat kTitleOnlyBarHeight = 48;

/// Height for image-and-title tab bars, in points.
static const CGFloat kTitledImageBarHeight = 72;

/// Height for bottom navigation bars, in points.
static const CGFloat kBottomNavigationBarHeight = 56;

/// Maximum width for individual items in bottom navigation bars, in points.
static const CGFloat kBottomNavigationMaximumItemWidth = 168;

/// Title-image padding for bottom navigation bars, in points.
static const CGFloat kBottomNavigationTitleImagePadding = 3;

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

  NSCAssert(0, @"Invalid alignment value %zd", alignment);
  return MDCItemBarAlignmentLeading;
}

@interface MDCTabBar () <MDCItemBarDelegate>
@end

@implementation MDCTabBar {
  /// Item bar responsible for displaying the actual tab bar content.
  MDCItemBar *_itemBar;

  // Flags tracking if properties are unset and using default values.
  BOOL _hasDefaultAlignment;
  BOOL _hasDefaultItemAppearance;

  // For properties which have been set, these store the new fixed values.
  MDCTabBarAlignment _alignmentOverride;
  MDCTabBarItemAppearance _itemAppearanceOverride;
}
// Inherit UIView's tintColor logic.
@dynamic tintColor;
@synthesize alignment = _alignment;
@synthesize barPosition = _barPosition;
@synthesize itemAppearance = _itemAppearance;

#pragma mark - Initialization

+ (void)initialize {
  [MDCTabBar appearance].selectedItemTintColor = [UIColor whiteColor];
  [MDCTabBar appearance].unselectedItemTintColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
  [MDCTabBar appearance].inkColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
  [MDCTabBar appearance].barTintColor = nil;

  id<MDCTabBarIndicatorTemplate> template = [[MDCTabBarUnderlineIndicatorTemplate alloc] init];
  [MDCTabBar appearance].selectionIndicatorTemplate = template;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCTabBarInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCTabBarInit];
  }
  return self;
}

- (void)commonMDCTabBarInit {
  self.clipsToBounds = YES;
  _barPosition = UIBarPositionAny;
  _hasDefaultItemAppearance = YES;
  _hasDefaultAlignment = YES;

  // Set default values
  _alignment = [self computedAlignment];
  _titleTextTransform = MDCTabBarTextTransformAutomatic;
  _itemAppearance = [self computedItemAppearance];
  _selectionIndicatorTemplate = [MDCTabBar defaultSelectionIndicatorTemplate];
  _selectedItemTitleFont = [MDCTypography buttonFont];
  _unselectedItemTitleFont = [MDCTypography buttonFont];

  // Create item bar.
  _itemBar = [[MDCItemBar alloc] initWithFrame:self.bounds];
  _itemBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _itemBar.delegate = self;
  _itemBar.alignment = MDCItemBarAlignmentForTabBarAlignment(_alignment);
  [self addSubview:_itemBar];

  [self updateItemBarStyle];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize sizeThatFits = [_itemBar sizeThatFits:self.bounds.size];
  _itemBar.frame = CGRectMake(0, 0, sizeThatFits.width, sizeThatFits.height);
}

#pragma mark - Public

+ (CGFloat)defaultHeightForBarPosition:(UIBarPosition)position
                        itemAppearance:(MDCTabBarItemAppearance)appearance {
  if ([self isTopTabsForPosition:position]) {
    switch (appearance) {
      case MDCTabBarItemAppearanceTitledImages:
        return kTitledImageBarHeight;

      case MDCTabBarItemAppearanceTitles:
        return kTitleOnlyBarHeight;

      case MDCTabBarItemAppearanceImages:
        return kImageOnlyBarHeight;
    }
  } else {
    // Bottom navigation has a fixed height.
    return kBottomNavigationBarHeight;
  }
}

+ (CGFloat)defaultHeightForItemAppearance:(MDCTabBarItemAppearance)appearance {
  return [self defaultHeightForBarPosition:UIBarPositionAny itemAppearance:appearance];
}

- (void)setDelegate:(id<MDCTabBarDelegate>)delegate {
  if (delegate != _delegate) {
    _delegate = delegate;

    // Delegate determines the position - update immediately.
    [self updateItemBarPosition];
  }
}

- (NSArray<UITabBarItem *> *)items {
  return _itemBar.items;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  _itemBar.items = items;
}

- (UITabBarItem *)selectedItem {
  return _itemBar.selectedItem;
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
  _itemBar.selectedItem = selectedItem;
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem animated:(BOOL)animated {
  [_itemBar setSelectedItem:selectedItem animated:animated];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
  if (_barTintColor != barTintColor && ![_barTintColor isEqual:barTintColor]) {
    _barTintColor = barTintColor;

    // Update background color.
    self.backgroundColor = barTintColor;
  }
}

- (void)setInkColor:(UIColor *)inkColor {
  if (_inkColor != inkColor && ![_inkColor isEqual:inkColor]) {
    _inkColor = inkColor;

    [self updateItemBarStyle];
  }
}

- (void)setUnselectedItemTitleFont:(UIFont *)unselectedItemTitleFont {
  if ((unselectedItemTitleFont != _unselectedItemTitleFont) &&
      ![unselectedItemTitleFont isEqual:_unselectedItemTitleFont]) {
    _unselectedItemTitleFont = unselectedItemTitleFont;
    [self updateItemBarStyle];
  }
}

- (void)setSelectedItemTitleFont:(UIFont *)selectedItemTitleFont {
  if ((selectedItemTitleFont != _selectedItemTitleFont) &&
      ![selectedItemTitleFont isEqual:_selectedItemTitleFont]) {
    _selectedItemTitleFont = selectedItemTitleFont;
    [self updateItemBarStyle];
  }
}

- (void)setAlignment:(MDCTabBarAlignment)alignment {
  [self setAlignment:alignment animated:NO];
}

- (void)setAlignment:(MDCTabBarAlignment)alignment animated:(BOOL)animated {
  _hasDefaultAlignment = NO;
  _alignmentOverride = alignment;
  [self internalSetAlignment:[self computedAlignment] animated:animated];
}

- (void)setItemAppearance:(MDCTabBarItemAppearance)itemAppearance {
  _hasDefaultItemAppearance = NO;
  _itemAppearanceOverride = itemAppearance;
  [self internalSetItemAppearance:[self computedItemAppearance]];
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

- (BOOL)displaysUppercaseTitles {
  switch (self.titleTextTransform) {
    case MDCTabBarTextTransformAutomatic:
      return [MDCTabBar displaysUppercaseTitlesByDefaultForPosition:_barPosition];

    case MDCTabBarTextTransformNone:
      return NO;

    case MDCTabBarTextTransformUppercase:
      return YES;
  }
}

- (void)setDisplaysUppercaseTitles:(BOOL)displaysUppercaseTitles {
  self.titleTextTransform =
      displaysUppercaseTitles ? MDCTabBarTextTransformUppercase : MDCTabBarTextTransformNone;
}

- (void)setTitleTextTransform:(MDCTabBarTextTransform)titleTextTransform {
  if (titleTextTransform != _titleTextTransform) {
    _titleTextTransform = titleTextTransform;
    [self updateItemBarStyle];
  }
}

- (void)setSelectionIndicatorTemplate:(id<MDCTabBarIndicatorTemplate>)selectionIndicatorTemplate {
  id<MDCTabBarIndicatorTemplate> template = selectionIndicatorTemplate;
  if (!template) {
    template = [MDCTabBar defaultSelectionIndicatorTemplate];
  }
  _selectionIndicatorTemplate = template;
  [self updateItemBarStyle];
}

#pragma mark - MDCAccessibility

- (id)accessibilityElementForItem:(UITabBarItem *)item {
  return [_itemBar accessibilityElementForItem:item];
}

#pragma mark - MDCItemBarDelegate

- (void)itemBar:(__unused MDCItemBar *)itemBar didSelectItem:(UITabBarItem *)item {
  id<MDCTabBarDelegate> delegate = self.delegate;
  if ([delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
    [delegate tabBar:self didSelectItem:item];
  }
}

- (BOOL)itemBar:(__unused MDCItemBar *)itemBar shouldSelectItem:(UITabBarItem *)item {
  id<MDCTabBarDelegate> delegate = self.delegate;
  BOOL shouldSelect = YES;
  if ([delegate respondsToSelector:@selector(tabBar:shouldSelectItem:)]) {
    shouldSelect = [delegate tabBar:self shouldSelectItem:item];
  }
  if (shouldSelect && [delegate respondsToSelector:@selector(tabBar:willSelectItem:)]) {
    [delegate tabBar:self willSelectItem:item];
  }
  return shouldSelect;
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

- (void)didMoveToWindow {
  [super didMoveToWindow];

  // Ensure the bar position is up to date before moving to a window.
  [self updateItemBarPosition];
}

#pragma mark - Private

+ (MDCItemBarStyle *)defaultStyleForPosition:(UIBarPosition)position
                              itemAppearance:(MDCTabBarItemAppearance)appearance {
  MDCItemBarStyle *style = [[MDCItemBarStyle alloc] init];

  // Set base style using position.
  if ([self isTopTabsForPosition:position]) {
    // Top tabs
    style.shouldDisplaySelectionIndicator = YES;
    style.shouldGrowOnSelection = NO;
    style.inkStyle = MDCInkStyleBounded;
    style.titleImagePadding = (kImageTitleSpecPadding + kImageTitlePaddingAdjustment);
    style.textOnlyNumberOfLines = 2;
  } else {
    // Bottom navigation
    style.shouldDisplaySelectionIndicator = NO;
    style.shouldGrowOnSelection = YES;
    style.maximumItemWidth = kBottomNavigationMaximumItemWidth;
    style.inkStyle = MDCInkStyleUnbounded;
    style.titleImagePadding = kBottomNavigationTitleImagePadding;
    style.textOnlyNumberOfLines = 1;
  }

  // Update appearance-dependent style properties.
  BOOL displayImage = NO;
  BOOL displayTitle = NO;
  switch (appearance) {
    case MDCTabBarItemAppearanceImages:
      displayImage = YES;
      break;

    case MDCTabBarItemAppearanceTitles:
      displayTitle = YES;
      break;

    case MDCTabBarItemAppearanceTitledImages:
      displayImage = YES;
      displayTitle = YES;
      break;

    default:
      NSAssert(0, @"Invalid appearance value %zd", appearance);
      displayTitle = YES;
      break;
  }
  style.shouldDisplayImage = displayImage;
  style.shouldDisplayTitle = displayTitle;

  // Update default height
  CGFloat defaultHeight = [self defaultHeightForBarPosition:position itemAppearance:appearance];
  if (defaultHeight == 0) {
    NSAssert(0, @"Missing default height for %zd", appearance);
    defaultHeight = kTitleOnlyBarHeight;
  }
  style.defaultHeight = defaultHeight;

  // Only show badge with images.
  style.shouldDisplayBadge = displayImage;

  return style;
}

+ (BOOL)isTopTabsForPosition:(UIBarPosition)position {
  switch (position) {
    case UIBarPositionAny:
    case UIBarPositionTop:
      return YES;

    case UIBarPositionBottom:
      return NO;

    case UIBarPositionTopAttached:
      NSAssert(NO, @"MDCTabBar does not support UIBarPositionTopAttached");
      return NO;
  }
}

+ (BOOL)displaysUppercaseTitlesByDefaultForPosition:(UIBarPosition)position {
  switch (position) {
    case UIBarPositionAny:
    case UIBarPositionTop:
      return YES;

    case UIBarPositionBottom:
      return NO;

    case UIBarPositionTopAttached:
      NSAssert(NO, @"MDCTabBar does not support UIBarPositionTopAttached");
      return YES;
  }
}

+ (MDCTabBarAlignment)defaultAlignmentForPosition:(UIBarPosition)position {
  switch (position) {
    case UIBarPositionAny:
    case UIBarPositionTop:
      return MDCTabBarAlignmentLeading;

    case UIBarPositionBottom:
      return MDCTabBarAlignmentJustified;

    case UIBarPositionTopAttached:
      NSAssert(NO, @"MDCTabBar does not support UIBarPositionTopAttached");
      return MDCTabBarAlignmentLeading;
  }
}

+ (MDCTabBarItemAppearance)defaultItemAppearanceForPosition:(UIBarPosition)position {
  switch (position) {
    case UIBarPositionAny:
    case UIBarPositionTop:
      return MDCTabBarItemAppearanceTitles;

    case UIBarPositionBottom:
      return MDCTabBarItemAppearanceTitledImages;

    case UIBarPositionTopAttached:
      NSAssert(NO, @"MDCTabBar does not support UIBarPositionTopAttached");
      return YES;
  }
}

+ (id<MDCTabBarIndicatorTemplate>)defaultSelectionIndicatorTemplate {
  return [[MDCTabBarUnderlineIndicatorTemplate alloc] init];
}

- (MDCTabBarAlignment)computedAlignment {
  if (_hasDefaultAlignment) {
    return [[self class] defaultAlignmentForPosition:_barPosition];
  } else {
    return _alignmentOverride;
  }
}

- (MDCTabBarItemAppearance)computedItemAppearance {
  if (_hasDefaultItemAppearance) {
    return [[self class] defaultItemAppearanceForPosition:_barPosition];
  } else {
    return _itemAppearanceOverride;
  }
}

- (void)internalSetAlignment:(MDCTabBarAlignment)alignment animated:(BOOL)animated {
  if (_alignment != alignment) {
    _alignment = alignment;
    [_itemBar setAlignment:MDCItemBarAlignmentForTabBarAlignment(_alignment) animated:animated];
  }
}

- (void)internalSetItemAppearance:(MDCTabBarItemAppearance)itemAppearance {
  if (_itemAppearance != itemAppearance) {
    _itemAppearance = itemAppearance;
    [self updateItemBarStyle];
  }
}

- (void)updateItemBarPosition {
  UIBarPosition newPosition = UIBarPositionAny;
  id<MDCTabBarDelegate> delegate = _delegate;
  if (delegate && [delegate respondsToSelector:@selector(positionForBar:)]) {
    newPosition = [delegate positionForBar:self];
  }

  if (_barPosition != newPosition) {
    _barPosition = newPosition;
    [self updatePositionDerivedDefaultValues];
    [self updateItemBarStyle];
  }
}

- (void)updatePositionDerivedDefaultValues {
  [self internalSetAlignment:[self computedAlignment] animated:NO];
  [self internalSetItemAppearance:[self computedItemAppearance]];
}

/// Update the item bar's style property, which depends on the bar position and item appearance.
- (void)updateItemBarStyle {
  MDCItemBarStyle *style;

  style = [[self class] defaultStyleForPosition:_barPosition itemAppearance:_itemAppearance];

  if ([MDCTabBar isTopTabsForPosition:_barPosition]) {
    // Top tabs: Use provided fonts.
    style.selectedTitleFont = self.selectedItemTitleFont;
    style.unselectedTitleFont = self.unselectedItemTitleFont;
  } else {
    // Bottom navigation: Ignore provided fonts.
    style.selectedTitleFont = [[MDCTypography fontLoader] regularFontOfSize:12];
    style.unselectedTitleFont = [[MDCTypography fontLoader] regularFontOfSize:12];
  }

  style.selectionIndicatorTemplate = self.selectionIndicatorTemplate;
  style.selectionIndicatorColor = self.tintColor;
  style.inkColor = _inkColor;
  style.selectedTitleColor = (_selectedItemTintColor ? _selectedItemTintColor : self.tintColor);
  style.titleColor = _unselectedItemTintColor;
  style.displaysUppercaseTitles = self.displaysUppercaseTitles;

  [_itemBar applyStyle:style];

  // Layout depends on -[MDCItemBar sizeThatFits], which depends on the style.
  [self setNeedsLayout];
}

@end
