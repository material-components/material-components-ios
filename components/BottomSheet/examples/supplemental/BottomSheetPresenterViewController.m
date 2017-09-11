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

#import "BottomSheetPresenterViewController.h"

#import "MaterialButtons.h"

@implementation BottomSheetPresenterViewController {
  MDCButton *_button;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];

  _button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [_button setTitle:@"Show Bottom Sheet" forState:UIControlStateNormal];
  [_button sizeToFit];
  _button.autoresizingMask =
  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [_button addTarget:self
              action:@selector(presentBottomSheet)
    forControlEvents:UIControlEventTouchUpInside];
  _button.center = self.view.center;
  [self.view addSubview:_button];
}

- (void)presentBottomSheet {
  // implement in subclasses
}

@end
