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

#import "MDCAppBarContainerViewController.h"

#import "MDCAppBar.h"
#import "MaterialFlexibleHeader.h"

@implementation MDCAppBarContainerViewController {
  MDCAppBar *_appBar;
}

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];

    [self addChildViewController:_appBar.headerViewController];

    _contentViewController = contentViewController;
    [self addChildViewController:contentViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];

  [_appBar addSubviewsToParent];

  [_appBar.navigationBar observeNavigationItem:_contentViewController.navigationItem];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_appBar.headerViewController updateTopLayoutGuide];
}

- (BOOL)prefersStatusBarHidden {
  return self.appBar.headerViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.appBar.headerViewController.preferredStatusBarStyle;
}

- (BOOL)shouldAutorotate {
  return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return self.contentViewController.preferredInterfaceOrientationForPresentation;
}

@end
