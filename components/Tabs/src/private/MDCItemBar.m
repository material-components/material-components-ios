// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCItemBar.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCItemBarCell.h"
#import "MDCItemBarStyle.h"
#import "MDCTabBarDisplayDelegate.h"
#import "MDCTabBarIndicatorAttributes.h"
#import "MDCTabBarIndicatorTemplate.h"
#import "MDCTabBarIndicatorView.h"
#import "MDCTabBarPrivateIndicatorContext.h"
#import "MDCTabBarSizeClassDelegate.h"
#import "MaterialAnimationTiming.h"

/// Cell reuse identifier for item bar cells.
static NSString *const kItemReuseID = @"MDCItem";

/// Default duration in seconds for selection change animations.
static const NSTimeInterval kDefaultAnimationDuration = 0.3;

/// Placeholder width for cells, which get per-item sizing.
static const CGFloat kPlaceholderCellWidth = 10;

/// Horizontal insets in regular size class layouts.
static const CGFloat kRegularInset = 56;

/// Horizontal insets in compact size class layouts.
static const CGFloat kCompactInset = 8;

/// KVO context pointer identifying changes in MDCItemBarItem properties.
static void *kItemPropertyContext = &kItemPropertyContext;

/// Custom flow layout for item content. Selectively works around bugs with RTL and flow layout:
/// Radar 22828797: "UICollectionView with variable-sized items does not reverse item order in RTL."
/// - On iOS 9.0 and later when a UICollectionViewFlow layout has custom-sized items via
///   collectionView:layout:sizeForItemAtIndexPath:, it does not perform automatic right-to-left
///   layout of items. We work around this by detecting incorrect ordering by the superclass and
///   correcting the layout attributes.
/// Radar 22828629, 22828529
/// - On iOS 9 and later, the default scroll location for horizontally-scrolling collection views in
///   RTL is correct, but resets to the left when scrolling an item to visible or manually scrolling
///   the content. We work around this by padding collection content to always fill the scroll view.
@interface MDCItemBarFlowLayout : UICollectionViewFlowLayout
@end

#pragma mark -

@interface MDCItemBar () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
// Current style properties.
@property(nonatomic, strong, nullable) MDCItemBarStyle *style;
// Collection view for items.
@property(nonatomic, strong, nullable) UICollectionView *collectionView;

@end

@implementation MDCItemBar {
  // Collection layout for items.
  UICollectionViewFlowLayout *_flowLayout;

  /// Indicator layered under the active item.
  MDCTabBarIndicatorView *_selectionIndicator;

  /// Size of the view at last layout, for deduplicating changes.
  CGSize _lastSize;

  /// Width of the collection view accounting for SafeAreaInsets at last layout.
  CGFloat _lastAdjustedCollectionViewWidth;

  /// The current alignment to use for item bar. This may vary from `_alignment` in cases where
  /// the actual alignment is determined on-the-fly.
  MDCItemBarAlignment _currentAlignment;
}

+ (CGFloat)defaultHeightForStyle:(nonnull MDCItemBarStyle *)style {
  return style.defaultHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonItemBarInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonItemBarInit];
  }
  return self;
}

- (void)commonItemBarInit {
  _alignment = MDCItemBarAlignmentLeading;
  _style = [[MDCItemBarStyle alloc] init];
  _items = @[];

  // Configure the collection view.
  _flowLayout = [self generatedFlowLayout];
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                                        collectionViewLayout:_flowLayout];
  collectionView.backgroundColor = [UIColor clearColor];
  collectionView.clipsToBounds = NO;
  collectionView.scrollsToTop = NO;
  collectionView.showsHorizontalScrollIndicator = NO;
  collectionView.showsVerticalScrollIndicator = NO;

  if (@available(iOS 11.0, *)) {
    collectionView.contentInsetAdjustmentBehavior =
        UIScrollViewContentInsetAdjustmentScrollableAxes;
  }

  collectionView.dataSource = self;
  collectionView.delegate = self;
  [collectionView registerClass:[MDCItemBarCell class] forCellWithReuseIdentifier:kItemReuseID];

  _collectionView = collectionView;
  [self addSubview:_collectionView];

  // Configure the selection indicator view.
  _selectionIndicator = [[MDCTabBarIndicatorView alloc] initWithFrame:CGRectZero];
  [_collectionView addSubview:_selectionIndicator];

  // Set initial properties.
  [self updateAlignmentAnimated:NO];
  [self updateScrollProperties];
  [self updateColors];
  [self updateSelectionIndicatorVisibility];
}

- (void)dealloc {
  // Clear out item observations.
  [self stopObservingItems];

  _collectionView.delegate = nil;
}

#pragma mark - Public

