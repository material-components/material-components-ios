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

#import "MDCBottomAppBarViewController.h"

#import "MDCBottomAppBarAttributes.h"
#import "private/MDCBottomAppBarView.h"

@interface MDCBottomAppBarViewController ()

@property(nonatomic, strong) MDCBottomAppBarView *bottomBarView;

@end

@implementation MDCBottomAppBarViewController

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    [self commonMDCBottomAppBarViewControllerInit];
    [self setViewController:viewController];
  }
  return self;
}

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
  [self addFloatingButton];
  [self setFloatingButtonVisible:YES];
  [self setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionCenter];
  [self addBottomBarView];
}

- (void)addFloatingButton {
  _floatingButton = [[MDCFloatingButton alloc] initWithFrame:CGRectZero];
}

- (void)addBottomBarView {
  _bottomBarView = [[MDCBottomAppBarView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:_bottomBarView];

  [_bottomBarView setupBottomBarView];
  [_bottomBarView setFloatingButton:_floatingButton];
}

- (void)viewWillLayoutSubviews {
  CGRect containerFrame = CGRectMake(0,
                                     self.view.bounds.size.height - kMDCBottomAppBarHeightCollapsed,
                                     self.view.bounds.size.width,
                                     kMDCBottomAppBarHeightCollapsed);
  _bottomBarView.frame = containerFrame;
}

- (void)setFloatingButtonVisible:(BOOL)floatingButtonVisible {
  [self setFloatingButtonVisible:floatingButtonVisible animated:NO];
}

- (void)setFloatingButtonVisible:(BOOL)floatingButtonVisible animated:(BOOL)animated {
  _floatingButtonVisible = floatingButtonVisible;
  [_bottomBarView setFloatingButtonVisible:floatingButtonVisible animated:animated];
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition {
  [self setFloatingButtonPosition:floatingButtonPosition animated:NO];
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                         animated:(BOOL)animated {
  _floatingButtonPosition = floatingButtonPosition;
  [_bottomBarView setFloatingButtonPosition:floatingButtonPosition
                                   animated:animated];
}

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

- (void)setContentViewController:(UIViewController *)contentViewController {
  if (contentViewController == _contentViewController) {
    return;
  }

  // If there is an existing content view controller, remove it.
  if (_contentViewController) {
    [_contentViewController willMoveToParentViewController:nil];
    [_contentViewController.view removeFromSuperview];
    [_contentViewController removeFromParentViewController];
  }
  _contentViewController = contentViewController;

  CGRect containerFrame = CGRectMake(0,
                                     kMDCBottomAppBarYOffset,
                                     _bottomBarView.bounds.size.width,
                                     _bottomBarView.bounds.size.height);
  _contentViewController.view.frame = containerFrame;

  [self addChildViewController:_contentViewController];
  [_bottomBarView addSubview:_contentViewController.view];
  [self didMoveToParentViewController:_contentViewController];
}

@end
