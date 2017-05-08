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

#import "MaterialButtons.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

@implementation FeatureHighlightColorThemerTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Themes" ];
}

+ (NSString *)catalogDescription {
  return @"Themes";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.infoLabel.text = @"Tap anywhere to move the button.";
  self.infoLabel.font = [MDCTypography subheadFont];
  self.infoLabel.textColor =
      [self.infoLabel.textColor colorWithAlphaComponent:[MDCTypography captionFontOpacity]];
  [self.view addSubview:self.infoLabel];

  self.button = [[MDCRaisedButton alloc] init];
  [self.button setTitle:@"GO!" forState:UIControlStateNormal];
  [self.button sizeToFit];
  [self.button addTarget:self
                  action:@selector(didTapButton:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.button];

  UITapGestureRecognizer *tapRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackground:)];
  [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.button sizeToFit];
  CGRect frame = self.button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  self.button.frame = frame;

  CGSize labelSize = [self.infoLabel sizeThatFits:self.view.frame.size];
  self.infoLabel.frame = CGRectMake(self.view.frame.size.width / 2 - labelSize.width / 2, 20,
                                    labelSize.width, labelSize.height);
}

- (void)didTapBackground:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:recognizer.view];
  location.x -= self.button.frame.size.width / 2;
  location.y -= self.button.frame.size.height / 2;
  self.button.frame = (CGRect){location, self.button.frame.size};
}

@end
