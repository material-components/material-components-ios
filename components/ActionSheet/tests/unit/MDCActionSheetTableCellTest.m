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

#import <XCTest/XCTest.h>

#import "../../src/private/MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetTestHelper.h"

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@interface MDCActionSheetTableCellTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@implementation MDCActionSheetTableCellTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)testDefaultRenderingMode {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqual(cell.imageRenderingMode, UIImageRenderingModeAlwaysTemplate);
  }
}

- (void)testSetImageRenderingMode {
  // When
  UIImageRenderingMode imageMode = UIImageRenderingModeAlwaysOriginal;
  self.actionSheet.imageRenderingMode = imageMode;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqual(cell.imageRenderingMode, imageMode);
  }
}

- (void)testDefaultCellActionTextColor {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [UIColor.blackColor colorWithAlphaComponent:0.87f]);
  }
}

- (void)testSetActionTextColor {
  // When
  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.actionTextColor = color;
    NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.actionLabel.textColor, color);
    }
  }
}

- (void)testDefaultCellTintColor {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [UIColor.blackColor colorWithAlphaComponent:0.6f]);
  }
}

- (void)testSetTintColor {
  // When
  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.actionTintColor = color;
    NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.actionImageView.tintColor, color);
    }
  }
}

- (void)testDefaultInkColor {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [[UIColor alloc] initWithWhite:0 alpha:0.14f]);
  }
}

- (void)testSetInkColor {
  // When
  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.inkColor = color;
    NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor, color);
    }
  }
}

- (void)testSetActionFont {
  // Given
  UIFont *actionFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

  // When
  self.actionSheet.actionFont = actionFont;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
  XCTAssertNotEqual(cells.count, (NSUInteger)0);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    // Then
    XCTAssertEqual(cell.actionLabel.font, actionFont);
  }
}

@end
