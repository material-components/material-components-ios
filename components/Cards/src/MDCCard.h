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

@interface MDCCard : UIControl <MDCElevatable, MDCElevationOverriding>

/**
 The corner radius for the card
 Default is set to 4.
 */
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

/**
 The inkView for the card that is initiated on tap
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property(nonatomic, readonly, strong, nonnull) MDCInkView *inkView;
#pragma clang diagnostic pop

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

/**
 By setting this property to YES, you will enable and use inkView's successor rippleView as the
 main view to provide visual feedback for taps. It is recommended to set this property right after
 initializing the card.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 Sets the shadow elevation for an UIControlState state

 @param shadowElevation The shadow elevation
 @param state UIControlState the card state
 */
- (void)setShadowElevation:(MDCShadowElevation)shadowElevation
                  forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setBorderColor:(nullable UIColor *)borderColor
              forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setShadowColor:(nullable UIColor *)shadowColor
              forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Returns the shadow color for an UIControlState state

 If no color has been set for a state, the value for MDCCardViewStateNormal will be returned.
 Default value for UIControlStateNormal is blackColor

 @param state UIControlState the card state
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 A block that is invoked when the @c MDCCard receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCCard *_Nonnull card, UITraitCollection *_Nullable previousTraitCollection);

/*
 The shape generator used to define the card's shape.
 When set, layer properties such as cornerRadius and other layer properties are nullified/zeroed.
 If a layer property is explicitly set after the shapeGenerator has been set, it will lead to
 unexpected behavior.

 When the shapeGenerator is nil, MDCCard will use the default underlying layer with
 its default settings.

 Default value for shapeGenerator is nil.
 */
@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGenerator;

@end
