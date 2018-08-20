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

#import "MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetController.h"

NSString *const kReuseIdentifier = @"BaseCell";

@interface MDCActionSheetDataSource ()
@end

@implementation MDCActionSheetDataSource

- (instancetype)initWithActions:(NSArray<MDCActionSheetAction *> *)actions {
  self = [super init];
  if (self) {
    self.actions = [NSMutableArray arrayWithArray:[actions copy]];
    [self commonMDCActionSheetListInit];
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.actions = [[NSMutableArray alloc] init];
    [self commonMDCActionSheetListInit];
  }
  return self;
}

- (void)commonMDCActionSheetListInit {
  self.backgroundColor = [UIColor whiteColor];
}

- (void)addAction:(MDCActionSheetAction *)action {
  [self.actions addObject:action];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetItemTableViewCell *cell =
  [[MDCActionSheetItemTableViewCell alloc] initWithAction:self.actions[indexPath.row]
                                 reuseIdentifier:kReuseIdentifier];
  cell.backgroundColor = self.backgroundColor;
  cell.actionsFont = _actionsFont;
  return cell;
}

@end
