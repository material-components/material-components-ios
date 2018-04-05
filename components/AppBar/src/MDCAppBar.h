/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialFlexibleHeader.h"
#import "MaterialHeaderStackView.h"
#import "MaterialNavigationBar.h"

@class MDCAppBar;

/**
 The MDCAppBarTextColorAccessibilityMutator class creates an external object with which to work on
 an instance of a Material App Bar to activate and ensure accessibility on its title and buttons.

 ### Dependencies

 Material AppBarTextColorAccessibilityMutator depends on the AppBar material component and
 MDFTextAccessibility Framework.
 */

@interface MDCAppBarTextColorAccessibilityMutator : NSObject

/**
 Mutates title text color and navigation items' tint colors based on background color of
 app bar's navigation bar or header view background color.
 */
- (void)mutate:(nonnull MDCAppBar *)appBar;

@end

/**
 The MDCAppBar class creates and configures the constellation of components required to represent a
 Material App Bar.

 A Material App Bar consists of a Flexible Header View with a shadow, a Navigation Bar, and space
 for flexible content such as a photo.

 Learn more at the [Material
 spec](https://material.io/guidelines/patterns/scrolling-techniques.html)

 ### Dependencies

 AppBar depends on the FlexibleHeader, HeaderStackView, and NavigationBar Material Components.
 */
//TODO: (#3012) Re-add NSSecureCoding
@interface MDCAppBar : NSObject

/**
 Adds headerViewController.view to headerViewController.parentViewController.view and registers
 navigationItem observation on headerViewController.parentViewController.
 */
- (void)addSubviewsToParent;

/** The header view controller instance manages the App Bar's flexible header view behavior. */
@property(nonatomic, strong, nonnull, readonly)
    MDCFlexibleHeaderViewController *headerViewController;

/** The navigation bar. */
@property(nonatomic, strong, nonnull, readonly) MDCNavigationBar *navigationBar;

/**
 The header stack view that owns the navigationBar (as the top bar) and an optional bottom bar.
 */
@property(nonatomic, strong, nonnull, readonly) MDCHeaderStackView *headerStackView;

@end
