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

#import "BottomSheetDummyStaticViewController.h"

@implementation BottomSheetDummyStaticViewController {
  // Add a view just beyond the bottom of our bounds so that bottom sheet bounce doesn't reveal the
  // background underneath.
  UIView *_overflowView;
}

- (instancetype)init {
  if (self = [super initWithNibName:nil bundle:nil]) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor redColor];

  _overflowView = [[UIView alloc] initWithFrame:CGRectZero];
  _overflowView.backgroundColor = self.view.backgroundColor;
  [self.view addSubview:_overflowView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize size = self.view.frame.size;
  _overflowView.frame = CGRectMake(0, size.height, size.width, 200);
}

@end
