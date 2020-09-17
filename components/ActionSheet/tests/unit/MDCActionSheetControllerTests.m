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

#import "../../src/private/MDCActionSheetHeaderView.h"
#import "MaterialActionSheet.h"
#import "MDCActionSheetTestHelper.h"
#import "MaterialBottomSheet.h"
#import "MaterialShadowElevations.h"

static const CGFloat kSafeAreaAmount = 20;
static const CGFloat kDefaultDividerOpacity = (CGFloat)0.12;

@interface MDCActionSheetController (MDCTesting)
@property(nonatomic, strong, nonnull) UIView *headerDividerView;
@end

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetControllerTests : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@interface MDCFakeView : UIView
@end

@implementation MDCFakeView

- (UIEdgeInsets)safeAreaInsets {
  return UIEdgeInsetsMake(kSafeAreaAmount, kSafeAreaAmount, kSafeAreaAmount, kSafeAreaAmount);
}

@end

@implementation MDCActionSheetControllerTests

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)tearDown {
  self.actionSheet = nil;

  [super tearDown];
}

- (void)testInitializerResultsInExpectedDefaults {
  // Then
  XCTAssertFalse(self.actionSheet.alwaysAlignTitleLeadingEdges);
  XCTAssertEqualWithAccuracy(self.actionSheet.mdc_currentElevation,
                             MDCShadowElevationModalBottomSheet, 0.001);
  XCTAssertEqualObjects(self.actionSheet.headerDividerColor,
                        [UIColor.blackColor colorWithAlphaComponent:kDefaultDividerOpacity]);
  XCTAssertFalse(self.actionSheet.showsHeaderDivider);
  XCTAssertNotNil(self.actionSheet.headerDividerView);
}

- (void)testTitleColor {
  // When
  self.actionSheet.title = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedColor);
}

- (void)testMessageColor {
  // When
  self.actionSheet.message = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedColor);
}

- (void)testTitleAndMessageColor {
  // When
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

- (void)testTitleAndMessageColorWhenMessageSetFirst {
  // When
  self.actionSheet.message = @"Test message";
  self.actionSheet.title = @"Test title";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.87];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

- (void)testCustomMessageColor {
  // Given
  self.actionSheet.message = @"Test message";

  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];
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

  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];
  for (UIColor *color in colors) {
    // When
    self.actionSheet.titleTextColor = color;

    // Then
    XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, color);
  }
}

- (void)testCustomBackgroundColor {
  // Given
  NSArray *colors = [MDCActionSheetTestHelper colorsToTest];
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
  UIColor *titleColorChangeAlpha = [titleColor colorWithAlphaComponent:(CGFloat)0.6];
  UIColor *messageColorChangeAlpha = [messageColor colorWithAlphaComponent:(CGFloat)0.5];

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
  UIColor *titleColor = [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.6];
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
                        [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [UIColor.blackColor colorWithAlphaComponent:(CGFloat)0.6]);
}

- (void)testSetAlignTitles {
  // When
  self.actionSheet.alwaysAlignTitleLeadingEdges = YES;

  // Then
  XCTAssertTrue(self.actionSheet.alwaysAlignTitleLeadingEdges);
}

- (void)testSetAlignTitlesWhenSomeActionsHaveImages {
  // Given
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Foo"
                                                              image:[[UIImage alloc] init]
                                                            handler:nil]];
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Bar" image:nil handler:nil]];

  // When
  self.actionSheet.alwaysAlignTitleLeadingEdges = YES;

  // Then
  XCTAssertTrue(self.actionSheet.addLeadingPaddingToCell);
}

- (void)testSetAlignTitlesWhenNoActionsHaveImages {
  // Given
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Foo" image:nil handler:nil]];
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Bar" image:nil handler:nil]];

  // When
  self.actionSheet.alwaysAlignTitleLeadingEdges = YES;

  // Then
  XCTAssertFalse(self.actionSheet.addLeadingPaddingToCell);
}

- (void)testPassThroughPropertiesToPresentationControllerWorkAfterItsInitialization {
  // Given
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"An action"
                                                              image:nil
                                                            handler:nil]];
  NSString *expectedScrimAccessibilityLabel =
      @"Accessibility label to be passed to presentation controller";
  __unused UIView *forceLoadedViewResultingInInitializationOfPresentationController =
      self.actionSheet.view;

  // When
  self.actionSheet.transitionController.scrimAccessibilityLabel = expectedScrimAccessibilityLabel;

  // Then
  NSString *actualScrimAccessibilityLabel =
      self.actionSheet.mdc_bottomSheetPresentationController.scrimAccessibilityLabel;
  XCTAssertEqualObjects(expectedScrimAccessibilityLabel, actualScrimAccessibilityLabel);
}

