/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

@implementation FeatureHighlightColorThemerTypicalUseViewController

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *featureHighlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button completion:nil];
  featureHighlightController.titleText = @"Hey a title";
  featureHighlightController.bodyText =
      @"This is the description of the feature highlight view controller.";

  MDCColorScheme *colorScheme = [[MDCColorScheme alloc] init];
  colorScheme.primaryColor = [MDCPalette redPalette].tint500;
  colorScheme.primaryColorLight = [MDCPalette redPalette].tint100;
  colorScheme.primaryColorDark = [MDCPalette redPalette].tint700;
  colorScheme.secondaryColor = [MDCPalette bluePalette].tint500;
  colorScheme.secondaryColorLight = [MDCPalette bluePalette].tint100;
  colorScheme.secondaryColorDark = [MDCPalette bluePalette].tint700;

  [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                      toFeatureHighlightController:featureHighlightController];

  [self presentViewController:featureHighlightController animated:YES completion:nil];
}

@end
