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

#import "MaterialAppBar.h"
#import "MaterialButtons.h"
#import "MaterialCollections.h"
#import "MaterialTabs.h"

#import "TabBarTextOnlyExampleSupplemental.h"
#import "CatalogStyle.h"

@implementation TabBarTextOnlyExample

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    [self setupExampleViews:@[@"Change Alignment", @"Toggle Case"]];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadTabBar];
  self.appBar.headerStackView.bottomBar = self.tabBar;
}

#pragma mark - Action

- (void)toggleCase:(id)sender {
  self.tabBar.displaysUppercaseTitles = !self.tabBar.displaysUppercaseTitles;
}

#pragma mark - Private

- (void)loadTabBar {
  const CGRect bounds = self.view.bounds;

  // Long tab bar with lots of items of varying length. Also demonstrates configurable accent color.
  self.tabBar =
      [[MDCTabBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds) - 20.0f, 0)];
  self.tabBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"This Is" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Tab Bar" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"With" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"A Variety of Titles of Varying Length" image:nil tag:0],
  ];

  // Give it a white appearance to show dark text and customize the unselected title color.
  self.tabBar.selectedItemTintColor = [UIColor whiteColor];
  self.tabBar.unselectedItemTintColor = [UIColor grayColor];
  self.tabBar.tintColor = [CatalogStyle secondaryColor];
  self.tabBar.barTintColor = [CatalogStyle primaryColor];
  self.tabBar.inkColor = [UIColor colorWithWhite:1 alpha:0.1];

  self.tabBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.tabBar sizeToFit];
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

#pragma mark - Options in Collection View


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  if (indexPath.row == 0) {
    [self changeAlignment:collectionView];
  } else {
    [self toggleCase:collectionView];
  }
}

@end
