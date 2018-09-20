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
#import "../../src/private/MDCActionSheetItemTableViewCell.h"

static const CGFloat kSafeAreaAmount = 20.f;

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
- (CGFloat)openingSheetHeight;
@end

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@end

@interface MDCActionSheetTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@interface MDCFakeView : UIView
@end

@implementation MDCFakeView

- (UIEdgeInsets)safeAreaInsets {
  return UIEdgeInsetsMake(kSafeAreaAmount, kSafeAreaAmount, kSafeAreaAmount, kSafeAreaAmount);
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

- (void)testCustomMessageColor {
  // Given
  self.actionSheet.message = @"Test message";

  NSArray *colors = [self colorsToTest];
  for (UIColor *color in colors) {
    // When
    self.actionSheet.messageTextColor = color;

    // Then
    XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, color);
  }
}

- (void)testCustomTitleColor {
  // Given
  self.actionSheet.title = @"Test title";

  NSArray *colors = [self colorsToTest];
  for (UIColor *color in colors) {
    // When
    self.actionSheet.titleTextColor = color;

    // Then
    XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, color);
  }
}

- (void)testCustomBackgroundColor {
  // Given
  NSArray *colors = [self colorsToTest];
  for (UIColor *color in colors) {
    // When
    self.actionSheet.backgroundColor = color;

    // Then
    XCTAssertEqualObjects(self.actionSheet.backgroundColor, color);
  }
}

- (void)testTitleAndMessageColorCorrectAlpha {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";
  UIColor *titleColor = UIColor.blackColor;
  UIColor *messageColor = UIColor.blackColor;

  // When
  UIColor *titleColorChangeAlpha = [titleColor colorWithAlphaComponent:0.6f];
  UIColor *messageColorChangeAlpha = [messageColor colorWithAlphaComponent:0.5f];

  self.actionSheet.titleTextColor = titleColorChangeAlpha;
  self.actionSheet.messageTextColor = messageColorChangeAlpha;

  // Then
  XCTAssertFalse([titleColor isEqual:self.actionSheet.header.titleLabel.textColor]);
  XCTAssertFalse([messageColor isEqual:self.actionSheet.header.messageLabel.textColor]);
}

- (void)testSetTitleAndMessageAfterCustomColorsSet {
  // Given
  UIColor *titleColor = UIColor.blueColor;
  UIColor *messageColor = UIColor.redColor;

  // When
  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.messageTextColor = messageColor;
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, messageColor);
}

- (void)testTitleCustomDoesNotChangeAfterSetMessage {
  // Given
  UIColor *titleColor = [UIColor.blueColor colorWithAlphaComponent:0.6f];
  self.actionSheet.title = @"Test title";

  // When
  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.message = @"Test message";

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
}

- (void)testSetNilTitleAndMessageColor {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  self.actionSheet.titleTextColor = nil;
  self.actionSheet.messageTextColor = nil;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [UIColor.blackColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [UIColor.blackColor colorWithAlphaComponent:0.6f]);
}

#pragma mark - Opening height

- (void)addNumberOfActions:(NSUInteger)actionsCount {
  for (NSUInteger actionIndex = 0; actionIndex < actionsCount; ++actionIndex) {
    NSString *actionTitle = [NSString stringWithFormat:@"Action #%@", @(actionIndex)];
    MDCActionSheetAction *action = [MDCActionSheetAction actionWithTitle:actionTitle
                                                                   image:nil
                                                                 handler:nil];
    [self.actionSheet addAction:action];
  }
}

- (CGRect)setUpActionSheetWithHeight:(CGFloat)height
                            andTitle:(NSString *)title
                          andMessage:(NSString *)message {
  // Given
  CGRect viewRect = CGRectMake(0, 0, 200, height);
  self.actionSheet.view.bounds = viewRect;
  self.actionSheet.title = title;
  self.actionSheet.message = message;

  // When
  [self addNumberOfActions:100];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];
  return viewRect;
}

- (void)testOpeningHeightWithTitle {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = [self setUpActionSheetWithHeight:fakeHeight
                                            andTitle:@"Test Title"
                                          andMessage:nil];

  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);

  for (NSInteger additionalHeight = 0; additionalHeight < cellHeight; ++additionalHeight) {
    // When
    viewRect.size.height = fakeHeight + additionalHeight;
    self.actionSheet.view.bounds = viewRect;
    [self.actionSheet.view setNeedsLayout];
    [self.actionSheet.view layoutIfNeeded];

    // Then
    CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
    CGFloat expectedMinusHeader = expectedHeight - headerHeight;
    // Action sheet should show half of the allowed actions but the full last action
    XCTAssertEqualWithAccuracy(fmod(expectedMinusHeader, halfCellHeight), 0, 0.001);
    XCTAssertNotEqualWithAccuracy(fmod(expectedMinusHeader, cellHeight), 0, 0.001);
  }
}

