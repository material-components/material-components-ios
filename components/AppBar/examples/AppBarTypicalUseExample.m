/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MaterialAppBar.h"

@interface AppBarTypicalUseExample : UITableViewController <MDCAppBarParenting>
@end

@implementation AppBarTypicalUseExample

@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"App bar", @"Typical use" ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Hello";
    MDCAppBarPrepareParent(self);

    self.headerViewController.headerView.backgroundColor = [UIColor lightGrayColor];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.headerViewController.headerView.trackingScrollView = self.tableView;
  self.tableView.delegate = self.headerViewController;

  MDCAppBarAddViews(self);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapButton:(id)button {
  [self.navigationController popViewControllerAnimated:YES];
}

// We must propagate the header's prefersStatusBarHidden value up so that the status bar's
// visibility can be affected.
- (BOOL)prefersStatusBarHidden {
  return [self.headerViewController prefersStatusBarHidden];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.headerViewController.headerView.trackingScrollView) {
    [self.headerViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.headerViewController.headerView.trackingScrollView) {
    [self.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.headerViewController.headerView.trackingScrollView) {
    MDCFlexibleHeaderView *headerView = self.headerViewController.headerView;
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.headerViewController.headerView.trackingScrollView) {
    MDCFlexibleHeaderView *headerView = self.headerViewController.headerView;
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell"];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
  return cell;
}

@end
