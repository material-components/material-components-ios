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

#import "FeatureHighlightScalableDynamicTypeController.h"

#import "MaterialButtons.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialTypographyScheme.h"

@implementation FeatureHighlightScalableDynamicTypeController

- (void)showFeatureHighlight:(BOOL)useLegacyFontScaling {
  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_featureButton
                                                              completion:nil];

  vc.mdc_adjustsFontForContentSizeCategory = YES;
  vc.mdc_legacyFontScaling = useLegacyFontScaling;

  vc.titleText = @"Hey this is a multi-line title for the Feature Highlight";
  vc.bodyText = @"This text scales in Dynamic Type.";
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)didTapStandardButton:(id)sender {
  [self showFeatureHighlight:NO];
}

- (void)didTapLegacyButton:(id)sender {
  [self showFeatureHighlight:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  self.featureButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.featureButton setTitle:@"New Feature" forState:UIControlStateNormal];
  [self.featureButton sizeToFit];
  [self.view addSubview:self.featureButton];

  self.showStandardButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.showStandardButton setTitle:@"Show Highlight" forState:UIControlStateNormal];
  [self.showStandardButton sizeToFit];
  [self.showStandardButton addTarget:self
                              action:@selector(didTapStandardButton:)
                    forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.showStandardButton];

  self.showLegacyButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [self.showLegacyButton setTitle:@"Show Highlight (Legacy)" forState:UIControlStateNormal];
  [self.showLegacyButton sizeToFit];
  [self.showLegacyButton addTarget:self
                            action:@selector(didTapLegacyButton:)
                  forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.showLegacyButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.featureButton sizeToFit];
  self.featureButton.center = self.view.center;

  CGRect frame;

  [self.showLegacyButton sizeToFit];
  self.showLegacyButton.center = self.view.center;
  frame = self.showLegacyButton.frame;
  frame.origin.y = CGRectGetHeight(self.view.frame) - 60;
  self.showLegacyButton.frame = frame;

  [self.showStandardButton sizeToFit];
  self.showStandardButton.center = self.view.center;
  frame = self.showStandardButton.frame;
  frame.origin.y = CGRectGetMinY(self.showLegacyButton.frame) - 60;
  self.showStandardButton.frame = frame;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Feature Highlight", @"Feature Highlight (Dynamic Type)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
