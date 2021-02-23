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
@protocol MDCBottomNavigationBarDelegate;

/**
 MDCBottomNavigationBarController is a class that manages the navigation bar that allows movement
 between primary destination in an app.  It ties a list of view controllers to the bottom
 navigation bar and will display the corresponding view controller in the content view when an
 in the navigation bar is selected.

 State Restoration:
 To enable state restoration assign a unique restoration identifier to any children view
 controllers that can be restored and implement the children's methods
 @c encodeWithRestorableStateWithCoder: and @c decodeRestorableStateWithCoder if needed. At
 startup set the @c viewControllers property. UIKit will restore the contents of each child view
 controller with encoded values corresponding with the child's restoration identifier. If a child
 view controller's restoration identifier is not set, its state will not be restored on the next
 application launch.
 A reference to the selected view controller is encoded when the state of this view controller is
 preserved. Upon decoding, if the view controllers array contains a reference to the previous
 selected view controller, that view controller is set to selected.
 */
API_AVAILABLE(ios(12.0))
@interface MDCBottomNavigationBarController : UIViewController <MDCBottomNavigationBarDelegate>

/**
 The bottom navigation bar that hosts the tab bar items.
 @warning This controller sets itself as the navigation bar's delegate.  If you would like to
 observe changes to the navigation bar, conform to @c MDCBottomNavigationBarControllerDelegate
 and set the delegate property of this controller.
 */
@property(nonatomic, strong, readonly, nonnull) MDCBottomNavigationBar *navigationBar;

/**
 An array of view controllers to display when their corresponding tab bar item is selected in the
 navigation bar.  When this property is set, the navigation bar's @c items property will be set to
 an array composed of the @c tabBarItem property of each view controller in this array.
 @see UIViewController#tabBarItem
 */
@property(nonatomic, copy, nonnull) NSArray<__kindof UIViewController *> *viewControllers;

/** The delegate to observe changes to the navigationBar. */
@property(nonatomic, weak, nullable) id<MDCBottomNavigationBarControllerDelegate> delegate;

/**
 The current selected view controller.  When setting this property, the view controller must be in
 @c viewControllers.
 */
@property(nonatomic, assign, nullable) __kindof UIViewController *selectedViewController;

/**
 The index of the current selected tab item.  When setting this property the value must be in bounds
 of @c viewcontrollers. If no tab item is selected it will be set to NSNotFound.
 */
@property(nonatomic) NSUInteger selectedIndex;

/**
 If enabled and the user has selected a @c UIContentSizeCategory of @c .AccessibilityMedium or
 larger, then when the user long-pressed on a tab item a view will be presented with a larger
 version of the image and title.
 */
@property(nonatomic, getter=isLongPressPopUpViewEnabled) BOOL longPressPopUpViewEnabled;

/**
 A Boolean value that determines whether @c navigationBar is hidden.
 */
@property(nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;

/**
 Shows or hides @c navigationBar with optional animation.

 @param hidden Whether @c navigationBar should be hidden.
 @param animated Whether the transition should be animated.
 */
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)viewDidLoad NS_REQUIRES_SUPER;

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item NS_REQUIRES_SUPER;

@end
