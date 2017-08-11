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

#import "MDCItemBar.h"

#import "MDCItemBarCell.h"
#import "MDCItemBarStyle.h"
#import "MaterialAnimationTiming.h"
#import "MaterialRTL.h"

/// Height in points of the bar shown under selected items.
static const CGFloat kSelectionIndicatorHeight = 2.0f;

/// Cell reuse identifier for item bar cells.
static NSString *const kItemReuseID = @"MDCItem";

/// Default duration in seconds for selection change animations.
static const NSTimeInterval kDefaultAnimationDuration = 0.3f;

/// Placeholder width for cells, which get per-item sizing.
static const CGFloat kPlaceholderCellWidth = 10.0f;

/// Horizontal insets in regular size class layouts.
static const CGFloat kRegularInset = 56.0f;

/// Horizontal insets in compact size class layouts.
static const CGFloat kCompactInset = 8.0f;

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
@end

@implementation MDCItemBar {
  // Collection view and layout for items.
  UICollectionView *_collectionView;
  UICollectionViewFlowLayout *_flowLayout;

  /// Underline displayed under the active item.
  UIView *_selectionIndicator;

  /// Size of the view at last layout, for deduplicating changes.
  CGSize _lastSize;

  /// Horizontal size class at the last item metrics update. Used to calculate deltas.
  UIUserInterfaceSizeClass _horizontalSizeClassAtLastMetricsUpdate;

  /// Current style properties.
  MDCItemBarStyle *_style;
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
  _horizontalSizeClassAtLastMetricsUpdate = UIUserInterfaceSizeClassUnspecified;

  // Configure the collection view.
  _flowLayout = [self generatedFlowLayout];
  UICollectionView *collectionView =
      [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
  collectionView.backgroundColor = [UIColor clearColor];
  collectionView.clipsToBounds = YES;
  collectionView.scrollsToTop = NO;
  collectionView.showsHorizontalScrollIndicator = NO;
  collectionView.showsVerticalScrollIndicator = NO;
  collectionView.dataSource = self;
  collectionView.delegate = self;
  collectionView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [collectionView registerClass:[MDCItemBarCell class] forCellWithReuseIdentifier:kItemReuseID];

  _collectionView = collectionView;
  [self addSubview:_collectionView];

  // Configure the selection indicator view.
  _selectionIndicator =
      [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, kSelectionIndicatorHeight)];
  _selectionIndicator.backgroundColor = [UIColor whiteColor];
  _selectionIndicator.opaque = YES;
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
  if (!CGSizeEqualToSize(bounds.size, _lastSize)) {
    [self updateFlowLayoutMetrics];

    // Ensure selected item is aligned properly on resize.
    [self selectItemAtIndex:[self indexForItem:_selectedItem] animated:NO];
  }
  _lastSize = bounds.size;
}

- (CGSize)sizeThatFits:(CGSize)size {
  size.height = [[self class] defaultHeightForStyle:_style];
  return size;
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(UIViewNoIntrinsicMetric, [[self class] defaultHeightForStyle:_style]);
}

- (void)didMoveToWindow {
  [super didMoveToWindow];

  // New window: Update for potentially updated size class.
  [self updateFlowLayoutMetrics];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  // Update metrics for potentially updated size class.
  [self updateFlowLayoutMetrics];
}

- (void)tintColorDidChange {
  [super tintColorDidChange];

  [self updateColors];
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_collectionView == collectionView) {
    // Notify delegate of impending selection.
    id<MDCItemBarDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(itemBar:shouldSelectItem:)]) {
      UITabBarItem *item = [self itemAtIndexPath:indexPath];
      return [delegate itemBar:self shouldSelectItem:item];
    }
  }
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_collectionView == collectionView) {
    // Update selected item.
    UITabBarItem *item = [self itemAtIndexPath:indexPath];
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

  MDCItemBarCell *itemCell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kItemReuseID forIndexPath:indexPath];
  UITabBarItem *item = [self itemAtIndexPath:indexPath];

  [self configureCell:itemCell];
  [itemCell updateWithItem:item atIndex:indexPath.item count:_items.count];

  return itemCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(__unused UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSParameterAssert(_collectionView == collectionView);

  UITabBarItem *item = [self itemAtIndexPath:indexPath];

  const CGFloat itemHeight = CGRectGetHeight(self.bounds);
  CGSize size = CGSizeMake(CGFLOAT_MAX, itemHeight);

  // Size cell to fit content.
  size = [MDCItemBarCell sizeThatFits:size
                  horizontalSizeClass:[self horizontalSizeClass]
                                 item:item
                                style:_style];

  // Divide justified items evenly across the view.
  if (_alignment == MDCItemBarAlignmentJustified) {
    NSInteger count = [self collectionView:_collectionView numberOfItemsInSection:0];
    size.width = _collectionView.bounds.size.width / MAX(count, 1);
  }

  // Constrain to style-based width if necessary.
  if (_style.maximumItemWidth > 0) {
    size.width = MIN(size.width, _style.maximumItemWidth);
  }

  // Constrain to view width
  size.width = MIN(size.width, CGRectGetWidth(collectionView.frame));

  // Force height to our height.
  size.height = itemHeight;

  return size;
}

