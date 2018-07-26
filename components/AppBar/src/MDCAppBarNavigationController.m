/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCAppBarNavigationController.h"

#import "MDCAppBar.h"

#import <objc/runtime.h>

@implementation MDCAppBarNavigationController

// We're overriding UINavigationController's delegate solely to change its type (we don't provide
// a getter or setter implementation), thus the @dynamic.
@dynamic delegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // We always want the navigation bar to be hidden.
    [self setNavigationBarHidden:YES animated:NO];
  }
  return self;
}

#pragma mark - UINavigationController overrides

// Intercept status bar style inquiries and reroute them to our flexible header view controller.
- (UIViewController *)childViewControllerForStatusBarStyle {
  UIViewController *child = [super childViewControllerForStatusBarStyle];
  MDCAppBar *appBar = [self appBarForViewController:child];
  if (appBar) {
    return appBar.headerViewController;
  }
  return child; // Fall back to using the child if we didn't knowingly inject an app bar.
}

// Inject an App Bar, if necessary, when a view controller is pushed.
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  // We call this invoking super because super immediately queries the pushed view controller for
  // things like status bar style, which we want to have rerouted to our flexible header view
  // controller.
  [self injectAppBarIntoViewController:viewController];

  [super pushViewController:viewController animated:animated];
}

#pragma mark - Private

- (void)injectAppBarIntoViewController:(UIViewController *)viewController {
  if ([self appBarForViewController:viewController] != nil) {
    return; // Already injected.
  }

  if ([self viewControllerHasFlexibleHeader:viewController]) {
    return; // Already has a flexible header (not one we injected, but that's ok).
  }

  MDCAppBar *appBar = [[MDCAppBar alloc] init];
  [self setAppBar:appBar forViewController:viewController];

  // Ensures that the view controller's top layout guide / additional safe area insets are adjusted
  // to take into consideration the flexible header's height.
  appBar.headerViewController.topLayoutGuideViewController = viewController;
  appBar.headerViewController.inferTopSafeAreaInsetFromViewController = YES;
  appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = NO;
  appBar.headerViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  // Attempt to infer the tracking scroll view.
  appBar.headerViewController.headerView.trackingScrollView =
      [self findFirstInstanceOfUIScrollViewInView:viewController.view];

  if ([self.delegate respondsToSelector:
       @selector(appBarNavigationController:willAddAppBar:asChildOfViewController:)]) {
    [self.delegate appBarNavigationController:self
                                willAddAppBar:appBar
                      asChildOfViewController:viewController];
  }

  [viewController addChildViewController:appBar.headerViewController];

  [appBar addSubviewsToParent];
}

- (BOOL)viewControllerHasFlexibleHeader:(UIViewController *)viewController {
  // Searching the child view controllers covers both the contained case and the injected-as-a-child
  // case. MDCFlexibleHeaderViewController can never be a top-level view controller.
  for (UIViewController *childViewController in viewController.childViewControllers) {
    if ([childViewController isKindOfClass:[MDCFlexibleHeaderViewController class]]) {
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

- (MDCAppBar *)appBarForViewController:(UIViewController *)viewController {
  return (MDCAppBar *)objc_getAssociatedObject(viewController, _cmd);
}

- (void)setAppBar:(MDCAppBar *)appBar forViewController:(UIViewController *)viewController {
  objc_setAssociatedObject(viewController,
                           @selector(appBarForViewController:),
                           appBar,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

