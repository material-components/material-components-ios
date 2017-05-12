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

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  self.blueButton = [[MDCRaisedButton alloc] init];
  [self.blueButton setTitle:@"Blue Theme" forState:UIControlStateNormal];
  [self.blueButton addTarget:self
                  action:@selector(didTapButton:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.blueButton];

  self.redButton = [[MDCRaisedButton alloc] init];
  [self.redButton setTitle:@"Red Theme" forState:UIControlStateNormal];
  [self.redButton addTarget:self
                      action:@selector(didTapButton:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.redButton];

  self.greenButton = [[MDCRaisedButton alloc] init];
  [self.greenButton setTitle:@"Green Theme" forState:UIControlStateNormal];
  [self.greenButton addTarget:self
                      action:@selector(didTapButton:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.greenButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  CGRect frame = CGRectMake(0, 0, 150, 36);
  frame.origin.x = CGRectGetWidth(self.view.frame) / 2 - frame.size.width / 2;
  frame.origin.y = CGRectGetHeight(self.view.frame) / 2 - frame.size.height / 2 - 100;
  self.blueButton.frame = frame;

  CGRect redFrame = frame;
  redFrame.origin.x = CGRectGetWidth(self.view.frame) / 2 - redFrame.size.width / 2;
  redFrame.origin.y = CGRectGetHeight(self.view.frame) / 2 - redFrame.size.height / 2;
  self.redButton.frame = redFrame;

  CGRect greenFrame = frame;
  greenFrame.origin.x = CGRectGetWidth(self.view.frame) / 2 - greenFrame.size.width / 2;
  greenFrame.origin.y = CGRectGetHeight(self.view.frame) / 2 - greenFrame.size.height / 2 + 100;
  self.greenButton.frame = greenFrame;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Theme Feature Highlight" ];
}

+ (NSString *)catalogDescription {
  return @"Demonstrate theming on feature highlight.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end
