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

@class MDCAppBar;
@class MDCAppBarViewController;
@class MDCAppBarNavigationController;

/**
 Defines the events that an MDCAppBarNavigationController may send to a delegate.
 */
@protocol MDCAppBarNavigationControllerDelegate <UINavigationControllerDelegate>
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
 */
- (void)appBarNavigationController:(nonnull MDCAppBarNavigationController *)navigationController
       willAddAppBarViewController:(nonnull MDCAppBarViewController *)appBarViewController
           asChildOfViewController:(nonnull UIViewController *)viewController;

/**
 Asks the receiver to determine the tracking scroll view for a given view controller.

 If this method is not implemented, the app bar navigation controller will extract the first
 UIScrollView instance in the view controller's view hierarchy using a depth-first view traversal.

 Implement this method when you need to change the default behavior of the tracking scroll view
 detection. The suggested tracking scroll view will contain the scroll view that would have been
 used; you can ignore this value.

 Your implementation will likely return the suggested tracking scroll view by default, with custom
 logic being implemented for specific view controllers that require it.

 @param navigationController The app bar navigation controller instance that owns the view
 controller.
 @param viewController The view controller for which the tracking scroll view should be determined.
 @param scrollView A suggested tracking scroll view. This is the first UIScrollView instance
 detected by a depth-first view traversal of @c viewController's view hierarchy. This suggestion
 can be ignored.
 @return The tracking scroll view to be used for this view controller. If nil is returned then no
 tracking scroll view will be set.

 @note This method will only be invoked if a new App Bar instance is about to be added to the view
 controller. If a flexible header is already present in the view controller, this method will not
 be invoked.
 */
- (nullable UIScrollView *)appBarNavigationController:
                               (nonnull MDCAppBarNavigationController *)navigationController
                  trackingScrollViewForViewController:(nonnull UIViewController *)viewController
                          suggestedTrackingScrollView:(nullable UIScrollView *)scrollView;

#pragma mark - Will be deprecated

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

/**
 A custom navigation controller instance that auto-injects App Bar instances into pushed view
 controllers.

 If a pushed view controller already has an App Bar or a Flexible Header then the navigation
 controller will not inject a new App Bar.

 To theme the injected App Bar, implement the delegate's
 -appBarNavigationController:willAddAppBar:asChildOfViewController: API.

 @note If you use the initWithRootViewController: API you will not have been able to provide a
 delegate yet. In this case, use the -appBarForViewController: API to retrieve the injected App Bar
 for your root view controller and execute your delegate logic on the returned result, if any.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCAppBarNavigationController
    : UINavigationController

#pragma mark - Reacting to state changes

/**
 An extension of the UINavigationController's delegate.
 */
@property(nonatomic, weak, nullable) id<MDCAppBarNavigationControllerDelegate> delegate;

#pragma mark - Getting App Bar view controller instances

/**
 Returns the injected App Bar view controller for a given view controller, if an App Bar was
 injected.
 */
- (nullable MDCAppBarViewController *)appBarViewControllerForViewController:
    (nonnull UIViewController *)viewController;

@end

@interface MDCAppBarNavigationController (ToBeDeprecated)

/**
 Returns the injected App Bar for a given view controller, if an App Bar was injected.

 @warning This method will eventually be deprecated. Use -appBarViewControllerForViewController:
 instead. Learn more at
 https://github.com/material-components/material-components-ios/blob/develop/components/AppBar/docs/migration-guide-appbar-appbarviewcontroller.md
 */
- (nullable MDCAppBar *)appBarForViewController:(nonnull UIViewController *)viewController;

@end
