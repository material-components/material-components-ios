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

#import <UIKit/UIKit.h>

#import "MaterialColorScheme.h"
#import "MaterialSlider.h"
#import "MaterialTabs+ColorThemer.h"
#import "MaterialTabs.h"
#import "supplemental/TabBarViewControllerExampleSupplemental.h"

@implementation TabBarViewControllerExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
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

#pragma mark - Private

- (void)loadTabBar {
  NSArray *viewControllers = [self constructExampleViewControllers];
  self.viewControllers = viewControllers;
  self.selectedViewController = self.viewControllers.firstObject;
  self.tabBar.enableRippleBehavior = YES;
  [MDCTabBarColorThemer applySemanticColorScheme:self.colorScheme toTabs:self.tabBar];
}

@end
