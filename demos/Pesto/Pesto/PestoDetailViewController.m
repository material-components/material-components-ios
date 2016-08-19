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

#import "PestoDetailViewController.h"
#import "PestoRecipeCardView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialAppBar.h"
#import "MaterialFlexibleHeader.h"

static CGFloat kPestoDetailAnimationDelay = 0.1f;
static CGFloat kPestoDetailAnimationDuration = 0.33f;
static CGFloat kPestoDetailFlexibleHeaderLandscapeHeight = 160.f;
static CGFloat kPestoDetailFlexibleHeaderMinHeight = 320.f;
static CGFloat kPestoDetailRecipeCardHeight = 400.f;

@interface PestoDetailViewController ()

@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, strong) PestoRecipeCardView *bottomView;

@end

@implementation PestoDetailViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  _fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
  [self addChildViewController:_fhvc];

  CGRect imageViewFrame = _fhvc.headerView.bounds;
  _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [_fhvc.headerView addSubview:_imageView];

  _appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:_appBar.headerViewController];

  _appBar.headerViewController.headerView.backgroundColor = [UIColor clearColor];
  _appBar.navigationBar.tintColor = [UIColor whiteColor];

  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(didTapBack:)];
  UIImage *backImage = [UIImage imageNamed:@"Back"];
  backButton.image = backImage;
  self.navigationItem.leftBarButtonItem = backButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.fhvc.headerView.minimumHeight = kPestoDetailFlexibleHeaderMinHeight;
  } else {
    self.fhvc.headerView.minimumHeight = kPestoDetailFlexibleHeaderLandscapeHeight;
    self.fhvc.headerView.maximumHeight = kPestoDetailFlexibleHeaderLandscapeHeight;
  }

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.backgroundColor = [UIColor whiteColor];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.scrollView];

  self.scrollView.delegate = self;
  self.fhvc.headerView.trackingScrollView = self.scrollView;
  self.fhvc.headerView.clipsToBounds = YES;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  CGRect bottomFrame = CGRectMake(0, 0, self.view.bounds.size.width, kPestoDetailRecipeCardHeight);
  self.bottomView = [[PestoRecipeCardView alloc] initWithFrame:bottomFrame];
  self.bottomView.descText = self.descText;
  self.bottomView.title = self.title;
  self.bottomView.iconImageName = self.iconImageName;
  self.bottomView.alpha = 0;
  self.bottomView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.scrollView addSubview:self.bottomView];

  dispatch_async(dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:kPestoDetailAnimationDuration
                          delay:kPestoDetailAnimationDelay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CAMediaTimingFunction *quantumEaseInOut = [CAMediaTimingFunction
                           mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
                       [CATransaction setAnimationTimingFunction:quantumEaseInOut];
                       self.bottomView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                     }];
  });
  [self.appBar addSubviewsToParent];

  // Only display title in the bottom view with no title in the app bar.
  self.bottomView.title = self.title;
  self.appBar.navigationBar.title = @"";
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  if (size.height > size.width) {
    _fhvc.headerView.minimumHeight = kPestoDetailFlexibleHeaderMinHeight;
  } else {
    _fhvc.headerView.minimumHeight = kPestoDetailFlexibleHeaderLandscapeHeight;
    _fhvc.headerView.maximumHeight = kPestoDetailFlexibleHeaderLandscapeHeight;
  }
}

- (void)didTapBack:(id)button {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  self.scrollView.contentSize =
      CGSizeMake(self.bottomView.bounds.size.width, kPestoDetailRecipeCardHeight);
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat contentOffsetY = -scrollView.contentOffset.y;
  if (contentOffsetY < kPestoDetailFlexibleHeaderMinHeight) {
    contentOffsetY = kPestoDetailFlexibleHeaderMinHeight;
  }
  [self.fhvc scrollViewDidScroll:scrollView];
}

@end
