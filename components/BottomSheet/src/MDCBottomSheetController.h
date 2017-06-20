/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

@protocol MDCBottomSheetControllerDelegate;

@interface MDCBottomSheetController : UIViewController

- (nonnull instancetype)initWithContentViewController:(nonnull UIViewController *)contentViewController
    NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

@property(nonatomic, readonly, nonnull) UIViewController *contentViewController;

@property(nonatomic, weak, nullable) id<MDCBottomSheetControllerDelegate> delegate;

@end

@protocol MDCBottomSheetControllerDelegate <NSObject>

- (void)bottomSheetControllerDidCancel:(nonnull MDCBottomSheetController *)controller;

@end
