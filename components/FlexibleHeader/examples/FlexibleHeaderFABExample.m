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

#import <UIKit/UIKit.h>

#import "FlexibleHeaderFABSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialFlexibleHeader.h"

static const CGFloat kFlexibleHeaderMinHeight = 200.f;

@interface FlexibleHeaderFABExample () <UIScrollViewDelegate>

@property(nonatomic) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic) MDCFloatingButton *floatingButton;

@end

@implementation FlexibleHeaderFABExample

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (void)commonMDCFlexibleHeaderViewControllerInit {
  _fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
  _fhvc.headerView.minimumHeight = kFlexibleHeaderMinHeight;
  [self addChildViewController:_fhvc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.backgroundColor = [UIColor whiteColor];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.scrollView];

  self.scrollView.delegate = self;
  self.fhvc.headerView.trackingScrollView = self.scrollView;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  // Light blue 500
  self.fhvc.headerView.backgroundColor =
      [UIColor colorWithRed:0.333 green:0.769 blue:0.961 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton sizeToFit];
  self.floatingButton.center = CGPointMake(
      self.view.frame.size.width - self.floatingButton.frame.size.width, kFlexibleHeaderMinHeight);
  [self.floatingButton addTarget:self
                          action:@selector(didTap:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.floatingButton];
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  self.floatingButton.center =
      CGPointMake(size.width - self.floatingButton.frame.size.width, self.floatingButton.center.y);
}

#pragma mark -

- (void)didTap:(id)sender {
  NSLog(@"Button was tapped.");
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat contentOffsetY = -scrollView.contentOffset.y;
  if (contentOffsetY < kFlexibleHeaderMinHeight) {
    contentOffsetY = kFlexibleHeaderMinHeight;
  }
  self.floatingButton.center = CGPointMake(self.floatingButton.center.x, contentOffsetY);
  [self.fhvc scrollViewDidScroll:scrollView];
}

@end
