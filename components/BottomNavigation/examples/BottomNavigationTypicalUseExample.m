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

static const CGFloat kBottomNavigationTypicalUseExampleNavHeight = 72.f;

@interface BottomNavigationTypicalUseExample ()

@property(nonatomic, assign) int badgeCount;
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

  CGRect frame =
      CGRectMake(0,
                 self.view.bounds.size.height - kBottomNavigationTypicalUseExampleNavHeight,
                 self.view.bounds.size.width,
                 kBottomNavigationTypicalUseExampleNavHeight);
  _bottomNavView = [[MDCBottomNavigationView alloc] initWithFrame:frame];
  [self.view addSubview:_bottomNavView];

  UITabBarItem *tabBarItem1 =
      [[UITabBarItem alloc] initWithTitle:@"Many items"
                                    image:[UIImage imageNamed:@"Add"]
                                      tag:0];
  UITabBarItem *tabBarItem2 =
      [[UITabBarItem alloc] initWithTitle:@"Item 2"
                                    image:[UIImage imageNamed:@"Menu"]
                                      tag:0];
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
  tabBarItem5.badgeColor = [UIColor blackColor];
  _bottomNavView.navBarItems = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];
  [_bottomNavView selectItem:tabBarItem2];
  [self updateBadgeItemCount];
}

- (void)viewWillLayoutSubviews {

  // Example of changing nav bar item values after the bottom navigation is created.
  _bottomNavView.navBarItems[2].title = @"Third item";
}

- (void)updateBadgeItemCount {
  if (!self.badgeCount) {
    self.badgeCount = 0;
  }
  self.badgeCount++;
  self.bottomNavView.navBarItems[1].badgeValue =
     [NSNumber numberWithInt:self.badgeCount].stringValue;

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self updateBadgeItemCount];
  });
}

@end