- (void)applyStyle:(MDCItemBarStyle *)style {
  if (style != _style && ![style isEqual:_style]) {
    _style = [style copy];

    // Update all style-dependent properties.
    [self updateColors];
    [self updateAlignmentAnimated:NO];
    [self updateSelectionIndicatorVisibility];
    [self updateSelectionIndicatorToIndex:[self indexForItem:_selectedItem]];
    [self configureVisibleCells];
    [self invalidateIntrinsicContentSize];
  }
}

- (void)setItems:(NSArray<UITabBarItem *> *)items {
  NSAssert([NSThread isMainThread], @"Item array may only be set on the main thread");
  NSParameterAssert(items != nil);

  if (_items != items && ![_items isEqual:items]) {
    // Stop observing old items.
    [self stopObservingItems];

    _items = [items copy];

    // Determine new selected item, defaulting to the first item.
    UITabBarItem *newSelectedItem = _items.firstObject;
    if (_selectedItem && [_items containsObject:_selectedItem]) {
      // Previously-selected item still around: Preserve selection.
      newSelectedItem = _selectedItem;
    }

    // Update _selectedItem directly so it's available for -reload.
    _selectedItem = newSelectedItem;

    // Update collection with new items
    [self reload];

    // Select tab for current item.
    [self selectItemAtIndex:[self indexForItem:_selectedItem] animated:NO];

    // Start observing new items for changes.
    [self startObservingItems];
  }
}

- (void)setAlignment:(MDCItemBarAlignment)alignment {
  [self setAlignment:alignment animated:NO];
}

- (void)setAlignment:(MDCItemBarAlignment)alignment animated:(BOOL)animated {
  if (_alignment != alignment) {
    _alignment = alignment;

    [self updateAlignmentAnimated:animated];
  }
}

- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem {
  [self setSelectedItem:selectedItem animated:NO];
}

- (void)setSelectedItem:(nullable UITabBarItem *)selectedItem animated:(BOOL)animated {
  if (_selectedItem != selectedItem) {
    NSUInteger itemIndex = [self indexForItem:selectedItem];
    if (selectedItem && (itemIndex == NSNotFound)) {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"Invalid item"
                             userInfo:nil] raise];
    }

    _selectedItem = selectedItem;
    [self selectItemAtIndex:itemIndex animated:animated];
  }
}

#pragma mark - Accessibility

- (UIAccessibilityTraits)accessibilityTraits {
  if (@available(iOS 10.0, *)) {
    return [super accessibilityTraits] | UIAccessibilityTraitTabBar;
  }
  return [super accessibilityTraits];
}

- (id)accessibilityElementForItem:(UITabBarItem *)item {
  NSUInteger index = [_items indexOfObject:item];
  if (index != NSNotFound) {
    NSArray<NSIndexPath *> *visibleItems = [_collectionView indexPathsForVisibleItems];
    NSIndexPath *indexPath = [self indexPathForItemAtIndex:index];
    if ([visibleItems containsObject:indexPath]) {
      MDCItemBarCell *itemCell =
          (MDCItemBarCell *)[_collectionView cellForItemAtIndexPath:indexPath];
      return itemCell;
    }
  }
  return nil;
}

#pragma mark - NSObject

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == kItemPropertyContext) {
    // MDCItemBarItem change, must be on the main thread.
    NSAssert([NSThread isMainThread], @"Item bar items may only be updated on the main thread.");
    NSAssert([object isKindOfClass:[UITabBarItem class]], @"Change in unexpected object type");

    UITabBarItem *item = object;
    NSInteger itemIndex = [_items indexOfObject:item];
    NSAssert(itemIndex != NSNotFound, @"Inconsistency: Change in unowned item bar item.");

    // Update the cell for the given item if it's visible.
    if (itemIndex != NSNotFound) {
      NSIndexPath *indexPath = [self indexPathForItemAtIndex:itemIndex];
      UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
      if (cell) {
        NSAssert([cell isKindOfClass:[MDCItemBarCell class]], @"All cells must be MDCItemBarCell");
        MDCItemBarCell *itemCell = (MDCItemBarCell *)cell;
        [itemCell updateWithItem:item atIndex:itemIndex count:_items.count];
      }
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  const CGRect bounds = self.bounds;

  _collectionView.frame = bounds;

  // Update collection metrics if the size has changed.
  if (!CGSizeEqualToSize(bounds.size, _lastSize) ||
      [self adjustedCollectionViewWidth] != _lastAdjustedCollectionViewWidth) {
    [self updateAlignmentAnimated:NO];

    // Ensure selected item is aligned properly on resize, forcing the new layout to take effect.
    [_collectionView layoutIfNeeded];

    [self selectItemAtIndex:[self indexForItem:_selectedItem] animated:NO];
  }
  _lastSize = bounds.size;
  _lastAdjustedCollectionViewWidth = [self adjustedCollectionViewWidth];

  // The selection indicator must be behind all cells, regardless of the collection view's layout.
  [_collectionView sendSubviewToBack:_selectionIndicator];
}

- (CGSize)sizeThatFits:(CGSize)size {
  size.height = [[self class] defaultHeightForStyle:_style];
  return size;
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(UIViewNoIntrinsicMetric, [[self class] defaultHeightForStyle:_style]);
}

- (void)safeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];
  }
  [self setNeedsLayout];
}

