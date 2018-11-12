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

#import "MaterialColorScheme.h"
#import "MaterialTabs.h"
#import "MaterialTabs+ColorThemer.h"

@interface TabBarViewControllerInterfaceBuilderExample : MDCTabBarViewController
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation TabBarViewControllerInterfaceBuilderExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  self.viewControllers = @[
    [self.storyboard instantiateViewControllerWithIdentifier:@"red"],
    [self.storyboard instantiateViewControllerWithIdentifier:@"blue"],
    [self.storyboard instantiateViewControllerWithIdentifier:@"green"],
  ];
  [MDCTabBarColorThemer applySemanticColorScheme:self.colorScheme toTabs:self.tabBar];
}

@end

@implementation TabBarViewControllerInterfaceBuilderExample (Supplemental)

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

// TabBarViewControllerInterfaceBuilderExample expect that appBars be inside the tabs,
// so don't stick an appBarViewController on it.
- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation TabBarViewControllerInterfaceBuilderExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Tab Bar", @"TabBarViewController Interface Builder" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
    @"storyboardName": @"TabBarViewControllerInterfaceBuilderExample"
  };
}

@end
