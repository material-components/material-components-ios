// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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


#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialIcons+ic_check_circle.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialIcons+ic_reorder.h"
#import "MaterialNavigationBar.h"

@interface NavigationBarRTL : UIViewController

@property(nonatomic, strong) MDCNavigationBar *navigationBar;

@end

@implementation NavigationBarRTL

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Slightly Long Title";
  self.view.backgroundColor = UIColor.darkGrayColor;

  self.navigationBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.navigationBar observeNavigationItem:self.navigationItem];
  self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.text = self.title;
  label.textColor = [UIColor whiteColor];
  self.navigationBar.titleView = label;

  [self.view addSubview:self.navigationBar];

  UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_info]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];
  UIBarButtonItem *reorderButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_reorder]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];
  UIBarButtonItem *checkCircleButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_check_circle]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];

  self.navigationBar.tintColor = UIColor.whiteColor;
  self.navigationItem.rightBarButtonItems =
      @[ infoButtonItem, reorderButtonItem, checkCircleButtonItem ];

  if (@available(iOS 11.0, *)) {
    [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navigationBar.topAnchor]
        .active = YES;
  } else {
    [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.navigationBar
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0]
        .active = YES;
  }
  NSDictionary *viewsBindings = NSDictionaryOfVariableBindings(_navigationBar);

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navigationBar]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsBindings]];
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapBackButton {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Navigation Bar", @"Navigation Bar TitleView RTL" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
