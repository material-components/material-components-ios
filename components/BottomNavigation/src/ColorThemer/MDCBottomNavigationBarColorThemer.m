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
#import <Foundation/Foundation.h>
#import "MDCBottomNavigationBarColorThemer.h"

@implementation MDCBottomNavigationBarColorThemer

+ (void)applyColorScheme:(id<MDCColorScheme>)colorScheme
    toBottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar {
  bottomNavigationBar.selectedItemTintColor = colorScheme.primaryLightColor;
  bottomNavigationBar.unselectedItemTintColor = colorScheme.primaryDarkColor;
  bottomNavigationBar.backgroundColor = colorScheme.secondaryColor;
}

+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme toBottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar {
  bottomNavigationBar.backgroundColor = colorScheme.backgroundColor;
  bottomNavigationBar.selectedItemTintColor = colorScheme.primaryColor;
  bottomNavigationBar.unselectedItemTintColor = colorScheme.textColor;
}

+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme toUITabBarItem:(UITabBarItem *)tabBarItem {
  NSOperatingSystemVersion iOS10Version = {10, 0, 0};
  if ([NSProcessInfo.processInfo isOperatingSystemAtLeastVersion:iOS10Version]) {
    tabBarItem.badgeColor = colorScheme.primaryColor;
    NSMutableDictionary *badgeTextAttributes = [[tabBarItem badgeTextAttributesForState:UIControlStateNormal] mutableCopy];
    badgeTextAttributes[NSForegroundColorAttributeName] = colorScheme.textColor;
    [tabBarItem setBadgeTextAttributes:[badgeTextAttributes copy] forState:UIControlStateNormal];
  }
}

@end
