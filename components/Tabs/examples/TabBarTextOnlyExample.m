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
#import "MaterialCollections.h"

#import "TabBarTextOnlyExampleSupplemental.h"

static NSString * const kReusableIdentifierItem = @"Cell";

@implementation TabBarTextOnlyExample

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupExampleViews];

  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  [self loadTabBar];
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
  self.tabBar.center = CGPointMake(CGRectGetMidX(self.view.bounds), 250);
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
  self.tabBar.tintColor = [UIColor colorWithRed:11/255.0 green:232/255.0 blue:94/255.0 alpha:1];
  self.tabBar.barTintColor = [UIColor colorWithWhite:0.1 alpha:1];
  self.tabBar.inkColor = [UIColor colorWithWhite:1 alpha:0.1];

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

#pragma mark - 

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = indexPath.row == 0 ? @"Text Alignment" : @"Toggle Case";
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    [self changeAlignment:collectionView];
  } else {
    [self toggleCase:collectionView];
  }
}

@end
