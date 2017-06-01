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

#import "AppDelegate.h"
#import "ProductGridViewController.h"
#import "ProductStorageHelper.h"

#import "MaterialSnackbar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  // Instantiate a UITabBarController with 3 ProductGridViewControllers
  NSString *const mainStoryboardName = @"ProductGrid";
  ProductGridViewController *home = [UIStoryboard storyboardWithName:mainStoryboardName bundle:nil].instantiateInitialViewController;
  home.isHome = YES;
  home.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
  home.tabBarItem.title = @"Home";
  home.tabBarItem.image = [UIImage imageNamed:@"Diamond"];
  home.products = productsFor(ProductCategoryHome);

  ProductGridViewController *clothing = [UIStoryboard storyboardWithName:mainStoryboardName bundle:nil].instantiateInitialViewController;
  clothing.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
  clothing.tabBarItem.title = @"Clothing";
  clothing.tabBarItem.image = [UIImage imageNamed:@"HeartFull"];
  clothing.products = productsFor(ProductCategoryClothing);

  ProductGridViewController *popsicles = [UIStoryboard storyboardWithName:mainStoryboardName bundle:nil].instantiateInitialViewController;
  popsicles.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
  popsicles.tabBarItem.title = @"Popsicles";
  popsicles.tabBarItem.image = [UIImage imageNamed:@"Cart"];
  popsicles.products = productsFor(ProductCategoryPopsicles);

  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  tabBarController.viewControllers = @[ clothing, home, popsicles ];
  tabBarController.tabBar.tintColor = [UIColor colorWithRed:96/255.0 green:125/255.0 blue:139/255.0 alpha:1];
  tabBarController.selectedIndex = 1;

  // Make the UITabBarController the main interface of the app
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = tabBarController;
  [self.window makeKeyAndVisible];

  [MDCSnackbarManager setBottomOffset:tabBarController.tabBar.bounds.size.height];

  return YES;
}

@end
