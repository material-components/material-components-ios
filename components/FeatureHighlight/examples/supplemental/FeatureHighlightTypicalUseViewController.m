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

#import "FeatureHighlightTypicalUseViewController.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialButtons.h"

@implementation FeatureHighlightTypicalUseViewController {
  UIButton *_button;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Feature Highlight", @"Feature Highlight" ];
}

+ (NSString *)catalogDescription {
  return @"Boop ba doop dee doo.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _button = [[MDCRaisedButton alloc] init];
  [_button setTitle:@"GO!" forState:UIControlStateNormal];
  [_button sizeToFit];
  [_button addTarget:self
                action:@selector(didTapButton:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_button];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [_button sizeToFit];
  CGRect frame = _button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  _button.frame = frame;
}

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                              completion:nil];
  [self presentViewController:vc animated:NO completion:nil];
}

@end
