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

+ (nonnull instancetype)actionSheetControllerWithTitle:(nullable NSString *)title;

/** Action sheet controllers must be created with alertControllerWithTitle:message: */
- (nonnull instancetype)initWithNibName:(NSString *)nibNameOrNil
                                 bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/** Action sheet controllers must be created with alertControllerWithTitle:message: */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


- (void)addAction:(nonnull MDCActionSheetAction *)action;

/**
 The actions that the user can take in response to the alert.

 The order of the actions in the array matches the order in which they were added to the alert.
 */
@property (nonatomic, nonnull, readonly) NSArray<MDCActionSheetAction *> *actions;

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

-(void)actionSheetControllerDidDismissActionSheet:(nonnull MDCActionSheetController *)controller;

@end
