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
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialColorScheme.h"
#import "MaterialSlider.h"
#import "MaterialTabs.h"
#import "MaterialTabs+ColorThemer.h"
#import "supplemental/TabBarViewControllerExampleSupplemental.h"

@implementation TabBarViewControllerExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

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

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  // Put the button under the header.
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];
  [button setTitle:@"Push and Hide Tab" forState:UIControlStateNormal];
  [button sizeToFit];
  [child1.view addSubview:button];
  [button addTarget:self
                action:@selector(pushHidesNavigation)
      forControlEvents:UIControlEventTouchUpInside];

  UIViewController *child2 = viewControllers[2];
  // Put the button under the header.
  button = [[MDCButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];
  [button setTitle:@"Toggle Tab Bar" forState:UIControlStateNormal];
  [button sizeToFit];
  [child2.view addSubview:button];
  [button addTarget:self
                action:@selector(toggleTabBar)
      forControlEvents:UIControlEventTouchUpInside];
  
  [MDCTabBarColorThemer applySemanticColorScheme:self.colorScheme toTabs:self.tabBar];
}

@end
