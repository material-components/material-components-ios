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

#import <UIKit/UIKit.h>

#import "BottomAppBarViewController.h"
#import "MDCButtonColorThemer.h"

@implementation BottomAppBarViewController

- (id)init {
  self = [super init];
  if (self) {
    [self commonBottomAppBarViewControllerInit];
  }
  return self;
}

- (void)commonBottomAppBarViewControllerInit {
  self.view.backgroundColor = [UIColor whiteColor];

  _bottomBarView = [[MDCBottomAppBarView alloc] initWithFrame:CGRectZero];
  [_bottomBarView setFloatingButtonHidden:YES animated:NO];
  _bottomBarView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
  [self.view addSubview:_bottomBarView];

  // Set the image on the floating button.
  UIImage *addImage = [UIImage imageNamed:@"Add"];
  [self.bottomBarView.floatingButton setImage:addImage forState:UIControlStateNormal];

  // Theme the floating button.
  MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor whiteColor]];
  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:self.bottomBarView.floatingButton];
}

- (void)viewWillLayoutSubviews {
  CGSize size = [_bottomBarView sizeThatFits:self.view.bounds.size];
  CGRect bottomBarViewFrame = CGRectMake(0,
                                         CGRectGetHeight(self.view.bounds) - size.height,
                                         size.width,
                                         size.height);
  _bottomBarView.frame = bottomBarViewFrame;
}


@end

