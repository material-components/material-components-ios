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

#import "MDCAppBarNavigationController.h"

#import "MDCAppBarNavigationControllerToBeDeprecatedDelegate.h"
#import "MDCAppBarViewController.h"

#import <objc/runtime.h>

// Light-weight book-keeping associated with any pushed view controller.
@interface MDCAppBarNavigationControllerInfo : NSObject

@property(nonatomic, strong) MDCAppBar *appBar;

// Note that this is a strong reference so that we can keep it around until we know that we're done
// with it (i.e. once the associated view controller is released).
@property(nonatomic, strong) UIScrollView *trackingScrollView;

@end

// This is intentionally a private protocol conformance in order to avoid public reliance on our
// conformance to this protocol.
@interface MDCAppBarNavigationController () <UIGestureRecognizerDelegate>
// Whether injected app bars should be hidden.
@property(nonatomic, assign) BOOL appBarHidden;
@end

@implementation MDCAppBarNavigationControllerInfo

- (void)dealloc {
  // On pre-iOS 11 devices we need to manually clear out the trackingScrollView because we've
  // enabled the observesTrackingScrollViewScrollEvents behavior on the flexible header.
  self.appBar.appBarViewController.headerView.trackingScrollView = nil;
}

@end

@implementation MDCAppBarNavigationController

// We're overriding UINavigationController's delegate solely to change its type (we don't provide
// a getter or setter implementation), thus the @dynamic.
@dynamic delegate;

- (void)dealloc {
  self.interactivePopGestureRecognizer.delegate = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self MDCAppBarNavigationController_commonInit];
  }
  return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
  self = [super initWithRootViewController:rootViewController];
  if (self) {
    [self MDCAppBarNavigationController_commonInit];

    [self injectAppBarIntoViewController:rootViewController];
  }
  return self;
}

