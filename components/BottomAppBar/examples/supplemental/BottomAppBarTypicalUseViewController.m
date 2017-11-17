/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "BottomAppBarTypicalUseViewController.h"

@interface BottomAppBarTypicalUseViewController ()

@end

@implementation BottomAppBarTypicalUseViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomAppBarViewControllerInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCBottomAppBarViewControllerInit];
  }
  return self;
}

- (void)commonMDCBottomAppBarViewControllerInit {
  _bottomBarView = [[MDCBottomAppBarView alloc] initWithFrame:CGRectZero];
  _bottomBarView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
  [self.view addSubview:_bottomBarView];
}

- (void)layoutBottomAppBar {
  CGSize size = [_bottomBarView sizeThatFits:self.view.bounds.size];
  CGRect bottomBarViewFrame = CGRectMake(0,
                                         CGRectGetHeight(self.view.bounds) - size.height,
                                         size.width,
                                         size.height);
  _bottomBarView.frame = bottomBarViewFrame;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self layoutBottomAppBar];
}

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
- (void)viewSafeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super viewSafeAreaInsetsDidChange];
  }
  [self layoutBottomAppBar];
}
#endif

#pragma mark - Setters

- (void)setViewController:(UIViewController *)viewController {
  if (viewController == _viewController) {
    return;
  }

  // If there is an existing content view controller, remove it.
  if (_viewController) {
    [_viewController willMoveToParentViewController:nil];
    [_viewController.view removeFromSuperview];
    [_viewController removeFromParentViewController];
  }
  _viewController = viewController;

  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);

  // Add the underlying content view controller to display beneath the bottom app bar.
  [self addChildViewController:_viewController];
  _viewController.view.frame = CGRectMake(0, 0, width, height);
  [self.view insertSubview:_viewController.view atIndex:0];
  [self didMoveToParentViewController:_viewController];
}

@end
