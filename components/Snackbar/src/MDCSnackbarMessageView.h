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

#import <UIKit/UIKit.h>

/**
 Class which provides the default implementation of a snackbar.
 */
@interface MDCSnackbarMessageView : UIView

/**
 The color for the background of the snackbar message view.

 The default color is a dark gray color.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 The color for the shadow color for the snackbar message view.

 The default color is @c blackColor.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewShadowColor UI_APPEARANCE_SELECTOR;

/**
 The color for the message text in the snackbar message view.

 The default color is @c whiteColor.
 */
@property(nonatomic, strong, nullable) UIColor *messageTextColor UI_APPEARANCE_SELECTOR;

/**
 The font for the message text in the snackbar message view.
 */
@property(nonatomic, strong, nullable) UIFont *messageFont UI_APPEARANCE_SELECTOR;

/**
 The font for the button text in the snackbar message view.
 */
@property(nonatomic, strong, nullable) UIFont *buttonFont UI_APPEARANCE_SELECTOR;

/**
 Returns the button title color for a particular control state.

 Default for UIControlStateNormal is MDCRGBAColor(0xFF, 0xFF, 0xFF, 0.6f).
 Default for UIControlStatehighlighted is white.

 @param state The control state.
 @return The button title color for the requested state.
 */
- (nullable UIColor *)buttonTitleColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Sets the button title color for a particular control state.

 @param titleColor The title color.
 @param state The control state.
 */
- (void)setButtonTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state
UI_APPEARANCE_SELECTOR;


/**
 Indicates whether the snackbar should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its message font on MDCFontTextStyleBody2
 and its button font on MDCFontTextStyleButton.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

@end

// clang-format off
@interface MDCSnackbarMessageView ()

/** @see messsageTextColor */
@property(nonatomic, strong, nullable) UIColor *snackbarMessageViewTextColor UI_APPEARANCE_SELECTOR
__deprecated_msg("Use messsageTextColor instead.");

@end
// clang-format on
