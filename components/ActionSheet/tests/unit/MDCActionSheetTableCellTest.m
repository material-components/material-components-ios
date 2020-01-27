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
@end

@interface MDCActionSheetTableCellTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@implementation MDCActionSheetTableCellTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)tearDown {
  self.actionSheet = nil;

  [super tearDown];
}

- (void)testInitializerResultsInExpectedDefaults {
  // When
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertFalse(cell.addLeadingPadding);
  }
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
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.87]);
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
                          [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6]);
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

- (void)testSetRippleColor {
  // When
  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];

  for (UIColor *color in colors) {
    self.actionSheet.rippleColor = color;
    NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.rippleColor, color);
    }
  }
}

- (void)testSetActionFont {
  // Given
  UIFont *actionFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

  // When
  self.actionSheet.actionFont = actionFont;
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
  XCTAssertNotEqual(cells.count, 0U);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    // Then
    XCTAssertEqualObjects(cell.actionLabel.font, actionFont);
  }
}

- (void)testSetActionItemAccessibilityLabel {
  // Given
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Resume"
                                                                 image:nil
                                                               handler:nil];
  action.accessibilityLabel = @"Résumé";

  // When
  [self.actionSheet addAction:action];
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];

  // Then
  XCTAssertEqual(cell.actionLabel.accessibilityLabel, action.accessibilityLabel);
}

- (void)testSetActionItemColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];
  [self.actionSheet addAction:action];

  // When
  action.titleColor = fakeColor;

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertEqualObjects(cell.actionLabel.textColor, fakeColor);
}

- (void)testSetActionItemColorForOnlyOneCell {
  // Given
  UIColor *fakeCellColor = UIColor.orangeColor;
  UIColor *fakeControllerColor = UIColor.blueColor;
  MDCActionSheetAction *actionOne = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                    image:nil
                                                                  handler:nil];
  MDCActionSheetAction *actionTwo = [MDCActionSheetAction actionWithTitle:@"Bar"
                                                                    image:nil
                                                                  handler:nil];
  MDCActionSheetAction *actionThree = [MDCActionSheetAction actionWithTitle:@"Baz"
                                                                      image:nil
                                                                    handler:nil];
  [self.actionSheet addAction:actionOne];
  [self.actionSheet addAction:actionTwo];
  [self.actionSheet addAction:actionThree];

  // When
  actionTwo.titleColor = fakeCellColor;
  self.actionSheet.actionTextColor = fakeControllerColor;

  // Then
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
  for (NSUInteger index = 0; index < cells.count; ++index) {
    MDCActionSheetItemTableViewCell *cell = cells[index];
    if (index == 1) {
      XCTAssertEqualObjects(cell.actionLabel.textColor, fakeCellColor);
    } else {
      XCTAssertEqualObjects(cell.actionLabel.textColor, fakeControllerColor);
    }
  }
}

- (void)testSetActionItemColorThenResetToNilFallsBackToControllerColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];
  action.titleColor = UIColor.blueColor;
  [self.actionSheet addAction:action];

  // When
  self.actionSheet.actionTextColor = fakeColor;
  action.titleColor = nil;

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertEqualObjects(cell.actionLabel.textColor, fakeColor);
}

- (void)testSetActionItemTintColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];
  [self.actionSheet addAction:action];

  // When
  action.tintColor = fakeColor;

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertEqualObjects(cell.actionImageView.tintColor, fakeColor);
}

- (void)testSetActionItemTintColorForOnlyOneCell {
  // Given
  UIColor *fakeCellColor = UIColor.orangeColor;
  UIColor *fakeControllerColor = UIColor.blueColor;
  MDCActionSheetAction *actionOne = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                    image:nil
                                                                  handler:nil];
  MDCActionSheetAction *actionTwo = [MDCActionSheetAction actionWithTitle:@"Bar"
                                                                    image:nil
                                                                  handler:nil];
  MDCActionSheetAction *actionThree = [MDCActionSheetAction actionWithTitle:@"Baz"
                                                                      image:nil
                                                                    handler:nil];
  [self.actionSheet addAction:actionOne];
  [self.actionSheet addAction:actionTwo];
  [self.actionSheet addAction:actionThree];

  // When
  actionTwo.tintColor = fakeCellColor;
  self.actionSheet.actionTintColor = fakeControllerColor;

  // Then
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];
  for (NSUInteger index = 0; index < cells.count; ++index) {
    MDCActionSheetItemTableViewCell *cell = cells[index];
    if (index == 1) {
      XCTAssertEqualObjects(cell.actionImageView.tintColor, fakeCellColor);
    } else {
      XCTAssertEqualObjects(cell.actionImageView.tintColor, fakeControllerColor);
    }
  }
}

- (void)testSetActionItemTintColorThenResetToNilFallsBackToControllerTintColor {
  // Given
  UIColor *fakeColor = UIColor.orangeColor;
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];
  action.tintColor = UIColor.blueColor;
  [self.actionSheet addAction:action];

  // When
  self.actionSheet.actionTintColor = fakeColor;
  action.tintColor = nil;

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertEqualObjects(cell.actionImageView.tintColor, fakeColor);
}

- (void)testSetActionSheetItemDividerColorSetsTheColorOnTheCell {
  // Given
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];

  // When
  action.dividerColor = UIColor.blueColor;
  [self.actionSheet addAction:action];

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertEqualObjects(cell.dividerColor, UIColor.blueColor);
}

- (void)testSetActionSheetItemDividerShownSetsTheDividerShownOnTheCell {
  // Given
  MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:@"Foo"
                                                                 image:nil
                                                               handler:nil];

  // When
  action.showsDivider = YES;
  [self.actionSheet addAction:action];

  // Then
  MDCActionSheetItemTableViewCell *cell =
      [MDCActionSheetTestHelper getCellFromActionSheet:self.actionSheet atIndex:0];
  XCTAssertTrue(cell.showsDivider);
}

@end
