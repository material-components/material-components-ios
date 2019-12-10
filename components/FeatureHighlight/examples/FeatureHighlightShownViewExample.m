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

#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialFeatureHighlight+ColorThemer.h"
#import "MaterialFeatureHighlight+FeatureHighlightAccessibilityMutator.h"
#import "MaterialFeatureHighlight.h"
#import "supplemental/FeatureHighlightExampleSupplemental.h"

@implementation FeatureHighlightShownViewExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (MDCContainerScheme *)containerScheme {
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
  scheme.colorScheme = self.colorScheme;
  scheme.typographyScheme = self.typographyScheme;
  return scheme;
}

- (void)didTapButton:(id)sender {
  MDCFloatingButton *fab = [[MDCFloatingButton alloc] init];
  [fab setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [fab sizeToFit];
  fab.center = _button.center;

  [fab applySecondaryThemeWithScheme:self.containerScheme];

  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                             andShowView:fab
                                                              completion:^(BOOL accepted) {
                                                                if (accepted) {
                                                                  [self fabDidTap:fab];
                                                                }
                                                              }];
  [MDCFeatureHighlightAccessibilityMutator mutate:vc];
  [MDCFeatureHighlightColorThemer applySemanticColorScheme:self.colorScheme
                          toFeatureHighlightViewController:vc];
  vc.titleFont = self.typographyScheme.headline6;
  vc.bodyFont = self.typographyScheme.body2;
  vc.titleText = @"Shown views can be interactive";
  vc.bodyText = @"The shown button has custom tap animations.";
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)fabDidTap:(MDCFloatingButton *)sender {
  NSLog(@"Tapped %@", sender);
}

@end
