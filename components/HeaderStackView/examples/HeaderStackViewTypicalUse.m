/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "HeaderStackViewTypicalUseSupplemental.h"
#import "MaterialHeaderStackView.h"

@interface HeaderStackViewTypicalUse ()

@end

@implementation HeaderStackViewTypicalUse

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupExampleViews];

  self.stackView = [[MDCHeaderStackView alloc] init];
  self.stackView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.stackView.topBar = self.topView;
  self.stackView.bottomBar = self.navBar;

  CGRect frame = self.view.bounds;
  self.stackView.frame = frame;
  [self.stackView sizeToFit];

  [self.view addSubview:self.stackView];
}

@end
