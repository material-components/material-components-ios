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
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightShownViewExample

- (void)didTapButton:(id)sender {
  MDCFloatingButton *fab =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [fab setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [fab sizeToFit];
  fab.backgroundColor = UIColor.orangeColor;
  fab.center = _button.center;

  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                             andShowView:fab
                                                              completion:^(BOOL accepted) {
                                                                if (accepted) {
                                                                  [self fabDidTap:fab];
                                                                }
                                                              }];

  vc.titleText = @"Shown views can be interactive";
  vc.bodyText = @"The shown button has custom tap animations.";
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)fabDidTap:(MDCFloatingButton *)sender {
  NSLog(@"Tapped %@", sender);
}

@end
