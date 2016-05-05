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

#import "MaterialSpritedAnimationView.h"

static CGFloat kPestoDetailAnimationDelay = 0.1f;
static CGFloat kPestoDetailAnimationDuration = 0.33f;
static CGFloat kPestoDetailBottomSheetBackgroundHeight = 320.f;
static CGFloat kPestoDetailBottomSheetHeightPortrait = 380.f;
static CGFloat kPestoDetailBottomSheetHeightLandscape = 300.f;
NSString *const kPestoMenuToBackArrow = @"mdc_sprite_menu__arrow_back";
NSString *const kPestoBackArrowToMenu = @"mdc_sprite_arrow_back__menu";

@interface PestoDetailViewController ()

@property(nonatomic) CGFloat bottomSheetHeight;
@property(nonatomic) PestoRecipeCardView *bottomView;
@property(nonatomic) UIImageView *imageView;
@property(nonatomic) BOOL showMenuIcon;

@end

@implementation PestoDetailViewController

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

  CGRect imageViewFrame = CGRectMake(0,
                                     0,
                                     self.view.frame.size.width,
                                     kPestoDetailBottomSheetBackgroundHeight);
  self.imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
  self.imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:self.imageView];

  CGRect bottomFrame =
      CGRectMake(0,
                 kPestoDetailBottomSheetBackgroundHeight,
                 self.view.frame.size.width,
                 self.view.frame.size.height - kPestoDetailBottomSheetBackgroundHeight);
  UIView *bottomViewBackground = [[UIView alloc] initWithFrame:bottomFrame];
  bottomViewBackground.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:bottomViewBackground];

  self.bottomView = [[PestoRecipeCardView alloc] initWithFrame:bottomFrame];
  self.bottomView.title = self.title;
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

  UIImage *spriteImage = [UIImage imageNamed:kPestoBackArrowToMenu];
  self.animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  self.animationView.frame = CGRectMake(20.f, 20.f, 24.f, 24.f);
  self.animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:self.animationView];

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tapDetected)];
  tap.numberOfTapsRequired = 1;
  self.animationView.userInteractionEnabled = YES;
  [self.animationView addGestureRecognizer:tap];
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
  CGRect bottomFrame = CGRectMake(0,
                                  size.height - self.bottomSheetHeight,
                                  size.width,
                                  self.bottomSheetHeight);
  self.bottomView.frame = bottomFrame;
}

- (void)loadImage {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.imageView setImage:self.image];
  });
}

- (void)tapDetected {
  [self.animationView startAnimatingWithCompletion:^{
    self.showMenuIcon = !self.showMenuIcon;
    NSString *imageName = (self.showMenuIcon
                               ? kPestoBackArrowToMenu
                               : kPestoMenuToBackArrow);
    UIImage *spriteImage = [UIImage imageNamed:imageName];
    self.animationView.spriteSheetImage = spriteImage;
    self.animationView.hidden = YES;
  }];
  [self dismissViewControllerAnimated:YES completion:nil];
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
