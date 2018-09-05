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

#import "BottomSheetPresenterViewController.h"

#import "MaterialButtons.h"

@implementation BottomSheetPresenterViewController {
  MDCButton *_button;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _colorScheme = [[MDCSemanticColorScheme alloc] init];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [_button setTitle:@"Show Bottom Sheet" forState:UIControlStateNormal];
  _button.autoresizingMask =
  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [_button addTarget:self
              action:@selector(presentBottomSheet)
    forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_button];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_button sizeToFit];
  _button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (void)presentBottomSheet {
  // implement in subclasses
}

@end
