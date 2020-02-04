// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <UIKit/UIKit.h>

#import "BottomNavigationTypicalUseSupplemental.h"

#include "MDCAvailability.h"
#import "MaterialBottomNavigation.h"
#import "MDCBottomNavigationBar+MaterialTheming.h"
#import "MaterialPalettes.h"

@interface BottomNavigationTypicalUseExample () <MDCBottomNavigationBarDelegate>

@property(nonatomic, assign) int badgeCount;
@property(nonatomic, strong) MDCBottomNavigationBar *bottomNavBar;

@end

@implementation BottomNavigationTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom Navigation";
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)commonBottomNavigationTypicalUseExampleViewDidLoad {
  self.bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectZero];
  self.bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
  self.bottomNavBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
  self.bottomNavBar.delegate = self;
  [self.view addSubview:self.bottomNavBar];

  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                            image:[UIImage imageNamed:@"Home"]
                                                              tag:0];
  UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Messages"
                                                            image:[UIImage imageNamed:@"Email"]
                                                              tag:0];
  tabBarItem2.badgeValue = @"8";
  UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                                            image:[UIImage imageNamed:@"Favorite"]
                                                              tag:0];
  tabBarItem3.badgeValue = @"";
  UITabBarItem *tabBarItem4 = [[UITabBarItem alloc]
      initWithTitle:@"Reader"
              image:[UIImage imageNamed:@"baseline_chrome_reader_mode_black_24pt"
                                             inBundle:[NSBundle
                                                          bundleForClass:
                                                              [BottomNavigationTypicalUseExample
                                                                  class]]
                        compatibleWithTraitCollection:nil]
                tag:0];
  tabBarItem4.badgeValue = @"88";
  UITabBarItem *tabBarItem5 = [[UITabBarItem alloc] initWithTitle:@"Birthday"
                                                            image:[UIImage imageNamed:@"Cake"]
                                                              tag:0];
  tabBarItem5.badgeValue = @"888+";
#if MDC_AVAILABLE_SDK_IOS(10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
  if ([tabBarItem5 respondsToSelector:@selector(badgeColor)]) {
    tabBarItem5.badgeColor = [MDCPalette cyanPalette].accent700;
  }
#pragma clang diagnostic pop
#endif  // MDC_AVAILABLE_SDK_IOS(10_0)
  self.bottomNavBar.items = @[ tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4, tabBarItem5 ];
  self.bottomNavBar.selectedItem = tabBarItem2;

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"+Message"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(updateBadgeItemCount)];
  self.navigationItem.rightBarButtonItem.accessibilityLabel = @"Add a message";
  self.navigationItem.rightBarButtonItem.accessibilityHint =
      @"Increases the badge on the \"Messages\" tab.";
  self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"messages-increment-badge";
}

- (void)layoutBottomNavBar {
  CGRect viewBounds = CGRectStandardize(self.view.bounds);
  CGSize size = [self.bottomNavBar sizeThatFits:viewBounds.size];
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  // Extend the Bottom Navigation to the bottom of the screen.
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.view.safeAreaInsets;
  }
  CGRect bottomNavBarFrame =
      CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width,
                 size.height + safeAreaInsets.bottom);
  self.bottomNavBar.frame = bottomNavBarFrame;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self commonBottomNavigationTypicalUseExampleViewDidLoad];

  [self.bottomNavBar applyPrimaryThemeWithScheme:self.containerScheme];
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutBottomNavBar];
}

- (void)viewSafeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super viewSafeAreaInsetsDidChange];
  }
  [self layoutBottomNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)updateBadgeItemCount {
  // Example of badge with increasing count.
  if (!self.badgeCount) {
    self.badgeCount = 0;
  }
  self.badgeCount++;
  self.bottomNavBar.items[1].badgeValue = [NSNumber numberWithInt:self.badgeCount].stringValue;
}

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(nonnull MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(nonnull UITabBarItem *)item {
  NSLog(@"Selected Item: %@", item.title);
}

@end
