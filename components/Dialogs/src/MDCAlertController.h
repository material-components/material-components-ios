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

@class MDCAlertAction;

/**
 MDCAlertController displays an alert message to the user, similar to UIAlertController.

 https://material.io/go/design-dialogs

 MDCAlertController class is intended to be used as-is and does not support subclassing. The view
 hierarchy for this class is private and must not be modified.
 */
@interface MDCAlertController : UIViewController

/**
 Convenience constructor to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @note Most alerts don't need titles. Use only for high-risk situations.

 @param title The title of the alert.
 @param message Descriptive text that summarizes a decision in a sentence of two.
 @return An initialized MDCAlertController object.
 */
+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)title
                                         message:(nullable NSString *)message;

/** Alert controllers must be created with alertControllerWithTitle:message: */
- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/** Alert controllers must be created with alertControllerWithTitle:message: */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Adds an action to the alert dialog.

 Actions are the possible reactions of the user to the presented alert. Actions are added as a
 button at the bottom of the alert. Affirmative actions should be added before dismissive actions.
 Action buttons will be laid out from right to left if possible or top to bottom depending on space.

 Material spec recommends alerts should not have more than two actions.

 @param action Will be added to the end of MDCAlertController.actions.
 */
- (void)addAction:(nonnull MDCAlertAction *)action;

/**
 The actions that the user can take in response to the alert.

 The order of the actions in the array matches the order in which they were added to the alert.
 */
@property(nonatomic, nonnull, readonly) NSArray<MDCAlertAction *> *actions;

/** The font applied to the title of Alert Controller.*/
@property(nonatomic, strong, nullable) UIFont *titleFont;

/** The color applied to the title of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *titleColor;

/** The font applied to the message of Alert Controller.*/
@property(nonatomic, strong, nullable) UIFont *messageFont;

/** The color applied to the message of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *messageColor;

/** The font applied to the button of Alert Controller.*/
@property(nonatomic, strong, nullable) UIFont *buttonFont;

/** The color applied to the button title text of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *buttonTitleColor;

/** The color applied to the button ink effect of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *buttonInkColor;

// TODO(iangordon): Add support for preferredAction to match UIAlertController.
// TODO(iangordon): Consider adding support for UITextFields to match UIAlertController.

/**
 High level description of the alert or decision being made.

 Use title only for high-risk situations, such as the potential loss of connectivity. If used,
 users should be able to understand the choices based on the title and button text alone.
 */
@property(nonatomic, nullable, copy) NSString *title;

/** Descriptive text that summarizes a decision in a sentence of two. */
@property(nonatomic, nullable, copy) NSString *message;

/*
 Indicates whether the alert contents should automatically update their font when the device’s
 UIContentSizeCategory changes.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/** MDCAlertController handles its own transitioning delegate. */
- (void)setTransitioningDelegate:
        (_Nullable id<UIViewControllerTransitioningDelegate>)transitioningDelegate NS_UNAVAILABLE;

/** MDCAlertController.modalPresentationStyle is always UIModalPresentationCustom. */
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle NS_UNAVAILABLE;

@end

/**
 MDCActionHandler is a block that will be invoked when the action is selected.
 */
typedef void (^MDCActionHandler)(MDCAlertAction *_Nonnull action);

/**
 MDCAlertAction is passed to an MDCAlertController to add a button to the alert dialog.
 */
@interface MDCAlertAction : NSObject <NSCopying, UIAccessibilityIdentification>

/**
 Action alerts control the buttons that will be displayed on the bottom of an alert controller.

 @param title The title of the button shown on the alert dialog.
 @param handler A block to execute when the user selects the action.
 @return An initialized MDCActionAlert object.
 */
+ (nonnull instancetype)actionWithTitle:(nonnull NSString *)title
                                handler:(__nullable MDCActionHandler)handler;

/** Alert actions must be created with actionWithTitle:handler: */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Title of the button shown on the alert dialog.

 Alert actions titles must be set in the actionWithTitle:handler: method.
 */
@property(nonatomic, nullable, readonly) NSString *title;

// TODO(iangordon): Add support for enabled property to match UIAlertAction

/**
 The @c accessibilityIdentifier for the view associated with this action.
 */
@property(nonatomic, nullable, copy) NSString *accessibilityIdentifier;

@end
