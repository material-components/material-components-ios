// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialFlexibleHeader.h"
#import "MaterialHeaderStackView.h"
#import "MaterialNavigationBar.h"

@class MDCAppBarViewController;
@protocol MDCAppBarViewControllerAccessibilityPerformEscapeDelegate;

/**
 MDCAppBarViewController is a flexible header view controller that manages a navigation bar and
 header stack view in order to provide the Material Top App Bar user interface.
 */
API_UNAVAILABLE(tvos, watchos)
@interface MDCAppBarViewController : MDCFlexibleHeaderViewController

/**
 The navigation bar often represents the information stored in a view controller's navigationItem
 property, but it can also be directly configured.
 */
@property(nonatomic, strong, nonnull) MDCNavigationBar *navigationBar;

/**
 The header stack view owns the navigationBar (as the top bar) and an optional bottom bar (typically
 a tab bar).
 */
@property(nonatomic, strong, nonnull) MDCHeaderStackView *headerStackView;

/**
 When this flag is set to YES, the height of the app bar will be automatically adjusted to the sum
 of the top bar height and the bottom bar height.

 Enabling this property will disable `minMaxHeightIncludesSafeArea` on the flexible header view.

 Defaults to NO.
*/
@property(nonatomic) BOOL shouldAdjustHeightBasedOnHeaderStackView;

/**
 Defines a downward shift distance for `headerStackView`.
 */
@property(nonatomic) CGFloat headerStackViewOffset;

/**
 A delegate that, if provided, allows for customization of the default behavior of
 @c accessibilityPerformEscape.

 If nil, then the default behavior will attempt to dismiss the MDCAppBarViewController's parent
 view controller and @c accessibilityPerformEscape will return @c YES.
 */
@property(nonatomic, weak, nullable) id<MDCAppBarViewControllerAccessibilityPerformEscapeDelegate>
    accessibilityPerformEscapeDelegate;

@end
#pragma mark - To be deprecated

/**
 The MDCAppBar class creates and configures the constellation of components required to represent a
 Material App Bar.

 A Material App Bar consists of a Flexible Header View with a shadow, a Navigation Bar, and space
 for flexible content such as a photo.

 The [Material Guidelines article for Scrolling
 Techniques](https://material.io/archive/guidelines/patterns/scrolling-techniques.html) has more
 detailed recommendations and guidance.

 ### Dependencies

 AppBar depends on the FlexibleHeader, HeaderStackView, and NavigationBar Material Components.

 @warning This API will be deprecated in favor of MDCAppBarViewController. Learn more at
 https://github.com/material-components/material-components-ios/blob/develop/components/AppBar/docs/migration-guide-appbar-appbarviewcontroller.md
 */
API_UNAVAILABLE(tvos, watchos)
@interface MDCAppBar : NSObject

/**
 Adds headerViewController.view to headerViewController.parentViewController.view and registers
 navigationItem observation on headerViewController.parentViewController.
 */
- (void)addSubviewsToParent;

/** The header view controller instance manages the App Bar's flexible header view behavior. */
@property(nonatomic, strong, nonnull, readonly)
    MDCFlexibleHeaderViewController *headerViewController;

/** The App Bar view controller instance manages the App Bar's flexible header view behavior. */
@property(nonatomic, strong, nonnull, readonly) MDCAppBarViewController *appBarViewController;

/** The navigation bar. */
@property(nonatomic, strong, nonnull, readonly) MDCNavigationBar *navigationBar;

/**
 The header stack view that owns the navigationBar (as the top bar) and an optional bottom bar.
 */
@property(nonatomic, strong, nonnull, readonly) MDCHeaderStackView *headerStackView;

/**
 Whether the App Bar should attempt to extract safe area insets from the view controller hierarchy
 or not.

 This behavior provides better support for App Bars on iPad, extensions, and anywhere else where the
 view controller might not be directly behind the status bar / device safe area insets.

 Enabling this behavior will do the following:

 - Enable the same-named behavior on the headerViewController.
 - Enable the headerViewController's topLayoutGuideAdjustmentEnabled behavior. Consider setting a
   topLayoutGuideViewController to your content view controller if you want to use topLayoutGuide.
 - The header stack view's frame will be inset by the flexible header view's topSafeAreaGuide rather
   than the global device safe area insets.

 Disabling this behavior will not disable headerViewController's topLayoutGuideAdjustmentEnabled
 behavior.

 This behavior will eventually be enabled by default.

 See MDCFlexibleHeaderViewController's documentation for the API of the same name.

 Default is NO.
 */
@property(nonatomic) BOOL inferTopSafeAreaInsetFromViewController;

@end
