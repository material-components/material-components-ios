/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCFlexibleHeaderContainerViewController.h"

#import "MDCFlexibleHeaderView.h"
#import "MDCFlexibleHeaderViewController.h"

@interface MDCFlexibleHeaderContainerViewController () <MDCFlexibleHeaderParentViewController>
@end

@implementation MDCFlexibleHeaderContainerViewController

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    [MDCFlexibleHeaderViewController addToParent:self];

    self.contentViewController = contentViewController;
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  return [self initWithContentViewController:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  return [self initWithContentViewController:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];

  [self.headerViewController addFlexibleHeaderViewToParentViewControllerView];
}

- (BOOL)prefersStatusBarHidden {
  return _headerViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return _headerViewController.preferredStatusBarStyle;
}

#pragma mark - Public

- (void)setHeaderViewController:(MDCFlexibleHeaderViewController *)headerViewController {
  _headerViewController = headerViewController;
}

- (void)setContentViewController:(UIViewController *)contentViewController {
  if (_contentViewController == contentViewController) {
    return;
  }

  // Teardown of the old controller

  [_contentViewController willMoveToParentViewController:nil];
  if ([_contentViewController isViewLoaded]) {
    [_contentViewController.view removeFromSuperview];
  }
  [_contentViewController removeFromParentViewController];

  // Setup of the new controller

  _contentViewController = contentViewController;

  [self addChildViewController:contentViewController];
  if ([self isViewLoaded]) {
    [self.view insertSubview:contentViewController.view
                belowSubview:self.headerViewController.headerView];
    [contentViewController didMoveToParentViewController:self];
  }
}

@end