- (void)didMoveToWindow {
  [super didMoveToWindow];

  // New window: Update for potentially updated size class.
  [self updateAlignmentAnimated:NO];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  // Update alignment and layout metrics for potentially updated size class.
  [self updateAlignmentAnimated:NO];
}

- (void)tintColorDidChange {
  [super tintColorDidChange];

  [self updateColors];
}

// UISemanticContentAttribute was added in iOS SDK 9.0 but is available on devices running earlier
// version of iOS. We ignore the partial-availability warning that gets thrown on our use of this
// symbol.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
- (void)mdf_setSemanticContentAttribute:(UISemanticContentAttribute)semanticContentAttribute {
  if (semanticContentAttribute == self.mdf_semanticContentAttribute) {
    return;
  }
  [super mdf_setSemanticContentAttribute:semanticContentAttribute];
  _collectionView.mdf_semanticContentAttribute = semanticContentAttribute;
  [_collectionView.collectionViewLayout invalidateLayout];
}
#pragma clang diagnostic pop

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_collectionView == collectionView) {
    // Notify delegate of impending selection.
    id<MDCItemBarDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(itemBar:shouldSelectItem:)]) {
      UITabBarItem *item = [self itemAtIndexPath:indexPath];
      if (item) {
        return [delegate itemBar:self shouldSelectItem:item];
      }
    }
  }
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_collectionView == collectionView) {
    // Update selected item.
    UITabBarItem *item = [self itemAtIndexPath:indexPath];
    if (!item) {
      return;
    }
    _selectedItem = item;

    // Notify delegate of new selection.
    id<MDCItemBarDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(itemBar:didSelectItem:)]) {
      [delegate itemBar:self didSelectItem:item];
    }

    // Update UI to reflect newly selected item.
    [self didSelectItemAtIndex:indexPath.item animateTransition:YES];
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                    animated:YES];
  }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  if ((_collectionView == collectionView) && section == 0) {
    return [_items count];
  }
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSParameterAssert(_collectionView == collectionView);

  MDCItemBarCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kItemReuseID
                                                                       forIndexPath:indexPath];
  [self configureCell:itemCell];

  UITabBarItem *item = [self itemAtIndexPath:indexPath];
  if (item) {
    [itemCell updateWithItem:item atIndex:indexPath.item count:_items.count];
  }

  return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
  UITabBarItem *item = [self itemAtIndexPath:indexPath];
  if (item) {
    [self.tabBar.displayDelegate tabBar:self.tabBar willDisplayItem:item];
  }
}