#pragma mark - Opening height

- (CGRect)setUpActionSheetWithHeight:(CGFloat)height
                            andTitle:(NSString *)title
                          andMessage:(NSString *)message {
  // Given
  CGRect viewRect = CGRectMake(0, 0, 200, height);
  self.actionSheet.view.bounds = viewRect;
  self.actionSheet.title = title;
  self.actionSheet.message = message;

  // When
  [MDCActionSheetTestHelper addNumberOfActions:100 toActionSheet:self.actionSheet];
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
  cellHeight = ceil(cellHeight);
  CGFloat halfCellHeight = cellHeight * (CGFloat)0.5;
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
  cellHeight = ceil(cellHeight);
  CGFloat halfCellHeight = cellHeight * (CGFloat)0.5;
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
  cellHeight = ceil(cellHeight);
  CGFloat halfCellHeight = cellHeight * (CGFloat)0.5;
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
  cellHeight = ceil(cellHeight);
  CGFloat halfCellHeight = cellHeight * (CGFloat)0.5;
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
  cellHeight = ceil(cellHeight);
  CGFloat halfCellHeight = cellHeight * (CGFloat)0.5;
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

#pragma mark - Fonts

- (void)testSetTitleFont {
  // Given
  UIFont *titleFont = [UIFont systemFontOfSize:23];

  // When
  self.actionSheet.titleFont = titleFont;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.font, titleFont);
}

- (void)testSetMessageFont {
  // Given
  UIFont *messageFont = [UIFont systemFontOfSize:23];

  // When
  self.actionSheet.messageFont = messageFont;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.font, messageFont);
}

#pragma mark - MaterialElevation

- (void)testDefaultOverrideBaseElevationIsNegative {
  // Then
  XCTAssertLessThan(self.actionSheet.mdc_overrideBaseElevation, 0);
}

- (void)testSettingBaseOverrideBaseElevationReturnsSetValue {
  // Given
  CGFloat fakeElevation = 99;

  // When
  self.actionSheet.mdc_overrideBaseElevation = fakeElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.actionSheet.mdc_overrideBaseElevation, fakeElevation, 0.001);
}

- (void)testSettingCustomElevation {
  // Given
  CGFloat customElevation = 99;

  // When
  self.actionSheet.elevation = customElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.actionSheet.elevation, customElevation, 0.001);
  XCTAssertEqualWithAccuracy(self.actionSheet.mdc_currentElevation, customElevation, 0.001);
}

- (void)testSetHeaderDividerColor {
  // Given
  UIColor *expectedColor = UIColor.orangeColor;

  // When
  self.actionSheet.headerDividerColor = expectedColor;

  // Then
  XCTAssertEqualObjects(self.actionSheet.headerDividerColor, expectedColor);
}

- (void)testSetShowsHeaderDivider {
  // When
  self.actionSheet.showsHeaderDivider = YES;

  // Then
  XCTAssertTrue(self.actionSheet.showsHeaderDivider);
}

- (void)testTableViewContentInsetsWithHeaderDividerViewAndTitle {
  // Given
  self.actionSheet.title = @"Foo";
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Bar" image:nil handler:nil]];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];
  CGFloat originalTableContentInset = self.actionSheet.tableView.contentInset.top;

  // When
  self.actionSheet.showsHeaderDivider = YES;
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  XCTAssertGreaterThan(self.actionSheet.tableView.contentInset.top, originalTableContentInset);
}

- (void)testTableViewContentInsetsWithHeaderDividerViewAndMessage {
  // Given
  self.actionSheet.message = @"Foo";
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Bar" image:nil handler:nil]];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];
  CGFloat originalTableContentInset = self.actionSheet.tableView.contentInset.top;

  // When
  self.actionSheet.showsHeaderDivider = YES;
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  XCTAssertGreaterThan(self.actionSheet.tableView.contentInset.top, originalTableContentInset);
}

- (void)testTableViewContentInsetsWithHeaderDividerViewAndNoTitleOrMessage {
  // Given
  self.actionSheet.title = nil;
  self.actionSheet.message = nil;
  [self.actionSheet addAction:[MDCActionSheetAction actionWithTitle:@"Bar" image:nil handler:nil]];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];
  CGFloat originalTableContentInset = self.actionSheet.tableView.contentInset.top;

  // When
  self.actionSheet.showsHeaderDivider = YES;
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  XCTAssertGreaterThan(self.actionSheet.tableView.contentInset.top, originalTableContentInset);
}

@end
