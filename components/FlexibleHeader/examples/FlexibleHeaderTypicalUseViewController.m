/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MaterialFlexibleHeader.h"

@interface FlexibleHeaderTypicalUseViewController : UITableViewController <MDCFlexibleHeaderParentViewController>
@end

@implementation FlexibleHeaderTypicalUseViewController

@synthesize headerViewController;

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"Flexible Header", @"Typical use" ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [MDCFlexibleHeaderViewController addToParent:self];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIToolbar *bar = [UIToolbar new];
  bar.items = @[ [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                  style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(didTapButton:)] ];
  bar.frame = self.headerViewController.headerView.bounds;
  bar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.headerViewController.headerView addSubview:bar];

  self.headerViewController.headerView.trackingScrollView = self.tableView;
  self.tableView.delegate = self.headerViewController;

  [self.headerViewController addFlexibleHeaderViewToParentViewControllerView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapButton:(id)button {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
  return cell;
}

@end
