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

@interface MDCAlertControllerView : UIView

@property(nonatomic, strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *titleColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong, nullable) UIImage *titleIcon;
@property(nonatomic, strong, nullable) UIColor *titleIconTintColor;

@property(nonatomic, strong, nullable) UIFont *messageFont UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *messageColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, assign) CGFloat cornerRadius;

/*
 Indicates whether the view's contents should automatically update their font when the device’s
 @c UIContentSizeCategory changes.

 This property is modeled after @c adjustsFontForContentSizeCategory property in
 @c UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.

 Defaults to @c NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

#pragma mark - Adjustable Insets

/**
 The edge insets around the title icon or title icon view against the dialog edges (top, leading,
 trailing) and the title (bottom). Note that `titleIconInsets.bottom` takes precedence over
 `titleInsets.top`.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 12, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleIconInsets;

/**
 The edge insets around the title against the dialog edges or its neighbor elements. Note that
 `titleInsets.bottom` takes precedence over `contentInsets.top`.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 20, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets titleInsets;

/**
 The edge insets around the content view (which includes the message, and the accessory view if it
 is set) against the dialog edges or its neighbor elements, the title and the actions.

 Default value is UIEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24).
 */
@property(nonatomic, assign) UIEdgeInsets contentInsets;

/**
 The edge insets around the actions against the dialog edges and its neighbor, which could be any of
 the other elements: the message, accessory view, title, title icon or title icon view.

 The action insets are taken based on the visible area of the button, not its frame.
 Since the default size of the alert buttons do not meet minimum touch area requirement,
 the buttons frame are larger than the visible area, allowing for a large enough touch area.

 Default value is UIEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8).
 */
@property(nonatomic, assign) UIEdgeInsets actionsInsets;

/**
 The horizontal space between the action buttons when the buttons are horizontally aligned, and if
 more than one button is presented.

 Default value is 8.
 */
@property(nonatomic, assign) CGFloat actionsHorizontalMargin;

/**
 The vertical space between the action buttons when the buttons are vertically aligned, and if more
 than one button is presented.

 The action buttons represent the visible areas of the buttons, it can differ from the frame when
 the button doesn't meet the minimum touch area requirement and its frame is adjusted to be larger
 then its visible area.

 Default value is 12.
 */
@property(nonatomic, assign) CGFloat actionsVerticalMargin;

/**
 The vertical inset between the accessory view and the message, if both are present.

 Default value is 20.
 */
@property(nonatomic, assign) CGFloat accessoryViewVerticalInset;

/**
The horizontal inset that sets the leading and trailing margins of the accessory view. The accessory
insets are added to the contentInsets.leading and contentInsets.trailing values when calculating the
leading and trailing margins of the accessory view.

@note: Unlike the content's horizontal insets, the accessory insets use a single value for both
       leading and trailing edge, while the final margins are calculated using both the content and
       the accessory insets.

@note: You may use a negative `accessoryViewHorizontalInset` value in order to to decreases the
       leading and trailing margins of the accessory view.

Default value is 0 (meaning, the accessory view's horizontal insets are determined soley by the
                    horizontal contentInsets values).
*/
@property(nonatomic, assign) CGFloat accessoryViewHorizontalInset;

@end

@interface MDCAlertControllerView (ToBeDeprecated)

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink to display
 visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part of
 our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

@end

@interface MDCAlertControllerView (Deprecated)

@property(nonatomic, strong, nullable) UIColor *buttonColor UI_APPEARANCE_SELECTOR __deprecated_msg(
    "Use MDCAlertController's buttonForAction API");
@property(nonatomic, strong, nullable)
    UIColor *buttonInkColor UI_APPEARANCE_SELECTOR __deprecated_msg(
        "Use MDCAlertController's buttonForAction API");
@end
