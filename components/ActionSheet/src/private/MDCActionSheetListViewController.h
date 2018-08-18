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
#import "../MDCActionSheetController.h"
#import "MDCActionSheetItemView.h"

@interface MDCActionSheetListViewController : UITableViewController

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                              actions:(NSArray<MDCActionSheetAction *> *)actions;

/**
 MDCActionSheetListViewController must be created with initWithActions:
*/
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 MDCActionSheetListViewController must be created with initWithActions:
*/
- (nonnull instancetype)initWithNibName:(NSString *)nibNameOrNil
                                 bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/**
 MDCActionSheetListViewController must be created with initWithActions:
*/
- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;

/**
 Adds an action to the table view.

 @param action Will be added to the table view.
*/
- (void)addAction:(nonnull MDCActionSheetAction *)action;

/**
 The actions that the table will display
*/
@property(nonatomic, readwrite, strong) NSMutableArray<MDCActionSheetAction *> *actions;

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

@property (nonatomic, nonnull, strong) UIFont *actionsFont;

@property (nonatomic, nonnull, strong) UIColor *backgroundColor;

- (void)updateFonts;

- (CGFloat)tableHeightForWidth:(CGFloat)width;

@end
