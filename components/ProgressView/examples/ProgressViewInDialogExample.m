// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MaterialButtons+Theming.h"
#import "MaterialDialogs.h"
#import "MaterialProgressView.h"
#import "MaterialProgressView+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

// static const CGFloat kMDCProgressViewIndeterminateAnimationDuration = 4;
static const CGFloat kMDCProgressViewHeight = 2;

@interface ProgressViewInDialogExample : UIViewController

@property(nonatomic, strong) MDCAlertController *alertViewController;
@property(nonatomic, strong) MDCProgressView *indeterminateProgressView;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, strong) MDCButton *alertButton;
@end

@implementation ProgressViewInDialogExample

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.title = @"Progress View (Dialogs)";
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  [self setupButton];
  [self setupDialog];
}

- (void)setupButton {
  MDCButton *alertButton = [[MDCButton alloc] init];
  [alertButton setTitle:@"Present Dialog" forState:UIControlStateNormal];
  [alertButton applyTextThemeWithScheme:self.containerScheme];
  [alertButton addTarget:self
                  action:@selector(didTapButton)
        forControlEvents:UIControlEventTouchUpInside];
  alertButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:alertButton];
  [alertButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [alertButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
  self.alertButton = alertButton;
}

- (void)setupDialog {
  MDCProgressView *indeterminateProgressView = [[MDCProgressView alloc] init];
  indeterminateProgressView.mode = MDCProgressViewModeIndeterminate;
  indeterminateProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  indeterminateProgressView.frame = CGRectMake(0, 0, 0, kMDCProgressViewHeight);
  [indeterminateProgressView applyThemeWithScheme:self.containerScheme];
  [indeterminateProgressView startAnimating];
  self.indeterminateProgressView = indeterminateProgressView;

  MDCAlertController *alertViewController = [[MDCAlertController alloc] init];
  alertViewController.title = @"Dialog with Progress View";
  MDCAlertAction *dismissAction = [MDCAlertAction
      actionWithTitle:@"OK"
              handler:^(MDCAlertAction *_Nonnull action) {
                [self.alertViewController dismissViewControllerAnimated:YES completion:nil];
              }];
  [alertViewController addAction:dismissAction];
  alertViewController.accessoryView = indeterminateProgressView;
  self.alertViewController = alertViewController;
}

- (void)didTapButton {
  [self presentViewController:self.alertViewController animated:YES completion:nil];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Progress View", @"Progress View In Dialog" ],
    @"description" : @"Progress indicators presented in a dialog",
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
