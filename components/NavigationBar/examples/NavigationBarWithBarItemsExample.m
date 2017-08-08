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

#import "NavigationBarTypicalUseExampleSupplemental.h"

@implementation NavigationBarWithBarItemsExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  self.title = @"With Items";

  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Leading"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(itemTapped:)];
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Trailing"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(itemTapped:)];

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self.navBar observeNavigationItem:self.navigationItem];

  [self.navBar setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
  MDCNavigationBarTextColorAccessibilityMutator *mutator =
      [[MDCNavigationBarTextColorAccessibilityMutator alloc] init];
  [mutator mutate:self.navBar];

  [self.view addSubview:self.navBar];

  self.navBar.translatesAutoresizingMaskIntoConstraints = NO;

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

@implementation NavigationBarWithBarItemsExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar with Items" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
