// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialElevation.h"
#import "MaterialInk.h"
#import "MaterialRipple.h"
#import "MaterialShadowLayer.h"

@protocol MDCShapeGenerating;

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
  MDCCardCellStateSelected,

  /**
   The visual state when the cell is being dragged.
   Currently only used with the Ripple Beta component.
  */
  MDCCardCellStateDragged
};

/**
 The horizontal alignment of the image when in selectable mode (`selectable` is set to YES).
 */
typedef NS_ENUM(NSInteger, MDCCardCellHorizontalImageAlignment) {
  /** The alignment of the image is to the right of the card. */
  MDCCardCellHorizontalImageAlignmentRight = 0,

  /** The alignment of the image is to the center of the card. */
  MDCCardCellHorizontalImageAlignmentCenter,

  /** The alignment of the image is to the left of the card. */
  MDCCardCellHorizontalImageAlignmentLeft,

  // TODO: Add AlignmentLeading and AlignmentTrailing. See Github issue #3045
};

/**
 The vertical alignment of the image when in selectable mode (`selectable` is set to YES).
 */
typedef NS_ENUM(NSInteger, MDCCardCellVerticalImageAlignment) {
  /** The alignment of the image is to the top of the card. */
  MDCCardCellVerticalImageAlignmentTop = 0,

  /** The alignment of the image is to the center of the card. */
  MDCCardCellVerticalImageAlignmentCenter,

  /** The alignment of the image is to the bottom of the card. */
  MDCCardCellVerticalImageAlignmentBottom,
};

@interface MDCCardCollectionCell : UICollectionViewCell <MDCElevatable, MDCElevationOverriding>

/**
 When selectable is set to YES, a tap on a cell will trigger a visual change between selected
 and unselected. When it is set to NO, a tap will trigger a normal tap (rather than trigger
 different visual selection states on the card).
 Default is set to NO.
 */
@property(nonatomic, assign, getter=isSelectable) BOOL selectable;

/**
 A Boolean value indicating whether the card is in the dragged state.
 */
@property(nonatomic, getter=isDragged) BOOL dragged;

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
 The rippleView for the card that is initiated on tap. The ripple view is the successor of ink
 view, and can be used by setting `enableRippleBehavior` to YES after initializing the card.
 */
@property(nonatomic, readonly, strong, nonnull) MDCStatefulRippleView *rippleView;

/**
 This property defines if a card as a whole should be interactable or not.
 What this means is that when isInteractable is set to NO, there will be no ink ripple and
 no change in shadow elevation when tapped or selected. Also the card container itself will not be
 tappable, but any of its subviews will still be tappable.

 Default is set to YES.

 Important: Our specification for cards explicitly define a card as being an interactable component.
 Therefore, this property should be set to NO *only if* there are other interactable items within
 the card's content, such as buttons or other tappable controls.
 */
@property(nonatomic, getter=isInteractable) IBInspectable BOOL interactable;

/*
 The shape generator used to define the card cell's shape.
 When set, layer properties such as cornerRadius and other layer properties are nullified/zeroed.
 If a layer property is explicitly set after the shapeGenerator has been set, it will lead to
 unexpected behavior.

 When the shapeGenerator is nil, MDCCardCollectionCell will use the default underlying layer with
 its default settings.

 Default value for shapeGenerator is nil.
 */
@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGenerator;

/**
 By setting this property to YES, you will enable and use inkView's successor rippleView as the
 main view to provide visual feedback for taps. It is recommended to set this property right after
 initializing the card.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 Sets the shadow elevation for an MDCCardViewState state

 @param shadowElevation The shadow elevation
 @param state MDCCardCellState the card state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation
                  forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

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
- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

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
- (void)setBorderColor:(nullable UIColor *)borderColor
              forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

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
- (void)setShadowColor:(nullable UIColor *)shadowColor
              forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow color for an MDCCardCellStateNormal state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.
 Default value for MDCCardCellStateNormal is blackColor

 @param state MDCCardCellState the card state
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the image for an MDCCardCellStateNormal state.

 @note The image is only displayed when `selectable` is YES.
 If no image has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then nil will be returned.
 Default value for MDCCardCellStateSelected is ic_check_circle

 @param state MDCCardCellState the card state
 @return The image for the requested state.
 */
- (nullable UIImage *)imageForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the image for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 @param image The image
 @param state MDCCardCellState the card state
 */
- (void)setImage:(nullable UIImage *)image forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the horizontal image alignment for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 If no alignment has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then MDCCardCellImageHorizontalAlignmentRight will be returned.

 @param state MDCCardCellState the card state
 @return The horizontal alignment for the requested state.
 */
- (MDCCardCellHorizontalImageAlignment)horizontalImageAlignmentForState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Sets the image alignment for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 @param horizontalImageAlignment The image alignment
 @param state MDCCardCellState the card state
 */
- (void)setHorizontalImageAlignment:(MDCCardCellHorizontalImageAlignment)horizontalImageAlignment
                           forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the vertical image alignment for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 If no alignment has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then MDCCardCellImageVerticalAlignmentTop will be returned.

 @param state MDCCardCellState the card state
 @return The vertical alignment for the requested state.
 */
- (MDCCardCellVerticalImageAlignment)verticalImageAlignmentForState:(MDCCardCellState)state
    UI_APPEARANCE_SELECTOR;

/**
 Sets the image alignment for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 @param verticalImageAlignment The image alignment
 @param state MDCCardCellState the card state
 */
- (void)setVerticalImageAlignment:(MDCCardCellVerticalImageAlignment)verticalImageAlignment
                         forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the image tint color for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 If no tint color has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then nil will be returned.

 @param state MDCCardCellState the card state
 @return The image tint color for the requested state.
 */
- (nullable UIColor *)imageTintColorForState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the image tint color for an MDCCardCellStateNormal state

 @note The image is only displayed when `selectable` is YES.
 @param imageTintColor The image tint color
 @param state MDCCardCellState the card state
 */
- (void)setImageTintColor:(nullable UIColor *)imageTintColor
                 forState:(MDCCardCellState)state UI_APPEARANCE_SELECTOR;

/**
 The state of the card cell.
 Default is MDCCardCellStateNormal.
 */
@property(nonatomic, readonly) MDCCardCellState state;

/**
 A block that is invoked when the @c MDCCardCollectionCell receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCCardCollectionCell *_Nonnull collectionCell,
     UITraitCollection *_Nullable previousTraitCollection);

@end
