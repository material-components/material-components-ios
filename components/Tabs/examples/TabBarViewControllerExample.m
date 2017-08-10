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

#import "MaterialButtons.h"
#import "MaterialSlider.h"
#import "MaterialTabs.h"

#import "TabBarViewControllerExampleSupplemental.h"

@implementation TabBarViewControllerExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  [self setupTabBarColors];
  [self loadTabBar];
}

#pragma mark - Action

- (void)toggleTabBar {
  [self setTabBarHidden:!self.tabBarHidden animated:YES];
}

- (void)pushHidesNavigation {
  UIViewController *vc =
      [TBVCSampleViewController sampleWithTitle:@"Push&Hide" color:UIColor.grayColor];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private

- (void)loadTabBar {
  NSArray *viewControllers = [self constructExampleViewControllers];
  self.viewControllers = viewControllers;
  UIViewController *child0 = viewControllers[0];
  self.selectedViewController = child0;
  UIViewController *child1 = viewControllers[1];
  // Put the button under the header.
  MDCRaisedButton *button = [[MDCRaisedButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
  [button setTitle:@"Push and Hide Tab" forState:UIControlStateNormal];
  [button sizeToFit];
  [child1.view addSubview:button];
  [button addTarget:self
                action:@selector(pushHidesNavigation)
      forControlEvents:UIControlEventTouchUpInside];

  UIViewController *child2 = viewControllers[2];
  // Put the button under the header.
  button = [[MDCRaisedButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
  [button setTitle:@"Toggle Tab Bar" forState:UIControlStateNormal];
  [button sizeToFit];
  [child2.view addSubview:button];
  [button addTarget:self
                action:@selector(toggleTabBar)
      forControlEvents:UIControlEventTouchUpInside];
}

// TabBarViewController expect that appBars be inside the tabs, so don't stick
// an appBar on it.
- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
