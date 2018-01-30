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
  /** The visual state when the cell is in its unselected state. */
  MDCCardCellSelectionStateUnselected,

  /** The visual state when the cell has been selected. */
  MDCCardCellSelectionStateSelected
};

@interface MDCCollectionViewCardCell : UICollectionViewCell

/**
 The underlying card view for the cell
 */
@property(readonly, nonatomic, strong, nonnull) MDCCardView *cardView;

/**
 When selectionMode is set to YES, a tap on a cell will trigger a visual change between selected
 and unselected. When it is set to NO, a tap will trigger a normal tap (rather than trigger
 different visual selection states on the card)
 */
@property(nonatomic, assign) BOOL selectionMode;

/**
 The corner radius for the cell and the underlying card
 */
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

/**
The image for the selected state (by default is a checked circle)
 */
@property(nonatomic, strong, nullable) UIImage *selectedImage;

/**
The tint color for the selected image.
 */
@property(nonatomic, strong, nullable) UIColor *selectedImageTintColor UI_APPEARANCE_SELECTOR;

/**
The selection state of the card cell
 */
@property(nonatomic, readonly) MDCCardCellSelectionState selectionState;

@end
