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

#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define HEXCOLOR(hex) RGBCOLOR(((hex >> 16) & 0xFF), ((hex >> 8) & 0xFF), ((hex)&0xFF))

@interface AppBarTypicalUseExample : UITableViewController <MDCAppBarParenting>
@end

@implementation AppBarTypicalUseExample

@synthesize navigationBar;
@synthesize headerStackView;
@synthesize headerViewController;

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"App Bar", @"Typical use" ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Hello";
    MDCAppBarPrepareParent(self);

    self.headerViewController.headerView.backgroundColor = HEXCOLOR(0x39A4DD);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.delegate = self.headerViewController;

  self.headerViewController.headerView.trackingScrollView = self.tableView;

  MDCAppBarAddViews(self);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.headerViewController;
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
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
  return cell;
}

@end
