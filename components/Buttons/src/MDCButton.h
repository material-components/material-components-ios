/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialInk.h"

/**
 A Material flat, raised or floating button.

 All buttons display animated ink splashes when the user interacts with the button.

 The title color of the button set to have an accessible contrast ratio with the button's
 background color. To ensure this works for flat buttons (with transparent background), the caller
 is responsible for setting (and updating, if necessary) the button's underlyingColor property.

 All buttons set the exclusiveTouch property to YES by default, which prevents users from
 simultaneously interacting with a button and other UI elements.

 @see https://material.io/guidelines/components/buttons.html
 */
@interface MDCButton : UIButton

/** The ink style of the button. */
@property(nonatomic, assign) MDCInkStyle inkStyle;

/** The ink color of the button. */
@property(nonatomic, strong, null_resettable) UIColor *inkColor;

/*
 Maximum radius of the button's ink. If the radius <= 0 then half the length of the diagonal of
 self.bounds is used. This value is ignored if button's @c inkStyle is set to |MDCInkStyleBounded|.
 */
@property(nonatomic, assign) CGFloat inkMaxRippleRadius;

/**
 The alpha value that will be applied when the button is disabled. Most clients can leave this as
 the default value to get a semi-transparent button automatically.
 */
@property(nonatomic) CGFloat disabledAlpha;

/**
 If true, converts the button title to uppercase. Changing this property to NO will not update the
 current title string.

 Default is YES and is recommended whenever possible.
 */
@property(nonatomic, getter=isUppercaseTitle) BOOL uppercaseTitle;

/**
 Insets to apply to the button’s hit area.

 Allows the button to detect touches outside of its bounds. A negative value indicates an
 extension past the bounds.

 Default is UIEdgeInsetsZero.
 */
@property(nonatomic) UIEdgeInsets hitAreaInsets;

/**
 The apparent background color as seen by the user, i.e. the color of the view behind the button.

 The underlying color hint is used by buttons to calculate accessible title text colors when in
 states with transparent background colors. The hint is used whenever the button changes state such
 that the background color changes, for example, setting the background color or disabling the
 button.

 For flat buttons, this is the color of both the surrounding area and the button's background.
 For raised and floating buttons, this is the color of view underneath the button.

 The default is nil.  If left unset, buttons will likely have an incorrect appearance when
 disabled. Additionally, flat buttons might have text colors with low accessibility.
 */
@property(nonatomic, strong, nullable) UIColor *underlyingColorHint;

/*
 Indicates whether the button should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIConnectSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its text font on MDCFontTextStyleButton.

 Defaults value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 A color used as the button's @c backgroundColor for @c state.

 @param state The state.
 @return The background color.
 */
- (nullable UIColor *)backgroundColorForState:(UIControlState)state;

/**
 A color used as the button's @c backgroundColor.

 If left unset or reset to nil for a given state, then a default blue color is used.

 @param backgroundColor The background color.
 @param state The state.
 */
- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/* Convenience for `setBackgroundColor:backgroundColor forState:UIControlStateNormal`. */
- (void)setBackgroundColor:(nullable UIColor *)backgroundColor;

/** Sets the enabled state with optional animation. */
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

/**
 Returns the elevation for a particular control state.

 The default values depend on the kind of button, for example, flat buttons in the
 UIControlStateNormal state have zero elevation.

 @param state The control state to retrieve the elevation.
 @return The elevation for the requested state.
 */
- (CGFloat)elevationForState:(UIControlState)state;

/**
 Sets the elevation for a particular control state.

 @param elevation The elevation to set.
 @param state The state to set.
 */
- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state;

#pragma mark - UIButton changes

/**
 From UIButton's documentation: "If you subclass UIButton, this method does not return an instance
 of your subclass. If you want to create an instance of a specific subclass, you must alloc/init
 the button directly."
 */
+ (nonnull instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;

#pragma mark - Deprecated

/**
 This property sets/gets the title color for UIControlStateNormal.
 */
@property(nonatomic, strong, nullable) UIColor *customTitleColor UI_APPEARANCE_SELECTOR
    __deprecated_msg("Use setTitleColor:forState: instead");

@property(nonatomic)
    BOOL shouldRaiseOnTouch __deprecated_msg("Use MDCFlatButton instead of shouldRaiseOnTouch = NO")
        ;

@property(nonatomic) BOOL shouldCapitalizeTitle __deprecated_msg("Use uppercaseTitle instead.");

@property(nonatomic, strong, nullable)
    UIColor *underlyingColor __deprecated_msg("Use underlyingColorHint instead.");

@end
