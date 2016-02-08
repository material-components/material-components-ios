/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

@interface MDCButton : UIButton

/**
 * A color used as the button's |backgroundColor| when the button is enabled.
 */
@property(nonatomic, strong, null_resettable) UIColor *enabledBackgroundColor;

/**
 * A color used as the button's |backgroundColor| when the button is disabled and the
 * |underlyingColor| is a dark color.
 */
@property(nonatomic, strong, null_resettable) UIColor *disabledBackgroundColorLight;

/**
 * A color used as the button's |backgroundColor| when the button is disabled and the
 * |underlyingColor| is a light (or transparent) color.
 */
@property(nonatomic, strong, null_resettable) UIColor *disabledBackgroundColorDark;

/**
 * A custom title color for the non-disabled states. The default is nil, which means that the button
 * chooses its title color automatically based on |underlyingColor|, whether the button is opaque,
 * its current background color, etc.
 *
 * Setting this to a non-nil color overrides that logic, and the caller is responsible for ensuring
 * that the title color/background color combination meets the accessibility requirements.
 */
@property(nonatomic, strong, nullable) UIColor *customTitleColor;

/**
 * The alpha value that will be applied when the button is disabled. Most clients can leave this as
 * the default value to get a semitransparent button automatically.
 */
@property(nonatomic) CGFloat disabledAlpha;

/**
 * Should the button raise when touched?
 *
 * Default is YES. Prefer using the factory methods to configure this based on the button type.
 */
@property(nonatomic) BOOL shouldRaiseOnTouch;

/**
 * Converts the button title to uppercase. Changing this property will not update the current
 * title string.
 *
 * Default is YES and is recommended whenever possible.
 */
@property(nonatomic, getter=isUppercaseTitle) BOOL uppercaseTitle;

/**
 * Allows the button to detect touches outside of its bounds. A negative value indicates an
 * extension past the bounds.
 *
 * Default is UIEdgeInsetsZero.
 */
@property(nonatomic) UIEdgeInsets hitAreaInsets;

/**
 * The underlying color of the button, set by the button's owner.
 *
 * For Flat buttons, this is the color of both the surrounding area and the button's background.
 * For Raised and Floating buttons, this is the color of view underneath the button.
 *
 * The default is nil, but if left unset, Raised/Floating buttons will have possibly-incorrect
 * disabled state, and flat buttons will additionally have incorrect text colors.
 */
@property(nonatomic, strong, nullable) UIColor *underlyingColor;

/**
 * From UIButton's documentation: "If you subclass UIButton, this method does not return an instance
 * of your subclass. If you want to create an instance of a specific subclass, you must alloc/init
 * the button directly."
 */
+ (nonnull instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;

/** Sets the enabled state with optional animation. */
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

/**
 * Returns the elevation for a particular control state.
 *
 * The default value for UIControlStateNormal is 0. The default value for UIControlStateSelected is
 * twice greater than the value of UIControlStateNormal. The default values for all other states is
 * the value of UIControlStateNormal.
 *
 * @param state The control state to retrieve the elevation.
 * @return The elevation for the requested state.
 */
- (CGFloat)elevationForState:(UIControlState)state;

/**
 * Sets the elevation for a particular control state.
 *
 * Use resetElevationForState: to reset the button's behavior to the default for a particular state.
 *
 * @param elevation The elevation to set.
 * @param state The state to set.
 */
- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state;

/**
 * Resets the elevation for a particular control state back to the button's default behavior.
 *
 * @param state The control state to reset the elevation.
 */
- (void)resetElevationForState:(UIControlState)state;

/**
 * Returns the text baseline for a set of button bounds.
 *
 * @param bounds The button bounds. Pass in self.bounds for the current bounds.
 * @return The vertical distance of the baseline from the button's origin.
 */
- (CGFloat)textBaselineForBounds:(CGRect)bounds;

@end