- (void)collectionView:(UICollectionView *)collectionView
    didEndDisplayingCell:(UICollectionViewCell *)cell
      forItemAtIndexPath:(NSIndexPath *)indexPath {
  UITabBarItem *item = [self itemAtIndexPath:indexPath];
  if (item) {
    [self.tabBar.displayDelegate tabBar:self.tabBar didEndDisplayingItem:item];
  }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(__unused UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSParameterAssert(_collectionView == collectionView);

  UITabBarItem *item = [self itemAtIndexPath:indexPath];
  if (!item) {
    return CGSizeZero;
  }

  const CGFloat itemHeight = CGRectGetHeight(self.bounds);
  CGSize size = CGSizeMake(CGFLOAT_MAX, itemHeight);

  // Size cell to fit content.
  size = [MDCItemBarCell sizeThatFits:size item:item style:_style];

  // Divide justified items evenly across the view.
  if (_currentAlignment == MDCItemBarAlignmentJustified) {
    NSInteger count = [self collectionView:_collectionView numberOfItemsInSection:0];
    size.width = [self adjustedCollectionViewWidth] / MAX(count, 1);
  }

  // Constrain to style-based width if necessary.
  if (_style.maximumItemWidth > 0) {
    size.width = MIN(size.width, _style.maximumItemWidth);
  }

  // Constrain to view width
  size.width = MIN(size.width, [self adjustedCollectionViewWidth]);

  // Force height to our height.
  size.height = itemHeight;
  return size;
}

#pragma mark - Private

- (CGFloat)adjustedCollectionViewWidth {
  if (@available(iOS 11.0, *)) {
    return CGRectGetWidth(
        UIEdgeInsetsInsetRect(_collectionView.bounds, _collectionView.adjustedContentInset));
  }
  return CGRectGetWidth(_collectionView.bounds);
}

+ (NSArray *)observableItemKeys {
  static dispatch_once_t onceToken;
  static NSArray *s_keys = nil;
  // clang-format off
  dispatch_once(&onceToken, ^{
    s_keys = @[
      NSStringFromSelector(@selector(title)),
      NSStringFromSelector(@selector(image)),
      NSStringFromSelector(@selector(badgeValue)),
      NSStringFromSelector(@selector(badgeColor)),
      NSStringFromSelector(@selector(accessibilityIdentifier))
    ];
  });
  // clang-format on
  return s_keys;
}

- (void)startObservingItems {
  NSAssert([NSThread isMainThread], @"Main thread required for KVO registration");

  for (UITabBarItem *item in _items) {
    for (NSString *key in [[self class] observableItemKeys]) {
      [item addObserver:self forKeyPath:key options:0 context:kItemPropertyContext];
    }
  }
}

- (void)stopObservingItems {
  NSAssert([NSThread isMainThread], @"Main thread required for KVO unregistration");

  for (UITabBarItem *item in _items) {
    for (NSString *key in [[self class] observableItemKeys]) {
      [item removeObserver:self forKeyPath:key context:kItemPropertyContext];
    }
  }
}

- (UIUserInterfaceSizeClass)horizontalSizeClass {
  NSObject<MDCTabBarSizeClassDelegate> *tabBarSizeClassDelegate = self.tabBar.sizeClassDelegate;
  if ([tabBarSizeClassDelegate respondsToSelector:@selector(horizontalSizeClassForObject:)]) {
    return [tabBarSizeClassDelegate horizontalSizeClassForObject:self];
  }
  return self.traitCollection.horizontalSizeClass;
}

- (void)selectItemAtIndex:(NSUInteger)index animated:(BOOL)animated {
  if (index != NSNotFound) {
    NSParameterAssert(index < [_items count]);
    [_collectionView selectItemAtIndexPath:[self indexPathForItemAtIndex:index]
                                  animated:animated
                            scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
  } else {
    // Deselect all
    for (NSIndexPath *path in [_collectionView indexPathsForSelectedItems]) {
      [_collectionView deselectItemAtIndexPath:path animated:NO];
    }
  }
  [self didSelectItemAtIndex:index animateTransition:animated];
}

- (UITabBarItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath && indexPath.section == 0 && indexPath.item >= 0 &&
      (NSInteger)_items.count > indexPath.item) {
    return _items[indexPath.item];
  }
  return nil;
}

- (NSInteger)indexForItem:(nullable UITabBarItem *)item {
  if (item) {
    return [_items indexOfObject:item];
  }
  return NSNotFound;
}

- (NSIndexPath *)indexPathForItemAtIndex:(NSInteger)index {
  return [NSIndexPath indexPathForItem:index inSection:0];
}

- (void)reload {
  [_collectionView reloadData];
  [self updateAlignmentAnimated:NO];
}

- (UICollectionViewFlowLayout *)generatedFlowLayout {
  UICollectionViewFlowLayout *flowLayout = [[MDCItemBarFlowLayout alloc] init];
  CGFloat itemHeight = CGRectGetHeight(self.bounds);
  flowLayout.itemSize = CGSizeMake(kPlaceholderCellWidth, itemHeight);
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  flowLayout.sectionInset = UIEdgeInsetsZero;
  flowLayout.minimumInteritemSpacing = 0;
  flowLayout.minimumLineSpacing = 0;
  return flowLayout;
}

- (void)didSelectItemAtIndex:(NSInteger)index animateTransition:(BOOL)animate {
  void (^animationBlock)(void) = ^{
    [self updateSelectionIndicatorToIndex:index];

    // Force layout so any changes to the selection indicator are captured by the animation block.
    [self->_selectionIndicator layoutIfNeeded];
  };

  if (animate) {
    CAMediaTimingFunction *easeInOutFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
    // Wrap in explicit CATransaction to allow layer-based animations with the correct duration.
    [CATransaction begin];
    [CATransaction setAnimationDuration:kDefaultAnimationDuration];
    [CATransaction setAnimationTimingFunction:easeInOutFunction];
    [UIView animateWithDuration:kDefaultAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:animationBlock
                     completion:nil];
    [CATransaction commit];

  } else {
    animationBlock();
  }
}

- (void)updateAlignmentAnimated:(BOOL)animated {
  [self updateCurrentAlignment];
  [self updateScrollProperties];
  [self updateFlowLayoutMetricsAnimated:animated];
}

- (void)updateCurrentAlignment {
  if (_alignment != MDCItemBarAlignmentBestEffortJustified) {
    _currentAlignment = _alignment;
    return;
  }

  // Calculate the "best" alignment for MDCItemBarAlignmentBestEffortJustified. Begin with
  // Justified alignment, but calculate to see if Leading alignment would be a better fit.
  _currentAlignment = MDCItemBarAlignmentJustified;
  const CGFloat widthPerJustifiedItem = [self adjustedCollectionViewWidth] / MAX(_items.count, 1ul);
  CGSize size = CGSizeMake(CGFLOAT_MAX, self.bounds.size.height);
  for (UITabBarItem *item in _items) {
    const CGSize itemSize = [MDCItemBarCell sizeThatFits:size item:item style:_style];
    const CGFloat itemWidth = itemSize.width;
    // If any item cannot fit nicely in its portion of the width, fallback to Leading alignment.
    if (itemWidth >= widthPerJustifiedItem) {
      _currentAlignment = MDCItemBarAlignmentLeading;
      break;
    }
  }
}

/// Sets _selectionIndicator's bounds and center to display under the item at the given index with
/// no animation. May be called from an animation block to animate the transition.
- (void)updateSelectionIndicatorToIndex:(NSInteger)index {
  if (index == NSNotFound) {
    // Hide selection indicator.
    _selectionIndicator.bounds = CGRectZero;
    return;
  }

  // Use layout attributes as the cell may not be visible or loaded yet.
  NSIndexPath *indexPath = [self indexPathForItemAtIndex:index];
  UICollectionViewLayoutAttributes *layoutAttributes =
      [_flowLayout layoutAttributesForItemAtIndexPath:indexPath];

  // Place selection indicator under the item's cell.
  CGRect selectionIndicatorBounds = layoutAttributes.bounds;
  CGPoint selectionIndicatorCenter = layoutAttributes.center;
  _selectionIndicator.bounds = selectionIndicatorBounds;
  _selectionIndicator.center = selectionIndicatorCenter;

  // Extract content frame from cell.
  CGRect contentFrame = selectionIndicatorBounds;
  UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
  if ([cell isKindOfClass:[MDCItemBarCell class]]) {
    MDCItemBarCell *itemBarCell = (MDCItemBarCell *)cell;
    contentFrame = [cell convertRect:itemBarCell.contentFrame fromView:cell];
  }

  // Construct a context object describing the selected tab.
  UITabBarItem *item = [self itemAtIndexPath:indexPath];
  if (!item) {
    return;
  }
  MDCTabBarPrivateIndicatorContext *context =
      [[MDCTabBarPrivateIndicatorContext alloc] initWithItem:item
                                                      bounds:selectionIndicatorBounds
                                                contentFrame:contentFrame];

  // Ask the template for attributes.
  id<MDCTabBarIndicatorTemplate> template = _style.selectionIndicatorTemplate;
  MDCTabBarIndicatorAttributes *indicatorAttributes =
      [template indicatorAttributesForContext:context];

  // Update the selection indicator.
  [_selectionIndicator applySelectionIndicatorAttributes:indicatorAttributes];
}

- (void)updateFlowLayoutMetricsAnimated:(BOOL)animate {
  void (^animationBlock)(void) = ^{
    [self updateFlowLayoutMetrics];
  };

  if (animate) {
    [CATransaction begin];
    CAMediaTimingFunction *easeInOut =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
    [CATransaction setAnimationTimingFunction:easeInOut];
    [UIView animateWithDuration:kDefaultAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:animationBlock
                     completion:nil];
    [CATransaction commit];
  } else {
    animationBlock();
  }
}

- (void)updateScrollProperties {
  _collectionView.alwaysBounceHorizontal = (_currentAlignment != MDCItemBarAlignmentJustified);
}

- (void)updateFlowLayoutMetrics {
  UIUserInterfaceSizeClass horizontalSizeClass = [self horizontalSizeClass];

  UIEdgeInsets newSectionInset = UIEdgeInsetsZero;
  switch (_currentAlignment) {
    case MDCItemBarAlignmentLeading:
      newSectionInset = [self leadingAlignedInsetsForHorizontalSizeClass:horizontalSizeClass];
      break;
    case MDCItemBarAlignmentJustified:
      newSectionInset = [self justifiedInsets];
      break;
    case MDCItemBarAlignmentCenter:
      newSectionInset = [self centeredInsetsForHorizontalSizeClass:horizontalSizeClass];
      break;
    case MDCItemBarAlignmentCenterSelected:
      newSectionInset = [self centerSelectedInsets];
      break;
    case MDCItemBarAlignmentBestEffortJustified:
      // This case should never be possible, since the _currentAlignment will never be set to
      // this value.
      break;
  }

  // Rather than just updating the sectionInset on the existing flowLayout, a new layout object
  // is created. This gives more control over whether the change is animated or not - as there is
  // no control when updating flow layout sectionInset (it's always animated).
  UICollectionViewFlowLayout *flowLayout = [self generatedFlowLayout];
  flowLayout.sectionInset = newSectionInset;
  _flowLayout = flowLayout;

  // This is not animated because -updateFlowLayoutMetrics may be called in an animation block and
  // the change will be still get animated anyway - using NO avoids 'double' animation and allows
  // this method to be used without animation.
  [_collectionView setCollectionViewLayout:_flowLayout animated:NO];

  // Force immediate layout so the selection indicator can be placed accurately.
  [_collectionView layoutIfNeeded];

  // Update selection indicator to potentially new location and size
  // Not animated for the same reason as mentioned above.
  [self updateSelectionIndicatorToIndex:[self indexForItem:_selectedItem]];
}

- (UIEdgeInsets)leadingAlignedInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass {
  const BOOL isRegular = (sizeClass == UIUserInterfaceSizeClassRegular);
  CGFloat inset = isRegular ? kRegularInset : kCompactInset;
  // If the collection view has Safe Area insets, we don't want to add an extra horizontal inset.
  if (@available(iOS 11.0, *)) {
    if (_collectionView.safeAreaInsets.left > 0 || _collectionView.safeAreaInsets.right > 0) {
      inset = 0;
    }
  }
  return UIEdgeInsetsMake(0, inset, 0, inset);
}

- (UIEdgeInsets)justifiedInsets {
  // Center items, which will be at most the width of the view.
  CGFloat itemWidths = [self totalWidthOfAllItems];
  CGFloat sideInsets = floorf((float)([self adjustedCollectionViewWidth] - itemWidths) / 2);
  return UIEdgeInsetsMake(0.0, sideInsets, 0.0, sideInsets);
}

- (UIEdgeInsets)centeredInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass {
  CGFloat itemWidths = [self totalWidthOfAllItems];
  CGFloat viewWidth = [self adjustedCollectionViewWidth];
  UIEdgeInsets insets = [self leadingAlignedInsetsForHorizontalSizeClass:sizeClass];
  if (itemWidths <= (viewWidth - insets.left - insets.right)) {
    CGFloat sideInsets = ([self adjustedCollectionViewWidth] - itemWidths) / 2;
    return UIEdgeInsetsMake(0.0, sideInsets, 0.0, sideInsets);
  }
  return insets;
}

- (UIEdgeInsets)centerSelectedInsets {
  UIEdgeInsets sectionInset = UIEdgeInsetsZero;

  NSInteger count = [self collectionView:_collectionView numberOfItemsInSection:0];
  if (count > 0) {
    CGFloat halfBoundsWidth = [self adjustedCollectionViewWidth] / 2;

    CGSize firstSize = [self collectionView:_collectionView
                                     layout:_flowLayout
                     sizeForItemAtIndexPath:[self indexPathForItemAtIndex:0]];
    CGSize lastSize = [self collectionView:_collectionView
                                    layout:_flowLayout
                    sizeForItemAtIndexPath:[self indexPathForItemAtIndex:count - 1]];

    // Left inset is equal to the space to the left of the first item when centered.
    CGFloat halfFirstWidth = firstSize.width / 2;
    sectionInset.left = halfBoundsWidth - halfFirstWidth;

    // Right inset is equal to the space to the right of the last item when centered.
    CGFloat halfLastWidth = lastSize.width / 2;
    sectionInset.right = halfBoundsWidth - halfLastWidth;
  }
  return sectionInset;
}

- (CGFloat)totalWidthOfAllItems {
  CGFloat itemWidths = 0;
  NSInteger count = [self collectionView:_collectionView numberOfItemsInSection:0];
  for (NSInteger itemIndex = 0; itemIndex < count; itemIndex++) {
    CGSize itemSize = [self collectionView:_collectionView
                                    layout:_flowLayout
                    sizeForItemAtIndexPath:[self indexPathForItemAtIndex:itemIndex]];
    itemWidths += itemSize.width;
  }
  return itemWidths;
}

- (void)configureCell:(MDCItemBarCell *)cell {
  // Configure content style
  [cell applyStyle:_style];
}

- (void)configureVisibleCells {
  NSArray<NSIndexPath *> *indexPaths = [self.collectionView indexPathsForVisibleItems];
  for (NSIndexPath *indexPath in indexPaths) {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[MDCItemBarCell class]]) {
      MDCItemBarCell *itemCell = (MDCItemBarCell *)cell;
      [self configureCell:itemCell];
      UITabBarItem *item = [self itemAtIndexPath:indexPath];
      if (item) {
        [itemCell updateWithItem:item atIndex:indexPath.item count:_items.count];
      }
    }
  }
}

