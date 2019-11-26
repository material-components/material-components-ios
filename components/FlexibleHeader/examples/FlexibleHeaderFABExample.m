// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
#import "MaterialFlexibleHeader.h"

static const CGFloat kFlexibleHeaderMinHeight = 200;

@interface FlexibleHeaderFABExample : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, strong) MDCFloatingButton *floatingButton;

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

  // Behavioral flags.
  _fhvc.topLayoutGuideAdjustmentEnabled = YES;
  _fhvc.inferTopSafeAreaInsetFromViewController = YES;
  _fhvc.headerView.minMaxHeightIncludesSafeArea = NO;

  _fhvc.headerView.maximumHeight = kFlexibleHeaderMinHeight;
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

  self.fhvc.headerView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton setBackgroundColor:[UIColor colorWithRed:11 / (CGFloat)255
                                                          green:232 / (CGFloat)255
                                                           blue:94 / (CGFloat)255
                                                          alpha:1]
                                 forState:UIControlStateNormal];
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
  NSLog(@"Button was tapped. %@", sender);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc scrollViewDidScroll:scrollView];
  }
  self.floatingButton.center =
      CGPointMake(self.floatingButton.center.x, CGRectGetMaxY(self.fhvc.headerView.frame));
}

#pragma mark - Supplemental

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.scrollView.contentSize = self.view.bounds.size;
}

@end

@implementation FlexibleHeaderFABExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Floating Action Button" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
