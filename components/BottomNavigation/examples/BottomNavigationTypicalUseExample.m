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
#import "MaterialPalettes.h"
#import "MaterialThemes.h"
#import "MDCBottomNavigationBarColorThemer.h"

@interface BottomNavigationTypicalUseExample ()

@property(nonatomic, assign) int badgeCount;
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;

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
  self.view.backgroundColor = [UIColor lightGrayColor];

  _bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectZero];
  _bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  _bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  _bottomNavBar.delegate = self;
  [self.view addSubview:_bottomNavBar];

  MDCBasicColorScheme *scheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette purplePalette].tint700
                                         secondaryColor:[UIColor whiteColor]];
  [MDCBottomNavigationBarColorThemer applyColorScheme:scheme toBottomNavigationBar:_bottomNavBar];

  UITabBarItem *tabBarItem1 =
      [[UITabBarItem alloc] initWithTitle:@"Home"
                                    image:[UIImage imageNamed:@"Home"]
                                      tag:0];
  UITabBarItem *tabBarItem2 =
      [[UITabBarItem alloc] initWithTitle:@"Messages"
                                    image:[UIImage imageNamed:@"Email"]
                                      tag:0];
  UITabBarItem *tabBarItem3 =
      [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                    image:[UIImage imageNamed:@"Favorite"]
                                      tag:0];
  UITabBarItem *tabBarItem4 =
      [[UITabBarItem alloc] initWithTitle:@"Search"
                                    image:[UIImage imageNamed:@"Search"]
                                      tag:0];
  tabBarItem4.badgeValue = @"88";
  UITabBarItem *tabBarItem5 =
      [[UITabBarItem alloc] initWithTitle:@"Birthday"
                                    image:[UIImage imageNamed:@"Cake"]
                                      tag:0];
  tabBarItem5.badgeValue = @"999+";
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  if ([tabBarItem5 respondsToSelector:@selector(badgeColor)]) {
    tabBarItem5.badgeColor = [MDCPalette cyanPalette].accent700;
  }
#pragma clang diagnostic pop
#endif
  _bottomNavBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];
  _bottomNavBar.selectedItem = tabBarItem2;
  [self updateBadgeItemCount];
}

- (void)viewWillLayoutSubviews {
  CGSize size = [_bottomNavBar sizeThatFits:self.view.bounds.size];
  CGRect bottomNavBarFrame = CGRectMake(0,
                                        CGRectGetHeight(self.view.bounds) - size.height,
                                        size.width,
                                        size.height);
  _bottomNavBar.frame = bottomNavBarFrame;
}

- (void)updateBadgeItemCount {

  // Example of badge with increasing count.
  if (!self.badgeCount) {
    self.badgeCount = 0;
  }
  self.badgeCount++;
  self.bottomNavBar.items[1].badgeValue = [NSNumber numberWithInt:self.badgeCount].stringValue;

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self updateBadgeItemCount];
  });
}

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item {
  NSLog(@"Selected Item: %@", item.title);
}

@end
