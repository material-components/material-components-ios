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

#import "PestoDetailViewController.h"
#import "PestoRecipeCardView.h"

#import "MaterialAppBar.h"

static CGFloat kPestoDetailAnimationDelay = 0.1f;
static CGFloat kPestoDetailAnimationDuration = 0.33f;
static CGFloat kPestoDetailBottomSheetBackgroundHeight = 320.f;
static CGFloat kPestoDetailBottomSheetHeightPortrait = 380.f;
static CGFloat kPestoDetailBottomSheetHeightLandscape = 300.f;

@interface PestoDetailViewController ()

@property(nonatomic) CGFloat bottomSheetHeight;
@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) PestoRecipeCardView *bottomView;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation PestoDetailViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];
    [self addChildViewController:_appBar.headerViewController];

    _appBar.headerViewController.headerView.backgroundColor = [UIColor clearColor];
    _appBar.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButton;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightPortrait;
  } else {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightLandscape;
  }

  UIView *mainView = [[UIView alloc] initWithFrame:self.view.frame];
  mainView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:mainView];

  CGRect imageViewFrame =
      CGRectMake(0, 0, self.view.frame.size.width, kPestoDetailBottomSheetBackgroundHeight);
  self.imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
  self.imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:self.imageView];

  CGRect bottomFrame =
      CGRectMake(0, kPestoDetailBottomSheetBackgroundHeight, self.view.frame.size.width,
                 self.view.frame.size.height - kPestoDetailBottomSheetBackgroundHeight);
  UIView *bottomViewBackground = [[UIView alloc] initWithFrame:bottomFrame];
  bottomViewBackground.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:bottomViewBackground];

  self.bottomView = [[PestoRecipeCardView alloc] initWithFrame:bottomFrame];
  self.bottomView.iconImageName = self.iconImageName;
  self.bottomView.descText = self.descText;
  self.bottomView.alpha = 0;
  [self.view addSubview:self.bottomView];

  dispatch_async(dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:kPestoDetailAnimationDuration
                          delay:kPestoDetailAnimationDelay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
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
  [self loadImage];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  if (size.width < size.height) {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightPortrait;
  } else {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightLandscape;
  }
  CGRect bottomFrame =
      CGRectMake(0, size.height - self.bottomSheetHeight, size.width, self.bottomSheetHeight);
  self.bottomView.frame = bottomFrame;
}

- (void)loadImage {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.imageView setImage:self.image];
  });
}

- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
