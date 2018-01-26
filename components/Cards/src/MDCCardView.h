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

  /** The visual state when the card is pressed (i.e. dragging). */
  MDCCardViewStateHighlighted
};

@interface MDCCardView : UIView

/**
 The corner radius for the card
 */
@property(nonatomic, assign) CGFloat cornerRadius;

/**
 The shadow elevation for the card
 */
@property(nonatomic, assign) CGFloat shadowElevation;

/**
 The resting (default) state shadow elevation for the card
 */
@property(nonatomic, assign) CGFloat restingShadowElevation;

/**
 The pressed/dragged state shadow elevation for the card
 */
@property(nonatomic, assign) CGFloat pressedShadowElevation;

/**
 The inkView for the card that is initiated on tap
 */
@property(nonatomic, readonly, strong, nullable) MDCInkView *inkView;

/**
 Sets the style for the MDCCardView based on the defined state. Please see the MDCCardViewState
 definition above to see all the possible states.

 @param state MDCCardViewState this defines the state in which the card should visually be set to
 @param location CGPoint some states may need the touch location to begin/end the ink from
 */
- (void)styleForState:(MDCCardViewState)state withLocation:(CGPoint)location;

@end
