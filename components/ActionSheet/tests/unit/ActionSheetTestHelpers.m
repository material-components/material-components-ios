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

#import "ActionSheetTestHelpers.h"

#import <CoreImage/CoreImage.h>

#import "../../src/private/MDCActionSheetItemTableViewCell.h"
#import "MaterialActionSheet.h"

@implementation ActionSheetTestHelpers

+ (NSArray *)colorsToTest {
  UIColor *rgbColor = [UIColor colorWithRed:(CGFloat)0.7
                                      green:(CGFloat)0.7
                                       blue:(CGFloat)0.7
                                      alpha:(CGFloat)0.7];
  UIColor *hsbColor = [UIColor colorWithHue:(CGFloat)0.8
                                 saturation:(CGFloat)0.8
                                 brightness:(CGFloat)0.8
                                      alpha:(CGFloat)0.8];
  UIColor *blackWithAlpha = [UIColor.greenColor colorWithAlphaComponent:(CGFloat)0.8];
  UIColor *black = UIColor.blackColor;
  CIColor *ciColor = [[CIColor alloc] initWithColor:UIColor.blackColor];
  UIColor *uiColorFromCIColor = [UIColor colorWithCIColor:ciColor];
  UIColor *whiteColor = [UIColor colorWithWhite:(CGFloat)0.5 alpha:(CGFloat)0.5];
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
  [ActionSheetTestHelpers addNumberOfActions:10 toActionSheet:actionSheet];
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

+ (MDCActionSheetItemTableViewCell *)getCellFromActionSheet:(MDCActionSheetController *)actionSheet
                                                    atIndex:(NSUInteger)index {
  if (index < actionSheet.actions.count) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableView *table = actionSheet.tableView;
    UITableViewCell *cell = [table.dataSource tableView:table cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[MDCActionSheetItemTableViewCell class]]) {
      return (MDCActionSheetItemTableViewCell *)cell;
    }
  }
  return nil;
}

@end
