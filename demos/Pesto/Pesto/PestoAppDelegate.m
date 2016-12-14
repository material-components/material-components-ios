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

#import "PestoAppDelegate.h"
#import "PestoViewController.h"

#import "PestoIcons/PestoIconFavorite.h"
#import "PestoIcons/PestoIconHome.h"
#import "PestoIcons/PestoIconTrending.h"

@interface PestoAppDelegate ()

@end

@implementation PestoAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window makeKeyAndVisible];

  CGRect iconFrame = CGRectMake(0, 0, 32, 32);
  UITabBarController *tabBarController = [[UITabBarController alloc] init];

  PestoViewController *homeViewController = [[PestoViewController alloc] init];
  PestoViewController *favoritesViewController = [[PestoViewController alloc] init];
  PestoViewController *trendingViewController = [[PestoViewController alloc] init];

  homeViewController.tabBarItem.title = @"Home";
  homeViewController.tabBarItem.image = [PestoIconHome drawTileImage:iconFrame];
  favoritesViewController.tabBarItem.title = @"Favorites";
  favoritesViewController.tabBarItem.image = [PestoIconFavorite drawTileImage:iconFrame];
  trendingViewController.tabBarItem.title = @"Trending";
  trendingViewController.tabBarItem.image = [PestoIconTrending drawTileImage:iconFrame];
  tabBarController.viewControllers =
      @[ homeViewController, favoritesViewController, trendingViewController ];
  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1.f];
  tabBarController.tabBar.tintColor = teal;
  tabBarController.tabBar.translucent = NO;
  self.window.rootViewController = tabBarController;

  return YES;
}

@end
