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

#import "MDCCollectionViewController.h"

#import "MDCCollectionViewFlowLayout.h"
#import "MaterialCollectionCells.h"
#import "MaterialInk.h"
#import "private/MDCCollectionInfoBarView.h"
#import "private/MDCCollectionStringResources.h"
#import "private/MDCCollectionViewEditor.h"
#import "private/MDCCollectionViewStyler.h"

#include <tgmath.h>

NSString *const MDCCollectionInfoBarKindHeader = @"MDCCollectionInfoBarKindHeader";
NSString *const MDCCollectionInfoBarKindFooter = @"MDCCollectionInfoBarKindFooter";

@interface MDCCollectionViewController () <MDCCollectionInfoBarViewDelegate,
                                           MDCInkTouchControllerDelegate>
@property(nonatomic, assign) BOOL currentlyActiveInk;
@end

@implementation MDCCollectionViewController {
  MDCInkTouchController *_inkTouchController;
  MDCCollectionInfoBarView *_headerInfoBar;
  MDCCollectionInfoBarView *_footerInfoBar;
  BOOL _headerInfoBarDismissed;
  CGPoint _inkTouchLocation;
}

@synthesize collectionViewLayout = _collectionViewLayout;

- (instancetype)init {
  MDCCollectionViewFlowLayout *defaultLayout = [[MDCCollectionViewFlowLayout alloc] init];
  return [self initWithCollectionViewLayout:defaultLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    _collectionViewLayout = layout;
  }
  return self;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self != nil) {
    // TODO(#): Why is this nil, the decoder should have created it
    if (!_collectionViewLayout) {
      _collectionViewLayout = [[MDCCollectionViewFlowLayout alloc] init];
    }
  }

  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self != nil) {
    // TODO(#): Why is this nil, the decoder should have created it
    if (!_collectionViewLayout) {
      _collectionViewLayout = [[MDCCollectionViewFlowLayout alloc] init];
    }
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (@available(iOS 11.0, *)) {
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
  }

  [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.alwaysBounceVertical = YES;

  _styler = [[MDCCollectionViewStyler alloc] initWithCollectionView:self.collectionView];
  _styler.delegate = self;

  _editor = [[MDCCollectionViewEditor alloc] initWithCollectionView:self.collectionView];
  _editor.delegate = self;

  // Set up ink touch controller.
  _inkTouchController = [[MDCInkTouchController alloc] initWithView:self.collectionView];
  _inkTouchController.delegate = self;

  // Register our supplementary header and footer
  NSString *classIdentifier = NSStringFromClass([MDCCollectionInfoBarView class]);
  NSString *headerKind = MDCCollectionInfoBarKindHeader;
  NSString *footerKind = MDCCollectionInfoBarKindFooter;
  [self.collectionView registerClass:[MDCCollectionInfoBarView class]
          forSupplementaryViewOfKind:headerKind
                 withReuseIdentifier:classIdentifier];
  [self.collectionView registerClass:[MDCCollectionInfoBarView class]
          forSupplementaryViewOfKind:footerKind
                 withReuseIdentifier:classIdentifier];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  // Fixes an iOS 11 bug where supplementary views would be given a zPosition of 1, meaning the
  // scroll view indicator (with a zPosition of 0) would be placed behind supplementary views.
  // We know that iOS keeps the scroll indicator as the top-most view in the hierarchy as a subview,
  // so we grab it and give it a better zPosition ourselves.
  if (@available(iOS 11.0, *)) {
    UIView *maybeScrollViewIndicator = self.collectionView.subviews.lastObject;
    if ([maybeScrollViewIndicator isKindOfClass:[UIImageView class]]) {
      maybeScrollViewIndicator.layer.zPosition = 2;
    }
  }
}

- (void)setCollectionView:(__kindof UICollectionView *)collectionView {
  [super setCollectionView:collectionView];

  // Reset editor and ink to provided collection view.
  _editor = [[MDCCollectionViewEditor alloc] initWithCollectionView:collectionView];
  _editor.delegate = self;
  _inkTouchController = [[MDCInkTouchController alloc] initWithView:collectionView];
  _inkTouchController.delegate = self;
}

#pragma mark - <MDCCollectionInfoBarViewDelegate>

- (void)updateControllerWithInfoBar:(MDCCollectionInfoBarView *)infoBar {
  // Updates info bar styling for header/footer.
  if ([infoBar.kind isEqualToString:MDCCollectionInfoBarKindHeader]) {
    _headerInfoBar = infoBar;
    _headerInfoBar.message = MDCCollectionStringResources(infoBarGestureHintString);
    _headerInfoBar.style = MDCCollectionInfoBarViewStyleHUD;
    [self updateHeaderInfoBarIfNecessary];
  } else if ([infoBar.kind isEqualToString:MDCCollectionInfoBarKindFooter]) {
    _footerInfoBar = infoBar;
    _footerInfoBar.message = MDCCollectionStringResources(deleteButtonString);
    _footerInfoBar.style = MDCCollectionInfoBarViewStyleActionable;
    [self updateFooterInfoBarIfNecessary];
  }
}

- (void)didTapInfoBar:(MDCCollectionInfoBarView *)infoBar {
  if ([infoBar isEqual:_footerInfoBar]) {
    [self deleteIndexPaths:self.collectionView.indexPathsForSelectedItems];
  }
}

- (void)infoBar:(MDCCollectionInfoBarView *)infoBar
    willShowAnimated:(__unused BOOL)animated
     willAutoDismiss:(__unused BOOL)willAutoDismiss {
  if ([infoBar.kind isEqualToString:MDCCollectionInfoBarKindFooter]) {
    [self updateContentWithBottomInset:MDCCollectionInfoBarFooterHeight];
  }
}

- (void)infoBar:(MDCCollectionInfoBarView *)infoBar
    willDismissAnimated:(__unused BOOL)animated
        willAutoDismiss:(BOOL)willAutoDismiss {
  if ([infoBar.kind isEqualToString:MDCCollectionInfoBarKindHeader]) {
    _headerInfoBarDismissed = willAutoDismiss;
  } else {
    [self updateContentWithBottomInset:-MDCCollectionInfoBarFooterHeight];
  }
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (MDCCollectionViewCellStyle)collectionView:(__unused UICollectionView *)collectionView
                         cellStyleForSection:(__unused NSInteger)section {
  return _styler.cellStyle;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attr =
      [collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
  CGSize size = [self sizeWithAttribute:attr collectionView:collectionView];
  size = [self inlaidSizeAtIndexPath:indexPath withSize:size collectionView:collectionView];
  return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(__unused UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return [self insetsAtSectionIndex:section collectionView:collectionView];
}

- (CGFloat)collectionView:(__unused UICollectionView *)collectionView
                                 layout:(UICollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(__unused NSInteger)section {
  if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
    if (_styler.cellLayoutType == MDCCollectionViewCellLayoutTypeGrid) {
      return _styler.gridPadding;
    }
    return [(UICollectionViewFlowLayout *)collectionViewLayout minimumLineSpacing];
  }
  return 0;
}

- (CGSize)sizeWithAttribute:(UICollectionViewLayoutAttributes *)attr
             collectionView:(UICollectionView *)collectionView {
  CGFloat height = MDCCellDefaultOneLineHeight;
  if ([_styler.delegate respondsToSelector:@selector(collectionView:cellHeightAtIndexPath:)]) {
    height = [_styler.delegate collectionView:collectionView cellHeightAtIndexPath:attr.indexPath];
  }

  CGFloat width =
      [self cellWidthAtSectionIndex:attr.indexPath.section collectionView:collectionView];
  return CGSizeMake(width, height);
}

// Note that this method is only exposed temporarily until self-sizing cells are supported.
- (CGFloat)cellWidthAtSectionIndex:(NSInteger)section
                    collectionView:(UICollectionView *)collectionView {
  UIEdgeInsets contentInset = collectionView.contentInset;
// On the iPhone X, we need to use the offset which might take into account the safe area.
  if (@available(iOS 11.0, *)) {
    contentInset = collectionView.adjustedContentInset;
  }

  CGFloat bounds = CGRectGetWidth(UIEdgeInsetsInsetRect(collectionView.bounds, contentInset));
  UIEdgeInsets sectionInsets = [self collectionView:collectionView
                                             layout:collectionView.collectionViewLayout
                             insetForSectionAtIndex:section];
  CGFloat insets = sectionInsets.left + sectionInsets.right;
  if (_styler.cellLayoutType == MDCCollectionViewCellLayoutTypeGrid) {
    CGFloat cellWidth = bounds - insets - (_styler.gridPadding * (_styler.gridColumnCount - 1));
    return cellWidth / _styler.gridColumnCount;
  }
  return bounds - insets;
}

- (UIEdgeInsets)insetsAtSectionIndex:(NSInteger)section
                      collectionView:(UICollectionView *)collectionView {
  // Determine insets based on cell style.
  CGFloat inset = (CGFloat)floor(MDCCollectionViewCellStyleCardSectionInset);
  UIEdgeInsets insets = UIEdgeInsetsZero;
  NSInteger numberOfSections = collectionView.numberOfSections;
  BOOL isTop = (section == 0);
  BOOL isBottom = (section == numberOfSections - 1);
  MDCCollectionViewCellStyle cellStyle = [_styler cellStyleAtSectionIndex:section];
  BOOL isCardStyle = cellStyle == MDCCollectionViewCellStyleCard;
  BOOL isGroupedStyle = cellStyle == MDCCollectionViewCellStyleGrouped;
  // Set left/right insets.
  if (isCardStyle) {
    insets.left = inset;
    insets.right = inset;
    if (@available(iOS 11.0, *)) {
      if (collectionView.contentInsetAdjustmentBehavior
          == UIScrollViewContentInsetAdjustmentAlways) {
        // We don't need section insets if there are already safe area insets.
        insets.left = MAX(0, insets.left - collectionView.safeAreaInsets.left);
        insets.right = MAX(0, insets.right - collectionView.safeAreaInsets.right);
      }
    }
  }
  // Set top/bottom insets.
  if (isCardStyle || isGroupedStyle) {
    insets.top = (CGFloat)floor((isTop) ? inset : inset / 2);
    insets.bottom = (CGFloat)floor((isBottom) ? inset : inset / 2);
  }
  return insets;
}

- (CGSize)inlaidSizeAtIndexPath:(NSIndexPath *)indexPath
                       withSize:(CGSize)size
                 collectionView:(UICollectionView *)collectionView {
  // If object is inlaid, return its adjusted size.
  if ([_styler isItemInlaidAtIndexPath:indexPath]) {
    CGFloat inset = MDCCollectionViewCellStyleCardSectionInset;
    UIEdgeInsets inlayInsets = UIEdgeInsetsZero;
    BOOL prevCellIsInlaid = NO;
    BOOL nextCellIsInlaid = NO;

    BOOL hasSectionHeader = NO;
    if ([self
            respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
      CGSize headerSize = [self collectionView:collectionView
                                        layout:collectionView.collectionViewLayout
               referenceSizeForHeaderInSection:indexPath.section];
      hasSectionHeader = !CGSizeEqualToSize(headerSize, CGSizeZero);
    }

    BOOL hasSectionFooter = NO;
    if ([self
            respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
      CGSize footerSize = [self collectionView:collectionView
                                        layout:_collectionViewLayout
               referenceSizeForFooterInSection:indexPath.section];
      hasSectionFooter = !CGSizeEqualToSize(footerSize, CGSizeZero);
    }

    // Check if previous cell is inlaid.
    if (indexPath.item > 0 || hasSectionHeader) {
      NSIndexPath *prevIndexPath =
          [NSIndexPath indexPathForItem:(indexPath.item - 1) inSection:indexPath.section];
      prevCellIsInlaid = [_styler isItemInlaidAtIndexPath:prevIndexPath];
      inlayInsets.top = prevCellIsInlaid ? inset / 2 : inset;
    }

    // Check if next cell is inlaid.
    if (indexPath.item < [collectionView numberOfItemsInSection:indexPath.section] - 1 ||
        hasSectionFooter) {
      NSIndexPath *nextIndexPath =
          [NSIndexPath indexPathForItem:(indexPath.item + 1) inSection:indexPath.section];
      nextCellIsInlaid = [_styler isItemInlaidAtIndexPath:nextIndexPath];
      inlayInsets.bottom = nextCellIsInlaid ? inset / 2 : inset;
    }

    // Apply top/bottom height adjustments to inlaid object.
    size.height += inlayInsets.top + inlayInsets.bottom;
  }
  return size;
}

#pragma mark - Subclassing Methods

/*
 The below method is solely used for subclasses to retrieve width information in order to
 calculate cell height. Not meant to call method cellWidthAtSectionIndex:collectionView as
 that method recalculates section insets which we don't want to do.
 */
- (CGFloat)cellWidthAtSectionIndex:(NSInteger)section {
  UIEdgeInsets contentInset = self.collectionView.contentInset;
  // On the iPhone X, we need to use the offset which might take into account the safe area.
  if (@available(iOS 11.0, *)) {
    contentInset = self.collectionView.adjustedContentInset;
  }
  CGFloat bounds = CGRectGetWidth(
      UIEdgeInsetsInsetRect(self.collectionView.bounds, contentInset));
  UIEdgeInsets sectionInsets = [self collectionView:self.collectionView
                                             layout:self.collectionView.collectionViewLayout
                             insetForSectionAtIndex:section];

  CGFloat insets = sectionInsets.left + sectionInsets.right;
  if (_styler != nil) {
    if (_styler.cellLayoutType == MDCCollectionViewCellLayoutTypeGrid) {
      CGFloat cellWidth = bounds - insets - (_styler.gridPadding * (_styler.gridColumnCount - 1));
      if (_styler.gridColumnCount > 0) {
        return cellWidth / _styler.gridColumnCount;
      }
    }
  }
  return bounds - insets;
}

#pragma mark - <MDCInkTouchControllerDelegate>

- (BOOL)inkTouchController:(__unused MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  // Only store touch location and do not allow ink processing. This ink location will be used when
  // manually starting/stopping the ink animation during cell highlight/unhighlight states.
  if (!self.currentlyActiveInk) {
    _inkTouchLocation = location;
  }
  return NO;
}

- (MDCInkView *)inkTouchController:(MDCInkTouchController *)inkTouchController
            inkViewAtTouchLocation:(CGPoint)location {
  NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
  MDCInkView *ink = nil;

  if ([_styler.delegate
          respondsToSelector:@selector(collectionView:inkTouchController:inkViewAtIndexPath:)]) {
    return [_styler.delegate collectionView:self.collectionView
                         inkTouchController:inkTouchController
                         inkViewAtIndexPath:indexPath];
  }
  if ([cell isKindOfClass:[MDCCollectionViewCell class]]) {
    MDCCollectionViewCell *inkCell = (MDCCollectionViewCell *)cell;
    if ([inkCell respondsToSelector:@selector(inkView)]) {
      // Set cell ink.
      ink = [cell performSelector:@selector(inkView)];
    }
  }

  return ink;
}

#pragma mark - <UICollectionViewDataSource>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  // TODO (shepj): This implementation of registering cell classes in data source methods should be
  // rethought. This causes a crash without a workaround when collections with headers or
  // footers entering editing mode. Also, we should find a way around implementing a data source
  // method in a super class.
  // Issue: https://github.com/material-components/material-components-ios/issues/1208
  // Editing info bar.
  if ([kind isEqualToString:MDCCollectionInfoBarKindHeader] ||
      [kind isEqualToString:MDCCollectionInfoBarKindFooter]) {
    NSString *identifier = NSStringFromClass([MDCCollectionInfoBarView class]);
    UICollectionReusableView *supplementaryView =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:identifier
                                                  forIndexPath:indexPath];

    // Update info bar.
    if ([supplementaryView isKindOfClass:[MDCCollectionInfoBarView class]]) {
      MDCCollectionInfoBarView *infoBarView = (MDCCollectionInfoBarView *)supplementaryView;
      infoBarView.delegate = self;
      infoBarView.kind = kind;
      [self updateControllerWithInfoBar:infoBarView];
    }
    return supplementaryView;
  } else {
    return [super collectionView:collectionView
        viewForSupplementaryElementOfKind:kind
                              atIndexPath:indexPath];
  }
}

#pragma mark - <UICollectionViewDelegate>

- (BOOL)collectionView:(__unused UICollectionView *)collectionView
    shouldHighlightItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
    didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([_styler.delegate respondsToSelector:@selector(collectionView:hidesInkViewAtIndexPath:)] &&
      [_styler.delegate collectionView:collectionView hidesInkViewAtIndexPath:indexPath]) {
    return;
  }
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  CGPoint location = [collectionView convertPoint:_inkTouchLocation toView:cell];

  // Start cell ink show animation.
  MDCInkView *inkView;
  if ([cell respondsToSelector:@selector(inkView)]) {
    inkView = [cell performSelector:@selector(inkView)];
  } else {
    return;
  }

  // Update ink color if necessary.
  if ([_styler.delegate respondsToSelector:@selector(collectionView:inkColorAtIndexPath:)]) {
    inkView.inkColor =
        [_styler.delegate collectionView:collectionView inkColorAtIndexPath:indexPath];
    if (!inkView.inkColor) {
      inkView.inkColor = inkView.defaultInkColor;
    }
  }
  self.currentlyActiveInk = YES;
  [inkView startTouchBeganAnimationAtPoint:location completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView
    didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  CGPoint location = [collectionView convertPoint:_inkTouchLocation toView:cell];

  // Start cell ink evaporate animation.
  MDCInkView *inkView;
  if ([cell respondsToSelector:@selector(inkView)]) {
    inkView = [cell performSelector:@selector(inkView)];
  } else {
    return;
  }

  self.currentlyActiveInk = NO;
  [inkView startTouchEndedAnimationAtPoint:location completion:nil];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_editor.isEditing) {
    if ([self collectionView:collectionView canEditItemAtIndexPath:indexPath]) {
      return [self collectionView:collectionView canSelectItemDuringEditingAtIndexPath:indexPath];
    }
    return NO;
  }
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    shouldDeselectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  return collectionView.allowsMultipleSelection;
}

- (void)collectionView:(__unused UICollectionView *)collectionView
    didSelectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  [self updateFooterInfoBarIfNecessary];
}

- (void)collectionView:(__unused UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  [self updateFooterInfoBarIfNecessary];
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsEditing:(__unused UICollectionView *)collectionView {
  return NO;
}

- (void)collectionViewWillBeginEditing:(__unused UICollectionView *)collectionView {
  if (self.currentlyActiveInk) {
    MDCInkView *activeInkView =
        [self inkTouchController:_inkTouchController inkViewAtTouchLocation:_inkTouchLocation];
    [activeInkView startTouchEndedAnimationAtPoint:_inkTouchLocation completion:nil];
  }
  // Inlay all items.
  _styler.allowsItemInlay = YES;
  _styler.allowsMultipleItemInlays = YES;
  [_styler applyInlayToAllItemsAnimated:YES];
  [self updateHeaderInfoBarIfNecessary];
}

- (void)collectionViewWillEndEditing:(__unused UICollectionView *)collectionView {
  // Remove inlay of all items.
  [_styler removeInlayFromAllItemsAnimated:YES];
  [self updateFooterInfoBarIfNecessary];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  return [self collectionViewAllowsEditing:collectionView];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSelectItemDuringEditingAtIndexPath:(NSIndexPath *)indexPath {
  if ([self collectionViewAllowsEditing:collectionView]) {
    return [self collectionView:collectionView canEditItemAtIndexPath:indexPath];
  }
  return NO;
}

#pragma mark - Item Moving

- (BOOL)collectionViewAllowsReordering:(__unused UICollectionView *)collectionView {
  return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canMoveItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  return ([self collectionViewAllowsEditing:collectionView] &&
          [self collectionViewAllowsReordering:collectionView]);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canMoveItemAtIndexPath:(NSIndexPath *)indexPath
               toIndexPath:(NSIndexPath *)newIndexPath {
  // First ensure both source and target items can be moved.
  return ([self collectionView:collectionView canMoveItemAtIndexPath:indexPath] &&
          [self collectionView:collectionView canMoveItemAtIndexPath:newIndexPath]);
}

- (void)collectionView:(UICollectionView *)collectionView
    didMoveItemAtIndexPath:(NSIndexPath *)indexPath
               toIndexPath:(NSIndexPath *)newIndexPath {
  [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

#pragma mark - Swipe-To-Dismiss-Items

- (BOOL)collectionViewAllowsSwipeToDismissItem:(__unused UICollectionView *)collectionView {
  return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(__unused NSIndexPath *)indexPath {
  return [self collectionViewAllowsSwipeToDismissItem:collectionView];
}

- (void)collectionView:(__unused UICollectionView *)collectionView
    didEndSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
  [self deleteIndexPaths:@[ indexPath ]];
}

#pragma mark - Swipe-To-Dismiss-Sections

- (BOOL)collectionViewAllowsSwipeToDismissSection:(__unused UICollectionView *)collectionView {
  return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissSection:(__unused NSInteger)section {
  return [self collectionViewAllowsSwipeToDismissSection:collectionView];
}

- (void)collectionView:(__unused UICollectionView *)collectionView
    didEndSwipeToDismissSection:(NSInteger)section {
  [self deleteSections:[NSIndexSet indexSetWithIndex:section]];
}

#pragma mark - Private

- (void)deleteIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  if ([self respondsToSelector:@selector(collectionView:willDeleteItemsAtIndexPaths:)]) {
    void (^batchUpdates)(void) = ^{
      // Notify delegate to delete data.
      [self collectionView:self.collectionView willDeleteItemsAtIndexPaths:indexPaths];

      // Delete index paths.
      [self.collectionView deleteItemsAtIndexPaths:indexPaths];
    };

    void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
      [self updateFooterInfoBarIfNecessary];
      // Notify delegate of deletion.
      if ([self respondsToSelector:@selector(collectionView:didDeleteItemsAtIndexPaths:)]) {
        [self collectionView:self.collectionView didDeleteItemsAtIndexPaths:indexPaths];
      }
    };

    // Animate deletion.
    [self.collectionView performBatchUpdates:batchUpdates completion:completionBlock];
  }
}

- (void)deleteSections:(NSIndexSet *)sections {
  if ([self respondsToSelector:@selector(collectionView:willDeleteSections:)]) {
    void (^batchUpdates)(void) = ^{
      // Notify delegate to delete data.
      [self collectionView:self.collectionView willDeleteSections:sections];

      // Delete sections.
      [self.collectionView deleteSections:sections];
    };

    void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
      [self updateFooterInfoBarIfNecessary];
      // Notify delegate of deletion.
      if ([self respondsToSelector:@selector(collectionView:didDeleteSections:)]) {
        [self collectionView:self.collectionView didDeleteSections:sections];
      }
    };

    // Animate deletion.
    [self.collectionView performBatchUpdates:batchUpdates completion:completionBlock];
  }
}

- (void)updateHeaderInfoBarIfNecessary {
  if (_editor.isEditing) {
    // Show HUD only once before autodissmissing.
    BOOL allowsSwipeToDismissItem = NO;
    if ([self respondsToSelector:@selector(collectionViewAllowsSwipeToDismissItem:)]) {
      allowsSwipeToDismissItem = [self collectionViewAllowsSwipeToDismissItem:self.collectionView];
    }

    if (!_headerInfoBar.isVisible && !_headerInfoBarDismissed && allowsSwipeToDismissItem) {
      [_headerInfoBar showAnimated:YES];
    } else {
      [_headerInfoBar dismissAnimated:YES];
    }
  }
}

- (void)updateFooterInfoBarIfNecessary {
  NSInteger selectedItemCount = [self.collectionView.indexPathsForSelectedItems count];
  if (_editor.isEditing) {
    // Invalidate layout to add info bar if necessary.
    [self.collectionView.collectionViewLayout invalidateLayout];
    if (_footerInfoBar) {
      if (selectedItemCount > 0 && !_footerInfoBar.isVisible) {
        [_footerInfoBar showAnimated:YES];
      } else if (selectedItemCount == 0 && _footerInfoBar.isVisible) {
        [_footerInfoBar dismissAnimated:YES];
      }
    }
  } else if (selectedItemCount == 0 && _footerInfoBar.isVisible) {
    [_footerInfoBar dismissAnimated:YES];
  }
}

- (void)updateContentWithBottomInset:(CGFloat)inset {
  // Update bottom inset to account for footer info bar.
  UIEdgeInsets contentInset = self.collectionView.contentInset;
  contentInset.bottom += inset;
  [UIView animateWithDuration:MDCCollectionInfoBarAnimationDuration
                   animations:^{
                     self.collectionView.contentInset = contentInset;
                   }];
}

@end
