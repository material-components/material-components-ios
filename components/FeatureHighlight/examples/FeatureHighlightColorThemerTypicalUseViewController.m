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

#import "FeatureHighlightColorThemerSupplemental.h"

#import "MaterialFeatureHighlight.h"
#import "MaterialThemes.h"
#import "MaterialPalettes.h"
#import "MDCFeatureHighlightColorThemer.h"

static NSString *const kTitleText = @"Themed Feature Highlight";
static NSString *const kBodyText =
    @"Feature highlight can be themed with a color scheme.";

@implementation FeatureHighlightColorThemerTypicalUseViewController

- (void)didTapButton:(id)sender {
  if (sender == self.blueButton) {
    MDCFeatureHighlightViewController *featureHighlightController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.blueButton
                                                                completion:nil];
    featureHighlightController.titleText = kTitleText;
    featureHighlightController.bodyText = kBodyText;

    MDCColorScheme *colorScheme = [[MDCColorScheme alloc] init];
    colorScheme.primaryColor = MDCPalette.bluePalette.tint500;
    colorScheme.primaryLightColor = MDCPalette.bluePalette.tint100;

    [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                              toFeatureHighlightView:[MDCFeatureHighlightView appearance]];

    [self presentViewController:featureHighlightController animated:YES completion:nil];
  } else if (sender == self.redButton) {
    MDCFeatureHighlightViewController *featureHighlightController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.redButton
                                                                completion:nil];
    featureHighlightController.titleText = kTitleText;
    featureHighlightController.bodyText = kBodyText;

    MDCColorScheme *colorScheme = [[MDCColorScheme alloc] init];
    colorScheme.primaryColor = MDCPalette.redPalette.tint500;
    colorScheme.primaryLightColor = MDCPalette.redPalette.tint100;

    [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                              toFeatureHighlightView:[MDCFeatureHighlightView appearance]];

    [self presentViewController:featureHighlightController animated:YES completion:nil];
  } else {
    MDCFeatureHighlightViewController *featureHighlightController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.greenButton
                                                                completion:nil];
    featureHighlightController.titleText = kTitleText;
    featureHighlightController.bodyText = kBodyText;

    MDCColorScheme *colorScheme = [[MDCColorScheme alloc] init];
    colorScheme.primaryColor = [MDCPalette greenPalette].tint500;
    colorScheme.primaryLightColor = [MDCPalette greenPalette].tint100;

    [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                              toFeatureHighlightView:[MDCFeatureHighlightView appearance]];

    [self presentViewController:featureHighlightController animated:YES completion:nil];
  }
}

@end
