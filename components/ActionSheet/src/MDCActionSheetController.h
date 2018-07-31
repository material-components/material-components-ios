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

@class MDCActionSheetAction;

@interface MDCActionSheetController : UIViewController


/**
 Convenience constructor to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @param title The title of the alert.
 @return An initialized MDCActionSheetController object.
 */
+ (nonnull instancetype)actionSheetControllerWithTitle:(nullable NSString *)title;

/**
 Convenience constructor to create and return a view controller for displaying an alert to the user.

 After creating the alert controller, add actions to the controller by calling -addAction.

 @param title The title of the alert.
 @param message Descriptive text that summarizes a decision in a sentence of two.
 @return An initialized MDCActionSheetController object.
 */
+ (nonnull instancetype)actionSheetControllerWithTitle:(nullable NSString *)title
                                               message:(nullable NSString *)message;

/** Action sheet controllers must be created with actionSheetControllerWithTitle: or
 with actionSheetControllerWithTitle:message:  */
- (nonnull instancetype)initWithNibName:(NSString *)nibNameOrNil
                                 bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/** Action sheet controllers must be created with actionSheetControllerwithTitle:
   or with actionSheetControllerWithTitle:message:  */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


/**
 Adds an action to the action sheet.

 Actions are the possible reactions of the user to the presented alert. Actions are added as a
 list item in the list of the action sheet.
 Action buttons will be laid out from right to top to bottom depending on the the order they
 were added, first being top last being bottom.

 @param action Will be added to the end of MDCActionSheetController.actions.
 */
- (void)addAction:(nonnull MDCActionSheetAction *)action;

/**
 The actions that the user can take in response to the action sheet.

 The order of the actions in the array matches the order in which they were added to the action sheet.
 */
@property (nonatomic, nonnull, readonly) NSArray<MDCActionSheetAction *> *actions;

/*
 Indicates whether the button should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIConnectSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its text font on MDCFontTextStyleButton.

 Defaults value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
BOOL mdc_adjustsFontForContentSizeCategory;

/** The color applied to the sheet view of the action sheet controller. */
@property(nonatomic, strong, nullable) UIColor *backgroundColor;

/** The font applied to the title of the action sheet controller. */
@property(nonatomic, strong, nullable) UIFont *titleFont;

/** The font applied to the message of the action sheet controller. */
@property(nonatomic, strong, nullable) UIFont *messageFont;

/** The font applied to the action items of the action sheet controller. */
@property(nonatomic, strong, nullable) UIFont *actionFont;

/** The color applied to the title of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *titleColor;

/** The color applied to the message of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *messageColor;

/** The color applied to the item list labels of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *actionTextColor;

/** The color applied to the image items of Alert Controller.*/
@property(nonatomic, strong, nullable) UIColor *actionImageColor;

@end

/**
 MDCActionHandler is a block that will be invoked when the action is selected.
 */
typedef void (^MDCActionSheetHandler)(MDCActionSheetAction *_Nonnull action);

/**
  MDCActionSheetAction is passed to MDCActionSheetController to add a button to the action sheet.
 */
@interface MDCActionSheetAction : NSObject <NSCopying>


/**
  Action alerts control the list items that will be displayed on the bottom of an action
 sheet controller.

 @param title The title of the list item shown on the list
 @param image The icon of the list item shown on the list
 @param handler A block to execute when the user selects the action.
 @return An initialized MDCActionSheetAction object.
 */
+ (nonnull instancetype)actionWithTitle:(nonnull NSString *)title
                                  image:(nonnull UIImage *)image
                                handler:(__nullable MDCActionSheetHandler)handler;

/** Action sheet actions must be created with actionWithTitle:image:handler: */
- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Title of the cell shown on the action sheet.

 Action sheet actions must have a title that will be set within actionWithTitle:image:handler: method.
 */
@property (nonatomic, nonnull, readonly) NSString *title;

/**
 Image of the cell shown on the action sheet.

 Action sheet actions must have an image that will be set within actionWithTitle:image:handler: method.
*/
@property (nonatomic, nonnull, readonly) UIImage *image;

/**
  Action of the cell shown on the action sheet.

  Action sheet actions must have an action taht will be set within
    actionWithTitle:image:handler: method.
*/
@property (nonatomic, nonnull, readonly) MDCActionSheetHandler action;

@end

@protocol MDCActionSheetControllerDelegate <NSObject>

/**
 Called when the user taps the dimmed background or swipes the action sheet off to dismiss
 the action sheet. This method is not called if the action sheet is dismissed
 programatically.

 @param controller The MDCActionSheetController that was dismissed.
 */
-(void)actionSheetControllerDidDismissActionSheet:(nonnull MDCActionSheetController *)controller;

@end
