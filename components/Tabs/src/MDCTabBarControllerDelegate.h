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

@class MDCTabBarViewController;

@protocol MDCTabBarControllerDelegate <NSObject>
@optional

/**
 Called when the user taps on a tab bar item. Not called for programmatic selection.

 If you provide this method, you can control whether tapping on a tab bar item actually
 switches to that viewController. If not provided, MDCTabBarViewController will always switch.

 @note The tab bar controller will call this method even when the tapped tab bar
 item is the currently-selected tab bar item.

 You can also use this method as a willSelectViewController.
 */
- (BOOL)tabBarController:(nonnull MDCTabBarViewController *)tabBarController
    shouldSelectViewController:(nonnull UIViewController *)viewController;

/**
 Called when the user taps on a tab bar item. Not called for programmatic selection.
 MDCTabBarViewController will call your delegate once it has responded to the user's tap
 by changing the selected view controller.

 @note The tab bar controller will call this method even when the tapped tab bar
 item is the currently-selected tab bar item.
 */
- (void)tabBarController:(nonnull MDCTabBarViewController *)tabBarController
    didSelectViewController:(nonnull UIViewController *)viewController;

@end
