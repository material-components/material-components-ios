/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MDCCard.h"

typedef NS_ENUM(NSInteger, MDCCardCellSelectionState) {
  /** The visual state when you are now selecting the cell. */
  MDCCardCellSelectionStateSelect,

  /** The visual state when you have already selected the cell. */
  MDCCardCellSelectionStateSelected,

  /** The visual state when you are now unselecting the cell. */
  MDCCardCellSelectionStateUnselect,

  /** The visual state when you have already unselected the cell. */
  MDCCardCellSelectionStateUnselected
};

@interface MDCCollectionViewCardCell : UICollectionViewCell

/**
 The underlying card view for the cell
 */
@property(nonatomic, strong, nullable) MDCCard *cardView;

/**
 editMode is toggled to true once any of the selection states are invoked
 to insure that the default touch recognizer isn't invoked like a regular tap.
 */
@property(nonatomic, assign) BOOL editMode;

/**
 Setter for the background color of the view

 @param backgroundColor UIColor for the background color
 */
- (void)setBackgroundColor:(nullable UIColor *)backgroundColor;

/**
 Getter for the background color of the view
 */
- (nullable UIColor *)backgroundColor;


/**
 Setter for the cornerRadius of the cell and the underlying card.

 @param cornerRadius CGFloat of the radius to set the corner
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/**
 Getter for the cornerRadius of the cell and the underlying card.
 */
- (CGFloat)cornerRadius;

/**
 Setter for the shadow elevation surrounding the cell.

 @param elevation CGFloat of the elevation for the shadow of the MDDCCard.
 */
- (void)setShadowElevation:(CGFloat)elevation;

/**
 Getter for the shadow elevation surrounding the cell.
 */
- (CGFloat)shadowElevation;

/**
 Set the color of the image appearing in the selected state.

 @param color UIColor the color to have the image as
 */
- (void)setColorForSelectedImage:(nonnull UIColor *)color;

/**
 Get the color of the image appearing in the selected state.
 */
- (nonnull UIColor *)getColorForSelectedImage;

/**
 Get the image for the selected state.
 */
- (void)setImageForSelectedState:(nullable UIImage *)image;

- (nullable UIImage *)getImageForSelectedState;

/**
 selectionState sets the selection state of the cell when in editing/selection mode.
 This method also puts the cell in editMode which then makes it follow the selection visuals.

 @param state MDCCardCellSelectionState is the visual state of the cell in regards to selection.
 */
- (void)selectionState:(MDCCardCellSelectionState)state;

@end