- (void)updateColors {
  [self configureVisibleCells];

  _selectionIndicator.tintColor = _style.selectionIndicatorColor;
}

- (void)updateSelectionIndicatorVisibility {
  _selectionIndicator.hidden = !_style.shouldDisplaySelectionIndicator;
}

@end

#pragma mark - MDCItemBarFlowLayout

@implementation MDCItemBarFlowLayout {
  /// Map from item index paths to RTL-corrected layout attributes. If no RTL correction is in
  /// effect, this will be set to nil.
  NSDictionary *_correctedAttributesForIndexPath;

  /// Controls the use of a padded collection view content size.
  BOOL _isPaddingCollectionViewContentSize;

  /// Collection view content size which will be used if padding is in effect.
  CGSize _paddedCollectionViewContentSize;
}

- (void)prepareLayout {
  [super prepareLayout];

  // Post-process the superclass layout to determine which workarounds need to be applied.
  BOOL shouldRelayoutAttributesForRTL = [self shouldRelayoutAttributesForRTL];
  BOOL shouldPadContentSizeForRTL = [self shouldPadContentSizeForRTL];

  // Build a new map of adjusted attributes if needed.
  if (shouldRelayoutAttributesForRTL || shouldPadContentSizeForRTL) {
    NSMutableDictionary *newAttributes = [NSMutableDictionary dictionary];
    const NSInteger sectionCount = self.collectionView.numberOfSections;
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
      const NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
      for (NSInteger itemIndex = 0; itemIndex < itemCount; itemIndex++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];

        // Must call super here to ensure we get un-corrected attributes.
        UICollectionViewLayoutAttributes *attributes =
            [super layoutAttributesForItemAtIndexPath:indexPath];

        // Flip attribute order for RTL. This must happen before padding because attributes are
        // flipped using the original un-padded bounds.
        if (shouldRelayoutAttributesForRTL) {
          attributes = [self flippedAttributesFromAttributes:attributes];
        }

        // Apply per-item content size padding.
        if (shouldPadContentSizeForRTL) {
          attributes = [self paddedAttributesFromAttributes:attributes];
        }

        newAttributes[indexPath] = attributes;
      }
    }
    _correctedAttributesForIndexPath = newAttributes;
  } else {
    // Clear out the map to indicate that no corrections are in effect.
    _correctedAttributesForIndexPath = nil;
  }

  // Apply global content size padding.
  if (shouldPadContentSizeForRTL) {
    _isPaddingCollectionViewContentSize = YES;
    _paddedCollectionViewContentSize = [self adjustedCollectionViewBounds].size;
  } else {
    _isPaddingCollectionViewContentSize = NO;
  }
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:
    (NSIndexPath *)indexPath {
  if (_correctedAttributesForIndexPath) {
    return _correctedAttributesForIndexPath[indexPath];
  }

  // No RTL correction needed.
  return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (nullable NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  if (_correctedAttributesForIndexPath) {
    NSPredicate *predicate =
        [NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *layoutAttributes,
                                              __unused NSDictionary *__nullable bindings) {
          return CGRectIntersectsRect(layoutAttributes.frame, rect);
        }];
    return [_correctedAttributesForIndexPath.allValues filteredArrayUsingPredicate:predicate];
  }

  // No RTL correction needed.
  return [super layoutAttributesForElementsInRect:rect];
}

