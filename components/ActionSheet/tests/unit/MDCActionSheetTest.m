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

- (void)addActions {
  for (NSUInteger i = 0; i < 100; ++i) {
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
  [self addActions];
  [self.actionSheet.view setNeedsLayout];
  [self.actionSheet.view layoutIfNeeded];

  // Then
  CGFloat 
  XCTAssertEqualWithAccuracy(self.actionSheet.mdc_bottomSheetPresentationController.preferredSheetHeight, (fakeHeight / 2) - cellHeight, 0.001);
}

- (void)testOpeningHeightWithTitle {
  // Given
  CGFloat fakeHeight = 500;
  self.actionSheet.view.bounds = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.title = @"Test title";

  // When
  [self addActions];
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)(self.actionSheet.actions.count);

  // Then
  CGFloat openingHeight = [self.actionSheet openingSheetHeight];
  XCTAssertEqualWithAccuracy(openingHeight, (fakeHeight / 2) - cellHeight, 0.001);
}

- (void)testOpeningHeightWithSafeArea {
  // Given
  CGFloat fakeHeight = 500;
  CGRect viewRect = CGRectMake(0, 0, 200, fakeHeight);
  self.actionSheet.view.bounds = viewRect;
  self.actionSheet.view = [[MDCFakeView alloc] initWithFrame:viewRect];

  // When
  [self addActions];
  CGFloat cellHeight =
      self.actionSheet.tableView.contentSize.height / (CGFloat)(self.actionSheet.actions.count);

  // Then
  CGFloat openingHeight = [self.actionSheet openingSheetHeight];
  XCTAssertEqualWithAccuracy(openingHeight, (fakeHeight / 2) - cellHeight - safeAreaAmount, 0.001);
}

@end
