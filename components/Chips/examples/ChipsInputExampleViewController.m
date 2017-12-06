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

#import "ChipsExamplesSupplemental.h"

#import "MaterialChips.h"
#import "MaterialTextFields.h"

@interface ChipsInputExampleViewController () <MDCChipFieldDelegate>
@end

@implementation ChipsInputExampleViewController {
  MDCChipField *_chipField;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor lightGrayColor];

  _chipField = [[MDCChipField alloc] initWithFrame:CGRectZero];
  _chipField.delegate = self;
  _chipField.textField.placeholderLabel.text = @"This is a chip field.";
  _chipField.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:_chipField];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGRect frame = CGRectInset(self.view.bounds, 10, 10);
  frame.size = [_chipField sizeThatFits:frame.size];
  _chipField.frame = frame;
}

- (void)chipFieldHeightDidChange:(MDCChipField *)chipField {
  [self.view layoutIfNeeded];
}

@end