- (CGSize)collectionViewContentSize {
  if (_isPaddingCollectionViewContentSize) {
    return _paddedCollectionViewContentSize;
  }
  return [super collectionViewContentSize];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  if (!CGSizeEqualToSize(newBounds.size, self.collectionView.bounds.size)) {
    // Padding depends on the size of the collection view, need to relayout for size changes.
    return YES;
  }
  return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

#pragma mark - Private

/// Computes RTL-flipped attributes given superclass-calculated attributes.
- (UICollectionViewLayoutAttributes *)flippedAttributesFromAttributes:
    (UICollectionViewLayoutAttributes *)attributes {
  UICollectionViewLayoutAttributes *newAttributes = [attributes copy];

  CGRect itemFrame = attributes.frame;

  // Must call super here to ensure we have the original collection bounds.
  CGRect collectionBounds = {CGPointZero, [super collectionViewContentSize]};
  newAttributes.frame = MDFRectFlippedHorizontally(itemFrame, CGRectGetWidth(collectionBounds));

  return newAttributes;
}

- (BOOL)shouldEnforceRightToLeftLayout {
  // Prior to iOS 9 RTL was not automatically applied, so we don't need to apply any fixes.
  NSOperatingSystemVersion iOS9Version = {9, 0, 0};
  UIUserInterfaceLayoutDirection rtl = UIUserInterfaceLayoutDirectionRightToLeft;
  NSProcessInfo *processInfo = [NSProcessInfo processInfo];
  return [processInfo isOperatingSystemAtLeastVersion:iOS9Version] &&
         self.collectionView.mdf_effectiveUserInterfaceLayoutDirection == rtl;
}

/// Indicates if the superclass' layout appears to have been layed out in a left-to-right order. If
/// there are zero or one items total, this always returns NO.
/// Note: This is used to detect incorrect layouts due to radar 22828797 by detecting the actual
/// layout ordering from superclass-generated layout frames. When there's no error (item frames are
/// already arranged RTL), this returns NO. We use this approach for two purposes:
/// * Robustly detecting the error condition. The bug occurs under specific conditions that would be
///   difficult to detect reliably, and given item bars are simple linear layouts it's more robust
///   to detect the error and correct it.
/// * Automatically disabling this workaround if the underlying bug is fixed in an unknown future OS
///   version. At time of writing (iOS 9.2) the bug has not been fixed. Detecting the error directly
///   and correcting it should allow this implementation to continue to produce correct results
///   without an immediate need for changes.
- (BOOL)shouldRelayoutAttributesForRTL {
  // The logic contained here only applies to horizontally-scrolling flow layouts. This should
  // always be the case for MDCItemBar, but check for safety.
  NSParameterAssert(self.scrollDirection == UICollectionViewScrollDirectionHorizontal);

  if (![self shouldEnforceRightToLeftLayout]) {
    return NO;
  }

  CGRect previousFrame = CGRectNull;

  const NSInteger sectionCount = self.collectionView.numberOfSections;
  for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
    const NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
    for (NSInteger itemIndex = 0; itemIndex < itemCount; itemIndex++) {
      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];

      // Must call super here to ensure we get un-corrected attributes.
      UICollectionViewLayoutAttributes *attributes =
          [super layoutAttributesForItemAtIndexPath:indexPath];

      CGRect frame = attributes.frame;
      // If any adjacent pairs of attributes have centers that are ordered left-to-right, assume the
      // whole layout is ordered left-to-right.
      if (!CGRectIsNull(previousFrame) && (CGRectGetMidX(previousFrame) < CGRectGetMidX(frame))) {
        return YES;
      }

      // Set up for next iteration.
      previousFrame = frame;
    }
  }

  // There are either fewer than 2 items (in which case order doesn't matter) or the whole thing is
  // ordered RTL.
  return NO;
}

