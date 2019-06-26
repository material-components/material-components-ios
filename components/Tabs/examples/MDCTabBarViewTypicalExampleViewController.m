// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MaterialComponents/MaterialContainerScheme.h>
#import "MaterialTabs+TabBarView.h"

static NSString *const kExampleTitle = @"TabBarView";

/**
 Typical use example showing how to place an @c MDCTabBarView within another view.
 */
@interface MDCTabBarViewTypicalExampleViewController : UIViewController

/** The tab bar for this example. */
@property(nonatomic, strong) MDCTabBarView *tabBar;

/** The container scheme injected into this example. */
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation MDCTabBarViewTypicalExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = kExampleTitle;

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;

  UITabBarItem *item1 = [[UITabBarItem alloc]
      initWithTitle:@"Home"
              image:[[UIImage imageNamed:@"Home"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc]
      initWithTitle:@"Favorite"
              image:[[UIImage imageNamed:@"Favorite"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:1];
  UITabBarItem *item3 = [[UITabBarItem alloc]
      initWithTitle:@"Cake"
              image:[[UIImage imageNamed:@"Cake"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc]
      initWithTitle:@"Email"
              image:[[UIImage imageNamed:@"Email"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:3];
  UITabBarItem *item5 = [[UITabBarItem alloc]
      initWithTitle:@"Search"
              image:[[UIImage imageNamed:@"Search"]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                tag:4];

  self.tabBar = [[MDCTabBarView alloc] init];
  self.tabBar.items = @[ item1, item2, item3, item4, item5 ];
  self.tabBar.barTintColor = self.containerScheme.colorScheme.secondaryColor;
  [self.tabBar setTitleColor:self.containerScheme.colorScheme.onSecondaryColor
                    forState:UIControlStateNormal];
  [self.tabBar setTitleColor:self.containerScheme.colorScheme.primaryColor
                    forState:UIControlStateSelected];
  [self.tabBar setImageTintColor:self.containerScheme.colorScheme.onSecondaryColor
                        forState:UIControlStateNormal];
  [self.tabBar setImageTintColor:self.containerScheme.colorScheme.primaryColor
                        forState:UIControlStateSelected];
  self.tabBar.selectedItem = item1;
  self.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.tabBar];

  if (@available(iOS 11.0, *)) {
    [self.view.layoutMarginsGuide.topAnchor constraintEqualToAnchor:self.tabBar.topAnchor].active =
        YES;
  } else {
    [self.topLayoutGuide.bottomAnchor constraintEqualToAnchor:self.tabBar.topAnchor].active = YES;
  }
  [self.view.leftAnchor constraintEqualToAnchor:self.tabBar.leftAnchor].active = YES;
  [self.view.rightAnchor constraintEqualToAnchor:self.tabBar.rightAnchor].active = YES;
}

@end

#pragma mark - CatalogByConvention
@implementation MDCTabBarViewTypicalExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Tab Bar", kExampleTitle ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
