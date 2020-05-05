// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCActionSheetAction;

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
@property(nonatomic, nullable) UIImage *image;

/**
 The @c accessibilityIdentifier for the view associated with this action.
 */
@property(nonatomic, nullable, copy) NSString *accessibilityIdentifier;

/**
 The color of the action title.

 @note If no @c titleColor is provided then the @c actionTextColor from the controller will be used.
 */
@property(nonatomic, copy, nullable) UIColor *titleColor;

/**
 The tint color of the action.

 @note If no @c tintColor is provided then the @c actionTintColor from the controller will be used.
 */
@property(nonatomic, copy, nullable) UIColor *tintColor;

/**
 The color of the divider at the top of the action.

 @note Defaults to clear.
 */
@property(nonatomic, copy, nonnull) UIColor *dividerColor;

/**
 Controls whether a divider is shown at the top of the action.

 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL showsDivider;

@end
