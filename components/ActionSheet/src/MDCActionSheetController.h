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

#import <MaterialComponents/MaterialBottomSheet.h>

@class MDCActionSheetAction;

/**
 MDCActionSheetController displays an alert message to the user, similar to
 UIAlertControllerStyleActionSheet.

 A Material Action Sheet consists of a title, message and a list of actions.

 The [Material Guidelines article for Bottom
 Sheets](https://material.io/design/components/sheets-bottom.html) and the
 [Material Guidelines article for Lists](https://material.io/design/components/lists.html) have more
 detailed guidance about how to style and use Action Sheets.

 To learn more about
 [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
 or
 [UIAlertControllerStyleActionSheet](https://developer.apple.com/documentation/uikit/uialertcontrollerstyle/uialertcontrollerstyleactionsheet)

 MDCActionSheetController does not support UIPopoverController, instead it will always be presented
 in a sheet from the bottom.

 */
__attribute__((objc_subclassing_restricted)) @interface MDCActionSheetController : UIViewController

/**
 Designated initializer to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @param title The title of the alert.
 @param message Descriptive text that summarizes a decision in a sentence or two.
 @return An initialized MDCActionSheetController object.
 */
+ (nonnull instancetype)actionSheetControllerWithTitle:(nullable NSString *)title
                                               message:(nullable NSString *)message;

/**
 Convenience initializer to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -
 addAction.

 @param title The title of the alert.
 @return An initialized MDCActionSheetController object.
 */
+ (nonnull instancetype)actionSheetControllerWithTitle:(nullable NSString *)title;

/**
 Action sheet controllers must be created with actionSheetControllerWithTitle: or
 with actionSheetControllerWithTitle:message:
 */
- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/**
 Action sheet controllers must be created with actionSheetControllerwithTitle:
 or with actionSheetControllerWithTitle:message:
 */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Adds an action to the action sheet.

 Actions are the possible reactions of the user to the presented alert. Actions
 are added as a list item in the list of the action sheet.
 Action buttons will be laid out from top to bottom depending on the order they
 were added.

 @param action Will be added to the end of MDCActionSheetController.actions.
 */
- (void)addAction:(nonnull MDCActionSheetAction *)action;

/**
 The actions that the user can take in response to the action sheet.

 The order of the actions in the array matches the order in which they were added
 to the action sheet.
 */
@property(nonatomic, nonnull, readonly, copy) NSArray<MDCActionSheetAction *> *actions;

/**
 The title of the action sheet controller.

 If this is updated after presentation the view will be updated to match the
 new value.
 */
@property(nonatomic, nullable, copy) NSString *title;

/**
 The message of the action sheet controller.

 If this is updated after presentation the view will be updated to match the new value.
 */
@property(nonatomic, nullable, copy) NSString *message;

/**
 Indicates whether the button should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its text font on MDCFontTextStyleButton.

 Defaults value is NO.
 */
@property(nonatomic, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory;

/**
  The font applied to the title of the action sheet controller.
 */
@property(nonatomic, nonnull, strong) UIFont *titleFont;

/**
  The font applied to the message of the action sheet controller.
 */
@property(nonatomic, nonnull, strong) UIFont *messageFont;

/**
   The font applied to the action items of the action sheet controller.
 */
@property(nonatomic, nullable, strong) UIFont *actionFont;

/**
 The color applied to the sheet view of the action sheet controller.
 */
@property(nonatomic, nonnull, strong) UIColor *backgroundColor;

/**
 The color applied to the title of the action sheet controller.

 @note If only using a title and the actions have no icons make sure they are different colors so
 there is a distinction between the title and actions.
 */
@property(nonatomic, strong, nullable) UIColor *titleTextColor;

/**
 The color applied to the message of the action sheet controller.

 @note To make for a better user experience we recommend using a different color for the message and
 actions if there are no icons so there is a distinction between the message and actions.
 */
@property(nonatomic, strong, nullable) UIColor *messageTextColor;

/**
 The color for the text for all action items within an action sheet.
 */
@property(nonatomic, strong, nullable) UIColor *actionTextColor;

/**
 The tint color for the action items within an action sheet.
 */
@property(nonatomic, strong, nullable) UIColor *actionTintColor;

/**
 The ink color for the action items within an action sheet.
 */
@property(nonatomic, strong, nullable) UIColor *inkColor;

/**
 The image rendering mode for all actions within an action sheet.
 */
@property(nonatomic) UIImageRenderingMode imageRenderingMode;

@property(nonatomic, strong, readonly, nonnull)
    MDCBottomSheetTransitionController *transitionController;

- (void)setTransitioningDelegate:
    (nullable id<UIViewControllerTransitioningDelegate>)transitioningDelegate NS_UNAVAILABLE;

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle NS_UNAVAILABLE;

@end

/**
 MDCActionSheetActionHandler is a block that will be invoked when the action is
 selected.
 */
typedef void (^MDCActionSheetHandler)(MDCActionSheetAction *_Nonnull action);

/**
 An instance of MDCActionSheetAction is passed to MDCActionSheetController to
 add an action to the action sheet.
 */
@interface MDCActionSheetAction : NSObject <NSCopying, UIAccessibilityIdentification>

/**
 Returns an action sheet action with the populated given values.

 @param title The title of the list item shown in the list
 @param image The icon of the list item shown in the list
 @param handler A block to execute when the user selects the action.
 @return An initialized MDCActionSheetAction object.
 */
+ (nonnull instancetype)actionWithTitle:(nonnull NSString *)title
                                  image:(nullable UIImage *)image
                                handler:(__nullable MDCActionSheetHandler)handler;

/**
 Action sheet actions must be created with actionWithTitle:image:handler:
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Title of the list item shown on the action sheet.

 Action sheet actions must have a title that will be set within actionWithTitle:image:handler:
 method.
 */
@property(nonatomic, nonnull, readonly) NSString *title;

/**
 Image of the list item shown on the action sheet.

 Action sheet actions must have an image that will be set within actionWithTitle:image:handler:
 method.
*/
@property(nonatomic, nullable, readonly) UIImage *image;

/**
 The @c accessibilityIdentifier for the view associated with this action.
 */
@property(nonatomic, nullable, copy) NSString *accessibilityIdentifier;

@end
