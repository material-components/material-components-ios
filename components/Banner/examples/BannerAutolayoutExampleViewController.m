// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialBanner.h"
#import "MaterialBanner+Theming.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

static NSString *const exampleText = @"Lorem ipsum dolor";

@interface BannerAutolayoutExampleViewController : UIViewController

@property(nonatomic, readwrite, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic, readwrite, strong) MDCBannerView *bannerView;

@end

@implementation BannerAutolayoutExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  // Action Button
  MDCButton *button = [[MDCButton alloc] init];
  button.translatesAutoresizingMaskIntoConstraints = NO;
  [button applyTextThemeWithScheme:self.containerScheme];
  [button setTitle:@"Material Banner" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(didTapButton)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  NSLayoutConstraint *buttonConstraintCenterX =
      [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
  buttonConstraintCenterX.active = YES;
  NSLayoutConstraint *buttonConstraintCenterY =
      [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
  buttonConstraintCenterY.active = YES;

  // Prepare Banner
  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  bannerView.textView.text = exampleText;
  bannerView.trailingButton.hidden = YES;
  bannerView.showsDivider = YES;
  bannerView.layoutMargins = UIEdgeInsetsZero;
  [bannerView applyThemeWithScheme:self.containerScheme];
  MDCButton *actionButton = bannerView.leadingButton;
  [actionButton applyTextThemeWithScheme:self.containerScheme];
  [actionButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [actionButton addTarget:self
                   action:@selector(didTapDismissOnBannerView)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:bannerView];
  NSLayoutConstraint *bannerViewConstraintTop;
  bannerViewConstraintTop =
      [bannerView.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor];
  bannerViewConstraintTop.active = YES;
  NSLayoutConstraint *bannerViewConstraintLeft =
      [bannerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
  bannerViewConstraintLeft.active = YES;
  NSLayoutConstraint *bannerViewConstraintRight =
      [bannerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
  bannerViewConstraintRight.active = YES;
  bannerView.hidden = YES;
  self.bannerView = bannerView;
}

- (void)didTapButton {
  self.bannerView.hidden = NO;
  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.bannerView);
}

- (void)didTapDismissOnBannerView {
  self.bannerView.hidden = YES;
}

#pragma mark - CBC

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Banner", @"Banner (Autolayout)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

- (NSDictionary<NSString *, void (^)(void)> *)testRunners {
  return @{
    @"visible" : ^{
      [self didTapButton];
    }
  };
}

@end
