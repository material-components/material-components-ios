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
#import "MaterialInk.h"
#import "MaterialShadowLayer.h"

/**
 Through the lifecycle of the cell, the cell can go through one of the 3 states,
 normal, highlighted, and selected. The cell starts in its default state, normal.
 When `selectable` is set to NO, each touch on the cell turns it to the highlighted state, and when
 the touch is released, it is returned to the normal state. When `selectable` is set to YES. Each
 touch on the cell that isn't cancelled turns the cell to its selected state. Another touch on the
 cell changes it back to normal.
 */
typedef NS_ENUM(NSInteger, MDCCardCellState) {
  /** The visual state when the cell is in its normal state. */
  MDCCardCellStateNormal = 0,

  /** The visual state when the cell is in its highlighted state. */
  MDCCardCellStateHighlighted,
  
  /** The visual state when the cell has been selected. */
  MDCCardCellStateSelected
};

@interface MDCCardCollectionCell : UICollectionViewCell

/**
 When selectable is set to YES, a tap on a cell will trigger a visual change between selected
 and unselected. When it is set to NO, a tap will trigger a normal tap (rather than trigger
 different visual selection states on the card).
 Default is set to NO.
 */
@property(nonatomic, assign, getter=isSelectable) BOOL selectable;

/**
 The corner radius for the card
 Default is set to 4.
 */
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

/**
 The inkView for the card that is initiated on tap
 */
@property(nonatomic, readonly, strong, nonnull) MDCInkView *inkView;

/**
 Sets the shadow elevation for an MDCCardViewState state

 @param shadowElevation The shadow elevation
 @param state MDCCardCellState the card state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow elevation for an MDCCardViewState state

 If no elevation has been set for a state, the value for MDCCardCellStateNormal will be returned.
 Default value for MDCCardCellStateNormal is 1
 Default value for MDCCardCellStateHighlighted is 8
 Default value for MDCCardCellStateSelected is 8

 @param state MDCCardCellStateNormal the card state
 @return The shadow elevation for the requested state.
 */
- (MDCShadowElevation)shadowElevationForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the border width for an MDCCardViewState state

 @param borderWidth The border width
 @param state MDCCardCellState the card state
 */
- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the border width for an MDCCardCellState state

 If no border width has been set for a state, the value for MDCCardCellStateNormal will be returned.
 Default value for MDCCardCellStateNormal is 0

 @param state MDCCardCellState the card state
 @return The border width for the requested state.
 */
- (CGFloat)borderWidthForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the border color for an MDCCardCellStateNormal state

 @param borderColor The border color
 @param state MDCCardCellState the card state
 */
- (void)setBorderColor:(nullable UIColor *)borderColor forState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the border color for an MDCCardCellStateNormal state

 If no border color has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then nil will be returned.

 @param state MDCCardCellState the card state
 @return The border color for the requested state.
 */
- (nullable UIColor *)borderColorForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the shadow color for an MDCCardCellStateNormal state

 @param shadowColor The shadow color
 @param state MDCCardCellState the card state
 */
- (void)setShadowColor:(nullable UIColor *)shadowColor forState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow color for an MDCCardCellStateNormal state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.
 Default value for MDCCardCellStateNormal is blackColor

 @param state MDCCardCellState the card state
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 The image for the selected state.
 Default is the checked circle image.
 */
@property(nonatomic, strong, nullable) UIImage *selectedImage UI_APPEARANCE_SELECTOR;

/**
 The tint color for the selected image.
 Default is set to default UIImageView tintColor
 */
@property(nonatomic, strong, nullable) UIColor *selectedImageTintColor UI_APPEARANCE_SELECTOR;

/**
 The state of the card cell.
 Default is MDCCardCellStateNormal.
 */
@property(nonatomic, readonly) MDCCardCellState state;

@end
