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

#import "MaterialFlexibleHeader.h"

@class FlexibleHeaderTypicalUseInstructionsView;

@interface FlexibleHeaderTypicalUseViewController : UIViewController

@property(nonatomic) MDCFlexibleHeaderViewController *fhvc;

@property(nonatomic, strong) IBOutlet UIView *exampleView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation FlexibleHeaderTypicalUseViewController

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

  [self addChildViewController:_fhvc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.scrollView];

  // If a tableView was being used instead of a scrollView, you would set the trackingScrollView
  // to be that tableView and either set the MDCFlexibleHeaderViewController to be the
  // UITableViewDelegate or forward the UIScrollViewDelegate methods to
  // MDCFlexibleHeaderViewController from the UITableViewDelegate.
  self.scrollView.delegate = self.fhvc;
  self.fhvc.headerView.trackingScrollView = self.scrollView;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  [self setupExampleViews];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

#pragma mark - Supplemental

- (void)setupExampleViews {
  NSBundle *bundle = [NSBundle bundleForClass:[FlexibleHeaderTypicalUseViewController class]];
  [bundle loadNibNamed:@"FlexibleHeaderTypicalUseInstructionsView" owner:self options:nil];

  self.imageView.image =
      [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.scrollView addSubview:self.exampleView];

  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.exampleView.frame = self.view.bounds;
  self.scrollView.contentSize = self.view.bounds.size;
}

@end

@implementation FlexibleHeaderTypicalUseViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Flexible Header" ],
    @"description" : @"The Flexible Header is a container view whose height and vertical offset "
                     @"react to UIScrollViewDelegate events.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
