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
#import "MaterialMath.h"

#import <XCTest/XCTest.h>

#import "../../src/private/MDCActionSheetHeaderView.h"

static const CGFloat safeAreaAmount = 20.f;

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
- (CGFloat)openingSheetHeight;
@end

@interface MDCActionSheetTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@interface MDCFakeView : UIView
@end

@implementation MDCFakeView
-(UIEdgeInsets)safeAreaInsets {
  return UIEdgeInsetsMake(safeAreaAmount, safeAreaAmount, safeAreaAmount, safeAreaAmount);
}
@end

@implementation MDCActionSheetTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)testTitleColor {
  // When
  self.actionSheet.title = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedColor);
}

- (void)testMessageColor {
  // When
  self.actionSheet.message = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedColor);
}

- (void)testTitleAndMessageColor {
  // When
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:0.87f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

- (void)testTitleAndMessageColorWhenMessageSetFirst {
  // When
  self.actionSheet.message = @"Test message";
  self.actionSheet.title = @"Test title";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:0.87f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

#pragma mark - Opening height

- (void)addActions:(NSUInteger)actions {
  for (NSUInteger i = 0; i < actions; ++i) {
    MDCActionSheetAction *action =
        [MDCActionSheetAction actionWithTitle:@"Title" image:nil handler:nil];
    [self.actionSheet addAction:action];
  }
}

- (void)testOpenningHeightWithNoHeader {
  // Given
  CGFloat fakeHeight = 500;
  self.actionSheet.view.bounds = CGRectMake(0, 0, 200, fakeHeight);

  // When
  [self addActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);
  CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
  CGFloat expectedMinusHeader = expectedHeight - headerHeight;
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  // Action sheet should show half of the allowed actions but the full last action
  XCTAssertEqual(fmod(expectedMinusHeader, halfCellHeight), 0);
  XCTAssertNotEqual(fmod(expectedMinusHeader, cellHeight), 0);
}

- (void)testOpeningHeightWithTitle {
  // Given
  CGFloat fakeHeight = 500;
  self.actionSheet.view.bounds = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.title = @"Test title";

  // When
  [self addActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);
  CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
  CGFloat expectedMinusHeader = expectedHeight - headerHeight;
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  // Action sheet should show half of the allowed actions but the full last action
  XCTAssertEqual(fmod(expectedMinusHeader, halfCellHeight), 0);
  XCTAssertNotEqual(fmod(expectedMinusHeader, cellHeight), 0);
}

- (void)testOpeningHeightWithtTitleAndSmallMessage {
  // Given
  CGFloat fakeHeight = 500;
  self.actionSheet.view.bounds = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  [self addActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);
  CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
  CGFloat expectedMinusHeader = expectedHeight - headerHeight;
  CGFloat cellHeight =
  self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  // Action sheet should show half of the allowed actions but the full last action
  XCTAssertEqual(fmod(expectedMinusHeader, halfCellHeight), 0);
  XCTAssertNotEqual(fmod(expectedMinusHeader, cellHeight), 0);
}

- (void)testOpeningHeightWithTitleAndLargeMessage {
  // Given
  CGFloat fakeHeight = 500;
  self.actionSheet.view.bounds = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.title = @"Test title";
  NSString *first = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies";
  NSString *second = @"diam libero, eget porta arcu feugiat sit amet Maecenas placerat felis sed ";
  NSString *third = @"risusnmaximus tempus.Integer feugiat, augue in pellentesque dictum, justo ";
  NSString *fourth = @"erat ultricies leo, quis eros dictum mi. In finibus vulputate eros, auctor";
  NSString *messageString = [NSString stringWithFormat:@"%@%@%@%@", first, second, third, fourth];
  self.actionSheet.message = messageString;

  // When
  [self addActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);
  CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
  CGFloat expectedMinusHeader = expectedHeight - headerHeight;
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  // Action sheet should show half of the allowed actions but the full last action
  XCTAssertEqual(fmod(expectedMinusHeader, halfCellHeight), 0);
  XCTAssertNotEqual(fmod(expectedMinusHeader, cellHeight), 0);
}

- (void)testOpeningHeightWithSafeArea {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.view.bounds = viewRect;
  self.actionSheet.view = [[MDCFakeView alloc] initWithFrame:viewRect];

  // When
  [self addActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);
  CGFloat expectedHeight = [self.actionSheet openingSheetHeight] + safeAreaAmount;
  CGFloat expectedMinusHeader = expectedHeight - headerHeight;
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  // Action sheet should show half of the allowed actions but the full last action
  XCTAssertEqual(fmod(expectedMinusHeader, halfCellHeight), 0);
  XCTAssertNotEqual(fmod(expectedMinusHeader, cellHeight), 0);
}

@end
