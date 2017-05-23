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

@import UIKit;

@import MaterialComponents.MaterialTabs;

@interface TabBarViewControllerInterfaceBuilderExample : MDCTabBarViewController

@end

@implementation TabBarViewControllerInterfaceBuilderExample

- (void)awakeFromNib {
  [super awakeFromNib];
  self.viewControllers = @[
    [self.storyboard instantiateViewControllerWithIdentifier:@"red"],
    [self.storyboard instantiateViewControllerWithIdentifier:@"blue"],
    [self.storyboard instantiateViewControllerWithIdentifier:@"green"],
  ];
  // Default is white text on a white background.
  self.tabBar.backgroundColor = [UIColor grayColor];
}

@end

@implementation TabBarViewControllerInterfaceBuilderExample (Supplemental)

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

// TabBarViewControllerInterfaceBuilderExample expect that appBars be inside the tabs,
// so don't stick an appBar on it.
- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation TabBarViewControllerInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"TabBarViewController Interface Builder" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TabBarViewControllerInterfaceBuilderExample";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (NSString *)catalogDescription {
  return @"The tab bar controller is a view controller for switching between views of "
      "grouped content.";
}


@end
