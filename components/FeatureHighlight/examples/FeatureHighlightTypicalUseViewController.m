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

#import "MaterialFeatureHighlight.h"
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightTypicalUseViewController

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button completion:nil];
  vc.mdc_adjustsFontForContentSizeCategory = YES;

  vc.titleText = @"Hey this is a multi-line title for the Feature Highlight";
  vc.bodyText = @"This is the description of the feature highlight view controller.";
  [self presentViewController:vc animated:YES completion:nil];
}

@end
