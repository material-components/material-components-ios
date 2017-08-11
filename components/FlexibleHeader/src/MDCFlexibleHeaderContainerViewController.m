/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFlexibleHeaderContainerViewController.h"

#import "MDCFlexibleHeaderView.h"
#import "MDCFlexibleHeaderViewController.h"

@implementation MDCFlexibleHeaderContainerViewController

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _headerViewController = [[MDCFlexibleHeaderViewController alloc] init];
    [self addChildViewController:_headerViewController];

    self.contentViewController = contentViewController;
  }
  return self;
}

- (instancetype)initWithNibName:(__unused NSString *)nibNameOrNil
                         bundle:(__unused NSBundle *)nibBundleOrNil {
  return [self initWithContentViewController:nil];
}

- (instancetype)initWithCoder:(__unused NSCoder *)aDecoder {
  return [self initWithContentViewController:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];

  // Enforce the header's desire to fully cover the width of its parent view.
  CGRect frame = self.view.frame;
  frame.origin.x = 0;
  frame.size.width = self.view.bounds.size.width;
  self.headerViewController.view.frame = self.view.bounds;
  [self.view addSubview:self.headerViewController.view];
  [self.headerViewController didMoveToParentViewController:self];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self.headerViewController updateTopLayoutGuide];
}

- (BOOL)prefersStatusBarHidden {
  return _headerViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return _headerViewController.preferredStatusBarStyle;
}

#pragma mark - Public

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

  if (contentViewController != nil) {
    [self addChildViewController:contentViewController];
    if ([self isViewLoaded]) {
      [self.view insertSubview:contentViewController.view
                  belowSubview:self.headerViewController.headerView];
      [contentViewController didMoveToParentViewController:self];
    }
  }
}

@end
