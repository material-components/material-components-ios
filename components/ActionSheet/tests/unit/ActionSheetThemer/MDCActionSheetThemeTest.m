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

#import "../../../src/private/MDCActionSheetHeaderView.h"
#import "../../../src/private/MDCActionSheetItemTableViewCell.h"
#import "../MDCActionSheetTestHelper.h"
#import "MaterialActionSheet+ActionSheetThemer.h"
#import "MaterialActionSheet+ColorThemer.h"
#import "MaterialActionSheet+TypographyThemer.h"

static const CGFloat kHighAlpha = (CGFloat)0.87;
static const CGFloat kMediumAlpha = (CGFloat)0.6;

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@interface MDCActionSheetThemeTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation MDCActionSheetThemeTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  UIColor *surface = UIColor.blueColor;
  UIColor *onSurface = UIColor.redColor;
  self.colorScheme.surfaceColor = surface;
  self.colorScheme.onSurfaceColor = onSurface;
  self.typographyScheme = [[MDCTypographyScheme alloc] init];
  self.typographyScheme.subtitle1 = [UIFont systemFontOfSize:12.0 weight:UIFontWeightBold];
  self.typographyScheme.body2 = [UIFont systemFontOfSize:10.0 weight:UIFontWeightLight];
}

- (void)tearDown {
  self.typographyScheme = nil;
  self.colorScheme = nil;
  self.actionSheet = nil;

  [super tearDown];
}

#pragma mark - Scheme test

- (void)testDefaultScheme {
  // Given
  MDCActionSheetScheme *defaultScheme = [[MDCActionSheetScheme alloc] init];
  MDCTypographyScheme *defaultTypographyScheme = [[MDCTypographyScheme alloc] init];
  MDCSemanticColorScheme *defaultColorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

  // Then
  XCTAssertEqualObjects(defaultScheme.typographyScheme.subtitle1,
                        defaultTypographyScheme.subtitle1);
  XCTAssertEqualObjects(defaultScheme.typographyScheme.body2, defaultTypographyScheme.body2);
  XCTAssertEqualObjects(defaultScheme.colorScheme.surfaceColor, defaultColorScheme.surfaceColor);
  XCTAssertEqualObjects(defaultScheme.colorScheme.onSurfaceColor,
                        defaultColorScheme.onSurfaceColor);
}

- (void)testCustomColorSchemeAppliedToGlobalScheme {
  // Given
  MDCActionSheetScheme *scheme = [[MDCActionSheetScheme alloc] init];

  // When
  scheme.colorScheme = self.colorScheme;

  // Then
  XCTAssertEqualObjects(scheme.colorScheme.surfaceColor, self.colorScheme.surfaceColor);
  XCTAssertEqualObjects(scheme.colorScheme.onSurfaceColor, self.colorScheme.onSurfaceColor);
}

- (void)testCustomTypographySchemeAppliedToGlobalScheme {
  // Given
  MDCActionSheetScheme *scheme = [[MDCActionSheetScheme alloc] init];

  // When
  scheme.typographyScheme = self.typographyScheme;

  // Then
  XCTAssertEqualObjects(scheme.typographyScheme.subtitle1, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(scheme.typographyScheme.body2, self.typographyScheme.body2);
}

#pragma mark - Header test

- (void)testApplyColorThemerWithTitleAndMessage {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
}

- (void)testApplyThemerWithOnlyTitle {
  // Given
  self.actionSheet.title = @"Test title";

  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
}

- (void)testApplyThemerWithOnlyMessage {
  // Given
  self.actionSheet.message = @"Test message";

  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
}

#pragma mark - default test

- (void)testApplyThemer {
  // Given
  MDCActionSheetController *tempActionSheet = [[MDCActionSheetController alloc] init];
  MDCActionSheetScheme *scheme = [[MDCActionSheetScheme alloc] init];
  scheme.colorScheme = self.colorScheme;
  scheme.typographyScheme = self.typographyScheme;

  // When
  [MDCActionSheetThemer applyScheme:scheme toActionSheetController:tempActionSheet];
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];
  [MDCActionSheetTypographyThemer applyTypographyScheme:self.typographyScheme
                                toActionSheetController:self.actionSheet];

  // Then
  XCTAssertEqualObjects(tempActionSheet.backgroundColor, self.actionSheet.backgroundColor);
  XCTAssertEqualObjects(tempActionSheet.titleTextColor, self.actionSheet.titleTextColor);
  XCTAssertEqualObjects(tempActionSheet.messageTextColor, self.actionSheet.messageTextColor);
  XCTAssertEqualObjects(tempActionSheet.titleFont, self.actionSheet.titleFont);
  XCTAssertEqualObjects(tempActionSheet.messageFont, self.actionSheet.messageFont);
  XCTAssertEqualObjects(tempActionSheet.actionFont, self.actionSheet.actionFont);
  XCTAssertEqualObjects(tempActionSheet.actionTintColor, self.actionSheet.actionTintColor);
  XCTAssertEqualObjects(tempActionSheet.actionTextColor, self.actionSheet.actionTextColor);
}

- (void)testApplyColorTheme {
  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  XCTAssertNotEqual(cells.count, 0U);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
  }
}

- (void)testApplyTypographyTheme {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  [MDCActionSheetTypographyThemer applyTypographyScheme:self.typographyScheme
                                toActionSheetController:self.actionSheet];
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.font, self.typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.font, self.typographyScheme.body2);
  XCTAssertNotEqual(cells.count, 0U);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionLabel.font, self.typographyScheme.subtitle1);
  }
}

@end
