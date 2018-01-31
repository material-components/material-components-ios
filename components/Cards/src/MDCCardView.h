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

typedef NS_ENUM(NSInteger, MDCCardViewState) {
  /** The normal state for the card. */
  MDCCardViewStateNormal,

  /** The state when the card is pressed (e.g. dragging). */
  MDCCardViewStateHighlighted
};

@interface MDCCardView : UIView

/**
 The corner radius for the card
 */
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

/**
 Returns the current state of the card
 */
@property(nonatomic, readonly) MDCCardViewState state;

/**
 Sets the shadow elevation for an MDCCardViewState state

 @param shadowElevation The shadow elevation
 @param state MDCCardViewState the card view state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(MDCCardViewState)state
  UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow elevation for an MDCCardViewState state

 If no elevation has been set for a state, the value for MDCCardViewStateNormal will be returned.

 @param state MDCCardViewState the card view state
 @return The shadow elevation for the requested state.
 */
- (MDCShadowElevation)shadowElevationForState:(MDCCardViewState)state;

/**
 Sets the border width for an MDCCardViewState state

 @param borderWidth The border width
 @param state MDCCardViewState the card view state
 */
- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardViewState)state
  UI_APPEARANCE_SELECTOR;

/**
 Returns the border width for an MDCCardViewState state

 If no border width has been set for a state, the value for MDCCardViewStateNormal will be returned.

 @param state MDCCardViewState the card view state
 @return The border width for the requested state.
 */
- (CGFloat)borderWidthForState:(MDCCardViewState)state;

/**
 Sets the border color for an MDCCardViewState state

 @param borderColor The border color
 @param state MDCCardViewState the card view state
 */
- (void)setBorderColor:(UIColor *)borderColor forState:(MDCCardViewState)state
  UI_APPEARANCE_SELECTOR;

/**
 Returns the border color for an MDCCardViewState state

 If no border color has been set for a state, the value for MDCCardViewStateNormal will be returned.

 @param state MDCCardViewState the card view state
 @return The border color for the requested state.
 */
- (UIColor *)borderColorForState:(MDCCardViewState)state;

/**
 Sets the shadow color for an MDCCardViewState state

 @param shadowColor The shadow color
 @param state MDCCardViewState the card view state
 */
- (void)setShadowColor:(UIColor *)shadowColor forState:(MDCCardViewState)state
UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow color for an MDCCardViewState state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.

 @param state MDCCardViewState the card view state
 @return The shadow color for the requested state.
 */
- (UIColor *)shadowColorForState:(MDCCardViewState)state;

@end
