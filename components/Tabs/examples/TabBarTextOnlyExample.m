/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
#import "MaterialTabs.h"

#import "TabBarTextOnlyExampleSupplemental.h"

@implementation TabBarTextOnlyExample

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupExampleViews];

  [self loadTabBar];
}

#pragma mark - Action

- (void)incrementBadges:(id)sender {
  // Increment all numeric badge values to show cells updating when their item's properties are set.
  for (UITabBarItem *item in self.tabBar.items) {
    NSString *badgeValue = item.badgeValue;
    if (badgeValue) {
      NSInteger badgeNumber = badgeValue.integerValue;
      if (badgeNumber > 0) {
        // Update badge value directly - the cell should update immediately.
        item.badgeValue = [NSNumberFormatter localizedStringFromNumber:@(badgeNumber + 1)
                                                           numberStyle:NSNumberFormatterNoStyle];
      }
    }
  }
}

#pragma mark - Private

- (void)loadTabBar {
  const CGRect bounds = self.view.bounds;

  // Long tab bar with lots of items of varying length. Also demonstrates configurable accent color.
  self.tabBar =
      [[MDCTabBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds) - 20.0f, 0)];
  self.tabBar.center = CGPointMake(CGRectGetMidX(self.view.bounds), 250);
  self.tabBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"This Is" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Tab Bar" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"With" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"A Variety of Titles of Varying Length" image:nil tag:0],
  ];

  // Make entire tab bar non-uppercased
  self.tabBar.displaysUppercaseTitles = NO;

  // Give it a white appearance to show dark text and customize the unselected title color.
  self.tabBar.selectedItemTintColor = [UIColor blackColor];
  self.tabBar.unselectedItemTintColor = [UIColor grayColor];
  self.tabBar.tintColor = [UIColor redColor];
  self.tabBar.barTintColor = [UIColor whiteColor];
  self.tabBar.inkColor = [UIColor colorWithWhite:0.0 alpha:0.1];

  self.tabBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.tabBar sizeToFit];
  [self.view addSubview:self.tabBar];
}

- (void)changeAlignment:(id)sender {
  UIAlertController *sheet =
      [UIAlertController alertControllerWithTitle:nil
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Leading"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self setAlignment:MDCTabBarAlignmentLeading];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Center"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self setAlignment:MDCTabBarAlignmentCenter];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Justified"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self setAlignment:MDCTabBarAlignmentJustified];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Selected Center"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self setAlignment:MDCTabBarAlignmentCenterSelected];
                                          }]];
  [self presentViewController:sheet animated:YES completion:nil];
}

- (void)setAlignment:(MDCTabBarAlignment)alignment {
  [self.tabBar setAlignment:alignment animated:YES];
}

@end
