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

#import "NavigationBarTypicalUseExampleSupplemental.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialIcons+ic_reorder.h"
#import "MaterialNavigationBar.h"
#import "supplemental/NavigationBarTypicalUseExampleSupplemental.h"

@interface NavigationBarIconsExample ()

@property(nonatomic, strong) MDCNavigationBar *navigationBar;
@property(nonatomic, weak) UIBarButtonItem *trailingBarButtonItem;
@property(nonatomic, weak) UIBarButtonItem *leadingBarButtonItem;

@end
@implementation NavigationBarIconsExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Title";
  self.view.backgroundColor = UIColor.darkGrayColor;

  self.navigationBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.navigationBar observeNavigationItem:self.navigationItem];
  self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};
  [self.view addSubview:self.navigationBar];

  UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[[MDCIcons imageFor_ic_arrow_back]
                        mdf_imageWithHorizontallyFlippedOrientation]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(didTapBackButton)];
  //  backButtonItem.tintColor = UIColor.whiteColor;

  UIBarButtonItem *leadingButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_info]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];
  //  leadingButtonItem.tintColor = UIColor.whiteColor;
  UIBarButtonItem *trailingButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_reorder]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];
  //  trailingButtonItem.tintColor = UIColor.whiteColor;

  self.navigationBar.tintColor = UIColor.whiteColor;
  self.leadingBarButtonItem = leadingButtonItem;
  self.trailingBarButtonItem = trailingButtonItem;
  self.navigationItem.hidesBackButton = NO;
  self.navigationItem.leftBarButtonItems = @[ leadingButtonItem ];
  self.navigationItem.rightBarButtonItem = trailingButtonItem;
  self.navigationItem.backBarButtonItem = backButtonItem;

  if ([self.view respondsToSelector:@selector(safeAreaLayoutGuide)]) {
    UILayoutGuide *layoutGuide = [self.view performSelector:@selector(safeAreaLayoutGuide)];
    [layoutGuide.topAnchor constraintEqualToAnchor:self.navigationBar.topAnchor].active = YES;
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

@end

@implementation NavigationBarIconsExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar With Icons" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
