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

#import "MaterialAppBar.h"
#import "MaterialTabs.h"

#import "TabBarTextOnlyExampleSupplemental.h"

static CGFloat const kStatusBarHeight = 20;
static CGFloat const kAppBarMinHeight = 56;
static CGFloat const kTabBarHeight = 48;

static NSString * const kReusableIdentifierItem = @"Cell";

@implementation TabBarTextOnlyExample (Supplemental)

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBar.headerViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBar.headerViewController;
}

- (void)setupExampleViews:(NSArray *)choices {
  self.choices = choices;
  self.title = @"Text Tabs";

  self.appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:self.appBar.headerViewController];

  self.appBar.headerViewController.headerView.trackingScrollView = self.collectionView;
  self.appBar.headerViewController.headerView.shiftBehavior =
      MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

  self.appBar.navigationBar.tintColor = [UIColor whiteColor];
  self.appBar.headerViewController.headerView.tintColor = [UIColor whiteColor];
  self.appBar.headerViewController.headerView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
  self.appBar.headerViewController.headerView.minimumHeight =
      kStatusBarHeight + kTabBarHeight;
  self.appBar.headerViewController.headerView.maximumHeight =
      kStatusBarHeight + kAppBarMinHeight + kTabBarHeight;
  
  self.appBar.navigationBar.titleTextAttributes = @{
      NSForegroundColorAttributeName: [UIColor whiteColor],
      NSFontAttributeName: [UIFont fontWithName:@"RobotoMono-Regular" size:14] };
  [self.appBar addSubviewsToParent];
  
  
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
}

#pragma mark - UICollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.choices.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = self.choices[indexPath.row];
  return cell;
}

#pragma mark - UIScrollViewDelegate Forwarding.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                                                           targetContentOffset:targetContentOffset];
  }
}

@end

@implementation TabBarTextOnlyExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"Text Tabs" ];
}

+ (NSString *)catalogDescription {
  return @"The tab bar is a component for switching between views of grouped content.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
