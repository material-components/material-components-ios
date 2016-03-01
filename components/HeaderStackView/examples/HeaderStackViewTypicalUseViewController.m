/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MaterialHeaderStackView.h"

@interface HeaderStackViewTypicalUseViewController : UIViewController
@end

@implementation HeaderStackViewTypicalUseViewController {
  BOOL _toggled;
  MDCHeaderStackView *_stackView;
}

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"Header stack view", @"Typical use" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _stackView = [MDCHeaderStackView new];
  _stackView.backgroundColor = [UIColor blueColor];

  UINavigationBar *topBar = [UINavigationBar new];
  [topBar pushNavigationItem:self.navigationItem animated:NO];
  _stackView.topBar = topBar;

  UIToolbar *bottomBar = [UIToolbar new];
  bottomBar.items =
      @[ [[UIBarButtonItem alloc] initWithTitle:@"Toggle"
                                          style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(didTapToggleButton:)] ];
  _stackView.bottomBar = bottomBar;

  CGRect frame = self.view.bounds;
  frame.origin.y = 150;
  _stackView.frame = frame;
  [_stackView sizeToFit];

  [self.view addSubview:_stackView];
}

#pragma mark User actions

- (void)didTapToggleButton:(id)sender {
  _toggled = !_toggled;

  [UIView animateWithDuration:0.4
                   animations:^{
                     CGRect frame = _stackView.frame;
                     if (_toggled) {
                       frame.size.height = 200;
                     } else {
                       frame.size = [_stackView sizeThatFits:_stackView.bounds.size];
                     }

                     _stackView.frame = frame;
                     [_stackView layoutIfNeeded];
                   }];
}

@end
