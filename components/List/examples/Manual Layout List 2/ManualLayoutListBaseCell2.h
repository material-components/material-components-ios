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

#import "MaterialShadowElevations.h"

@class MDCInkView;

/**
 The cell can be in a Normal, a Highlighted, or a Selected state.
 The Highlighted and Selected states map to the properties of the UICollectionViewCell that
 share the same names.
 */
typedef NS_ENUM(NSInteger, MDCListBaseCellState) {
  /** The visual state when the cell is in its normal state. */
  MDCListBaseCellStateNormal = 0,

  /** The visual state when the cell is in its highlighted state. */
  MDCListBaseCellStateHighlighted,

  /** The visual state when the cell is in its selected state. */
  MDCListBaseCellStateSelected,
};

@interface ManualLayoutListBaseCell2 : UICollectionViewCell

/**
 Sets the shadow elevation for an UIControlState state

 @param shadowElevation The shadow elevation
 @param state UIControlState the card state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(MDCListBaseCellState)state;

/**
 Returns the shadow elevation for an UIControlState state

 If no elevation has been set for a state, the value for UIControlStateNormal will be returned.
 Default value for UIControlStateNormal is 1
 Default value for UIControlStateHighlighted is 8

 @param state UIControlState the card state
 @return The shadow elevation for the requested state.
 */
- (MDCShadowElevation)shadowElevationForState:(MDCListBaseCellState)state;

/**
 Sets the shadow color for an UIControlState state

 @param shadowColor The shadow color
 @param state UIControlState the card state
 */
- (void)setShadowColor:(nullable UIColor *)shadowColor forState:(MDCListBaseCellState)state;

/**
 Returns the shadow color for an UIControlState state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.
 Default value for UIControlStateNormal is blackColor

 @param state UIControlState the card state
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(MDCListBaseCellState)state;

@end
