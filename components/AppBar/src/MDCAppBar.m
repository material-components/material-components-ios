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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCAppBar.h"

#import "MaterialFlexibleHeader.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static NSString *const kBarStackKey = @"barStack";
static NSString *const kStatusBarHeightKey = @"statusBarHeight";
static const CGFloat kStatusBarHeight = 20;

@interface MDCAppBarViewController : UIViewController

@property(nonatomic, strong) MDCHeaderStackView *headerStackView;
@property(nonatomic, strong) MDCNavigationBar *navigationBar;

@end

@implementation MDCAppBarViewController

- (MDCHeaderStackView *)headerStackView {
  [self loadViewIfNeeded];
  return _headerStackView;
}

- (MDCNavigationBar *)navigationBar {
  [self loadViewIfNeeded];
  return _navigationBar;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.headerStackView = [[MDCHeaderStackView alloc] initWithFrame:self.view.bounds];
  self.headerStackView.translatesAutoresizingMaskIntoConstraints = NO;

  self.navigationBar = [MDCNavigationBar new];
  self.headerStackView.topBar = self.navigationBar;

  // TODO(featherless): Provide a leftButtonBarDelegate/rightButtonBarDelegate.

  [self.view addSubview:self.headerStackView];

  // Bar stack expands vertically, but has a margin above it for the status bar.

  NSArray *horizontalConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:
                              [NSString stringWithFormat:
                                            @"H:|[%@]|",
                                            kBarStackKey]
                                              options:0
                                              metrics:nil
                                                views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:horizontalConstraints];

  NSArray *verticalConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:
                              [NSString stringWithFormat:
                                            @"V:|-%@-[%@]|",
                                            kStatusBarHeightKey,
                                            kBarStackKey]
                                              options:0
                                              metrics:@{ kStatusBarHeightKey : @(kStatusBarHeight) }
                                                views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:verticalConstraints];
}

@end

void MDCAppBarPrepareParent(id<MDCAppBarParenting> parent) {
  if (parent.headerViewController) {
    return;
  }
  MDCFlexibleHeaderViewController *hvc = [MDCFlexibleHeaderViewController new];
  parent.headerViewController = hvc;

  MDCFlexibleHeaderView *headerView = parent.headerViewController.headerView;

  // Shadow layer

  MDCFlexibleHeaderShadowIntensityChangeBlock intensityBlock = ^(CALayer *_Nonnull shadowLayer,
                                                                 CGFloat intensity) {
    CGFloat elevation = MDCShadowElevationAppBar * intensity;
    [(MDCShadowLayer *)shadowLayer setElevation:elevation];
  };
  [headerView setShadowLayer:[MDCShadowLayer new] intensityDidChangeBlock:intensityBlock];

  // Header stack view + navigation bar
  MDCAppBarViewController *appBarViewController = [MDCAppBarViewController new];
  [hvc addChildViewController:appBarViewController];
  [hvc.view addSubview:appBarViewController.view];
  [appBarViewController didMoveToParentViewController:hvc];

  [headerView forwardTouchEventsForView:appBarViewController.headerStackView];
  [headerView forwardTouchEventsForView:appBarViewController.navigationBar];

  parent.headerStackView = appBarViewController.headerStackView;
  parent.navigationBar = appBarViewController.navigationBar;

  if ([parent isKindOfClass:[UIViewController class]]) {
    [(UIViewController *)parent addChildViewController:hvc];
  }
}

void MDCAppBarAddViews(id<MDCAppBarParenting> parent) {
  MDCFlexibleHeaderViewController *fhvc = [parent headerViewController];
  if (fhvc.view.superview == fhvc.parentViewController.view) {
    return;
  }

  // Enforce the header's desire to fully cover the width of its parent view.
  CGRect frame = fhvc.view.frame;
  frame.origin.x = 0;
  frame.size.width = fhvc.parentViewController.view.bounds.size.width;
  fhvc.view.frame = frame;

  [fhvc.parentViewController.view addSubview:fhvc.view];
  [fhvc didMoveToParentViewController:fhvc.parentViewController];

  if ([parent isKindOfClass:[UIViewController class]]) {
    UIViewController *viewController = (UIViewController *)parent;
    [[parent navigationBar] observeNavigationItem:viewController.navigationItem];
  }
}
