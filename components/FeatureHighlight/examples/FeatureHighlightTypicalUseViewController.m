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

#import "MaterialButtons.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialTypography.h"

@implementation FeatureHighlightTypicalUseViewController {
  UILabel *_infoLabel;
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

  _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _infoLabel.text = @"Tap anywhere to move the button.";
  _infoLabel.font = [MDCTypography subheadFont];
  _infoLabel.textColor = [_infoLabel.textColor colorWithAlphaComponent:[MDCTypography captionFontOpacity]];
  [self.view addSubview:_infoLabel];

  _button = [[MDCRaisedButton alloc] init];
  [_button setTitle:@"GO!" forState:UIControlStateNormal];
  [_button sizeToFit];
  [_button addTarget:self
                action:@selector(didTapButton:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_button];

  UITapGestureRecognizer *tapRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(didTapBackground:)];
  [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [_button sizeToFit];
  CGRect frame = _button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  _button.frame = frame;

  CGSize labelSize = [_infoLabel sizeThatFits:self.view.frame.size];
  _infoLabel.frame = (CGRect){
    CGPointMake(self.view.frame.size.width/2 - labelSize.width / 2, 20),
    labelSize
  };
}

- (void)didTapButton:(id)sender {
  MDCFeatureHighlightViewController *vc =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:_button
                                                              completion:nil];
  vc.titleText = @"Hey a title";
  vc.bodyText = @"This is the description of the feature highlight view controller.";
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)didTapBackground:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:recognizer.view];
  location.x -= _button.frame.size.width / 2;
  location.y -= _button.frame.size.height / 2;
  _button.frame = (CGRect) { location, _button.frame.size };
}

@end
