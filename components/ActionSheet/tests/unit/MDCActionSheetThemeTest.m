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
#import "../../src/private/MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetTestHelper.h"
#import "MaterialActionSheet+ColorThemer.h"

static const CGFloat kHighAlpha = 0.87f;
static const CGFloat kMediumAlpha = 0.6f;
static const CGFloat kInkAlpha = 16.f;

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
@end

@implementation MDCActionSheetThemeTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  UIColor *surface = UIColor.blueColor;
  UIColor *onSurface = UIColor.redColor;
  self.colorScheme.primaryColor = surface;
  self.colorScheme.onPrimaryColor = onSurface;
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
- (void)testApplyThemeToCells {
  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                              toActionSheetController:self.actionSheet];
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha]);
  }
}

@end
