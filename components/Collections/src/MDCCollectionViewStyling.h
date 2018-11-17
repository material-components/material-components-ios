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

#import <UIKit/UIKit.h>

@protocol MDCCollectionViewStylingDelegate;
@class MDCCollectionViewLayoutAttributes;

/** The default section insets. Should be an even number to allow even division. */
extern const CGFloat MDCCollectionViewCellStyleCardSectionInset;

/** The styles in which the collectionView cells can be shown. */
typedef NS_ENUM(NSUInteger, MDCCollectionViewCellStyle) {
  /** Cells displayed full width without section padding. */
  MDCCollectionViewCellStyleDefault,

  /** Cells displayed full width with section padding. */
  MDCCollectionViewCellStyleGrouped,

  /** Cells displayed card style with sections padding. */
  MDCCollectionViewCellStyleCard,
};

/** The layout types in which the collectionView cells can be shown. */
typedef NS_ENUM(NSUInteger, MDCCollectionViewCellLayoutType) {
  /** Cells displayed in list layout. */
  MDCCollectionViewCellLayoutTypeList,

  /** Cells displayed in grid layout. */
  MDCCollectionViewCellLayoutTypeGrid,

  /**
   Cells displayed in custom defined layout. A new UICollectionViewLayout must be
   provided and set on the collection view.
   */
  MDCCollectionViewCellLayoutTypeCustom
};

/**
 The MDCCollectionViewStyling protocol defines the stylable properties for a Material collection
 view.
 */
@protocol MDCCollectionViewStyling <NSObject>

/** The associated collection view. */
@property(nonatomic, readonly, weak, nullable) UICollectionView *collectionView;

/** The delegate is sent messages when styles change. */
@property(nonatomic, weak, nullable) id<MDCCollectionViewStylingDelegate> delegate;

/** Indicates whether the collection view layout should be invalidated. */
@property(nonatomic, assign) BOOL shouldInvalidateLayout;

#pragma mark - Cell Styling

/** The cell background color. Defaults to white color. */
@property(nonatomic, strong, nonnull) UIColor *cellBackgroundColor;

/**
 The cell layout type. Defaults to MDCCollectionViewCellLayoutTypeList if not set. Not animated.
 Defaults to MDCCollectionViewCellLayoutTypeList.
 */
@property(nonatomic, assign) MDCCollectionViewCellLayoutType cellLayoutType;

/**
 The grid column count. Requires cellLayoutType to be set to MDCCollectionViewCellLayoutTypeGrid.
 Not animated.
 */
@property(nonatomic, assign) NSInteger gridColumnCount;

/**
 The grid padding property is used when the cellLayoutType is MDCCollectionViewCellLayoutTypeGrid
 and the gridColumnCount is greater than or equal to 2. This value ensure that the left, center,
 and right padding are equivalent. This prevents double padding at center. Not animated.
 */
@property(nonatomic, assign) CGFloat gridPadding;

/** The cell style. Not animated. @c setCellStyle:animated: for animated layout type changes. */
@property(nonatomic, assign) MDCCollectionViewCellStyle cellStyle;

/** The border radius of a card cell. Defaults to 1.5 */
@property(nonatomic) CGFloat cardBorderRadius;

/**
 Updates the cell style with/without animation.

 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)setCellStyle:(MDCCollectionViewCellStyle)cellStyle animated:(BOOL)animated;

/**
 The collection view cell style at the specified section index.

 @param section The collection view section.
 @return The cell style at specified section.
 */
- (MDCCollectionViewCellStyle)cellStyleAtSectionIndex:(NSInteger)section;

/**
 The collection view cell background image view (used to render the background color and
 shadows) edge outsets as determined for a cell and its layout attributes.

 @param attr The cell's layout attributes.
 @return Edge outsets as detemined by cell style at this index.
 */
- (UIEdgeInsets)backgroundImageViewOutsetsForCellWithAttribute:
        (nonnull MDCCollectionViewLayoutAttributes *)attr;

/**
 Returns an image for use with the given cell style and ordinal position within section.

 The returned image is cached internally after the first request. Changing any of the display
 properties will invalidate the cached images.

 @param attr The cell's layout attributes.
 @return Image as determined by cell style and section ordinal position.
 */
- (nullable UIImage *)backgroundImageForCellLayoutAttributes:
        (nonnull MDCCollectionViewLayoutAttributes *)attr;

#pragma mark - Cell Separator

/** Separator color. Defaults to #E0E0E0. */
@property(nonatomic, strong, nullable) UIColor *separatorColor;

/** Separator inset. Defaults to UIEdgeInsetsZero. */
@property(nonatomic) UIEdgeInsets separatorInset;

/** Separator line height. Defaults to 1 */
@property(nonatomic) CGFloat separatorLineHeight;

