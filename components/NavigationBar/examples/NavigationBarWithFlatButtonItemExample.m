/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialNavigationBar.h"
#import "MaterialButtons.h"
#import "MaterialIcons+ic_add.h"

#import "NavigationBarTypicalUseExampleSupplemental.h"

@implementation NavigationBarWithFlatButtonItemExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  self.navBar.backgroundColor = UIColor.lightGrayColor;
  self.title = @"With Flat Button";
  self.navBar.titleAlignment = MDCNavigationBarTitleAlignmentLeading;
  self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blackColor};

  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];
  [flatButton setTitle:@"Flat Button" forState:UIControlStateNormal];
  [flatButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
  [flatButton setImage:[MDCIcons imageFor_ic_add] forState:UIControlStateNormal];
  [flatButton addTarget:self
                 action:@selector(itemTapped:)
       forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *flatButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flatButton];
  self.navigationItem.rightBarButtonItem = flatButtonItem;

  NSDictionary *viewBindings = @{ @"navBar" : self.navBar };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];
  [arrayOfConstraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navBar]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints
      addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[navBar]"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];

  [self.view addConstraints:arrayOfConstraints];

  [self setupExampleViews];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)itemTapped:(id)sender {
  NSAssert([sender respondsToSelector:@selector(title)], @"");
  NSLog(@"%@", [sender title]);
}

@end

@implementation NavigationBarWithFlatButtonItemExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar with Flat Button Item" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
