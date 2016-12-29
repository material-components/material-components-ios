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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "TabBarIconExampleSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialTabs.h"
#import "MaterialAppBar.h"
@import MaterialComponents.MaterialPalettes;

@implementation TabBarIconExample (Supplemental)

- (void)setupExampleViews {
  self.view.backgroundColor = [UIColor whiteColor];

  self.appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:self.appBar.headerViewController];

  self.appBar.headerViewController.headerView.backgroundColor = [UIColor whiteColor];
  self.appBar.headerViewController.headerView.minimumHeight = 76 + 72;
  self.appBar.headerViewController.headerView.tintColor = [[MDCPalette bluePalette] tint500];

  [self.appBar addSubviewsToParent];

  UIBarButtonItem *badgeIncrementItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Stars"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(incrementBadges:)];
  self.navigationItem.rightBarButtonItem = badgeIncrementItem;
  self.title = @"Tabs With Icons";

  // Button to change tab alignments.
  self.alignmentButton = [[MDCRaisedButton alloc] init];
  [self.alignmentButton setTitle:@"Change Alignment" forState:UIControlStateNormal];
  [self.alignmentButton sizeToFit];
  self.alignmentButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 76 + 72 + 100);
  self.alignmentButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                          UIViewAutoresizingFlexibleBottomMargin |
                                          UIViewAutoresizingFlexibleRightMargin;
  [self.alignmentButton addTarget:self
                           action:@selector(changeAlignment:)
                 forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.alignmentButton];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBar.headerViewController;
}

@end

@implementation TabBarIconExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"Icons and Text" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The tab bar is a component for switching between views of grouped content.";
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
