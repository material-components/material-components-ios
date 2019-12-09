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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialContainerScheme.h"
#import "MaterialPalettes.h"
#import "MaterialProgressView.h"

static const CGFloat kProgressViewHeight = 4;

@interface ProgressViewPillExample : UIViewController

@property(nonatomic, strong) UIView *container;

@property(nonatomic, strong) MDCProgressView *progressView;
@property(nonatomic, strong) UILabel *progressLabel;

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation ProgressViewPillExample

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Progress View Pill";
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Advance"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(didPressAdvanceButton:)];
    self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"advance_button";

    self.containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  self.container = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.container];

  _progressView = [[MDCProgressView alloc] init];
  _progressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_progressView];
  _progressView.progress = (float)0.25;

  // Configure the "pill" effect.
  _progressView.cornerRadius = kProgressViewHeight / 2;

  [self setupConstraints];
}

- (void)didPressAdvanceButton:(UIButton *)sender {
  float advancedProgress = _progressView.progress + (float)0.25;
  if (advancedProgress > (float)1.0) {
    advancedProgress = (float)0.0;
  }

  [_progressView setProgress:advancedProgress animated:YES completion:nil];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.container.frame = UIEdgeInsetsInsetRect(self.view.bounds, self.view.layoutMargins);
}

- (void)setupConstraints {
  NSDictionary *views = @{
    @"container" : _container,
    @"progressView" : _progressView,
  };
  NSDictionary *metrics = @{
    @"topMargin" : @20,
    @"horizontalMargin" : @0,
    @"progressViewHeight" : @(kProgressViewHeight),
  };

  [NSLayoutConstraint
      activateConstraints:
          [NSLayoutConstraint
              constraintsWithVisualFormat:@"V:|-(topMargin)-[progressView(==progressViewHeight)]"
                                  options:0
                                  metrics:metrics
                                    views:views]];

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                                  @"H:|-(horizontalMargin)-[progressView]-(horizontalMargin)-|"
                                                  options:0
                                                  metrics:metrics
                                                    views:views]];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Progress View", @"Progress View Pill" ],
    @"presentable" : @YES,
  };
}

@end
