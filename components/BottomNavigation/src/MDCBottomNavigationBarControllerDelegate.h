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

@class MDCBottomNavigationBarController;

/**
 The protocol for clients of the MDCBottomNavigationBarController to conform to for updates on the
 bottom navigation bar, manage selection, and other possible actions.
 */
@protocol MDCBottomNavigationBarControllerDelegate <NSObject>
@optional
/**
 Called when the user makes a selection in the bottom navigation bar.
 @warning This method is not called when the selection is set programmatically.
 */
- (void)bottomNavigationBarController:
            (nonnull MDCBottomNavigationBarController *)bottomNavigationBarController
              didSelectViewController:(nonnull UIViewController *)viewController;

/**
 Delegates may implement this method if they wish to determine if the bottom navigation controller
 should select an item.  If true is returned, the selection will continue as normal. If false,
 selection will not proceed.
 @warning This method is called in response to user action, not programmatically setting the
 selection.
 */
- (BOOL)bottomNavigationBarController:
            (nonnull MDCBottomNavigationBarController *)bottomNavigationBarController
           shouldSelectViewController:(nonnull UIViewController *)viewController;

@end
