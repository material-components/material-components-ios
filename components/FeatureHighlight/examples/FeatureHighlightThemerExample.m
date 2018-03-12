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

#import "MaterialButtons.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialThemes.h"
#import "MaterialTypography.h"
#import "MDCFeatureHighlightAccessibilityMutator.h"
#import "MDCFeatureHighlightColorThemer.h"
#import "MDCFeatureHighlightFontThemer.h"
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightThemerExample

- (void)applyFeatureHighlightTheming {
  // You would normally set your UIAppearance properties in your AppDelegate in
  // applicationDidFinishLoading.  We are doing it here to keep the revalent
  // code in the sample.
  // Once this code has been executed ALL MDCFeatureHighlightView's will have the following
  // fonts and color unless they are explicitly set.
  // See Apple > UIKit > UIAppearance
  // https://developer.apple.com/documentation/uikit/uiappearance
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.headline2 = [UIFont fontWithName:@"Zapfino" size:14.0];
  fontScheme.body2 = [UIFont fontWithName:@"Chalkduster" size:12.0];
  UIColor *primaryColor = [UIColor purpleColor];
  MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:primaryColor];

  [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                            toFeatureHighlightView:[MDCFeatureHighlightView appearance]];
  [MDCFeatureHighlightFontThemer applyFontScheme:fontScheme
                          toFeatureHighlightView:[MDCFeatureHighlightView appearance]];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self applyFeatureHighlightTheming];

  self.view.backgroundColor = [UIColor whiteColor];

  self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.infoLabel.text = @"Tap on the button below.";
  self.infoLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleCaption];
  self.infoLabel.textColor =
      [self.infoLabel.textColor colorWithAlphaComponent:[MDCTypography captionFontOpacity]];
  [self.view addSubview:self.infoLabel];

  self.button = [[MDCRaisedButton alloc] init];
  [self.button setBackgroundColor:[UIColor colorWithWhite:0.1f alpha:1]];
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
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                              completion:nil];
  [MDCFeatureHighlightAccessibilityMutator mutate:vc];

  vc.titleText = @"Feature Highlight can use themers";
  vc.bodyText = @"The fonts and colors can be themed.";
  [self presentViewController:vc animated:YES completion:nil];
}

@end
