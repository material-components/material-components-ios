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

// TODO(b/238930139): Remove usage of this deprecated API.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
/**
 Class which provides the default implementation of a Snackbar.
 */
@interface MDCSnackbarMessageView : UIView <MDCElevatable, MDCElevationOverriding>
#pragma clang diagnostic pop

/**
 The color for the background of the Snackbar message view.

 The default color is a dark gray color.

 If you are using the GM3 branding API, customize the background color by setting this property
 after calling the branding API.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 The color for the background of the Snackbar message view when highlighted.

 The default color is nil (no change on highlight).

 If you are using the GM3 branding API, customize the highlight color by setting this property
 after calling the branding API.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewHighlightColor UI_APPEARANCE_SELECTOR;

/**
 The color for the shadow color for the Snackbar message view.

 The default color is @c blackColor.
 */
@property(nonatomic, strong, nullable)
    UIColor *snackbarMessageViewShadowColor UI_APPEARANCE_SELECTOR;

/**
 The color for the message text in the Snackbar message view.

 The default color is @c whiteColor.

 If you are using the GM3 branding API, customize the message text color by setting this property
 after calling the branding API.
 */
@property(nonatomic, strong, nullable) UIColor *messageTextColor UI_APPEARANCE_SELECTOR;

/**
 The font for the message text in the Snackbar message view.

 If you are using the GM3 branding API, customize the message font by setting this property after
 calling the branding API.
 */
@property(nonatomic, strong, nullable) UIFont *messageFont UI_APPEARANCE_SELECTOR;

/**
 The font for the button text in the Snackbar message view.

 If you are using the GM3 branding API, customize the button font by setting this property after
 calling the branding API.
 */
@property(nonatomic, strong, nullable) UIFont *buttonFont UI_APPEARANCE_SELECTOR;

/**
 The action button for the snackbar, if `message.action` is set.
 */
@property(nonatomic, strong, nullable) UIButton *actionButton;

/**
 The elevation of the snackbar view.

 If `MDCSnackbarManager.usesGM3Shapes` is true, this property defaults to
 MDCShadowElevationNone.

 If you are using the GM3 branding API, customize the elevation by configuring it after calling the
 branding API. See go/material-ios-elevation for details on how to do so.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 The corner radius of the snackbar view.

 If you are using the GM3 branding API, customize the corner radius by setting this property after
 calling the branding API.
 */
@property(nonatomic, assign) CGFloat cornerRadius;

/**
 The @c accessibilityLabel to apply to the message of the Snackbar.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityLabel;

/**
 The @c accessibilityHint to apply to the message of the Snackbar.
 */
@property(nullable, nonatomic, copy) NSString *accessibilityHint;

/**
 The @c minimumLayoutHeight to use when laying out the Snackbar such that there
 will be enough space to layout text at the current text size.
 */
@property(nonatomic, readonly) CGFloat minimumLayoutHeight;

/**
 Enable a hidden touch affordance (button) for users to dismiss under VoiceOver.

 It allows users to dismiss the snackbar in an explicit way. When it is enabled,
 tapping on the message label won't dismiss the snackbar.

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableDismissalAccessibilityAffordance;

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

 If you are using the GM3 branding API, customize the button title color by
 setting this value after calling the branding API.

 @param titleColor The title color.
 @param state The control state.
 */
- (void)setButtonTitleColor:(nullable UIColor *)titleColor
                   forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/**
 A block that is invoked when the MDCSnackbarMessageView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCSnackbarMessageView *_Nonnull messageView,
     UITraitCollection *_Nullable previousTraitCollection);

@end
