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
#import "MaterialActionSheet+Theming.h"

static const CGFloat kHighAlpha = (CGFloat)0.87;
static const CGFloat kMediumAlpha = (CGFloat)0.6;
static const CGFloat kInkAlpha = (CGFloat)0.16;

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@interface MDCActionSheetThemingTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCActionSheetThemingTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.colorScheme =
  [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  self.containerScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.actionSheet = nil;
  self.colorScheme = nil;
  self.containerScheme = nil;

  [super tearDown];
}

- (void)testActionSheetThemingTest {
  // Given
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];


  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // Then
  // Color
  XCTAssertEqualObjects(self.actionSheet.backgroundColor, self.colorScheme.surfaceColor);

  // Typography
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.font, typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.font, typographyScheme.body2);

  // Cells
  XCTAssertNotEqual(cells.count, 0U);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha]);
    XCTAssertEqualObjects(cell.actionLabel.font, typographyScheme.subtitle1);
  }
}

- (void)testActionSheetThemingTestWithHeaderOnly {
  // Given
  self.actionSheet.title = @"Foo";

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
}

- (void)testActionSheetThemingTestWithMessageOnly {
  // Given
  self.actionSheet.message = @"Bar";

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
}

- (void)testActionSheetThemingTestWithHeaderAndMessage {
  // Given
  self.actionSheet.title = @"Foo";
  self.actionSheet.message = @"Bar";

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);

}

@end
