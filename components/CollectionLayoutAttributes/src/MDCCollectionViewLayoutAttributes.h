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

#import <UIKit/UIKit.h>

/** Types of cell ordinal positions available within a collectionView. */
typedef NS_OPTIONS(NSUInteger, MDCCollectionViewOrdinalPosition) {
  /** Cell visually has top edge within section. */
  MDCCollectionViewOrdinalPositionVerticalTop = 1 << 0,

  /** Cell visually has no top/bottom edges within section. */
  MDCCollectionViewOrdinalPositionVerticalCenter = 1 << 1,

  /** Cell visually has bottom edge within section. */
  MDCCollectionViewOrdinalPositionVerticalBottom = 1 << 2,

  /**
   Cell visually has both bottom/top edges within section. Typically for a single or inlaid cell.
   */
  MDCCollectionViewOrdinalPositionVerticalTopBottom =
      (MDCCollectionViewOrdinalPositionVerticalTop |
       MDCCollectionViewOrdinalPositionVerticalBottom),

  /** Cell visually has left edge within section. */
  MDCCollectionViewOrdinalPositionHorizontalLeft = 1 << 10,

  /** Cell visually has no left/right edges within section. */
  MDCCollectionViewOrdinalPositionHorizontalCenter = 1 << 11,

  /** Cell visually has right edge within section. */
  MDCCollectionViewOrdinalPositionHorizontalRight = 1 << 12
};

/**
 The MDCCollectionViewLayoutAttributes class allows passing layout attributes to the cells and
 supplementary views.
 */
@interface MDCCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

#pragma mark - Cell Styling

/** A boolean value indicating whether the collectionView is being edited. Defaults to NO. */
@property(nonatomic, getter=isEditing) BOOL editing;

/**
 A boolean value indicating whether the collectionView cell should be displayed with reorder
 state mask. Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldShowReorderStateMask;

/**
 A boolean value indicating whether the collectionView cell should be displayed with selector
 state mask. Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldShowSelectorStateMask;

/**
 A Boolean value indicating whether the collection view cell should allow the grid background
 decoration view to be drawn at the specified index.
 */
@property(nonatomic, assign) BOOL shouldShowGridBackground;

/** The image for use as the cells background image. */
@property(nonatomic, strong, nullable) UIImage *backgroundImage;

/** The background image view edge insets. */
@property(nonatomic) UIEdgeInsets backgroundImageViewInsets;

/**
 A boolean value indicating whether the collectionView cell style is set to
 MDCCollectionViewCellLayoutTypeGrid.
 */
@property(nonatomic, assign) BOOL isGridLayout;

/** The ordinal position within the collectionView section. */
@property(nonatomic, assign) MDCCollectionViewOrdinalPosition sectionOrdinalPosition;

#pragma mark - Cell Separator

/** Separator color. Defaults to #E0E0E0. */
@property(nonatomic, strong, nullable) UIColor *separatorColor;

/** Separator inset. Defaults to UIEdgeInsetsZero. */
@property(nonatomic) UIEdgeInsets separatorInset;

/** Separator line height. Defaults to 1.0f */
@property(nonatomic) CGFloat separatorLineHeight;

/** Whether to hide the cell separators. Defaults to NO. */
@property(nonatomic) BOOL shouldHideSeparators;

#pragma mark - Cell Appearance Animation

/** Whether cells will animation on appearance. */
@property(nonatomic, assign) BOOL willAnimateCellsOnAppearance;

/**
 The cell appearance animation duration. Defaults to MDCCollectionViewAnimatedAppearanceDuration.
 */
@property(nonatomic, assign) NSTimeInterval animateCellsOnAppearanceDuration;

/** The cell delay used to stagger fade-in during appearance animation. Defaults to 0. */
@property(nonatomic, assign) NSTimeInterval animateCellsOnAppearanceDelay;

@end
