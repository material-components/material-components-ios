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

@class MDCAppBar;
@class MDCAppBarNavigationController;

/**
 Defines delegate methods that will be deprecated.
 */
@protocol MDCAppBarNavigationControllerToBeDeprecatedDelegate <NSObject>
@optional

/**
 Informs the receiver that the given App Bar will be added as a child of the given view controller.

 This event is primarily intended to allow any configuration or theming of the App Bar to occur
 before it becomes part of the view controller hierarchy.

 By the time this event has fired, the navigation controller will already have attempted to infer
 the tracking scroll view from the provided view controller.

 @note This method will only be invoked if a new App Bar instance is about to be added to the view
 controller. If a flexible header is already present in the view controller, this method will not
 be invoked.

 @warning This method will soon be deprecated. Please use
 -appBarNavigationController:willAddAppBarViewController:asChildOfViewController: instead. Learn
 more at
 https://github.com/material-components/material-components-ios/blob/develop/components/AppBar/docs/migration-guide-appbar-appbarviewcontroller.md
 */
- (void)appBarNavigationController:(nonnull MDCAppBarNavigationController *)navigationController
                     willAddAppBar:(nonnull MDCAppBar *)appBar
           asChildOfViewController:(nonnull UIViewController *)viewController;

@end
