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

@interface FlexibleHeaderUINavigationBarExample : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, strong) UIButton *button;

@end

@implementation FlexibleHeaderUINavigationBarExample

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

  // Use a standard UINavigationBar in the flexible header.
  CGRect navBarFrame = CGRectMake(0, 0, _fhvc.headerView.frame.size.width, 60);
  UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navBarFrame];
  [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
  navBar.shadowImage = [[UIImage alloc] init];
  navBar.translucent = YES;
  navBar.tintColor = [UIColor whiteColor];

  [self.fhvc.headerView addSubview:navBar];

  navBar.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:navBar
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView.topSafeAreaGuide
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:navBar
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:navBar
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:navBar
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0]
  ]];

  UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(doneAction:)];
  UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(doneAction:)];

  [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
  [self.navigationItem setRightBarButtonItem:doneItem animated:YES];
  [navBar setItems:@[ self.navigationItem ] animated:YES];

  self.button = [[UIButton alloc] init];
  [self.button setTitle:@"UIButton" forState:UIControlStateNormal];
  [self.button sizeToFit];
  [self.button addTarget:self
                  action:@selector(didTapButton:)
        forControlEvents:UIControlEventTouchUpInside];
  self.button.tintColor = [UIColor redColor];
  self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.fhvc.headerView addSubview:self.button];
}

- (void)didTapButton:(id)sender {
  NSLog(@"Button Tapped: %@", sender);
}

- (void)doneAction:(id)sender {
  [super.navigationController popViewControllerAnimated:YES];
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

  [self.navigationController setNavigationBarHidden:YES animated:animated];
  self.button.center = CGPointMake(CGRectGetMidX(self.fhvc.headerView.frame),
                                   CGRectGetMidY(self.fhvc.headerView.frame) + 50);
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.fhvc scrollViewDidScroll:scrollView];
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

@implementation FlexibleHeaderUINavigationBarExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Standard UINavigationBar" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
