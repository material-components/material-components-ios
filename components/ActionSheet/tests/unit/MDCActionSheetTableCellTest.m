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

#import "MaterialActionSheet.h"

#import <XCTest/XCTest.h>

#import "../../src/private/MDCActionSheetItemTableViewCell.h"

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) UITableView *tableView;
@end

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@end

@interface MDCActionSheetTableCellTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@implementation MDCActionSheetTableCellTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)addNumberOfActions:(NSUInteger)actionsCount {
  for (NSUInteger actionIndex = 0; actionIndex < actionsCount; ++actionIndex) {
    NSString *actionTitle = [NSString stringWithFormat:@"Action #%@", @(actionIndex)];
    MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:actionTitle
                                                                   image:nil
                                                                 handler:nil];
    [self.actionSheet addAction:action];
  }
}

- (NSArray *)colorsToTest {
  UIColor *rgbColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:0.7f];
  UIColor *hsbColor = [UIColor colorWithHue:0.8f saturation:0.8f brightness:0.8f alpha:0.8f];
  UIColor *blackWithAlpha = [UIColor.greenColor colorWithAlphaComponent:0.8f];
  UIColor *black = UIColor.blackColor;
  CIColor *ciColor = [[CIColor alloc] initWithColor:UIColor.blackColor];
  UIColor *uiColorFromCIColor = [UIColor colorWithCIColor:ciColor];
  UIColor *whiteColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
  return @[ rgbColor, hsbColor, blackWithAlpha, black, uiColorFromCIColor, whiteColor ];
}

- (NSArray<MDCActionSheetItemTableViewCell *> *)setupActionSheetAndGetCells {
  NSMutableArray *cellsArray = [[NSMutableArray alloc] init];
  [self addNumberOfActions:10];
  NSUInteger cellsCount = self.actionSheet.actions.count;
  UITableView *table = self.actionSheet.tableView;
  for (NSUInteger cellIndex = 0; cellIndex < cellsCount; ++cellIndex) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellIndex inSection:0];
    UITableViewCell *cell = [table.dataSource tableView:table cellForRowAtIndexPath:indexPath];
    MDCActionSheetItemTableViewCell *actionCell = (MDCActionSheetItemTableViewCell *)cell;
    [cellsArray addObject:actionCell];
  }
  return cellsArray;
}

- (void)testDefaultRenderingMode {
  // When
  NSArray *cells = [self setupActionSheetAndGetCells];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqual(cell.imageRenderingMode, UIImageRenderingModeAlwaysTemplate);
  }
}

- (void)testSetImageRenderingMode {
  // When
  UIImageRenderingMode imageMode = UIImageRenderingModeAlwaysOriginal;
  self.actionSheet.imageRenderingMode = imageMode;
  NSArray *cells = [self setupActionSheetAndGetCells];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqual(cell.imageRenderingMode, imageMode);
  }
}

- (void)testDefaultCellActionTextColor {
  // When
  NSArray *cells = [self setupActionSheetAndGetCells];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [UIColor.blackColor colorWithAlphaComponent:0.87f]);
  }
}

- (void)testSetActionTextColor {
  // When
  NSArray *colors = [self colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.actionTextColor = color;
    NSArray *cells = [self setupActionSheetAndGetCells];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.actionLabel.textColor, color);
    }
  }
}

- (void)testDefaultCellTintColor {
  // When
  NSArray *cells = [self setupActionSheetAndGetCells];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [UIColor.blackColor colorWithAlphaComponent:0.6f]);
  }
}

- (void)testSetTintColor {
  // When
  NSArray *colors = [self colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.actionTintColor = color;
    NSArray *cells = [self setupActionSheetAndGetCells];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.actionImageView.tintColor, color);
    }
  }
}

@end