/* Whether to hide the cell separators. Defaults to NO. */
@property(nonatomic) BOOL shouldHideSeparators;

/**
 Returns whether the separator should be hidden for the cell with this layout attributes, determined
 by the cell position and type.
 This method may override the shouldHideSeparators property depending on which delegate methods are
 implemented.

 @param attr The cell's layout attributes.
 @return Whether the separtor should be hidden.
 */
- (BOOL)shouldHideSeparatorForCellLayoutAttributes:
        (nonnull MDCCollectionViewLayoutAttributes *)attr;

#pragma mark - Item Inlaying

/**
 Whether inlaying a collection view item is allowed. When an item is inlaid, it will be given
 padding at its edges to make it inset from other sibling items. A typical use case for inlaying
 is when setting a collection view into editing mode, in which each cell gets inlaid so that they
 can individually be selected/unselected/swiped for deletion.

 If YES, call the -inlayItemAtIndexPath:animated method to inlay the item at the specified
 index path. Remove the inlay by calling the -removeInlayAtIndexPath:animated: method.
 Not animated. Defaults to YES.
 */
@property(nonatomic, assign) BOOL allowsItemInlay;

/** Whether inlaying multiple items is allowed. Not animated. Defaults to NO. */
@property(nonatomic, assign) BOOL allowsMultipleItemInlays;

/**
 Returns an array of collection view index paths for items that have their respective frames
 inlaid.

 @return An array of index paths.
 */
- (nullable NSArray<NSIndexPath *> *)indexPathsForInlaidItems;

/**
 A Boolean value indicating if the collection view item at the specified index path has its
 frame inlaid.

 @param indexPath The collection view index path.
 @return YES if the cells are Material styled cards. Otherwise No.
 */
- (BOOL)isItemInlaidAtIndexPath:(nonnull NSIndexPath *)indexPath;

/**
 Inlays the item at the specified index path.

 Property allowsItemInlay must be set to YES, otherwise no-op.

 @param indexPath The specified index path.
 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)applyInlayToItemAtIndexPath:(nonnull NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 Removes the inlaid state of the item at the specified index path.

 @param indexPath The specified index path.
 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)removeInlayFromItemAtIndexPath:(nonnull NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 Inlays items at all available index paths.

 Property allowsItemInlay must be set to YES, otherwise no-op.

 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)applyInlayToAllItemsAnimated:(BOOL)animated;

/**
 Removes the inlaid state of items at all available index paths.

 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)removeInlayFromAllItemsAnimated:(BOOL)animated;

/**
 Resets the internal storage array of all item index paths for inlaid items. When modifying
 items in the collection view model, a call to this method will ensure that all inserted
 and/or deleted index paths are reflected properly in the return array from the
 method -indexPathsForInlaidItems. Calling this is not animated.
 */
- (void)resetIndexPathsForInlaidItems;

#pragma mark - Cell Appearance Animation

/**
 Whether cells should animate on appearance. This property typically should be set in the
 -viewDidLoad method of the controller. If YES, cells will animate the following properties:

 A) Cell heights will begin expanded by the padding specified by animateCellsOnAppearancePadding.
    It will then animate to original height.

 B) Cell frame will begin with positive y-offset as specified by animateCellsOnAppearancePadding.
    It will animate upwards to original y coordinate.

 C) Cell contentView and separatorView will begin hidden by setting alpha to 0. It will then
    animate with a fade-in transition in a staggered fashion from the top cell down to last
    visible cell.
 */
@property(nonatomic, assign) BOOL shouldAnimateCellsOnAppearance;

/** Whether cells should calculate their initial properties before animation on appearance. */
@property(nonatomic, readonly, assign) BOOL willAnimateCellsOnAppearance;

/*
 The cell appearance animation padding. This value is ignored unless
 shouldAnimateCellsOnAppearance is set to YES. Its value is set at initialization time by the
 constant MDCCollectionViewAnimatedAppearancePadding.
 */
@property(nonatomic, readonly, assign) CGFloat animateCellsOnAppearancePadding;

/*
 The cell appearance animation duration. This value is ignored unless
 shouldAnimateCellsOnAppearance is set to YES. Its value is set at initialization time by the
 constant MDCCollectionViewAnimatedAppearanceDuration.
 */
@property(nonatomic, readonly, assign) NSTimeInterval animateCellsOnAppearanceDuration;

/**
 This method should only be called from MDCCollectionViewFlowLayout class once all visible
 collection view attributes are available. By calling -updateLayoutAnimated within this method's
 animation block, it will trigger the collection view to query both the item and supplementary
 view sizing methods of the UICollectionViewDelegateFlowLayout protocol, resulting in an
 animated resizing of the cells by the height specified in animateCellsOnAppearancePadding.
 */
- (void)beginCellAppearanceAnimation;

@end
