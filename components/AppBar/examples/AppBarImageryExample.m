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

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"

@interface AppBarImageryExample : UITableViewController
@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation AppBarImageryExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create our custom image view and add it to the header view.
  UIImageView *imageView = [[UIImageView alloc]
      initWithImage:
          [UIImage imageNamed:@"mdc_theme"
                                   inBundle:[NSBundle bundleForClass:[AppBarImageryExample class]]
              compatibleWithTraitCollection:nil]];
  imageView.frame = self.appBar.headerViewController.headerView.bounds;

  // Ensure that the image view resizes in reaction to the header view bounds changing.
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  // Ensure that the image view is below other App Bar views (headerStackView).
  [self.appBar.headerViewController.headerView insertSubview:imageView atIndex:0];

  // Scales up the image while the header is over-extending.
  imageView.contentMode = UIViewContentModeScaleAspectFill;

  // The header view does not clip to bounds by default so we ensure that the image is clipped.
  imageView.clipsToBounds = YES;

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme toAppBar:_appBar];

  // Make sure navigation bar background color is clear so the image view is visible.
  self.appBar.navigationBar.backgroundColor = [UIColor clearColor];

  // Allow the header to show more of the image.
  self.appBar.headerViewController.headerView.maximumHeight = 300;

  // Typical use
  self.appBar.headerViewController.headerView.trackingScrollView = self.tableView;

  // Choice: If you do not need to implement any delegate methods and you are not using a
  //         collection view, you can use the headerViewController as the delegate.
  // Alternative: See AppBarTypicalUseExample.
  self.tableView.delegate = self.appBar.headerViewController;

  [self.appBar addSubviewsToParent];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarImageryExample (TypicalUse)

- (id)init {
  self = [super init];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];

    self.title = @"Imagery";

    [self addChildViewController:_appBar.headerViewController];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarImageryExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Imagery" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return YES;
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
    cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.layoutMargins = UIEdgeInsetsZero;
  return cell;
}

@end
