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
#import "MDCCardView.h"

typedef NS_ENUM(NSInteger, MDCCardCellSelectionState) {
  /** The visual state when you have already selected the cell. */
  MDCCardCellSelectionStateSelected,

  /** The visual state when you have already unselected the cell. */
  MDCCardCellSelectionStateUnselected
};

@interface MDCCollectionViewCardCell : UICollectionViewCell

/**
 The underlying card view for the cell
 */
@property(readonly, nonatomic, strong, nullable) MDCCardView *cardView;

/**
 editMode is toggled to true once any of the selection states are invoked
 to insure that the default touch recognizer isn't invoked like a regular tap.
 */
@property(nonatomic, assign) BOOL editMode;
@property(nonatomic, assign) MDCCardCellSelectionState state;
/**
 The corner radius for the cell and the underlying card
 */
@property(nonatomic, assign) CGFloat cornerRadius;

/**
 The shadow elevation for the card in the cell
 */
@property(nonatomic, assign) CGFloat shadowElevation;

/**
 The resting (default) state shadow elevation for the card in the cell
 */
@property(nonatomic, assign) CGFloat restingShadowElevation;

/**
 The pressed/dragged state shadow elevation for the card in the cell
 */
@property(nonatomic, assign) CGFloat pressedShadowElevation;

/**
 The image view that is seen when the card is in the selected state
 */
@property(nonatomic, strong, nullable) UIImageView *selectedImageView;

/**
The color of the image in the selected state
 */
@property(nonatomic, strong, nullable) UIColor *colorForSelectedImage;

/**
The image for the selected state (by default is a checked circle)
 */
@property(nonatomic, strong, nullable) UIImage *imageForSelectedState;

/**
 selectionState sets the selection state of the cell when in editing/selection mode.
 This method also puts the cell in editMode which then makes it follow the selection visuals.

 @param state MDCCardCellSelectionState is the visual state of the cell in regards to selection.
 */
- (void)selectionState:(MDCCardCellSelectionState)state withAnimation:(BOOL)animation;

@end
