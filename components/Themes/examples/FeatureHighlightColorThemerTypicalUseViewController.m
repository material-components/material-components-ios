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

@implementation FeatureHighlightColorThemerTypicalUseViewController

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *featureHighlightVC =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button completion:nil];
  featureHighlightVC.titleText = @"Hey a title";
  featureHighlightVC.bodyText = @"This is the description of the feature highlight view controller.";

  MDCTheme *redTheme = [MDCTheme redTheme];
  [MDCFeatureHighlightColorThemer applyTheme:redTheme toFeatureHighlight:featureHighlightVC];

  [self presentViewController:featureHighlightVC animated:YES completion:nil];  
}

@end
