/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

/**
 The MDCAppBarParenting protocol defines a set of properties that store the necessary objects
 for working with a Material App Bar.

 A Material App Bar consists of a flexible view with a shadow, a navigation bar, and space for
 flexible content such as a photo.

 Learn more at the [Material spec](https://www.google.com/design/spec/patterns/scrolling-techniques.html)

 This protocol must be implemented by a UIViewController class.

 A view controller must conform to this protocol in order to use
 MDCAppBarPrepareParent and MDCAppBarAddViews. The combination of these APIs is
 commonly referred to as "injection". This contrasts with the alternative "wrapping" API,
 MDCAppBarContainerViewController.
 */
@protocol MDCAppBarParenting <NSObject>

/**
 The header stack view that owns the navigationBar (as the top bar) and an optional bottom bar.
 */
@property(nonatomic, strong, nullable) MDCHeaderStackView *headerStackView;

/** The navigation bar. */
@property(nonatomic, strong, nullable) MDCNavigationBar *navigationBar;

/** The header view controller instance manages the App Bar's flexible header view behavior. */
@property(nonatomic, strong, nullable) MDCFlexibleHeaderViewController *headerViewController;

@end

/**
 Initializes all of the properties described by MDCAppBarParenting and adds the header
 view controller as a child view controller to the parent.

 This should be called in your view controller's init* method.
 */
FOUNDATION_EXTERN void MDCAppBarPrepareParent(id<MDCAppBarParenting> __nonnull parent);

/**
 Adds the App Bar views to the headerViewController's parentViewController.

 This should be called at the end of your view controller's viewDidLoad method.
 */
FOUNDATION_EXTERN void MDCAppBarAddViews(id<MDCAppBarParenting> __nonnull parent);
