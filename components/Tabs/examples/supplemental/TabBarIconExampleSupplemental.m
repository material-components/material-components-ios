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

#import "MaterialAppBar.h"
#import "MaterialButtons.h"
#import "MaterialTabs.h"
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
      [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(incrementBadges:)];
  self.navigationItem.rightBarButtonItem = badgeIncrementItem;

  self.title = @"Tabs With Icons";

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  self.scrollView.pagingEnabled = YES;
  self.scrollView.scrollEnabled = NO;
  [self.view addSubview:self.scrollView];

  NSDictionary *viewsScrollView =
      @{ @"scrollView" : self.scrollView,
         @"header" : self.appBar.headerStackView };
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[header][scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsScrollView]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsScrollView]];

  // Button to change tab alignments.
  self.alignmentButton = [[MDCRaisedButton alloc] init];
  [self.view addSubview:self.alignmentButton];

  self.alignmentButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.alignmentButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
  [self.alignmentButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40]
      .active = YES;

  [self.alignmentButton setTitle:@"Change Alignment" forState:UIControlStateNormal];
  [self.alignmentButton addTarget:self
                           action:@selector(changeAlignment:)
                 forControlEvents:UIControlEventTouchUpInside];

  UIView *page0 = [[UIView alloc] initWithFrame:CGRectZero];
  page0.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:page0];
  page0.backgroundColor = [[MDCPalette lightBluePalette] tint300];

  UIView *page1 = [[UIView alloc] initWithFrame:CGRectZero];
  page1.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:page1];
  page1.backgroundColor = [[MDCPalette lightBluePalette] tint200];

  [page0.widthAnchor constraintEqualToAnchor:page1.widthAnchor].active = YES;

  [page0.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
  [page0.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;

  NSDictionary *viewsPages = @{ @"page0" : page0, @"page1" : page1 };

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[page0][page1]|"
                                                  options:NSLayoutFormatAlignAllTop |
                                                          NSLayoutFormatAlignAllBottom
                                                  metrics:nil
                                                    views:viewsPages]];
  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[page0]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsPages]];
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
