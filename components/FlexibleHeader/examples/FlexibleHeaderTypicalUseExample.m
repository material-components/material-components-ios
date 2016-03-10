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

@interface FlexibleHeaderTypicalUseViewController : UITableViewController
@end

@implementation FlexibleHeaderTypicalUseViewController {
  MDCFlexibleHeaderViewController *_fhvc;
}

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"Flexible Header", @"Typical use" ];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _fhvc = [MDCFlexibleHeaderViewController new];
    [self addChildViewController:_fhvc];
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
  bar.frame = _fhvc.headerView.bounds;
  bar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [_fhvc.headerView addSubview:bar];

  _fhvc.headerView.trackingScrollView = self.tableView;
  self.tableView.delegate = _fhvc;

  _fhvc.view.frame = self.view.bounds;
  [self.view addSubview:_fhvc.view];

  [_fhvc didMoveToParentViewController:self];
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
  return [_fhvc prefersStatusBarHidden];
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
