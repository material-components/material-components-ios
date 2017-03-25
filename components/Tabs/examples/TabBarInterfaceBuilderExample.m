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

@import UIKit;

@import MaterialComponents.MaterialPalettes;
@import MaterialComponents.MaterialTabs;

@interface TabBarInterfaceBuilderExample : UIViewController <MDCTabBarDelegate>

@property(weak, nonatomic) IBOutlet MDCTabBar *tabBar;
@property(nonatomic) NSArray<UIColor *> *colors;

@end

@implementation TabBarInterfaceBuilderExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tabBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"Blue" image:nil tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Pink" image:nil tag:1],
    [[UITabBarItem alloc] initWithTitle:@"Red" image:nil tag:2],
    [[UITabBarItem alloc] initWithTitle:@"Green" image:nil tag:3]
  ];

  self.colors = @[
    [MDCPalette bluePalette].tint500, [MDCPalette pinkPalette].tint500,
    [MDCPalette redPalette].tint500, [MDCPalette greenPalette].tint500
  ];

  self.view.backgroundColor = self.colors[0];
}

#pragma mark MDCTabBarDelegate

- (void)tabBar:(MDCTabBar *)tabBar didSelectItem:(UITabBarItem *)item {
  self.view.backgroundColor = self.colors[item.tag];
}

#pragma mark Target / Action

- (IBAction)alignmentButtonDidTouch:(UIButton *)sender {
  UIAlertController *sheet =
      [UIAlertController alertControllerWithTitle:nil
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Leading"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self.tabBar setAlignment:MDCTabBarAlignmentLeading];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Center"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self.tabBar setAlignment:MDCTabBarAlignmentCenter];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Justified"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self.tabBar setAlignment:MDCTabBarAlignmentJustified];
                                          }]];
  [sheet addAction:[UIAlertAction actionWithTitle:@"Selected Center"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self.tabBar
                                                setAlignment:MDCTabBarAlignmentCenterSelected];
                                          }]];
  [self presentViewController:sheet animated:YES completion:nil];
}

@end

@implementation TabBarInterfaceBuilderExample (Supplemental)

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation TabBarInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"Interface Builder" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TabBarInterfaceBuilderExample";
}

@end
