/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActionSheetListViewController.h"
#import "MDCActionSheetItemView.h"

static const CGFloat kCellHeight = 56.f;

@interface MDCActionSheetListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MDCActionSheetListViewController {
  NSArray<MDCActionSheetAction *> *_actions;
}

- (instancetype)initWithActions:(NSArray<MDCActionSheetAction *> *)actions {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    _actions = actions;
    [self commonMDCActionSheetListInit];
  }
  return self;
}

-(void)commonMDCActionSheetListInit {
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kCellHeight;
}

#pragma mark - Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetItemView *cell = [MDCActionSheetItemView cellWithAction:_actions[indexPath.row]];
  return cell;
}

@end
