// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialFeatureHighlight+FeatureHighlightAccessibilityMutator.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialTypography.h"
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightCustomFontsExample

- (void)viewDidLoad {
  [super viewDidLoad];

  // You would normally set your UIAppearance properties in your AppDelegate in
  // applicationDidFinishLoading.  We are doing it here to keep the revalent
  // code in the sample.
  // Once this code has been executed ALL MDCFeatureHighlightView's will have the following
  // titleFont and bodyFont unless they are explicitly set.
  // See Apple > UIKit > UIAppearance
  // https://developer.apple.com/documentation/uikit/uiappearance
  [MDCFeatureHighlightView appearance].titleFont = [UIFont fontWithName:@"Zapfino" size:14.0];
  [MDCFeatureHighlightView appearance].bodyFont = [UIFont fontWithName:@"Chalkduster" size:12.0];

  self.view.backgroundColor = [UIColor whiteColor];

  self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.infoLabel.text = @"Tap on the button below.";
  self.infoLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
  self.infoLabel.textColor =
      [self.infoLabel.textColor colorWithAlphaComponent:[MDCTypography captionFontOpacity]];
  [self.view addSubview:self.infoLabel];

  self.button = [[MDCRaisedButton alloc] init];
  [self.button setBackgroundColor:[UIColor colorWithWhite:(CGFloat)0.1 alpha:1]];
  [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.button setTitle:@"Action" forState:UIControlStateNormal];
  [self.button sizeToFit];
  [self.button addTarget:self
                  action:@selector(didTapButton:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.button];
}

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button completion:nil];
  [MDCFeatureHighlightAccessibilityMutator mutate:vc];

  vc.titleText = @"Feature Highlight can use custom fonts";
  vc.bodyText = @"The title and body font can be set individually.";
  [self presentViewController:vc animated:YES completion:nil];
}

@end
