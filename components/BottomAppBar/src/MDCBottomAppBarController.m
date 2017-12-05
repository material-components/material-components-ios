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

#import "MDCBottomAppBarController.h"
#import "MaterialBottomSheet.h"

@interface MDCBottomAppBarController () <MDCBottomSheetControllerDelegate,
                                         UIGestureRecognizerDelegate>

@property(nonatomic, strong) MDCBottomSheetController *bottomSheet;
@property(nonatomic, strong) UINavigationController *navController;

@end

@implementation MDCBottomAppBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCBottomAppBarControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomAppBarControllerInit];
  }
  return self;
}

- (void)commonMDCBottomAppBarControllerInit {
  self.view.backgroundColor = [UIColor whiteColor];

  _navController = [[UINavigationController alloc] init];
  _navController.navigationBarHidden = YES;
  [self addNavViewController:_navController];

  UIViewController *viewController = [[UIViewController alloc] init];
  viewController.view.backgroundColor = [UIColor lightGrayColor];
  [_navController pushViewController:viewController animated:NO];

  _bottomBarView = [[MDCBottomAppBarView alloc] initWithFrame:CGRectZero];
  _bottomBarView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
  [self.view addSubview:_bottomBarView];

  UIViewController *bottomSheetViewController = [[UIViewController alloc] init];
  bottomSheetViewController.view.backgroundColor = [UIColor whiteColor];

  _bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:bottomSheetViewController];
  _bottomSheet.delegate = self;

  UISwipeGestureRecognizer *recognizer =
      [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentBottomSheet)];
  recognizer.direction = UISwipeGestureRecognizerDirectionUp;
  [recognizer setNumberOfTouchesRequired:1];
  recognizer.delegate = self;
  [_bottomBarView addGestureRecognizer:recognizer];
  [_bottomBarView setUserInteractionEnabled:YES];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize size = [_bottomBarView sizeThatFits:self.view.frame.size];
  CGRect bottomBarViewFrame = CGRectMake(0,
                                         self.view.frame.size.height - size.height,
                                         size.width,
                                         size.height);
  _bottomBarView.frame = bottomBarViewFrame;
}

- (void)addNavViewController:(UIViewController *)navViewController {
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);

  // Add the underlying content view controller to display beneath the bottom app bar.
  [self addChildViewController:navViewController];
  navViewController.view.frame = CGRectMake(0, 0, width, height);
  [self.view insertSubview:navViewController.view atIndex:0];
  [self didMoveToParentViewController:navViewController];
}

- (void)presentBottomSheet {
  [self.bottomBarView setFloatingButtonHidden:YES animated:YES];

  [UIView animateWithDuration:0.270f animations:^{
    self.bottomBarView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                            CGRectGetMidY(self.view.bounds) + 15);
  }];

  [self presentViewController:_bottomSheet animated:YES completion:nil];
}

- (void)bottomSheetControllerDidDismissBottomSheet:(MDCBottomSheetController *)controller {
  if (controller) {
    [self.bottomBarView setFloatingButtonHidden:NO animated:YES];
    [UIView animateWithDuration:0.180f animations:^{
      self.bottomBarView.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                              CGRectGetMidY(self.view.bounds) +
                                              CGRectGetHeight(self.view.bounds) / 2 - 48);
    }];
  }
}

- (NSArray<UIViewController *> *)viewControllers {
  return self.navController.viewControllers;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
  self.navController.viewControllers = viewControllers;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  [self.navController pushViewController:viewController animated:animated];
}

- (void)popViewControllerAnimated:(BOOL)animated {
  [self.navController popViewControllerAnimated:animated];
}

@end