/// Indicates if the collection's content is narrower than the collection view.
/// Note: This is used to detect conditions under which collection view scrolling bugs happen in RTL
/// layouts. If and when the underlying bugs are fixed in an unknown future iOS version, this method
/// will continue to return YES and trigger harmless but unnecessary workarounds.
- (BOOL)shouldPadContentSizeForRTL {
  if (![self shouldEnforceRightToLeftLayout]) {
    return NO;
  }

  // When the content is narrower than the scroll view bounds, we need to pad all attribute frames
  // on the left to prevent the layout from "jumping" to the origin under various situations.
  // Must call super here to ensure we have the original collection content size.
  CGSize contentSize = [super collectionViewContentSize];
  CGRect scrollBounds = [self adjustedCollectionViewBounds];
  return contentSize.width < CGRectGetWidth(scrollBounds);
}

- (UICollectionViewLayoutAttributes *)paddedAttributesFromAttributes:
    (UICollectionViewLayoutAttributes *)attributes {
  // Must call super here to ensure we have the original collection content size.
  CGSize contentSize = [super collectionViewContentSize];
  CGRect scrollBounds = [self adjustedCollectionViewBounds];

  CGFloat leftPadding = CGRectGetWidth(scrollBounds) - contentSize.width;

  UICollectionViewLayoutAttributes *newAttributes = [attributes copy];

  // Shift frame to the right to counteract the content size width expansion.
  CGRect itemFrame = attributes.frame;
  itemFrame.origin.x += leftPadding;

  newAttributes.frame = itemFrame;

  return newAttributes;
}

- (CGRect)adjustedCollectionViewBounds {
  if (@available(iOS 11.0, *)) {
    return UIEdgeInsetsInsetRect(self.collectionView.bounds,
                                 self.collectionView.adjustedContentInset);
  }
  return self.collectionView.bounds;
}

@end
