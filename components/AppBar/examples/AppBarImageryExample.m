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

@interface AppBarImageryExample : UITableViewController <MDCAppBarParenting>
@end

@implementation AppBarImageryExample

@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create our custom image view and add it to the header view.
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[self headerBackgroundImage]];
  imageView.frame = self.headerViewController.headerView.bounds;

  // Ensure that the image view resizes in reaction to the header view bounds changing.
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  // Ensure that the image view is below other App Bar views (headerStackView).
  [self.headerViewController.headerView.contentView insertSubview:imageView atIndex:0];

  // Scales up the image while the header is over-extending.
  imageView.contentMode = UIViewContentModeScaleAspectFill;

  // The header view does not clip to bounds by default so we ensure that the image is clipped.
  imageView.clipsToBounds = YES;

  // We want navigation bar + status bar tint color to be white, so we set tint color here and
  // implement -preferredStatusBarStyle.
  self.headerViewController.headerView.tintColor = [UIColor whiteColor];

  // Allow the header to show more of the image.
  self.headerViewController.headerView.maximumHeight = 200;

  // Typical use
  self.headerViewController.headerView.trackingScrollView = self.tableView;
  self.tableView.delegate = self.headerViewController;
  MDCAppBarAddViews(self);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

// Typical image loading.
- (UIImage *)headerBackgroundImage {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *imagePath = [bundle pathForResource:@"dinosaur" ofType:@"jpg"];
  return [UIImage imageWithContentsOfFile:imagePath];
}

@end

@implementation AppBarImageryExample (TypicalUse)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Imagery";

    MDCAppBarPrepareParent(self);
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarImageryExample (CatalogByConvention)

+ (NSArray *)catalogHierarchy {
  return @[ @"App Bar", @"Imagery" ];
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation AppBarImageryExample (UITableViewDataSource)

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
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
  return cell;
}

@end