- (void)testOpeningHeightWithtTitleAndSmallMessage {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = [self setUpActionSheetWithHeight:fakeHeight
                                            andTitle:@"Test title"
                                          andMessage:@"Test message"];

  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);

  for (NSInteger additionalHeight = 0; additionalHeight < cellHeight; ++additionalHeight) {
    // When
    viewRect.size.height = fakeHeight + additionalHeight;
    self.actionSheet.view.bounds = viewRect;
    [self.actionSheet.view setNeedsLayout];
    [self.actionSheet.view layoutIfNeeded];

    // Then
    CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
    CGFloat expectedMinusHeader = expectedHeight - headerHeight;
    // Action sheet should show half of the allowed actions but the full last action
    XCTAssertEqualWithAccuracy(fmod(expectedMinusHeader, halfCellHeight), 0, 0.001);
    XCTAssertNotEqualWithAccuracy(fmod(expectedMinusHeader, cellHeight), 0, 0.001);
  }
}

- (void)testOpeningHeightWithTitleAndLargeMessage {
  // Given
  CGFloat fakeHeight = 500;
  NSString *first = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies";
  NSString *second = @"diam libero, eget porta arcu feugiat sit amet Maecenas placerat felis sed ";
  NSString *third = @"risusnmaximus tempus.Integer feugiat, augue in pellentesque dictum, justo ";
  NSString *fourth = @"erat ultricies leo, quis eros dictum mi. In finibus vulputate eros, auctor";
  NSString *messageString = [NSString stringWithFormat:@"%@%@%@%@", first, second, third, fourth];
  self.actionSheet.message = messageString;
  CGRect viewRect = [self setUpActionSheetWithHeight:fakeHeight
                                            andTitle:@"Test title"
                                          andMessage:messageString];

  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);

  for (NSInteger additionalHeight = 0; additionalHeight < cellHeight; ++additionalHeight) {
    // When
    viewRect.size.height = fakeHeight + additionalHeight;
    self.actionSheet.view.bounds = viewRect;
    [self.actionSheet.view setNeedsLayout];
    [self.actionSheet.view layoutIfNeeded];

    // Then
    CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
    CGFloat expectedMinusHeader = expectedHeight - headerHeight;
    // Action sheet should show half of the allowed actions but the full last action
    XCTAssertEqualWithAccuracy(fmod(expectedMinusHeader, halfCellHeight), 0, 0.001);
    XCTAssertNotEqualWithAccuracy(fmod(expectedMinusHeader, cellHeight), 0, 0.001);
  }
}

- (void)testOpeningHeightWithSafeArea {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = [self setUpActionSheetWithHeight:fakeHeight andTitle:nil andMessage:nil];

  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);

  for (NSInteger additionalHeight = 0; additionalHeight < cellHeight; ++additionalHeight) {
    // When
    viewRect.size.height = fakeHeight + additionalHeight;
    self.actionSheet.view.bounds = viewRect;
    [self.actionSheet.view setNeedsLayout];
    [self.actionSheet.view layoutIfNeeded];

    // Then
    CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
    CGFloat expectedMinusHeader = expectedHeight - headerHeight;
    // Action sheet should show half of the allowed actions but the full last action
    XCTAssertEqualWithAccuracy(fmod(expectedMinusHeader, halfCellHeight), 0, 0.001);
    XCTAssertNotEqualWithAccuracy(fmod(expectedMinusHeader, cellHeight), 0, 0.001);
  }
}

- (void)testOpeningHeightNoHeader {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = [self setUpActionSheetWithHeight:fakeHeight andTitle:nil andMessage:nil];

  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)self.actionSheet.actions.count;
  cellHeight = MDCCeil(cellHeight);
  CGFloat halfCellHeight = cellHeight * 0.5f;
  CGFloat headerHeight = CGRectGetHeight(self.actionSheet.header.frame);

  for (NSInteger additionalHeight = 0; additionalHeight < cellHeight; ++additionalHeight) {
    // When
    viewRect.size.height = fakeHeight + additionalHeight;
    self.actionSheet.view.bounds = viewRect;
    [self.actionSheet.view setNeedsLayout];
    [self.actionSheet.view layoutIfNeeded];

    // Then
    CGFloat expectedHeight = [self.actionSheet openingSheetHeight];
    CGFloat expectedMinusHeader = expectedHeight - headerHeight;
    // Action sheet should show half of the allowed actions but the full last action
    XCTAssertEqualWithAccuracy(fmod(expectedMinusHeader, halfCellHeight), 0, 0.001);
    XCTAssertNotEqualWithAccuracy(fmod(expectedMinusHeader, cellHeight), 0, 0.001);
  }
}
#pragma mark Table

- (NSArray <MDCActionSheetItemTableViewCell *>*)setupActionSheetAndGetCells {
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
    self.actionSheet.tintColor = color;
    NSArray *cells = [self setupActionSheetAndGetCells];
    for (MDCActionSheetItemTableViewCell *cell in cells) {
      // Then
      XCTAssertEqualObjects(cell.actionImageView.tintColor, color);
    }
  }
}

@end
