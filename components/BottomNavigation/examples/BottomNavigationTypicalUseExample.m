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

#import "BottomNavigationTypicalUseSupplemental.h"
#import "MaterialBottomNavigation.h"

@interface BottomNavigationTypicalUseExample ()

@property(nonatomic, strong) MDCBottomNavigationView *bottomNavView;

@end

@implementation BottomNavigationTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom Navigation";
     [self commonBottomNavigationTypicalUseExampleInit];
  }
  return self;
}

- (void)commonBottomNavigationTypicalUseExampleInit {
  self.view.backgroundColor = [UIColor grayColor];

  CGRect frame = CGRectMake(0,
                            self.view.bounds.size.height - 72.f,
                            self.view.bounds.size.width,
                            72.f);
  _bottomNavView = [[MDCBottomNavigationView alloc] initWithFrame:frame];
//  _bottomNavView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_bottomNavView];
  
  UITabBarItem *tabBarItem1 =
      [[UITabBarItem alloc] initWithTitle:@"Item 1"
                                    image:[UIImage imageNamed:@"Add"]
                                      tag:0];
  UITabBarItem *tabBarItem2 =
      [[UITabBarItem alloc] initWithTitle:@"Item 2"
                                           image:[UIImage imageNamed:@"Menu"]
                                             tag:0];
  tabBarItem2.badgeValue = @"5";
  tabBarItem2.badgeColor = [UIColor blueColor];
  UITabBarItem *tabBarItem3 =
      [[UITabBarItem alloc] initWithTitle:@"Item 3"
                                    image:[UIImage imageNamed:@"Add"]
                                      tag:0];
  tabBarItem3.badgeValue = @"88";
  UITabBarItem *tabBarItem4 =
      [[UITabBarItem alloc] initWithTitle:@"Item 4"
                                    image:[UIImage imageNamed:@"Search"]
                                      tag:0];
  UITabBarItem *tabBarItem5 =
      [[UITabBarItem alloc] initWithTitle:@"Item 5"
                                    image:[UIImage imageNamed:@"Add"]
                                      tag:0];
  tabBarItem5.badgeValue = @"New";
  _bottomNavView.navBarItems = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];

}

- (void)viewWillLayoutSubviews {
  _bottomNavView.navBarItems[1].badgeValue = @"100";
  _bottomNavView.navBarItems[2].title = @"Third item";
  _bottomNavView.navBarItems[4].badgeColor = [UIColor orangeColor];
  [_bottomNavView selectItem:_bottomNavView.navBarItems[2]];
}

@end
