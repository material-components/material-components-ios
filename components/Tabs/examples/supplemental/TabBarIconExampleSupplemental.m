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

#import "TabBarIconExampleSupplemental.h"

@import MaterialComponents.MaterialAppBar;
@import MaterialComponents.MaterialButtons;
@import MaterialComponents.MaterialPalettes;
@import MaterialComponents.MaterialTabs;

@implementation TabBarIconExample (Supplemental)

- (void)setupExampleViews {
  [self setupAppBar];

  [self setupScrollView];
  [self setupScrollingContent];

  [self setupAlignmentButton];
}

- (void)setupAlignmentButton {
  self.alignmentButton = [[MDCRaisedButton alloc] init];
  [self.view addSubview:self.alignmentButton];

  self.alignmentButton.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint constraintWithItem:self.alignmentButton
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:self.alignmentButton
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                                constant:-40]
      .active = YES;

  [self.alignmentButton setTitle:@"Change Alignment" forState:UIControlStateNormal];
  [self.alignmentButton addTarget:self
                           action:@selector(changeAlignment:)
                 forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupAppBar {
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
                                      action:@selector(incrementDidTouch:)];
  self.navigationItem.rightBarButtonItem = badgeIncrementItem;

  self.title = @"Tabs With Icons";
}

- (void)setupScrollView {
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
}

- (void)setupScrollingContent {
  UIView *pageInfo = [[UIView alloc] initWithFrame:CGRectZero];
  pageInfo.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:pageInfo];
  pageInfo.backgroundColor = [[MDCPalette lightBluePalette] tint300];

  UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
  infoLabel.textColor = [UIColor whiteColor];
  infoLabel.numberOfLines = 0;
  infoLabel.text =
      @"Tabs enable content organization at a high level, such as switching between views";
  [pageInfo addSubview:infoLabel];

  [NSLayoutConstraint constraintWithItem:infoLabel
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:pageInfo
                               attribute:NSLayoutAttributeCenterX
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:infoLabel
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:pageInfo
                               attribute:NSLayoutAttributeCenterY
                              multiplier:1
                                constant:-50]
      .active = YES;

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[infoLabel]-50-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:@{
                                                                      @"infoLabel" : infoLabel
                                                                    }]];

  self.starPage = [[UIView alloc] initWithFrame:CGRectZero];
  self.starPage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:self.starPage];
  self.starPage.backgroundColor = [[MDCPalette lightBluePalette] tint200];

  [NSLayoutConstraint constraintWithItem:pageInfo
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeWidth
                              multiplier:1
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:pageInfo
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.scrollView
                               attribute:NSLayoutAttributeHeight
                              multiplier:1
                                constant:0]
      .active = YES;

  [NSLayoutConstraint constraintWithItem:self.starPage
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:pageInfo
                               attribute:NSLayoutAttributeWidth
                              multiplier:1
                                constant:0]
      .active = YES;

  NSDictionary *viewsPages = @{ @"page0" : pageInfo, @"page1" : self.starPage };

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

  [self addStarCentered:YES];
}

- (void)addStarCentered:(BOOL)centered {
  UIImage *starImage = [UIImage imageNamed:@"TabBarDemo_ic_star"
                                  inBundle:[NSBundle bundleForClass:[self class]]
             compatibleWithTraitCollection:nil];

  UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
  starView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.starPage addSubview:starView];
  [starView sizeToFit];

  CGFloat x = centered ? 1 : (arc4random_uniform(199) + 1.0) / 100.0;  // 0 < x <=2
  CGFloat y = centered ? 1 : (arc4random_uniform(199) + 1.0) / 100.0;  // 0 < y <=2

  [NSLayoutConstraint constraintWithItem:starView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.starPage
                               attribute:NSLayoutAttributeCenterX
                              multiplier:x
                                constant:0]
      .active = YES;
  [NSLayoutConstraint constraintWithItem:starView
                               attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.starPage
                               attribute:NSLayoutAttributeCenterY
                              multiplier:y
                                constant:0]
      .active = YES;
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
