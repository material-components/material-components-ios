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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCActionSheetHeaderView.h"
#import "MDCActionSheetItemTableViewCell.h"
#pragma clang diagnostic pop
#import "MDCActionSheetAction.h"
#import "MDCActionSheetController.h"
#import "MDCActionSheetController+MaterialTheming.h"
#import "MDCAvailability.h"
#import "MDCShadowElevations.h"
#import "MDCSemanticColorScheme.h"
#import "MDCContainerScheme.h"
#import "MDCTypographyScheme.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kHighAlpha = (CGFloat)0.87;
static const CGFloat kMediumAlpha = (CGFloat)0.6;

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
@end

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetItemTableViewCell (Testing)
@property(nonatomic, strong) UILabel *actionLabel;
@property(nonatomic, strong) UIImageView *actionImageView;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@interface MDCActionSheetControllerThemingTests : XCTestCase
@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheet;
@property(nonatomic, strong, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong, nullable) MDCContainerScheme *containerScheme;
@end

@implementation MDCActionSheetControllerThemingTests

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
  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  MDCActionSheetAction *fakeActionOne = [MDCActionSheetAction actionWithTitle:@"Action 1"
                                                                        image:nil
                                                                      handler:nil];
  [self.actionSheet addAction:fakeActionOne];
  UITableView *tableView = self.actionSheet.tableView;
  NSIndexPath *fakeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];
  UITableViewCell *cell = [tableView.dataSource tableView:tableView
                                    cellForRowAtIndexPath:fakeIndexPath];
  MDCActionSheetItemTableViewCell *actionSheetCell = (MDCActionSheetItemTableViewCell *)cell;

  // Then
  // Color
  XCTAssertEqualObjects(self.actionSheet.backgroundColor, self.colorScheme.surfaceColor);

  // Typography
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.font, typographyScheme.subtitle1);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.font, typographyScheme.body2);

  // Cells
  XCTAssertEqualObjects(actionSheetCell.actionImageView.tintColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
  XCTAssertEqualObjects(actionSheetCell.actionLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]);
  XCTAssertEqualObjects(actionSheetCell.actionLabel.font, typographyScheme.subtitle1);

  // Elevation
  XCTAssertEqualWithAccuracy(self.actionSheet.elevation, MDCShadowElevationModalActionSheet, 0.001);

  [self assertTraitCollectionBlockAndElevationBlockForActionSheet:self.actionSheet];
}

- (void)testActionSheetThemingTestWithHeaderOnly {
  // Given
  self.actionSheet.title = @"Foo";

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
  [self assertTraitCollectionBlockAndElevationBlockForActionSheet:self.actionSheet];
}

- (void)testActionSheetThemingTestWithMessageOnly {
  // Given
  self.actionSheet.message = @"Bar";

  // When
  [self.actionSheet applyThemeWithScheme:self.containerScheme];

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [self.colorScheme.onSurfaceColor colorWithAlphaComponent:kMediumAlpha]);
  [self assertTraitCollectionBlockAndElevationBlockForActionSheet:self.actionSheet];
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
  [self assertTraitCollectionBlockAndElevationBlockForActionSheet:self.actionSheet];
}

- (void)assertTraitCollectionBlockAndElevationBlockForActionSheet:
    (MDCActionSheetController *)actionSheet {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    XCTAssertNotNil(self.actionSheet.mdc_elevationDidChangeBlock);
    XCTAssertNotNil(self.actionSheet.traitCollectionDidChangeBlock);
  } else {
    XCTAssertNil(self.actionSheet.mdc_elevationDidChangeBlock);
    XCTAssertNil(self.actionSheet.traitCollectionDidChangeBlock);
  }
#else
  XCTAssertNil(self.actionSheet.mdc_elevationDidChangeBlock);
  XCTAssertNil(self.actionSheet.traitCollectionDidChangeBlock);
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end

NS_ASSUME_NONNULL_END
