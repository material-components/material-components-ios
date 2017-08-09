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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "ThemerTypicalUseSupplemental.h"

@implementation ThemerTypicalUseViewController (Supplemental)

- (instancetype)initWithColorScheme:(NSObject<MDCColorScheme> *)colorScheme {
  self = [super init];
  if (self) {
    [self setupAppBar];
    self.colorScheme = colorScheme;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 600);
  
  self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, 80);
  self.alertButton.center = CGPointMake(self.view.frame.size.width / 2 - 100, 160);
  self.featureButton.center = CGPointMake(self.view.frame.size.width / 2 + 50, 160);
  self.slider.center = CGPointMake(self.view.frame.size.width / 2, 240);
  self.progressView.center = CGPointMake(self.view.frame.size.width / 2, 320);
  self.floatingButton.center = CGPointMake(self.view.frame.size.width / 2, 400);
  self.textField.center = CGPointMake(self.view.frame.size.width / 2, 480);
}

- (void)setupAppBar {
  self.title = @"Themes";

  self.appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:self.appBar.headerViewController];

  self.appBar.navigationBar.tintColor = [UIColor whiteColor];
  self.appBar.navigationBar.titleTextAttributes =
      @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setupExampleViews {
  self.view.backgroundColor = [UIColor whiteColor];
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.scrollView];

  self.appBar.headerViewController.headerView.trackingScrollView = self.scrollView;
  self.scrollView.delegate = self.appBar.headerViewController;
  [self.appBar addSubviewsToParent];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                       style:UIBarButtonItemStyleDone
                                      target:nil
                                      action:nil];

  CGRect defaultRect = CGRectMake(0, 0, 32, 32);
  self.activityIndicator =
      [[MDCActivityIndicator alloc] initWithFrame:defaultRect];
  self.activityIndicator.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  [self.activityIndicator sizeToFit];
  [self.scrollView addSubview:self.activityIndicator];
  [self.activityIndicator startAnimating];

  self.alertButton = [[MDCRaisedButton alloc] init];
  [self.alertButton setTitle:@"Alert" forState:UIControlStateNormal];
  [self.alertButton sizeToFit];
  self.alertButton.center = CGPointMake(100, 100);
  [self.scrollView addSubview:self.alertButton];
  [self.alertButton addTarget:self
                  action:@selector(didTapShowAlert:)
        forControlEvents:UIControlEventTouchUpInside];

  self.featureButton = [[MDCRaisedButton alloc] init];
  [self.featureButton setTitle:@"Feature Highlight" forState:UIControlStateNormal];
  [self.featureButton sizeToFit];
  self.featureButton.center = CGPointMake(100, 100);
  [self.scrollView addSubview:self.featureButton];
  [self.featureButton addTarget:self
                         action:@selector(didTapShowFeature:)
               forControlEvents:UIControlEventTouchUpInside];

  CGRect sliderRect = CGRectMake(0, 0, 200, 32);
  self.slider = [[MDCSlider alloc] initWithFrame:sliderRect];
  self.slider.value = 0.5f;
  [self.scrollView addSubview:self.slider];

  CGRect progressRect = CGRectMake(0, 0, 200, 4);
  self.progressView = [[MDCProgressView alloc] initWithFrame:progressRect];
  [self.scrollView addSubview:self.progressView];
  [self animateStep1:self.progressView];

  self.floatingButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [self.floatingButton sizeToFit];
  [self.scrollView addSubview:self.floatingButton];

  self.textField = [[MDCTextField alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
  [self.scrollView addSubview:self.textField];
  self.textField.placeholder = @"Text Field";
  self.textInputControllerDefault =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.textField];
}

- (void)didTapShowAlert:(id)sender {
  NSString *titleString = @"Themed Alert";
  NSString *messageString = @"Button text color of alert is themed.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  MDCAlertAction *agreeAction = [MDCAlertAction actionWithTitle:@"AGREE"
                                                        handler:^(MDCAlertAction *action) {
                                                          NSLog(@"%@", @"AGREE pressed");
                                                        }];
  [materialAlertController addAction:agreeAction];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (void)didTapShowFeature:(id)sender {
  NSString *titleText = @"Themed Feature Highlight";
  NSString *bodyText = @"Feature highlight can be themed with a color scheme.";

  MDCFeatureHighlightViewController *featureHighlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.featureButton
                                                              completion:nil];
  featureHighlightController.titleText = titleText;
  featureHighlightController.bodyText = bodyText;
  [self presentViewController:featureHighlightController animated:YES completion:nil];
}

- (void)animateStep1:(MDCProgressView *)progressView {
  progressView.progress = 0;
  __weak MDCProgressView *weakProgressView = progressView;
  [progressView setHidden:NO
                 animated:YES
               completion:^(BOOL finished) {
                 [self performSelector:@selector(animateStep2:)
                            withObject:weakProgressView
                            afterDelay:MDCProgressViewAnimationDuration];
               }];
}

- (void)animateStep2:(MDCProgressView *)progressView {
  [progressView setProgress:0.5 animated:YES completion:nil];
  [self performSelector:@selector(animateStep3:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep3:(MDCProgressView *)progressView {
  [progressView setProgress:1 animated:YES completion:nil];
  [self performSelector:@selector(animateStep4:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep4:(MDCProgressView *)progressView {
  __weak MDCProgressView *weakProgressView = progressView;
  [progressView setHidden:YES
                 animated:YES
               completion:^(BOOL finished) {
                 [self performSelector:@selector(animateStep1:)
                            withObject:weakProgressView
                            afterDelay:MDCProgressViewAnimationDuration];
               }];
}

@end
