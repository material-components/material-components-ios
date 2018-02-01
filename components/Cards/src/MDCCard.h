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

@interface MDCCard : UIControl

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
 Sets the shadow elevation for an UIControlState state

 @param shadowElevation The shadow elevation
 @param state UIControlState the card state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow elevation for an UIControlState state

 If no elevation has been set for a state, the value for UIControlStateNormal will be returned.
 Default value for UIControlStateNormal is 1
 Default value for UIControlStateHighlighted is 8

 @param state UIControlState the card state
 @return The shadow elevation for the requested state.
 */
- (MDCShadowElevation)shadowElevationForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the border width for an UIControlState state

 @param borderWidth The border width
 @param state UIControlState the card state
 */
- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the border width for an UIControlState state

 If no border width has been set for a state, the value for UIControlStateNormal will be returned.
 Default value for UIControlStateNormal is 0

 @param state UIControlState the card state
 @return The border width for the requested state.
 */
- (CGFloat)borderWidthForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the border color for an UIControlState state

 @param borderColor The border color
 @param state UIControlState the card state
 */
- (void)setBorderColor:(nullable UIColor *)borderColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the border color for an UIControlState state

 If no border color has been set for a state, it will check the value of UIControlStateNormal.
 If that value also isn't set, then nil will be returned.

 @param state UIControlState the card state
 @return The border color for the requested state.
 */
- (nullable UIColor *)borderColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the shadow color for an UIControlState state

 @param shadowColor The shadow color
 @param state UIControlState the card state
 */
- (void)setShadowColor:(nullable UIColor *)shadowColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow color for an UIControlState state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.
 Default value for UIControlStateNormal is blackColor

 @param state UIControlState the card state
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
