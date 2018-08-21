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

#import "MDCActionSheetDataSource.h"

#import "MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetController.h"

static NSString *const ReuseIdentifier = @"BaseCell";

@interface MDCActionSheetDataSource ()
@end

@implementation MDCActionSheetDataSource

- (instancetype)init {
  self = [super init];
  if (self) {
    _actions = [[NSMutableArray alloc] init];
    _backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:action];
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
      [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
  cell.action = self.actions[indexPath.row];
  cell.backgroundColor = self.backgroundColor;
  cell.actionsFont = _actionsFont;
  return cell;
}

@end
