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

#import <MaterialComponents/MaterialBottomNavigation.h>

@protocol MDCBottomNavigationBarControllerDelegate;

/**
 * MDCBottomNavigationBarController is a class that manages the navigation bar that allows movement
 * between primary destination in an app.  It ties a list of view controllers to the bottom
 * navigation bar and will display the corresponding view controller in the content view when an
 * in the navigation bar is selected.
 * Available iOS 9.0+
 */
NS_CLASS_AVAILABLE_IOS(9_0)
@interface MDCBottomNavigationBarController : UIViewController <MDCBottomNavigationBarDelegate>

/**
 * The bottom navigation bar that hosts the tab bar items.
 * @warning This controller sets itself as the navigation bar's delegate.  If you would like to
 * observe changes to the navigation bar, conform to @c MDCBottomNavigationBarControllerDelegate
 * and set the delegate property of this controller.
 */
@property(nonatomic, strong, readonly, nonnull) MDCBottomNavigationBar *navigationBar;

/**
 * An array of view controllers to display when their corresponding tab bar item is selected in the
 * navigation bar.  When this property is set, the navigation bar's @c items property will be set to
 * an array composed of the @c tabBarItem property of each view controller in this array.
 * @see UIViewController#tabBarItem
 */
@property(nonatomic, copy, nonnull) NSArray<__kindof UIViewController *> *viewControllers;

/**
 * The delegate to observe changes to the navigationBar.
 */
@property(nonatomic, weak, nullable) id<MDCBottomNavigationBarControllerDelegate> delegate;

/**
 * The current selected view controller.  When setting this property, the view controller must
 * be in @c viewControllers .
 */
@property(nonatomic, assign, nullable) __kindof UIViewController *selectedViewController;

/**
 * The index of the current selected tab item.  When setting this property the value must be in
 * bounds of @c viewcontrollers .
 * If no tab item is selected it will be set to NSNotFound.
 */
@property(nonatomic) NSUInteger selectedIndex;

- (void)viewDidLoad NS_REQUIRES_SUPER;

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item NS_REQUIRES_SUPER;

@end

/**
 * The protocol for clients of the MDCBottomNavigationBarController to conform to for updates on the
 * bottom navigation bar, manage selection, and other possible actions.
 */
@protocol MDCBottomNavigationBarControllerDelegate <NSObject>
@optional
/**
 * Called when the user makes a selection in the bottom navigation bar.
 * @warning This method is not called when the selection is set programmatically.
 */
- (void)bottomNavigationBarController:
            (nonnull MDCBottomNavigationBarController *)bottomNavigationBarController
              didSelectViewController:(nonnull UIViewController *)viewController;

/**
 * Delegates may implement this method if they wish to determine if the bottom navigation controller
 * should select an item.  If true is returned, the selection will continue as normal.  If false,
 * selection will not proceed.
 * @warning This method is called in response to user action, not programmatically setting the
 * selection.
 */
- (BOOL)bottomNavigationBarController:
            (nonnull MDCBottomNavigationBarController *)bottomNavigationBarController
           shouldSelectViewController:(nonnull UIViewController *)viewController;

@end
