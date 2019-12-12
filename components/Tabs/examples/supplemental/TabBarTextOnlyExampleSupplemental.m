// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import "TabBarTextOnlyExampleSupplemental.h"

static CGFloat const kAppBarMinHeight = 56;
static CGFloat const kTabBarHeight = 48;

static NSString *const kReusableIdentifierItem = @"Cell";

@implementation TabBarTextOnlyExample (Supplemental)

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBarViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBarViewController;
}

- (void)setupExampleViews:(NSArray *)choices {
  self.choices = choices;
  self.title = @"Text Tabs";

  self.appBarViewController = [[MDCAppBarViewController alloc] init];
  [self addChildViewController:self.appBarViewController];

  self.appBarViewController.headerView.trackingScrollView = self.collectionView;
  self.appBarViewController.headerView.shiftBehavior =
      MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;

  self.appBarViewController.navigationBar.tintColor = [UIColor whiteColor];
  self.appBarViewController.headerView.tintColor = [UIColor whiteColor];
  self.appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;
  self.appBarViewController.headerView.minimumHeight = kTabBarHeight;
  self.appBarViewController.headerView.maximumHeight = kAppBarMinHeight + kTabBarHeight;

  UIFont *font = [UIFont monospacedDigitSystemFontOfSize:14 weight:UIFontWeightRegular];

  self.appBarViewController.navigationBar.titleTextAttributes =
      @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : font};
  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];

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
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView
        trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
    [self.appBarViewController.headerView
        trackingScrollViewWillEndDraggingWithVelocity:velocity
                                  targetContentOffset:targetContentOffset];
  }
}

@end

@implementation TabBarTextOnlyExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Tab Bar", @"Text Tabs" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
