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

#import "MDCActionSheetTestHelper.h"
#import "MaterialActionSheet+ColorThemer.h"

static const CGFloat kHighAlpha = 0.87f;
static const CGFloat kMediumAlpha = 0.6f;
static const CGFloat kInkAlpha = 16.f;

@interface MDCActionSheetThemeTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@end

@implementation MDCActionSheetThemeTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
  self.colorScheme = [[MDCSemanticColorScheme alloc] init];
}

- (void)testApplyColorThemerWithTitleAndMessage {
  // Given
  UIColor *primary = UIColor.blueColor;
  UIColor *onPrimary = UIColor.redColor;
  self.colorScheme.primaryColor = primary;
  self.colorScheme.onPrimaryColor = onPrimary;
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";
  NSArray *cells = [MDCActionSheetTestHelper getCellsFromActionSheet:self.actionSheet];

  // When
  [MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                                        toActionSheet:self.actionSheet];

  // Then
  XCTAssertEqualObjects(self.actionSheet.backgroundColor, primary);
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [onPrimary colorWithAlphaComponent:kHighAlpha]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [onPrimary colorWithAlphaComponent:kMediumAlpha]);
  for (MDCActionSheetItemTableViewCell *cell in cells) {
    XCTAssertEqualObjects(cell.actionImageView.tintColor,
                          [onPrimary colorWithAlphaComponent:kMediumAlpha]);
    XCTAssertEqualObjects(cell.actionLabel.textColor,
                          [onPrimary colorWithAlphaComponent:kHighAlpha]);
    XCTAssertEqualObjects(cell.inkTouchController.defaultInkView.inkColor,
                          [onPrimary colorWithAlphaComponent:kInkAlpha]);
  }
}

- (void)testApplyThemerWithOnlyTitle {
  // Given

}

@end