#pragma mark - Private

+ (NSArray *)observableItemKeys {
  static dispatch_once_t onceToken;
  static NSArray *s_keys = nil;
  // clang-format off
  dispatch_once(&onceToken, ^{
    s_keys = @[
      NSStringFromSelector(@selector(title)),
      NSStringFromSelector(@selector(image)),
      NSStringFromSelector(@selector(badgeValue)),
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
  // Use trait collection's horizontalSizeClass if available.
  if ([self respondsToSelector:@selector(traitCollection)]) {
    return self.traitCollection.horizontalSizeClass;
  }

  // Pre-iOS 8: Use fixed size class for device.
  BOOL isPad = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
  return isPad ? UIUserInterfaceSizeClassRegular : UIUserInterfaceSizeClassCompact;
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
  return _items[indexPath.item];
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
  [self updateFlowLayoutMetrics];
}

- (UICollectionViewFlowLayout *)generatedFlowLayout {
  UICollectionViewFlowLayout *flowLayout = [[MDCItemBarFlowLayout alloc] init];
  CGFloat itemHeight = CGRectGetHeight(self.bounds);
  flowLayout.itemSize = CGSizeMake(kPlaceholderCellWidth, itemHeight);
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  flowLayout.sectionInset = UIEdgeInsetsZero;
  flowLayout.minimumInteritemSpacing = 0.0f;
  flowLayout.minimumLineSpacing = 0.0f;
  return flowLayout;
}

- (void)didSelectItemAtIndex:(NSInteger)index animateTransition:(BOOL)animate {
  void (^animationBlock)(void) = ^{
    [self updateSelectionIndicatorToIndex:index];
  };

  if (animate) {
    CAMediaTimingFunction *easeInOutFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
    [UIView mdc_animateWithTimingFunction:easeInOutFunction
                                 duration:kDefaultAnimationDuration
                                    delay:0
                                  options:UIViewAnimationOptionBeginFromCurrentState
                               animations:animationBlock
                               completion:nil];
  } else {
    animationBlock();
  }
}

- (void)updateAlignmentAnimated:(BOOL)animated {
  [self updateScrollProperties];
  [self updateFlowLayoutMetricsAnimated:animated];
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
  UICollectionViewLayoutAttributes *attributes =
      [_flowLayout layoutAttributesForItemAtIndexPath:[self indexPathForItemAtIndex:index]];

  // Size selection indicator to a fixed height, equal in width to the selected item's cell.
  CGRect selectionIndicatorBounds = attributes.bounds;
  selectionIndicatorBounds.size.height = kSelectionIndicatorHeight;

  // Center selection indicator under cell.
  CGPoint selectionIndicatorCenter = attributes.center;
  selectionIndicatorCenter.y =
      CGRectGetMaxY(_collectionView.bounds) - (kSelectionIndicatorHeight / 2.0f);

  _selectionIndicator.bounds = selectionIndicatorBounds;
  _selectionIndicator.center = selectionIndicatorCenter;
}

- (void)updateFlowLayoutMetricsAnimated:(BOOL)animate {
  void (^animationBlock)(void) = ^{
    [self updateFlowLayoutMetrics];
  };

  if (animate) {
    CAMediaTimingFunction *easeInOutFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
    [UIView mdc_animateWithTimingFunction:easeInOutFunction
                                 duration:kDefaultAnimationDuration
                                    delay:0.0f
                                  options:UIViewAnimationOptionBeginFromCurrentState
                               animations:animationBlock
                               completion:nil];
  } else {
    animationBlock();
  }
}

- (void)updateScrollProperties {
  _collectionView.alwaysBounceHorizontal = (_alignment != MDCItemBarAlignmentJustified);
}

- (void)updateFlowLayoutMetrics {
  // Layout metrics cannot be updated while offscreen.
  if (!self.window) {
    return;
  }

  UIUserInterfaceSizeClass horizontalSizeClass = [self horizontalSizeClass];

  UIEdgeInsets newSectionInset = UIEdgeInsetsZero;
  switch (_alignment) {
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
  }

  UIEdgeInsets oldSectionInset = _flowLayout.sectionInset;
  if (UIEdgeInsetsEqualToEdgeInsets(oldSectionInset, newSectionInset) &&
      _alignment != MDCItemBarAlignmentJustified) {
    // No change - can bail early, except when the item alignment is "justified". When justified,
    // the layout metrics need updating due to change in view size or orientation.
    return;
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
  NSAssert(_collectionView.window, @"Collection view must be in a window to update layout");
  [_collectionView setCollectionViewLayout:_flowLayout animated:NO];

  // Update selection indicator to potentially new location and size
  // Not animated for the same reason as mentioned above.
  [self updateSelectionIndicatorToIndex:[self indexForItem:_selectedItem]];

  _horizontalSizeClassAtLastMetricsUpdate = horizontalSizeClass;
}

- (UIEdgeInsets)leadingAlignedInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass {
  const BOOL isRegular = (sizeClass == UIUserInterfaceSizeClassRegular);
  const CGFloat inset = isRegular ? kRegularInset : kCompactInset;
  return UIEdgeInsetsMake(0.0f, inset, 0.0f, inset);
}

- (UIEdgeInsets)justifiedInsets {
  // Center items, which will be at most the width of the view.
  CGFloat itemWidths = [self totalWidthOfAllItems];
  CGFloat sideInsets = floorf((float)(_collectionView.bounds.size.width - itemWidths) / 2.0f);
  return UIEdgeInsetsMake(0.0, sideInsets, 0.0, sideInsets);
}

- (UIEdgeInsets)centeredInsetsForHorizontalSizeClass:(UIUserInterfaceSizeClass)sizeClass {
  CGFloat itemWidths = [self totalWidthOfAllItems];
  CGFloat viewWidth = _collectionView.bounds.size.width;
  UIEdgeInsets insets = [self leadingAlignedInsetsForHorizontalSizeClass:sizeClass];
  if (itemWidths <= (viewWidth - insets.left - insets.right)) {
    CGFloat sideInsets = (_collectionView.bounds.size.width - itemWidths) / 2.0f;
    return UIEdgeInsetsMake(0.0, sideInsets, 0.0, sideInsets);
  }
  return insets;
}

- (UIEdgeInsets)centerSelectedInsets {
  UIEdgeInsets sectionInset = UIEdgeInsetsZero;

  NSInteger count = [self collectionView:_collectionView numberOfItemsInSection:0];
  if (count > 0) {
    CGRect bounds = _collectionView.bounds;
    CGFloat halfBoundsWidth = bounds.size.width / 2.0f;

    CGSize firstSize = [self collectionView:_collectionView
                                     layout:_flowLayout
                     sizeForItemAtIndexPath:[self indexPathForItemAtIndex:0]];
    CGSize lastSize = [self collectionView:_collectionView
                                    layout:_flowLayout
                    sizeForItemAtIndexPath:[self indexPathForItemAtIndex:count - 1]];

    // Left inset is equal to the space to the left of the first item when centered.
    CGFloat halfFirstWidth = firstSize.width / 2.0f;
    sectionInset.left = halfBoundsWidth - halfFirstWidth;

    // Right inset is equal to the space to the right of the last item when centered.
    CGFloat halfLastWidth = lastSize.width / 2.0f;
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
  for (UICollectionViewCell *cell in _collectionView.visibleCells) {
    if ([cell isKindOfClass:[MDCItemBarCell class]]) {
      MDCItemBarCell *itemCell = (MDCItemBarCell *)cell;
      [self configureCell:itemCell];
    }
  }
}

- (void)updateColors {
  [self configureVisibleCells];

  _selectionIndicator.backgroundColor = _style.selectionIndicatorColor;
}

- (void)updateSelectionIndicatorVisibility {
  _selectionIndicator.hidden = !_style.shouldDisplaySelectionIndicator;
}

@end

#pragma mark -

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
    _paddedCollectionViewContentSize = self.collectionView.bounds.size;
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
  newAttributes.frame = MDCRectFlippedForRTL(itemFrame, CGRectGetWidth(collectionBounds),
                                             UIUserInterfaceLayoutDirectionRightToLeft);

  return newAttributes;
}

- (BOOL)shouldEnforceRightToLeftLayout {
  BOOL enforceRTL = NO;

  // Prior to iOS 9 RTL was not automatically applied, so we don't need to apply any fixes.
  NSOperatingSystemVersion iOS9Version = {9, 0, 0};
  NSProcessInfo *processInfo = [NSProcessInfo processInfo];
  if ([processInfo respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)] &&
      [processInfo isOperatingSystemAtLeastVersion:iOS9Version]) {
    if (self.collectionView.mdc_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      enforceRTL = YES;
    }
  }

  return enforceRTL;
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
  CGRect scrollBounds = self.collectionView.bounds;
  return contentSize.width < CGRectGetWidth(scrollBounds);
}

- (UICollectionViewLayoutAttributes *)paddedAttributesFromAttributes:
        (UICollectionViewLayoutAttributes *)attributes {
  // Must call super here to ensure we have the original collection content size.
  CGSize contentSize = [super collectionViewContentSize];
  CGRect scrollBounds = self.collectionView.bounds;

  CGFloat leftPadding = CGRectGetWidth(scrollBounds) - contentSize.width;

  UICollectionViewLayoutAttributes *newAttributes = [attributes copy];

  // Shift frame to the right to counteract the content size width expansion.
  CGRect itemFrame = attributes.frame;
  itemFrame.origin.x += leftPadding;

  newAttributes.frame = itemFrame;

  return newAttributes;
}

@end
