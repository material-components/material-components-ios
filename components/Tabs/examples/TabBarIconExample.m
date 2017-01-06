/*
 Copyright 2016-present the Material Components for iOS authors. All Rights
 Reserved.

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

#import "MaterialAppBar.h"
#import "MaterialTabs.h"
@import MaterialComponents.MaterialPalettes;

#import "TabBarIconExampleSupplemental.h"

@implementation TabBarIconExample

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupExampleViews];

  [self loadTabBar];
}

#pragma mark - Action

- (void)incrementBadges:(id)sender {
  // Increment all numeric badge values to show cells updating when their item's
  // properties are set.
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
  [self addStarCentered:NO];
}

#pragma mark - Private

- (void)loadTabBar {
  self.tabBar = [MDCTabBar new];
  self.tabBar.delegate = self;
  self.tabBar.alignment = MDCTabBarAlignmentCenterSelected;

  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  UIImage *infoImage =
      [UIImage imageNamed:@"TabBarDemo_ic_info" inBundle:bundle compatibleWithTraitCollection:nil];
  UIImage *starImage =
      [UIImage imageNamed:@"TabBarDemo_ic_star" inBundle:bundle compatibleWithTraitCollection:nil];
  self.tabBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"Info" image:infoImage tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Stars" image:starImage tag:0]
  ];

  // Give the first item a badge
  [self.tabBar.items[1] setBadgeValue:@"1"];

  UIColor *color = [[MDCPalette bluePalette] tint500];

  self.tabBar.barTintColor = [UIColor whiteColor];
  self.tabBar.tintColor = color;
  self.tabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  self.tabBar.selectedItemTintColor = nil;
  self.tabBar.unselectedItemTintColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
  self.tabBar.inkColor = color;

  self.appBar.headerStackView.bottomBar = self.tabBar;
  [self.appBar.headerStackView setNeedsLayout];
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

#pragma mark - MDCTabBarDelegate
- (void)tabBar:(MDCTabBar *)tabBar didSelectItem:(UITabBarItem *)item {
  NSUInteger index = [tabBar.items indexOfObject:item];
  [self.scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(self.view.bounds), 0)
                           animated:YES];
}

@end
