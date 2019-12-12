// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialElevation.h"
#import "MaterialShadowElevations.h"

/**
 Class which provides the default implementation of a Snackbar.
 */
@interface MDCSnackbarMessageView : UIView <MDCElevatable, MDCElevationOverriding>

/**
 The color for the background of the Snackbar message view.

 The default color is a dark gray color.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 The color for the shadow color for the Snackbar message view.

 The default color is @c blackColor.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewShadowColor UI_APPEARANCE_SELECTOR;

/**
 The color for the message text in the Snackbar message view.

 The default color is @c whiteColor.
 */
@property(nonatomic, strong, nullable) UIColor *messageTextColor UI_APPEARANCE_SELECTOR;

/**
 The font for the message text in the Snackbar message view.
 */
@property(nonatomic, strong, nullable) UIFont *messageFont UI_APPEARANCE_SELECTOR;

/**
 The font for the button text in the Snackbar message view.
 */
@property(nonatomic, strong, nullable) UIFont *buttonFont UI_APPEARANCE_SELECTOR;

/**
 The array of action buttons of the snackbar.
 */
@property(nonatomic, strong, nullable) NSMutableArray<MDCButton *> *actionButtons;

/**
 The elevation of the snackbar view.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 The @c accessibilityLabel to apply to the message of the Snackbar.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityLabel;

/**
 The @c accessibilityHint to apply to the message of the Snackbar.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityHint;

/**
 Returns the button title color for a particular control state.

 Default for UIControlStateNormal is MDCRGBAColor(0xFF, 0xFF, 0xFF, (CGFloat)0.6).
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
- (void)setButtonTitleColor:(nullable UIColor *)titleColor
                   forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 Indicates whether the Snackbar should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its message font on MDCFontTextStyleBody2
 and its button font on MDCFontTextStyleButton.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 Affects the fallback behavior for when a scaled font is not provided.

 If enabled, the font size will adjust even if a scaled font has not been provided for
 a given UIFont property on this component.

 If disabled, the font size will only be adjusted if a scaled font has been provided.
 This behavior most closely matches UIKit's.

 Default value is YES.
 */
@property(nonatomic, assign)
    BOOL adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable __deprecated_msg(
        "Use UIFontMetrics and UIContentSizeCategoryAdjusting on iOS 11+ or MDCFontScaler on "
        "earlier versions");

/**
 A block that is invoked when the MDCSnackbarMessageView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCSnackbarMessageView *_Nonnull messageView,
     UITraitCollection *_Nullable previousTraitCollection);

@end
