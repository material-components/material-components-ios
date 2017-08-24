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

#import "FeatureHighlightExampleSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialFeatureHighlight.h"

@implementation FeatureHighlightShownViewExample

- (void)didTapButton:(id)sender {
  MDCFloatingButton *fab =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [fab setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [fab sizeToFit];
  fab.backgroundColor = UIColor.orangeColor;
  [fab addTarget:self action:@selector(fabDidTap:) forControlEvents:UIControlEventTouchUpInside];
  fab.center = _button.center;

  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                             andShowView:fab
                                                              completion:nil];

  vc.titleText = @"Shown views can be interactive";
  vc.bodyText =
      @"Tapping the button below will dismiss it. Tap again to dismiss Feature Highlight.";
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)fabDidTap:(MDCFloatingButton *)sender {
  [sender collapse:YES
        completion:^(void) {
          [sender removeFromSuperview];
        }];
}

@end