- (void)MDCAppBarNavigationController_commonInit {
  // We always want the UIKit navigation bar to be hidden; to do so we must invoke the super
  // implementation.
  [super setNavigationBarHidden:YES animated:NO];

  _appBarHidden = NO;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UINavigationController overrides

// Intercept status bar style inquiries and reroute them to our flexible header view controller.
- (UIViewController *)childViewControllerForStatusBarStyle {
  UIViewController *child = [super childViewControllerForStatusBarStyle];
  MDCAppBar *appBar = [self appBarForViewController:child];
  if (appBar) {
    return appBar.appBarViewController;
  }
  return child;  // Fall back to using the child if we didn't knowingly inject an app bar.
}

// Inject an App Bar, if necessary, when a view controller is pushed.
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  [super pushViewController:viewController animated:animated];

  [self injectAppBarIntoViewController:viewController];

  [self setNeedsStatusBarAppearanceUpdate];
  if (@available(iOS 11.0, *)) {
    [self setNeedsUpdateOfHomeIndicatorAutoHidden];
  }
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
  [super setViewControllers:viewControllers animated:animated];

  for (UIViewController *viewController in viewControllers) {
    [self injectAppBarIntoViewController:viewController];
  }

  [self setNeedsStatusBarAppearanceUpdate];
  if (@available(iOS 11.0, *)) {
    [self setNeedsUpdateOfHomeIndicatorAutoHidden];
  }
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
  if (!self.shouldSetNavigationBarHiddenHideAppBar) {
    NSAssert(navigationBarHidden, @"%@ requires that the system navigation bar remain hidden.",
             NSStringFromClass([self class]));
    [super setNavigationBarHidden:YES];
    return;
  }

  [super setNavigationBarHidden:YES];
  [self appbar_setNavigationBarHidden:navigationBarHidden animated:NO];
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated {
  if (!self.shouldSetNavigationBarHiddenHideAppBar) {
    NSAssert(navigationBarHidden, @"%@ requires that the system navigation bar remain hidden.",
             NSStringFromClass([self class]));
    [super setNavigationBarHidden:YES animated:animated];
    return;
  }

  [super setNavigationBarHidden:YES animated:animated];
  [self appbar_setNavigationBarHidden:navigationBarHidden animated:animated];
}

- (BOOL)isNavigationBarHidden {
  if (!self.shouldSetNavigationBarHiddenHideAppBar) {
    return [super isNavigationBarHidden];
  }

  MDCAppBarViewController *appBarViewController =
      [self appBarViewControllerForViewController:self.visibleViewController];
  if (!appBarViewController) {
    return YES;
  }
  return appBarViewController.headerView.shiftedOffscreen;
}

#pragma mark - Private

- (void)appbar_setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated {
  [self appbar_setNavigationBarHidden:navigationBarHidden
                             animated:animated
                    forViewController:self.visibleViewController];
}

- (void)appbar_setNavigationBarHidden:(BOOL)navigationBarHidden
                             animated:(BOOL)animated
                    forViewController:(UIViewController *)viewController {
  self.appBarHidden = navigationBarHidden;

  MDCAppBarViewController *appBarViewController =
      [self appBarViewControllerForViewController:viewController];
  if (!appBarViewController) {
    return;
  }

  // If the shift behavior is presently disabled (the default), then adjust it to be hideable
  // instead, otherwise we do not make any adjustments to the shift behavior because it's likely
  // that the shift behavior was explicitly set to something else.
  if (appBarViewController.headerView.shiftBehavior == MDCFlexibleHeaderShiftBehaviorDisabled) {
    appBarViewController.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorHideable;
  }

  // Only toggle visiblity on app bars that have the correct shift behavior enabled.
  if (appBarViewController.headerView.shiftBehavior != MDCFlexibleHeaderShiftBehaviorHideable) {
    return;
  }

  // Ensure that the app bar's content fades out when shifted off-screen.
  [appBarViewController.headerView hideViewWhenShifted:appBarViewController.headerStackView];

  if (navigationBarHidden) {
    [appBarViewController.headerView shiftHeaderOffScreenAnimated:animated];
  } else {
    [appBarViewController.headerView shiftHeaderOnScreenAnimated:animated];
  }
}

- (void)injectAppBarIntoViewController:(UIViewController *)viewController {
  // Force the view to load immediately in case the view controller is using viewDidLoad to manage
  // its child view controllers (potentially injecting an App Bar as a result).
  UIView *viewControllerView = viewController.view;

  if ([self viewControllerHasFlexibleHeader:viewController]) {
    return;  // Already has a flexible header (not one we injected, but that's ok).
  }

  // Attempt to infer the tracking scroll view.
  UIScrollView *trackingScrollView =
      [self findFirstInstanceOfUIScrollViewInView:viewControllerView];

  if ([self.delegate respondsToSelector:@selector
                     (appBarNavigationController:
                         trackingScrollViewForViewController:suggestedTrackingScrollView:)]) {
    trackingScrollView = [self.delegate appBarNavigationController:self
                               trackingScrollViewForViewController:viewController
                                       suggestedTrackingScrollView:trackingScrollView];
  }

  MDCAppBar *appBar = [[MDCAppBar alloc] init];

  // Book-keeping so that we can do two things:
  // 1. Return the associated App Bar for a given view controller.
  // 2. Hold a strong reference to the scroll view until the view controller is released, at which
  //    point we nil out the trackingScrollView on the App Bar so that the header's KVO observer is
  //    unregistered.
  MDCAppBarNavigationControllerInfo *info = [[MDCAppBarNavigationControllerInfo alloc] init];
  info.appBar = appBar;
  info.trackingScrollView = trackingScrollView;
  [self setInfo:info forViewController:viewController];

  if (@available(iOS 11.0, *)) {
    appBar.appBarViewController.headerView
        .disableContentInsetAdjustmentWhenContentInsetAdjustmentBehaviorIsNever = YES;
  }

  // Ensures that the view controller's top layout guide / additional safe area insets are adjusted
  // to take into consideration the flexible header's height.
  appBar.appBarViewController.topLayoutGuideViewController = viewController;

  // Ensures that our App Bar's top layout guide reflects the current view controller hierarchy.
  // Most notably, this ensures we support iPad popovers and extensions.
  appBar.appBarViewController.inferTopSafeAreaInsetFromViewController = YES;

  // We want our flexible header to calculate the safe area insets dynamically, rather than assume
  // we've pre-calculated them.
  appBar.appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

  // This is the magic that allows us to avoid having to explicitly forward any scroll view events
  // to the flexible header. Enabling this means we cannot enable the shiftBehavior on the
  // flexible header. In those cases the client is expected to create their own App Bar.
  appBar.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  appBar.appBarViewController.traitCollectionDidChangeBlock =
      self.traitCollectionDidChangeBlockForAppBarController;

  if ([self.delegate respondsToSelector:@selector
                     (appBarNavigationController:willAddAppBar:asChildOfViewController:)]) {
    [self.delegate appBarNavigationController:self
                                willAddAppBar:appBar
                      asChildOfViewController:viewController];
  }

  if ([self.delegate
          respondsToSelector:@selector(appBarNavigationController:
                                      willAddAppBarViewController:asChildOfViewController:)]) {
    [self.delegate appBarNavigationController:self
                  willAddAppBarViewController:appBar.appBarViewController
                      asChildOfViewController:viewController];
  }

  // Allow the delegates to configure the app bar's behavior before we inject the tracking scroll
  // view in case features like observesTrackingScrollViewScrollEvents are disabled.
  appBar.appBarViewController.headerView.trackingScrollView = trackingScrollView;

  [viewController addChildViewController:appBar.appBarViewController];
  [appBar addSubviewsToParent];

  // Propagate the navigation bar visibility to the new app bar.
  if (self.shouldSetNavigationBarHiddenHideAppBar && self.appBarHidden) {
    [self appbar_setNavigationBarHidden:self.appBarHidden animated:NO];
  }
}

- (BOOL)viewControllerHasFlexibleHeader:(UIViewController *)viewController {
  // Searching the child view controllers covers both the contained case and the injected-as-a-child
  // case. MDCFlexibleHeaderViewController can never be a top-level view controller.
  for (UIViewController *childViewController in viewController.childViewControllers) {
    if ([childViewController isKindOfClass:[MDCFlexibleHeaderViewController class]]) {
      return YES;
    }
    // Recurse in case the flexible header is nested within a container.
    if ([self viewControllerHasFlexibleHeader:childViewController]) {
      return YES;
    }
  }
  return NO;
}

- (UIScrollView *)findFirstInstanceOfUIScrollViewInView:(UIView *)view {
  if ([view isKindOfClass:[UIScrollView class]]) {
    return (UIScrollView *)view;
  }
  for (UIView *subview in view.subviews) {
    UIScrollView *scrollView = [self findFirstInstanceOfUIScrollViewInView:subview];
    if (scrollView != nil) {
      return scrollView;
    }
  }
  return nil;
}

- (MDCAppBarNavigationControllerInfo *)infoForViewController:(UIViewController *)viewController {
  return objc_getAssociatedObject(viewController, _cmd);
}

- (void)setInfo:(MDCAppBarNavigationControllerInfo *)info
    forViewController:(UIViewController *)viewController {
  objc_setAssociatedObject(viewController, @selector(infoForViewController:), info,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (MDCAppBar *)appBarForViewController:(UIViewController *)viewController {
  return [self infoForViewController:viewController].appBar;
}

- (MDCAppBarViewController *)appBarViewControllerForViewController:
    (UIViewController *)viewController {
  return [self infoForViewController:viewController].appBar.appBarViewController;
}

@end
