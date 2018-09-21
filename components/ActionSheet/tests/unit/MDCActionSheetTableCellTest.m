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

#import "MDCActionSheetTestHelper.m"
#import "../../src/private/MDCActionSheetItemTableViewCell.h"

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

@end
