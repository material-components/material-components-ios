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
#import "MaterialShadowLayer.h"
#import "MaterialInk.h"

typedef NS_ENUM(NSInteger, MDCCardsState) {
  /** The default state for the card. */
  MDCCardsStateDefault,

  /** The visual state when the card is pressed (i.e. dragging). */
  MDCCardsStatePressed,

  /** The visual state when you select the card (i.e. editing). */
  MDCCardsStateSelect,

  /** The visual state when the card is already selected (i.e. editing). */
  MDCCardsStateSelected,

  /** The visual state when the card is already unselected (i.e. editing) */
  MDCCardStateUnselected
};

@interface MDCCard : UIControl

/**
 Initializing the MDCCard using the frame and if it is the
 underlying view for MDCCollectionViewCardCell

 @param frame CGRect for the view's frame.
 @param isUsingCell YES if this is the underlying view for MDCCollectionViewCardCell,
                    otherwise, NO.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame withIsUsingCollectionViewCell:(BOOL)isUsingCell;

/**
 Setter for the cornerRadius of the MDCCard.

 @param cornerRadius CGFloat of the radius to set the corner
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/**
 Getter for the cornerRadius of the MDCCard.
 */
- (CGFloat)cornerRadius;

/**
 Setter for the shadow elevation surrounding the MDCCard.

 @param elevation CGFloat of the elevation for the shadow of the MDDCCard.
 */
- (void)setShadowElevation:(CGFloat)elevation;

/**
 Getter for the shadow elevation surrounding the MDCCard.
 */
- (CGFloat)shadowElevation;

/**
 Sets the style for the MDCCard based on the defined state. Please see the MDCCardState definition
 above to see all the possible states.

 @param state MDCCardState this defines the state in which the card should visually be set to
 @param location CGPoint some states may need the touch location to begin/end the ink from
 @param completion MDCInkCompletionBlock the completion block for the ink animation
 */
- (void)styleForState:(MDCCardsState)state
         withLocation:(CGPoint)location
       withCompletion:(nullable MDCInkCompletionBlock)completion;

/**
  The inkView for the card that is initiated on tap
 */
@property(nonatomic, strong, nullable) MDCInkView *inkView;

/**
 The image view that is seen when the card is in the selected state
 */
@property(nonatomic, strong, nonnull) UIImageView *selectedImageView;

@end
