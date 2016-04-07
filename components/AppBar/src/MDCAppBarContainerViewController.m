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

    self.contentViewController = contentViewController;
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];

  [_appBar addSubviewsToParent];

  [_appBar.navigationBar observeNavigationItem:_contentViewController.navigationItem];
}

- (BOOL)prefersStatusBarHidden {
  return self.appBar.headerViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.appBar.headerViewController.preferredStatusBarStyle;
}

#pragma mark - Public

- (MDCFlexibleHeaderViewController *)headerViewController {
  return self.appBar.headerViewController;
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

  NSAssert(![self isViewLoaded],
           @"View should not have been loaded at this point."
           @" Verify that the view is not being accessed anywhere in %@ or %@.",
           NSStringFromSelector(_cmd),
           NSStringFromSelector(@selector(initWithContentViewController:)));
}

@end
