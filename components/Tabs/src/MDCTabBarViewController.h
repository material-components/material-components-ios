// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTabBar.h"

@protocol MDCTabBarControllerDelegate;

/** The animation duration for the animation tab bar hiding and showing. Defaults to 0.3 seconds. */
extern const CGFloat MDCTabBarViewControllerAnimationDuration;

/**
 The MDCTabBarViewController class manages a set of view controllers, showing their UITabBarItems
 as tappable items in a bottom MDCTabBar. When the user taps one of those items, the corresponding
 view controller appears.
 */
IB_DESIGNABLE
@interface MDCTabBarViewController : UIViewController <MDCTabBarDelegate, UIBarPositioningDelegate>

/** The tab bar controller's delegate. */
@property(nonatomic, weak, nullable) id<MDCTabBarControllerDelegate> delegate;

/**
 The array of view controllers managed by the tab bar controller.
 The currently selected view controller must be one of these.
 */
@property(nonatomic, nonnull, copy) NSArray<UIViewController *> *viewControllers;

/**
 The currently selected view controller. Setting it switches without animation.
 It must be one of the items in the view controllers array.
 */
@property(nonatomic, weak, nullable) UIViewController *selectedViewController;

/**
 The tab bar which allows the user to switch between view controllers.
 You can use this property to set colors but hide it, show it, and select
 items in it using methods of this class.
 */
@property(nonatomic, readonly, nullable) MDCTabBar *tabBar;

/** Use this to show and hide the tab bar. Same as setTabBarHidden:animated:NO */
@property(nonatomic) BOOL tabBarHidden;

/** Use this to show and hide the tab bar. If animated, hides by panning the tab bar down. */
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

/** The delegate protocol for MDCTabBarViewController */
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
