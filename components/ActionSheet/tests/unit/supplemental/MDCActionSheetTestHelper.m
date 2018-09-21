// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCActionSheetTestHelper.h"

@implementation MDCActionSheetTestHelper

+ (NSArray *)colorsToTest {
  UIColor *rgbColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:0.7f];
  UIColor *hsbColor = [UIColor colorWithHue:0.8f saturation:0.8f brightness:0.8f alpha:0.8f];
  UIColor *blackWithAlpha = [UIColor.greenColor colorWithAlphaComponent:0.8f];
  UIColor *black = UIColor.blackColor;
  CIColor *ciColor = [[CIColor alloc] initWithColor:UIColor.blackColor];
  UIColor *uiColorFromCIColor = [UIColor colorWithCIColor:ciColor];
  UIColor *whiteColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
  return @[ rgbColor, hsbColor, blackWithAlpha, black, uiColorFromCIColor, whiteColor ];
}

+ (void)addNumberOfActions:(NSUInteger)actionsCount
             toActionSheet:(MDCActionSheetController *)actionSheet {
  for (NSUInteger actionIndex = 0; actionIndex < actionsCount; ++actionIndex) {
    NSString *actionTitle = [NSString stringWithFormat:@"Action #%@", @(actionIndex)];
    MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:actionTitle
                                                                   image:nil
                                                                 handler:nil];
    [actionSheet addAction:action];
  }
}

+ (NSArray<MDCActionSheetItemTableViewCell *> *)getCellsFromActionSheet:
    (MDCActionSheetController *)actionSheet {
  NSMutableArray *cellsArray = [[NSMutableArray alloc] init];
  [MDCActionSheetTestHelper addNumberOfActions:10 toActionSheet:actionSheet];
  NSUInteger cellsCount = actionSheet.actions.count;
  UITableView *table = actionSheet.tableView;
  for (NSUInteger cellIndex = 0; cellIndex < cellsCount; ++cellIndex) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellIndex inSection:0];
    UITableViewCell *cell = [table.dataSource tableView:table cellForRowAtIndexPath:indexPath];
    MDCActionSheetItemTableViewCell *actionCell = (MDCActionSheetItemTableViewCell *)cell;
    [cellsArray addObject:actionCell];
  }
  return cellsArray;
}

@end
